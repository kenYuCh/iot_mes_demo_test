import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';

/// 裝置近期命令歷史（新到舊，取一頁）。
final commandsProvider = FutureProvider.autoDispose
    .family<DeviceCommandListResult, int>((ref, deviceId) {
      final client = ref.watch(clientProvider);
      return client.command.listCommands(deviceId, limit: 10);
    });

/// 裝置命令狀態即時更新（Serverpod Streaming）。
final commandUpdatesProvider = StreamProvider.autoDispose
    .family<DeviceCommand, int>((ref, deviceId) {
      final client = ref.watch(clientProvider);
      return client.command.watchDeviceCommands(deviceId);
    });
