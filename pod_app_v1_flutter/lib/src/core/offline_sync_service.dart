import 'dart:convert';

import 'package:pod_app_v1_client/pod_app_v1_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 可重播、具 idempotency key 的離線設備設定佇列。
///
/// 僅允許 setParam 這類可被後值覆蓋的設定；重新啟動、校正與刪除等
/// 高風險動作不會離線排程，避免恢復網路後意外執行。
class OfflineSyncService {
  static const _key = 'offline_device_command_queue_v1';
  static bool _flushing = false;

  static Future<int> enqueueSetParam({
    required int deviceId,
    required String featureKey,
    required double value,
  }) async {
    final queue = await _load();
    // 同設備同參數只保留最新值，避免離線拖動產生大量過期命令。
    queue.removeWhere(
      (item) => item.deviceId == deviceId && item.featureKey == featureKey,
    );
    queue.add(
      _OfflineCommand(
        deviceId: deviceId,
        featureKey: featureKey,
        value: value,
        idempotencyKey:
            'offline-$deviceId-$featureKey-${DateTime.now().microsecondsSinceEpoch}',
        queuedAt: DateTime.now().toUtc(),
      ),
    );
    await _save(queue);
    return queue.length;
  }

  static Future<int> pendingCount() async => (await _load()).length;

  static Future<int> flush(Client client) async {
    if (_flushing) return pendingCount();
    _flushing = true;
    try {
      final queue = await _load();
      final remaining = <_OfflineCommand>[];
      for (var index = 0; index < queue.length; index++) {
        final item = queue[index];
        try {
          await client.command.sendCommand(
            item.deviceId,
            'setParam',
            {'featureKey': item.featureKey, 'value': '${item.value}'},
            item.idempotencyKey,
          );
        } catch (_) {
          // 保留失敗項與後續命令；下次連線再依原順序重播。
          remaining.addAll(queue.skip(index));
          break;
        }
      }
      await _save(remaining);
      return remaining.length;
    } finally {
      _flushing = false;
    }
  }

  static Future<List<_OfflineCommand>> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    try {
      return [
        for (final item in jsonDecode(raw) as List)
          _OfflineCommand.fromJson(item as Map<String, dynamic>),
      ];
    } catch (_) {
      return [];
    }
  }

  static Future<void> _save(List<_OfflineCommand> queue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode([for (final item in queue) item.toJson()]),
    );
  }
}

class _OfflineCommand {
  const _OfflineCommand({
    required this.deviceId,
    required this.featureKey,
    required this.value,
    required this.idempotencyKey,
    required this.queuedAt,
  });
  factory _OfflineCommand.fromJson(Map<String, dynamic> json) =>
      _OfflineCommand(
        deviceId: json['deviceId'] as int,
        featureKey: json['featureKey'] as String,
        value: (json['value'] as num).toDouble(),
        idempotencyKey: json['idempotencyKey'] as String,
        queuedAt: DateTime.parse(json['queuedAt'] as String),
      );
  final int deviceId;
  final String featureKey;
  final double value;
  final String idempotencyKey;
  final DateTime queuedAt;
  Map<String, dynamic> toJson() => {
    'deviceId': deviceId,
    'featureKey': featureKey,
    'value': value,
    'idempotencyKey': idempotencyKey,
    'queuedAt': queuedAt.toIso8601String(),
  };
}
