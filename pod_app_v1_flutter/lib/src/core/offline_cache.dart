import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// 離線快取（docs 說明書 21.4）：
/// 最後成功取得的資料存於本機，離線時顯示並標記最後同步時間。
class OfflineCache {
  static const _payloadPrefix = 'cache_payload_';
  static const _syncedAtPrefix = 'cache_synced_at_';

  /// 寫入一份 JSON 快取並記錄同步時間。
  static Future<void> save(String key, Object jsonPayload) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_payloadPrefix$key', jsonEncode(jsonPayload));
    await prefs.setString(
      '$_syncedAtPrefix$key',
      DateTime.now().toIso8601String(),
    );
  }

  /// 讀取快取；不存在時回傳 null。
  static Future<CachedPayload?> load(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_payloadPrefix$key');
    final syncedAt = prefs.getString('$_syncedAtPrefix$key');
    if (raw == null || syncedAt == null) return null;
    return CachedPayload(
      json: jsonDecode(raw),
      syncedAt: DateTime.parse(syncedAt),
    );
  }
}

class CachedPayload {
  const CachedPayload({required this.json, required this.syncedAt});

  final dynamic json;
  final DateTime syncedAt;
}
