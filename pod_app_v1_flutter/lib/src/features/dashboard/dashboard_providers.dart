import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/offline_cache.dart';
import '../../core/offline_providers.dart';
import '../../core/providers.dart';

/// Dashboard 資料與快取來源標記。
class DashboardView {
  const DashboardView({
    required this.summary,
    required this.fromCache,
    required this.syncedAt,
  });

  final DashboardSummary summary;
  final bool fromCache;
  final DateTime syncedAt;
}

/// 全公司 Dashboard 彙總，每 10 秒自動刷新。
/// 離線時回退到本機快取並標記最後同步時間（docs 說明書 21.4）。
final dashboardProvider = FutureProvider.autoDispose<DashboardView>((
  ref,
) async {
  final client = ref.watch(clientProvider);
  // 網路恢復時立即重新抓取。
  ref.watch(isOnlineProvider);
  final timer = Timer(const Duration(seconds: 10), ref.invalidateSelf);
  ref.onDispose(timer.cancel);

  try {
    final summary = await client.dashboard.getSummary();
    await OfflineCache.save('dashboard', summary.toJson());
    return DashboardView(
      summary: summary,
      fromCache: false,
      syncedAt: DateTime.now(),
    );
  } catch (_) {
    final cached = await OfflineCache.load('dashboard');
    if (cached == null) rethrow;
    return DashboardView(
      summary: DashboardSummary.fromJson(
        (cached.json as Map).cast<String, dynamic>(),
      ),
      fromCache: true,
      syncedAt: cached.syncedAt,
    );
  }
});

/// 近 8 小時 OEE 彙總，每 30 秒刷新；離線回退快取。
final oeeProvider = FutureProvider.autoDispose<OeeSummary>((ref) async {
  final client = ref.watch(clientProvider);
  ref.watch(isOnlineProvider);
  final timer = Timer(const Duration(seconds: 30), ref.invalidateSelf);
  ref.onDispose(timer.cancel);

  try {
    final summary = await client.dashboard.getOee();
    await OfflineCache.save('oee', summary.toJson());
    return summary;
  } catch (_) {
    final cached = await OfflineCache.load('oee');
    if (cached == null) rethrow;
    return OeeSummary.fromJson((cached.json as Map).cast<String, dynamic>());
  }
});
