import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';

final deviceProvider = FutureProvider.autoDispose.family<Device, int>((
  ref,
  deviceId,
) {
  final client = ref.watch(clientProvider);
  return client.device.getDevice(deviceId);
});

typedef MeasurementHistoryQuery = ({
  int deviceId,
  String featureKey,
  DateTime startAt,
  DateTime endAt,
});

/// 設備某一量測通道的區間歷史（新到舊，圖表端再依時間排序）。
final measurementsProvider = FutureProvider.autoDispose
    .family<MeasurementListResult, MeasurementHistoryQuery>((
      ref,
      key,
    ) {
      final client = ref.watch(clientProvider);
      return client.telemetry.listMeasurements(
        key.deviceId,
        featureKey: key.featureKey,
        limit: 300,
        startAt: key.startAt,
        endAt: key.endAt,
      );
    });
