import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Resolves persisted heartbeats into a current connection state.
///
/// MQTT availability provides immediate disconnect detection. This timeout is
/// the safety net for broker/server outages where no LWT can be consumed.
class DevicePresenceService {
  const DevicePresenceService._();

  static DeviceConnectionState effectiveState(
    Device device,
    DeviceStatus status, {
    DateTime? now,
  }) {
    if (status.connectionState == DeviceConnectionState.offline) {
      return DeviceConnectionState.offline;
    }
    final heartbeat = status.lastUpdatedAt;
    if (heartbeat == null) return DeviceConnectionState.unknown;
    final age = (now ?? DateTime.now().toUtc()).difference(heartbeat.toUtc());
    final interval = Duration(
      seconds: device.expectedIntervalSeconds.clamp(1, 3600),
    );
    final staleAfter = Duration(
      seconds: (interval.inSeconds * 3).clamp(15, 3600),
    );
    final offlineAfter = Duration(
      seconds: (interval.inSeconds * 6).clamp(30, 7200),
    );
    if (age > offlineAfter) return DeviceConnectionState.offline;
    if (age > staleAfter) return DeviceConnectionState.stale;
    return DeviceConnectionState.online;
  }

  static Future<List<DeviceStatus>> refresh(
    Session session,
    List<Device> devices,
    List<DeviceStatus> statuses,
  ) async {
    final byDevice = {for (final device in devices) device.id: device};
    final now = DateTime.now().toUtc();
    final result = <DeviceStatus>[];
    for (final status in statuses) {
      final device = byDevice[status.deviceId];
      if (device == null) continue;
      final effective = effectiveState(device, status, now: now);
      if (effective == status.connectionState) {
        result.add(status);
      } else {
        result.add(
          await DeviceStatus.db.updateRow(
            session,
            status.copyWith(connectionState: effective),
          ),
        );
      }
    }
    return result;
  }
}
