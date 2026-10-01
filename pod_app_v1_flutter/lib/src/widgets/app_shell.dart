import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../core/notification_service.dart';
import '../core/offline_providers.dart';
import '../core/offline_sync_service.dart';
import '../core/providers.dart';
import '../features/alerts/alerts_providers.dart';
import '../features/work_orders/work_orders_providers.dart';

/// App 主殼層：底部導覽五分頁（docs/product/enterprise-iot-platform-spec.md）＋離線 Banner。
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final openAlertCount =
        ref.watch(openAlertsProvider).value?.items.length ?? 0;
    final openWorkOrders = ref.watch(openWorkOrderCountProvider).value ?? 0;
    final isOnline = ref.watch(isOnlineProvider);

    ref.listen<bool>(isOnlineProvider, (previous, next) {
      if (next && previous != true) {
        OfflineSyncService.flush(ref.read(clientProvider));
      }
    });

    // 告警事件（觸發、確認、恢復）即時更新徽章；
    // 依告警規則保存於事件上的通知決策顯示本地推播。
    ref.listen(alertUpdatesProvider, (previous, next) {
      final alert = next.value;
      if (alert == null) return;
      ref.invalidate(openAlertsProvider);
      if (alert.state == AlertState.active && alert.mobileNotificationEnabled) {
        NotificationService.showAlert(
          id: alert.id ?? 0,
          title: '設備告警',
          body: alert.message,
          severity: alert.severity,
        );
      }
    });

    return Scaffold(
      body: Column(
        children: [
          if (!isOnline) const OfflineBanner(),
          Expanded(child: shell),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) => shell.goBranch(
          index,
          initialLocation: index == shell.currentIndex,
        ),
        destinations: [
          const NavigationDestination(
            icon: Icon(CupertinoIcons.square_grid_2x2),
            selectedIcon: Icon(CupertinoIcons.square_grid_2x2_fill),
            label: '總覽',
          ),
          NavigationDestination(
            icon: Badge.count(
              count: openAlertCount,
              isLabelVisible: openAlertCount > 0,
              child: const Icon(CupertinoIcons.bell),
            ),
            selectedIcon: Badge.count(
              count: openAlertCount,
              isLabelVisible: openAlertCount > 0,
              child: const Icon(CupertinoIcons.bell_fill),
            ),
            label: '警報',
          ),
          NavigationDestination(
            icon: Badge.count(
              count: openWorkOrders,
              isLabelVisible: openWorkOrders > 0,
              child: const Icon(CupertinoIcons.doc_text),
            ),
            selectedIcon: Badge.count(
              count: openWorkOrders,
              isLabelVisible: openWorkOrders > 0,
              child: const Icon(CupertinoIcons.doc_text_fill),
            ),
            label: '運維',
          ),
          const NavigationDestination(
            icon: Icon(CupertinoIcons.cube_box),
            selectedIcon: Icon(CupertinoIcons.cube_box_fill),
            label: '設備',
          ),
          const NavigationDestination(
            icon: Icon(CupertinoIcons.gear_alt),
            selectedIcon: Icon(CupertinoIcons.gear_alt_fill),
            label: '設定',
          ),
        ],
      ),
    );
  }
}

/// 離線模式橫幅（產品規格：Wi-Fi 死角提示；離線時禁止即時控制）。
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange.shade800,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.wifi_off, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '離線模式：顯示快取資料，控制功能已停用',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
