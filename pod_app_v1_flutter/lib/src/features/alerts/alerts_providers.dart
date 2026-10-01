import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';

/// 告警列表（新到舊，取一頁）。
final alertsProvider = FutureProvider.autoDispose<AlertListResult>((ref) {
  final client = ref.watch(clientProvider);
  return client.alert.listAlerts(openOnly: false, limit: 50);
});

/// 未結束（active/acknowledged）告警，供徽章計數。
final openAlertsProvider = FutureProvider.autoDispose<AlertListResult>((ref) {
  final client = ref.watch(clientProvider);
  return client.alert.listAlerts(openOnly: true, limit: 100);
});

/// 公司告警規則列表。
final alertRulesProvider = FutureProvider.autoDispose<List<AlertRule>>((ref) {
  final client = ref.watch(clientProvider);
  return client.alert.listRules();
});

/// 告警事件即時串流（觸發、確認、恢復）。
final alertUpdatesProvider = StreamProvider.autoDispose<Alert>((ref) {
  final client = ref.watch(clientProvider);
  return client.alert.watchAlerts();
});

/// 建立規則用：全公司所有設備。
final allDevicesProvider = FutureProvider.autoDispose<List<Device>>((
  ref,
) async {
  final client = ref.watch(clientProvider);
  final sites = await client.site.listSites();
  final lists = await Future.wait([
    for (final site in sites) client.device.listBySite(site.id!),
  ]);
  return [for (final list in lists) ...list];
});
