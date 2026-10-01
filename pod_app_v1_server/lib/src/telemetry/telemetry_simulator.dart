import 'dart:async';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../device/device_profiles.dart';
import '../generated/protocol.dart';
import 'telemetry_channels.dart';

/// 開發環境的感測數據模擬器。
///
/// 取代實際的 MQTT ingestion 路徑（Device → Gateway → MQTT → Consumer），
/// 讓垂直切片可以在 iOS Simulator 上完整驗證：
/// 批次寫入 Measurement、更新 DeviceStatus、透過 Message Central
/// 推送給 Serverpod Streaming 訂閱者。
///
/// 另外模擬裝置端行為：
/// - 推進控制命令狀態機（created → sent → acknowledged → completed）
/// - 依告警規則評估量測值，觸發／恢復告警
class TelemetrySimulator {
  TelemetrySimulator(this._pod, {this.interval = const Duration(seconds: 2)});

  final Serverpod _pod;
  final Duration interval;
  final _random = Random();
  Timer? _timer;
  bool _ticking = false;

  void start() {
    _timer ??= Timer.periodic(interval, (_) => _tick());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _tick() async {
    if (_ticking) return;
    _ticking = true;
    final session = await _pod.createSession(enableLogging: false);
    try {
      final devices = await Device.db.find(session);
      if (devices.isEmpty) return;
      final statuses = await DeviceStatus.db.find(session);
      final statusByDevice = {for (final s in statuses) s.deviceId: s};

      final now = DateTime.now().toUtc();
      final measurements = <Measurement>[];

      for (final device in devices) {
        final status = statusByDevice[device.id!];
        final values = <String, double>{...?status?.latestValues};

        // 控制參數：尚未設定時帶入出廠預設值（之後由 setParam 命令改寫）。
        for (final control in DeviceProfiles.controlsOf(device)) {
          values.putIfAbsent(
            control.key,
            () => control.defaultValue ?? control.minValue,
          );
        }

        // 每個量測通道各產生一筆量測（多通道設備一個 tick 多筆）。
        for (final feature in DeviceProfiles.measurementsOf(device)) {
          final value = _simulateValue(feature.key, now, values);
          values[feature.key] = value;
          measurements.add(
            Measurement(
              companyId: device.companyId,
              deviceId: device.id!,
              featureKey: feature.key,
              value: value,
              measuredAt: now,
              receivedAt: now,
            ),
          );
        }

        if (status == null) continue;
        final updated = status.copyWith(
          connectionState: DeviceConnectionState.online,
          latestValues: values,
          lastUpdatedAt: now,
        );
        await DeviceStatus.db.updateRow(session, updated);
        await session.messages.postMessage(
          TelemetryChannels.siteStatus(device.companyId, device.siteId),
          updated,
        );
      }

      // 高頻資料一律批次寫入，不逐筆交易（docs/backend/iot-data-flow.md）。
      await Measurement.db.insert(session, measurements);

      await _advanceCommands(session, now);
      await _evaluateAlertRules(session, devices, measurements, now);
      await _accumulateProductionStats(session, now);
    } catch (e, stackTrace) {
      session.log(
        '模擬器 tick 失敗: $e',
        level: LogLevel.warning,
        stackTrace: stackTrace,
      );
    } finally {
      _ticking = false;
      await session.close();
    }
  }

  /// 模擬裝置端回應：每 tick 將未終態命令往下推進一步。
  Future<void> _advanceCommands(Session session, DateTime now) async {
    final pending = await DeviceCommand.db.find(
      session,
      where: (t) => t.state.inSet({
        DeviceCommandState.created,
        DeviceCommandState.sent,
        DeviceCommandState.acknowledged,
      }),
    );
    for (final command in pending) {
      final advanced = switch (command.state) {
        DeviceCommandState.created => command.copyWith(
          state: DeviceCommandState.sent,
          sentAt: now,
        ),
        DeviceCommandState.sent => command.copyWith(
          state: DeviceCommandState.acknowledged,
          acknowledgedAt: now,
        ),
        _ => command.copyWith(
          state: DeviceCommandState.completed,
          completedAt: now,
        ),
      };
      final updated = await DeviceCommand.db.updateRow(session, advanced);
      if (updated.state == DeviceCommandState.completed &&
          updated.commandType == 'setParam') {
        await _applyControlParam(session, updated, now);
      }
      await session.messages.postMessage(
        TelemetryChannels.deviceCommands(updated.companyId, updated.deviceId),
        updated,
      );
    }
  }

  /// setParam 命令完成時模擬裝置套用控制參數：
  /// 寫回 DeviceStatus.latestValues 並推送狀態更新。
  Future<void> _applyControlParam(
    Session session,
    DeviceCommand command,
    DateTime now,
  ) async {
    final key = command.payload['featureKey'];
    final value = double.tryParse(command.payload['value'] ?? '');
    if (key == null || value == null) return;

    final device = await Device.db.findById(session, command.deviceId);
    final status = await DeviceStatus.db.findFirstRow(
      session,
      where: (t) => t.deviceId.equals(command.deviceId),
    );
    if (device == null || status == null) return;

    final updated = status.copyWith(
      latestValues: {...status.latestValues, key: value},
      lastUpdatedAt: now,
    );
    await DeviceStatus.db.updateRow(session, updated);
    await session.messages.postMessage(
      TelemetryChannels.siteStatus(device.companyId, device.siteId),
      updated,
    );
  }

  /// 依啟用中的規則評估本 tick 量測值：超標觸發告警、恢復自動 resolved。
  Future<void> _evaluateAlertRules(
    Session session,
    List<Device> devices,
    List<Measurement> measurements,
    DateTime now,
  ) async {
    final rules = await AlertRule.db.find(
      session,
      where: (t) => t.enabled.equals(true),
    );
    if (rules.isEmpty) return;

    final openAlerts = await Alert.db.find(
      session,
      where: (t) => t.state.inSet({AlertState.active, AlertState.acknowledged}),
    );
    final openByRule = {for (final a in openAlerts) a.ruleId: a};
    final deviceById = {for (final d in devices) d.id!: d};
    final valueByDeviceFeature = {
      for (final m in measurements) (m.deviceId, m.featureKey): m.value,
    };

    for (final rule in rules) {
      final value = valueByDeviceFeature[(rule.deviceId, rule.featureKey)];
      if (value == null) continue;
      final device = deviceById[rule.deviceId];
      final breached = _isBreached(value, rule);
      final open = openByRule[rule.id];

      if (breached && open == null) {
        final alert = await Alert.db.insertRow(
          session,
          Alert(
            companyId: rule.companyId,
            siteId: device?.siteId ?? 0,
            deviceId: rule.deviceId,
            ruleId: rule.id!,
            featureKey: rule.featureKey,
            triggeredValue: value,
            threshold: rule.threshold,
            comparison: rule.comparison,
            severity: rule.severity,
            mobileNotificationEnabled: rule.mobileNotificationEnabled,
            state: AlertState.active,
            message:
                '${device?.name ?? '設備 ${rule.deviceId}'} '
                '${rule.featureKey} = $value，'
                '${_comparisonLabel(rule.comparison)} ${rule.threshold}',
            triggeredAt: now,
          ),
        );
        await session.messages.postMessage(
          TelemetryChannels.companyAlerts(alert.companyId),
          alert,
        );
      } else if (!breached && open != null) {
        final resolved = await Alert.db.updateRow(
          session,
          open.copyWith(state: AlertState.resolved, resolvedAt: now),
        );
        await session.messages.postMessage(
          TelemetryChannels.companyAlerts(resolved.companyId),
          resolved,
        );
      }
    }
  }

  /// 累加當前小時的產線統計（模擬 PLC / MES 資料來源）。
  Future<void> _accumulateProductionStats(Session session, DateTime now) async {
    final sites = await Site.db.find(session);
    if (sites.isEmpty) return;

    final windowStart = DateTime.utc(now.year, now.month, now.day, now.hour);
    final tickMinutes = interval.inMilliseconds / 60000;

    for (final site in sites) {
      final existing = await ProductionStat.db.findFirstRow(
        session,
        where: (t) =>
            t.siteId.equals(site.id!) & t.windowStart.equals(windowStart),
      );
      // 稼動 ~93%、性能 ~94%、良率 ~98% 的隨機波動。
      final running = _random.nextDouble() < 0.93;
      final ideal = (tickMinutes * 60).round();
      final actual = running
          ? (ideal * (0.88 + _random.nextDouble() * 0.12)).round()
          : 0;
      final good = (actual * (0.96 + _random.nextDouble() * 0.04)).round();

      if (existing == null) {
        await ProductionStat.db.insertRow(
          session,
          ProductionStat(
            companyId: site.companyId,
            siteId: site.id!,
            windowStart: windowStart,
            plannedMinutes: tickMinutes,
            runMinutes: running ? tickMinutes : 0,
            idealCount: ideal,
            actualCount: actual,
            goodCount: good,
          ),
        );
      } else {
        await ProductionStat.db.updateRow(
          session,
          existing.copyWith(
            plannedMinutes: existing.plannedMinutes + tickMinutes,
            runMinutes: existing.runMinutes + (running ? tickMinutes : 0),
            idealCount: existing.idealCount + ideal,
            actualCount: existing.actualCount + actual,
            goodCount: existing.goodCount + good,
          ),
        );
      }
    }
  }

  bool _isBreached(double value, AlertRule rule) => switch (rule.comparison) {
    AlertComparison.greaterThan => value > rule.threshold,
    AlertComparison.greaterOrEqual => value >= rule.threshold,
    AlertComparison.lessThan => value < rule.threshold,
    AlertComparison.lessOrEqual => value <= rule.threshold,
  };

  String _comparisonLabel(AlertComparison comparison) => switch (comparison) {
    AlertComparison.greaterThan => '超過閾值',
    AlertComparison.greaterOrEqual => '達到上限',
    AlertComparison.lessThan => '低於閾值',
    AlertComparison.lessOrEqual => '達到下限',
  };

  /// 依 featureKey 產生模擬值。[current] 為裝置當前狀態值，
  /// 讓量測能反映控制參數（例如 rpm 追隨 targetRpm、風扇壓低馬達溫度）。
  double _simulateValue(
    String featureKey,
    DateTime now,
    Map<String, double> current,
  ) {
    final phase = now.millisecondsSinceEpoch / 60000 * 2 * pi;
    final noise = (_random.nextDouble() - 0.5);
    final targetRpm = current['targetRpm'] ?? 1500;
    final coolingFan = current['coolingFan'] ?? 40;
    final value = switch (featureKey) {
      'temperature' => 25 + 4 * sin(phase) + noise,
      'humidity' => 55 + 10 * sin(phase / 3) + noise * 4,
      'power' => 120 + 30 * sin(phase / 5) + noise * 10,
      'vibration' => 0.5 + 0.3 * sin(phase * 2).abs() + noise * 0.1,
      'co2' => 650 + 150 * sin(phase / 7) + noise * 40,
      'lux' => 800 + 300 * sin(phase / 11) + noise * 60,
      // 轉速追隨目標轉速；馬達溫度隨轉速升、隨風扇降。
      'rpm' => targetRpm + noise * 30,
      'motorTemp' =>
        35 + targetRpm / 3000 * 45 - coolingFan / 100 * 15 + noise * 2,
      'current' => 40 + 15 * sin(phase / 4) + noise * 5,
      'torque' => 180 + 60 * sin(phase / 6) + noise * 15,
      'voltage' => 380 + 8 * sin(phase / 9) + noise * 3,
      _ => 50 + noise * 10,
    };
    return double.parse(value.toStringAsFixed(2));
  }
}
