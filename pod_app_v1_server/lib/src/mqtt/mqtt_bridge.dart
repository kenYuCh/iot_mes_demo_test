import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:serverpod/serverpod.dart';

import '../alert/alert_engine.dart';
import '../generated/protocol.dart';
import '../ota/ota_device_fallback_service.dart';
import '../operations/automation_engine.dart';
import '../telemetry/telemetry_channels.dart';
import '../device/device_profiles.dart';
import 'mqtt_config.dart';

/// Server ↔ MQTTS 橋接。
///
/// 架構（App 不直連 MQTT）：
/// ```
/// App --HTTPS/JWT--> Serverpod --mTLS--> Mosquitto:8883 <--mTLS-- Device
/// ```
///
/// - 訂閱 `devices/+/telemetry`：寫入 Measurement／DeviceStatus，推送 Streaming
/// - 發布 `devices/{serial}/commands/set`：App 下發命令時同步到設備
class MqttBridge {
  MqttBridge(this._pod) {
    _automation = AutomationEngine(_pod, publishCommand);
  }

  final Serverpod _pod;
  late final AutomationEngine _automation;
  final AlertEngine _alerts = const AlertEngine();
  MqttServerClient? _client;
  StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>? _updates;
  bool _started = false;

  bool get isConnected =>
      _client?.connectionStatus?.state == MqttConnectionState.connected;

  /// 啟動並連線；憑證缺失或連線失敗時僅記錄警告（開發環境仍可用模擬器）。
  Future<void> start() async {
    if (_started) return;
    if (!MqttConfig.credentialsReady) {
      stdout.writeln(
        '[MqttBridge] 略過：找不到 backend MQTT 憑證。'
        '請執行 ./tool/setup_mqtts.sh 後重啟。',
      );
      return;
    }

    _started = true;
    final client = MqttServerClient.withPort(
      MqttConfig.host,
      MqttConfig.clientId,
      MqttConfig.port,
    );
    client.secure = true;
    client.keepAlivePeriod = 30;
    client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = true;
    client.setProtocolV311();
    client.logging(on: false);

    final context = SecurityContext(withTrustedRoots: false)
      ..setTrustedCertificates(MqttConfig.caCert)
      ..useCertificateChain(MqttConfig.clientCertChain)
      ..usePrivateKey(MqttConfig.clientKey);
    client.securityContext = context;

    client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(MqttConfig.clientId)
        .startClean();

    client.onConnected = () {
      stdout.writeln(
        '[MqttBridge] 已連線 ${MqttConfig.host}:${MqttConfig.port}（mTLS）',
      );
      client.subscribe('devices/+/telemetry', MqttQos.atLeastOnce);
      client.subscribe('devices/+/state', MqttQos.atLeastOnce);
      client.subscribe('devices/+/controls/state', MqttQos.atLeastOnce);
      client.subscribe('devices/+/ota/status', MqttQos.atLeastOnce);
      client.subscribe('devices/+/commands/status', MqttQos.atLeastOnce);
      client.subscribe('devices/+/availability', MqttQos.atLeastOnce);
    };
    client.onDisconnected = () {
      stdout.writeln('[MqttBridge] 連線中斷，將自動重試…');
    };
    client.onAutoReconnect = () {
      stdout.writeln('[MqttBridge] 自動重連中…');
    };

    _client = client;
    try {
      await client.connect();
    } catch (e) {
      stdout.writeln(
        '[MqttBridge] 連線失敗：$e（請確認 docker compose up -d mosquitto）',
      );
      client.disconnect();
      return;
    }

    if (!isConnected) {
      stdout.writeln(
        '[MqttBridge] 連線狀態異常：${client.connectionStatus}',
      );
      return;
    }

    _updates = client.updates?.listen(_onMessages);
  }

  void stop() {
    _automation.stop();
    _updates?.cancel();
    _updates = null;
    _client?.disconnect();
    _client = null;
    _started = false;
  }

  /// 下發命令到設備 topic（找不到序號或未連線時回傳 false）。
  Future<bool> publishCommand({
    required String serial,
    required DeviceCommand command,
  }) async {
    final client = _client;
    if (client == null || !isConnected) return false;

    final payload = jsonEncode({
      'version': 1,
      'requestId': command.idempotencyKey,
      'commandType': command.commandType,
      'payload': command.payload,
      'issuedBy': command.issuedBy,
      'issuedAt': command.createdAt.toUtc().toIso8601String(),
    });
    final builder = MqttClientPayloadBuilder()..addString(payload);
    client.publishMessage(
      'devices/$serial/commands/set',
      MqttQos.atLeastOnce,
      builder.payload!,
    );
    return true;
  }

  Future<bool> publishOtaRequest({
    required String serial,
    required int campaignId,
    required FirmwarePackage firmware,
  }) async {
    final client = _client;
    if (client == null || !isConnected) return false;
    final baseUrl =
        Platform.environment['FIRMWARE_PUBLIC_BASE_URL'] ??
        'http://localhost:8082';
    final relative = firmware.downloadUrl.startsWith('/')
        ? firmware.downloadUrl
        : '/firmware/${firmware.fileName ?? ''}';
    final payload = jsonEncode({
      'schemaVersion': 1,
      'campaignId': campaignId,
      'version': firmware.version,
      'url': '$baseUrl$relative',
      'sha256': firmware.sha256,
      'sizeBytes': firmware.sizeBytes,
      'productKey': firmware.productKey,
      'chipFamily': firmware.chipFamily,
      'hardwareRevision': firmware.hardwareRevision,
    });
    final builder = MqttClientPayloadBuilder()..addString(payload);
    client.publishMessage(
      'devices/$serial/ota/request',
      MqttQos.atLeastOnce,
      builder.payload!,
    );
    return true;
  }

  /// Ask a physical device to clear only its Wi-Fi provisioning state and
  /// reboot into BLE advertising mode. This must be sent before Server-side
  /// credentials are revoked, otherwise the device can no longer receive it.
  Future<bool> publishProvisioningReset(String serial) async {
    final client = _client;
    if (client == null || !isConnected) return false;
    final payload = jsonEncode({
      'version': 1,
      'requestId':
          'provisioning-reset-${DateTime.now().microsecondsSinceEpoch}',
      'commandType': 'system',
      'payload': {'featureKey': 'provisioning_reset', 'value': true},
      'issuedBy': 'server',
      'issuedAt': DateTime.now().toUtc().toIso8601String(),
    });
    final builder = MqttClientPayloadBuilder()..addString(payload);
    client.publishMessage(
      'devices/$serial/commands/set',
      MqttQos.atLeastOnce,
      builder.payload!,
    );
    return true;
  }

  Future<void> _onMessages(
    List<MqttReceivedMessage<MqttMessage>> messages,
  ) async {
    for (final message in messages) {
      final rec = message.payload;
      if (rec is! MqttPublishMessage) continue;
      final topic = message.topic;
      final body = MqttPublishPayload.bytesToStringAsString(
        rec.payload.message,
      );
      try {
        await _ingest(topic, body);
      } catch (e, st) {
        stdout.writeln('[MqttBridge] 處理 $topic 失敗：$e\n$st');
      }
    }
  }

  /// topic: devices/{serial}/telemetry|state|controls/state
  Future<void> _ingest(String topic, String body) async {
    final parts = topic.split('/');
    if (parts.length < 3 || parts[0] != 'devices') return;
    final serial = parts[1];
    final kind = parts[2];
    if (kind == 'availability') {
      await _ingestAvailability(serial, body);
      return;
    }
    if (parts.length >= 4 && kind == 'ota' && parts[3] == 'status') {
      await _ingestOtaStatus(serial, body);
      return;
    }
    if (parts.length >= 4 && kind == 'commands' && parts[3] == 'status') {
      await _ingestCommandStatus(serial, body);
      return;
    }
    final isControlState =
        kind == 'controls' && parts.length >= 4 && parts[3] == 'state';
    if (kind != 'telemetry' && kind != 'state' && !isControlState) return;

    final decoded = jsonDecode(body);
    if (decoded is! Map) return;
    final session = await _pod.createSession(enableLogging: false);
    try {
      final provisioned = await ProvisionedDevice.db.findFirstRow(
        session,
        where: (t) => t.serial.equals(serial),
      );
      final deviceId = provisioned?.linkedDeviceId;
      if (deviceId == null) {
        // 尚未加入設備庫：略過（身分層已配對、營運層未掛載）。
        return;
      }

      final device = await Device.db.findById(session, deviceId);
      final status = await DeviceStatus.db.findFirstRow(
        session,
        where: (t) => t.deviceId.equals(deviceId),
      );
      if (device == null || status == null) return;

      // Firmware metadata belongs to the retained/low-frequency state topic,
      // never to high-frequency telemetry measurements.
      final reportedFirmware = decoded['firmwareVersion'];
      if (kind == 'state' &&
          reportedFirmware is String &&
          reportedFirmware.isNotEmpty &&
          reportedFirmware != device.firmwareVersion) {
        await Device.db.updateRow(
          session,
          device.copyWith(firmwareVersion: reportedFirmware),
        );
      }
      if (kind == 'state' &&
          reportedFirmware is String &&
          reportedFirmware.isNotEmpty) {
        await _reconcileOtaFromReportedFirmware(
          session,
          deviceId,
          reportedFirmware,
        );
      }

      final features = {
        for (final feature in DeviceProfiles.featuresFor(device))
          feature.key: feature,
      };
      final values = <String, double>{};
      for (final entry in decoded.entries) {
        final key = entry.key.toString();
        final feature = features[key];
        if (feature == null) continue;
        final value = _decodeFeatureValue(feature, entry.value);
        if (value != null) values[key] = value;
      }
      final now = DateTime.now().toUtc();
      final measurementValues = <String, double>{
        for (final entry in values.entries)
          if (features[entry.key]?.kind == FeatureKind.measurement)
            entry.key: entry.value,
      };
      if (measurementValues.isNotEmpty) {
        final measurements = [
          for (final entry in measurementValues.entries)
            Measurement(
              companyId: device.companyId,
              deviceId: deviceId,
              featureKey: entry.key,
              value: double.parse(entry.value.toStringAsFixed(2)),
              measuredAt: now,
              receivedAt: now,
            ),
        ];
        await Measurement.db.insert(session, measurements);
      }

      // A valid state/telemetry packet is also the device heartbeat. State
      // packets commonly contain metadata only, so they must still transition
      // the device from unknown/offline to online without inventing a sensor
      // measurement.
      final updated = status.copyWith(
        connectionState: DeviceConnectionState.online,
        latestValues: {...status.latestValues, ...values},
        lastUpdatedAt: now,
      );
      await DeviceStatus.db.updateRow(session, updated);
      await session.messages.postMessage(
        TelemetryChannels.siteStatus(device.companyId, device.siteId),
        updated,
      );
      if (measurementValues.isNotEmpty) {
        await _alerts.onTelemetry(
          session,
          device,
          measurementValues,
          now,
        );
        await _automation.onTelemetry(
          session,
          device,
          measurementValues,
          now,
        );
      }
    } finally {
      await session.close();
    }
  }

  Future<void> _ingestAvailability(String serial, String body) async {
    final state = body.trim().toLowerCase();
    if (state != 'online' && state != 'offline') return;
    final session = await _pod.createSession(enableLogging: false);
    try {
      final provisioned = await ProvisionedDevice.db.findFirstRow(
        session,
        where: (t) => t.serial.equals(serial),
      );
      final deviceId = provisioned?.linkedDeviceId;
      if (deviceId == null) return;
      final device = await Device.db.findById(session, deviceId);
      final status = await DeviceStatus.db.findFirstRow(
        session,
        where: (t) => t.deviceId.equals(deviceId),
      );
      if (device == null || status == null) return;
      final updated = await DeviceStatus.db.updateRow(
        session,
        status.copyWith(
          connectionState: state == 'online'
              ? DeviceConnectionState.online
              : DeviceConnectionState.offline,
          lastUpdatedAt: state == 'online'
              ? DateTime.now().toUtc()
              : status.lastUpdatedAt,
        ),
      );
      await session.messages.postMessage(
        TelemetryChannels.siteStatus(device.companyId, device.siteId),
        updated,
      );
    } finally {
      await session.close();
    }
  }

  Future<void> _ingestCommandStatus(String serial, String body) async {
    final decoded = jsonDecode(body);
    if (decoded is! Map) return;
    final requestId = decoded['requestId']?.toString();
    final stateName = decoded['state']?.toString();
    if (requestId == null || stateName == null) return;
    final session = await _pod.createSession(enableLogging: false);
    try {
      final command = await DeviceCommand.db.findFirstRow(
        session,
        where: (t) => t.idempotencyKey.equals(requestId),
      );
      if (command == null) return;
      final now = DateTime.now().toUtc();
      final success = stateName == 'completed' || stateName == 'acknowledged';
      final updated = await DeviceCommand.db.updateRow(
        session,
        command.copyWith(
          state: success
              ? DeviceCommandState.completed
              : DeviceCommandState.failed,
          acknowledgedAt: now,
          completedAt: now,
          errorMessage: success
              ? null
              : decoded['error']?.toString() ?? '設備拒絕命令',
        ),
      );
      await session.messages.postMessage(
        TelemetryChannels.deviceCommands(command.companyId, command.deviceId),
        updated,
      );
    } finally {
      await session.close();
    }
  }

  double? _decodeFeatureValue(DeviceFeature feature, Object? raw) {
    if (raw is num) return raw.toDouble();
    if (raw is bool) return raw ? 1 : 0;
    if (raw is! String) return null;
    final numeric = double.tryParse(raw);
    if (numeric != null) return numeric;
    final normalized = raw.trim().toUpperCase();
    if (feature.dataType == FeatureDataType.boolean) {
      if (normalized == 'ON' || normalized == 'TRUE') return 1;
      if (normalized == 'OFF' || normalized == 'FALSE') return 0;
    }
    if (feature.dataType == FeatureDataType.enumeration) {
      final options = feature.enumOptions ?? const <String>[];
      final index = options.indexWhere(
        (option) => option.toUpperCase() == normalized,
      );
      if (index >= 0) return index.toDouble();
    }
    return null;
  }

  Future<void> _ingestOtaStatus(String serial, String body) async {
    final decoded = jsonDecode(body);
    if (decoded is! Map) return;
    final session = await _pod.createSession(enableLogging: false);
    try {
      await OtaDeviceFallbackService.ingestStatus(
        session,
        serial: serial,
        status: decoded.map(
          (key, value) => MapEntry(key.toString(), value),
        ),
      );
    } finally {
      await session.close();
    }
  }

  /// A device can lose MQTT while downloading and reboot before its final OTA
  /// status packet is delivered. Its retained identity state is authoritative:
  /// if the running version matches an active job's target package, complete
  /// that job and campaign instead of leaving the App permanently loading.
  Future<void> _reconcileOtaFromReportedFirmware(
    Session session,
    int deviceId,
    String reportedFirmware,
  ) async {
    final jobs = await OtaDeviceJob.db.find(
      session,
      where: (t) => t.deviceId.equals(deviceId),
    );
    for (final job in jobs) {
      final watchdogFailure =
          job.state == OtaJobState.failed &&
          job.errorMessage?.contains('沒有收到新的 OTA 進度') == true;
      if (job.state == OtaJobState.succeeded ||
          (job.state == OtaJobState.failed && !watchdogFailure) ||
          job.state == OtaJobState.rolledBack) {
        continue;
      }
      final campaign = await OtaCampaign.db.findById(session, job.campaignId);
      if (campaign == null ||
          (campaign.state != OtaCampaignState.running && !watchdogFailure)) {
        continue;
      }
      final firmware = await FirmwarePackage.db.findById(
        session,
        campaign.firmwarePackageId,
      );
      if (firmware?.version != reportedFirmware) {
        // Rollback-test images intentionally return to the previously running
        // firmware. The final MQTT status may be lost while the ESP32 reboots,
        // so its fresh retained identity message is the recovery signal.
        final isRollbackTest =
            firmware?.fileName?.toLowerCase().contains('rollback_test') == true;
        final hadStarted =
            job.state == OtaJobState.downloading ||
            job.state == OtaJobState.installing ||
            job.state == OtaJobState.verifying;
        if (isRollbackTest && hadStarted) {
          await OtaDeviceJob.db.updateRow(
            session,
            job.copyWith(
              state: OtaJobState.rolledBack,
              progress: 100,
              errorMessage: '設備健康檢查未通過，已自動回滾至 v$reportedFirmware',
              updatedAt: DateTime.now().toUtc(),
            ),
          );
          await _finishCampaignIfTerminal(session, campaign.id!);
        }
        continue;
      }
      await OtaDeviceJob.db.updateRow(
        session,
        job.copyWith(
          state: OtaJobState.succeeded,
          progress: 100,
          errorMessage: null,
          updatedAt: DateTime.now().toUtc(),
        ),
      );
      await _finishCampaignIfTerminal(session, campaign.id!);
    }
  }

  Future<void> _finishCampaignIfTerminal(
    Session session,
    int campaignId,
  ) async {
    final campaign = await OtaCampaign.db.findById(session, campaignId);
    if (campaign == null) return;
    final jobs = await OtaDeviceJob.db.find(
      session,
      where: (t) => t.campaignId.equals(campaignId),
    );
    final succeeded = jobs
        .where((job) => job.state == OtaJobState.succeeded)
        .length;
    final failed = jobs
        .where(
          (job) =>
              job.state == OtaJobState.failed ||
              job.state == OtaJobState.rolledBack,
        )
        .length;
    if (succeeded + failed != jobs.length) return;
    await OtaCampaign.db.updateRow(
      session,
      campaign.copyWith(
        state: failed == 0
            ? OtaCampaignState.completed
            : OtaCampaignState.failed,
        succeededDevices: succeeded,
        failedDevices: failed,
        completedAt: DateTime.now().toUtc(),
      ),
    );
  }
}

/// 全域 bridge 實例（CommandEndpoint 下發時共用）。
MqttBridge? mqttBridge;
