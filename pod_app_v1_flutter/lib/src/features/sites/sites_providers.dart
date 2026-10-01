import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/offline_cache.dart';
import '../../core/offline_providers.dart';
import '../../core/providers.dart';

/// 目前租戶的場域列表；離線時回退本機快取。
final sitesProvider = FutureProvider.autoDispose<List<Site>>((ref) async {
  final client = ref.watch(clientProvider);
  // 網路恢復時立即重新抓取。
  ref.watch(isOnlineProvider);
  try {
    final sites = await client.site.listSites();
    await OfflineCache.save('sites', [for (final s in sites) s.toJson()]);
    return sites;
  } catch (_) {
    final cached = await OfflineCache.load('sites');
    if (cached == null) rethrow;
    return [
      for (final json in cached.json as List)
        Site.fromJson((json as Map).cast<String, dynamic>()),
    ];
  }
});
