import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../device/device_profiles.dart';
import '../generated/protocol.dart';
import '../mqtt/mqtt_bridge.dart';
import '../telemetry/telemetry_channels.dart';

/// 控制命令下發與查詢。
///
/// 命令生命週期（docs/backend/api-rules.md）：
/// CREATED → SENT → ACKNOWLEDGED → COMPLETED / FAILED / TIMED_OUT / CANCELLED。
/// 開發環境由 TelemetrySimulator 模擬裝置端推進狀態。
class CommandEndpoint extends Endpoint {
  static const _defaultLimit = 20;
  static const _maxLimit = 100;

  @override
  bool get requireLogin => true;

  /// 下發控制命令。冪等：同一 [idempotencyKey] 重複呼叫回傳既有命令。
  Future<DeviceCommand> sendCommand(
    Session session,
    int deviceId,
    String commandType,
    Map<String, String> payload,
    String idempotencyKey,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final device = await TenantService.assertDeviceAccess(
      session,
      companyId,
      deviceId,
      write: true,
    );

    // setParam：featureKey 必須是該設備的控制參數，且值在允許範圍內。
    if (commandType == 'setParam') {
      final key = payload['featureKey'];
      final value = double.tryParse(payload['value'] ?? '');
      if (key == null || value == null) {
        throw ValidationException(message: 'setParam 需要 featureKey 與 value');
      }
      final control = DeviceProfiles.controlsOf(
        device,
      ).where((f) => f.key == key).firstOrNull;
      if (control == null) {
        throw ValidationException(message: '$key 不是此設備的控制參數');
      }
      if (value < control.minValue || value > control.maxValue) {
        throw ValidationException(
          message:
              '${control.label} 允許範圍 ${control.minValue}~${control.maxValue}'
              ' ${control.unit}',
        );
      }
    }

    if (commandType == 'calibrate') {
      final key = payload['featureKey'];
      final standardValue = double.tryParse(payload['standardValue'] ?? '');
      if (key == null || standardValue == null) {
        throw ValidationException(message: '感測校正需要 featureKey 與 standardValue');
      }
      final measurement = DeviceProfiles.measurementsOf(
        device,
      ).where((feature) => feature.key == key).firstOrNull;
      if (measurement == null ||
          measurement.dataType == FeatureDataType.boolean ||
          measurement.dataType == FeatureDataType.enumeration) {
        throw ValidationException(message: '$key 不是可校正的數值量測特徵');
      }
      if (standardValue < measurement.minValue ||
          standardValue > measurement.maxValue) {
        throw ValidationException(
          message:
              '${measurement.label} 標準值允許範圍 '
              '${measurement.minValue}~${measurement.maxValue} ${measurement.unit}',
        );
      }
    }

    final existing = await DeviceCommand.db.findFirstRow(
      session,
      where: (t) => t.idempotencyKey.equals(idempotencyKey),
    );
    if (existing != null) return existing;

    final command = await DeviceCommand.db.insertRow(
      session,
      DeviceCommand(
        companyId: companyId,
        deviceId: device.id!,
        commandType: commandType,
        payload: payload,
        state: DeviceCommandState.created,
        idempotencyKey: idempotencyKey,
        issuedBy: session.authenticated!.userIdentifier,
        createdAt: DateTime.now().toUtc(),
      ),
    );

    // 有對應序號且 MQTTS 已連線時，同步下發到設備 topic。
    final provisioned = await ProvisionedDevice.db.findFirstRow(
      session,
      where: (t) => t.linkedDeviceId.equals(device.id!),
    );
    if (provisioned != null) {
      final published =
          await mqttBridge?.publishCommand(
            serial: provisioned.serial,
            command: command,
          ) ??
          false;
      if (published) {
        final sent = await DeviceCommand.db.updateRow(
          session,
          command.copyWith(
            state: DeviceCommandState.sent,
            sentAt: DateTime.now().toUtc(),
          ),
        );
        await session.messages.postMessage(
          TelemetryChannels.deviceCommands(companyId, device.id!),
          sent,
        );
        return sent;
      }
    }

    await session.messages.postMessage(
      TelemetryChannels.deviceCommands(companyId, device.id!),
      command,
    );
    return command;
  }

  /// 取消尚未送達的命令（created/sent）。已進入其他狀態則回傳現況。
  Future<DeviceCommand> cancelCommand(Session session, int commandId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final command = await DeviceCommand.db.findFirstRow(
      session,
      where: (t) => t.id.equals(commandId) & t.companyId.equals(companyId),
    );
    if (command == null) {
      throw NotFoundException(message: '命令不存在');
    }
    if (command.state != DeviceCommandState.created &&
        command.state != DeviceCommandState.sent) {
      return command;
    }

    final cancelled = await DeviceCommand.db.updateRow(
      session,
      command.copyWith(
        state: DeviceCommandState.cancelled,
        completedAt: DateTime.now().toUtc(),
      ),
    );
    await session.messages.postMessage(
      TelemetryChannels.deviceCommands(companyId, cancelled.deviceId),
      cancelled,
    );
    return cancelled;
  }

  /// 查詢裝置命令歷史（cursor 分頁，新到舊）。
  Future<DeviceCommandListResult> listCommands(
    Session session,
    int deviceId, {
    int limit = _defaultLimit,
    int? cursorId,
  }) async {
    final companyId = await TenantService.resolveCompanyId(session);
    await TenantService.assertDeviceAccess(session, companyId, deviceId);

    final effectiveLimit = limit.clamp(1, _maxLimit);
    final items = await DeviceCommand.db.find(
      session,
      where: (t) {
        var expr = t.companyId.equals(companyId) & t.deviceId.equals(deviceId);
        if (cursorId != null) {
          expr = expr & (t.id < cursorId);
        }
        return expr;
      },
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: effectiveLimit,
    );
    return DeviceCommandListResult(
      items: items,
      nextCursorId: items.length == effectiveLimit ? items.last.id : null,
    );
  }

  /// 訂閱裝置命令狀態更新（Serverpod Streaming）。
  Stream<DeviceCommand> watchDeviceCommands(
    Session session,
    int deviceId,
  ) async* {
    final companyId = await TenantService.resolveCompanyId(session);
    await TenantService.assertDeviceAccess(session, companyId, deviceId);
    yield* session.messages.createStream<DeviceCommand>(
      TelemetryChannels.deviceCommands(companyId, deviceId),
    );
  }
}
