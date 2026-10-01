import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../telemetry/telemetry_channels.dart';

/// Evaluates persisted alert rules for real MQTT telemetry.
///
/// Only the transition from normal to breached creates an alert and a phone
/// notification candidate. Further breached samples reuse the open alert,
/// preventing a five-second sensor from flooding the user.
class AlertEngine {
  const AlertEngine();

  Future<void> onTelemetry(
    Session session,
    Device device,
    Map<String, double> values,
    DateTime measuredAt,
  ) async {
    if (values.isEmpty) return;
    final rules = await AlertRule.db.find(
      session,
      where: (t) =>
          t.companyId.equals(device.companyId) &
          t.deviceId.equals(device.id!) &
          t.enabled.equals(true) &
          t.featureKey.inSet(values.keys.toSet()),
    );
    if (rules.isEmpty) return;

    final ruleIds = rules.map((rule) => rule.id!).toSet();
    final openAlerts = await Alert.db.find(
      session,
      where: (t) =>
          t.ruleId.inSet(ruleIds) &
          t.state.inSet({AlertState.active, AlertState.acknowledged}),
    );
    final openByRule = {for (final alert in openAlerts) alert.ruleId: alert};

    for (final rule in rules) {
      final value = values[rule.featureKey];
      if (value == null) continue;
      final open = openByRule[rule.id];
      final breached = _isBreached(value, rule);
      if (breached && open == null) {
        final alert = await Alert.db.insertRow(
          session,
          Alert(
            companyId: rule.companyId,
            siteId: device.siteId,
            deviceId: device.id!,
            ruleId: rule.id!,
            featureKey: rule.featureKey,
            triggeredValue: value,
            threshold: rule.threshold,
            comparison: rule.comparison,
            severity: rule.severity,
            mobileNotificationEnabled: rule.mobileNotificationEnabled,
            state: AlertState.active,
            message:
                '${device.name} ${rule.featureKey} = $value，'
                '${_comparisonLabel(rule.comparison)} ${rule.threshold}',
            triggeredAt: measuredAt,
          ),
        );
        await session.messages.postMessage(
          TelemetryChannels.companyAlerts(alert.companyId),
          alert,
        );
      } else if (!breached && open != null) {
        final resolved = await Alert.db.updateRow(
          session,
          open.copyWith(
            state: AlertState.resolved,
            resolvedAt: measuredAt,
          ),
        );
        await session.messages.postMessage(
          TelemetryChannels.companyAlerts(resolved.companyId),
          resolved,
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
    AlertComparison.greaterThan => '高於',
    AlertComparison.greaterOrEqual => '高於或等於',
    AlertComparison.lessThan => '低於',
    AlertComparison.lessOrEqual => '低於或等於',
  };
}
