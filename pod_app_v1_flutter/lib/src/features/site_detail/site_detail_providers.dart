import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';

final siteProvider = FutureProvider.autoDispose.family<Site, int>((
  ref,
  siteId,
) {
  final client = ref.watch(clientProvider);
  return client.site.getSite(siteId);
});

/// 可選用的設備型別檔（伺服器目錄，變動頻率低）。
final deviceProfilesProvider = FutureProvider<List<DeviceProfile>>((ref) {
  final client = ref.watch(clientProvider);
  return client.device.listProfiles();
});

final featureCatalogProvider = FutureProvider<List<FeatureCatalogItem>>((ref) {
  final client = ref.watch(clientProvider);
  return client.device.listFeatureCatalog();
});

final gatewaysProvider = FutureProvider.autoDispose.family<List<Gateway>, int>((
  ref,
  siteId,
) {
  final client = ref.watch(clientProvider);
  return client.gateway.listBySite(siteId);
});

final devicesProvider = FutureProvider.autoDispose.family<List<Device>, int>((
  ref,
  siteId,
) {
  final client = ref.watch(clientProvider);
  return client.device.listBySite(siteId);
});

/// 場域內所有設備的即時狀態：先取 snapshot，再由 Serverpod Streaming 接收增量。
/// key 為 deviceId。離開頁面自動取消訂閱（autoDispose）。
final siteStatusesProvider = StreamProvider.autoDispose
    .family<Map<int, DeviceStatus>, int>((ref, siteId) async* {
      final client = ref.watch(clientProvider);
      final statuses = <int, DeviceStatus>{};

      final snapshot = await client.telemetry.listSiteStatuses(siteId);
      for (final status in snapshot) {
        statuses[status.deviceId] = status;
      }
      yield Map.unmodifiable(statuses);

      await for (final status in client.telemetry.watchSiteStatus(siteId)) {
        statuses[status.deviceId] = status;
        yield Map.unmodifiable(statuses);
      }
    });
