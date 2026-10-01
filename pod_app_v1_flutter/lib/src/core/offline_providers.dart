import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 網路連線狀態串流（Wi-Fi 死角、蜂巢網路切換時更新）。
final connectivityProvider = StreamProvider<List<ConnectivityResult>>((ref) {
  return Connectivity().onConnectivityChanged;
});

/// 是否在線。尚未取得結果時預設在線，避免啟動瞬間閃離線 Banner。
final isOnlineProvider = Provider<bool>((ref) {
  final results = ref.watch(connectivityProvider).value;
  if (results == null) return true;
  return results.any((r) => r != ConnectivityResult.none);
});
