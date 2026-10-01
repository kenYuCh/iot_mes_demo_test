import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/notification_service.dart';
import '../../core/providers.dart';
import '../../design/factory_theme.dart';
import '../../widgets/tech_ui.dart';
import '../work_orders/work_orders_providers.dart';
import 'alerts_providers.dart';
import 'rule_editor_dialog.dart';
import 'severity.dart';

/// 告警中心：告警事件列表與規則管理。
class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 告警事件（觸發、確認、恢復）到達時重新整理列表與徽章。
    ref.listen(alertUpdatesProvider, (previous, next) {
      if (next.hasValue) {
        ref.invalidate(alertsProvider);
        ref.invalidate(openAlertsProvider);
      }
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('告警中心'),
          actions: [
            IconButton(
              tooltip: '測試手機通知',
              onPressed: () => _testNotification(context),
              icon: const Icon(Icons.notifications_active_outlined),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: '告警'),
              Tab(text: '規則'),
            ],
          ),
        ),
        body: const TabBarView(children: [_AlertsTab(), _RulesTab()]),
      ),
    );
  }

  Future<void> _testNotification(BuildContext context) async {
    final allowed = await NotificationService.ensurePermissions();
    if (!context.mounted) return;
    if (!allowed) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(
        SnackBar(
          content: const Text('iPhone 尚未允許通知，請到系統設定開啟橫幅、聲音與鎖定畫面。'),
          action: SnackBarAction(
            label: '開啟設定',
            onPressed: openAppSettings,
          ),
        ),
      );
      return;
    }
    await NotificationService.showAlert(
      id: DateTime.now().millisecondsSinceEpoch.remainder(1 << 31),
      title: '通知測試',
      body: 'IoT 智慧工廠的手機告警通知已正常啟用。',
      severity: AlertSeverity.warning,
    );
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('測試通知已送出')));
    }
  }
}

class _AlertsTab extends ConsumerWidget {
  const _AlertsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertsProvider);

    return alerts.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('$error')),
      data: (result) {
        if (result.items.isEmpty) {
          return const Center(child: Text('目前沒有告警'));
        }
        return RefreshIndicator(
          onRefresh: () => ref.refresh(alertsProvider.future),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
            children: [
              TechHero(
                eyebrow: 'REAL-TIME INCIDENTS',
                title: '${result.items.length} 筆告警事件',
                subtitle: '即時判讀風險、確認事件並快速轉派維修',
                icon: Icons.radar_rounded,
                accent: FactoryColors.red,
              ),
              TechSectionLabel('事件串流', detail: '${result.items.length} EVENTS'),
              for (final alert in result.items) _AlertTile(alert: alert),
            ],
          ),
        );
      },
    );
  }
}

class _AlertTile extends ConsumerWidget {
  const _AlertTile({required this.alert});

  final Alert alert;

  Future<void> _acknowledge(WidgetRef ref) async {
    await ref.read(clientProvider).alert.acknowledgeAlert(alert.id!);
    ref.invalidate(alertsProvider);
    ref.invalidate(openAlertsProvider);
  }

  Future<void> _convertToWorkOrder(BuildContext context, WidgetRef ref) async {
    final workOrder = await ref
        .read(clientProvider)
        .workOrder
        .createFromAlert(alert.id!);
    ref.invalidate(workOrdersProvider);
    ref.invalidate(openWorkOrderCountProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('已開立工單 #WO-${workOrder.id}「${workOrder.title}」'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final triggeredAt = DateFormat(
      'MM/dd HH:mm:ss',
    ).format(alert.triggeredAt.toLocal());
    final (severityColor, _) = severityStyle(alert.severity);

    return Card(
      key: ValueKey(alert.id),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        minTileHeight: 76,
        leading: TechIcon(
          icon: alert.state == AlertState.resolved
              ? Icons.check_circle_outline
              : Icons.warning_amber_rounded,
          color: alert.state == AlertState.resolved
              ? FactoryColors.green
              : severityColor,
        ),
        title: Text(alert.message),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              SeverityChip(severity: alert.severity),
              const SizedBox(width: 6),
              AlertStateChip(state: alert.state),
              const SizedBox(width: 6),
              Expanded(
                child: Text(triggeredAt, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (alert.state == AlertState.active)
              TextButton(
                onPressed: () => _acknowledge(ref),
                child: const Text('確認'),
              ),
            PopupMenuButton<String>(
              tooltip: '更多動作',
              onSelected: (action) {
                if (action == 'work_order') _convertToWorkOrder(context, ref);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'work_order',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.build_outlined),
                    title: Text('轉為維修工單'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RulesTab extends ConsumerWidget {
  const _RulesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rules = ref.watch(alertRulesProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const RuleEditorDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('新增規則'),
      ),
      body: rules.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('尚未建立任何規則'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final rule = items[index];
              return Card(
                key: ValueKey(rule.id),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: ListTile(
                  title: Text(rule.name),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        SeverityChip(severity: rule.severity),
                        const SizedBox(width: 6),
                        if (rule.mobileNotificationEnabled) ...[
                          const Icon(Icons.notifications_active, size: 16),
                          const SizedBox(width: 6),
                        ],
                        Expanded(
                          child: Text(
                            '${rule.featureKey} '
                            '${comparisonSymbol(rule.comparison)} '
                            '${rule.threshold}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Switch(
                        value: rule.enabled,
                        onChanged: (enabled) async {
                          await ref
                              .read(clientProvider)
                              .alert
                              .setRuleEnabled(rule.id!, enabled);
                          ref.invalidate(alertRulesProvider);
                        },
                      ),
                      IconButton(
                        tooltip: '刪除',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () async {
                          await ref
                              .read(clientProvider)
                              .alert
                              .deleteRule(rule.id!);
                          ref.invalidate(alertRulesProvider);
                          ref.invalidate(alertsProvider);
                          ref.invalidate(openAlertsProvider);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// 告警狀態標籤。
class AlertStateChip extends StatelessWidget {
  const AlertStateChip({super.key, required this.state});

  final AlertState state;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (state) {
      AlertState.active => (Colors.red, '觸發中'),
      AlertState.acknowledged => (Colors.orange, '已確認'),
      AlertState.resolved => (Colors.green, '已恢復'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

String comparisonSymbol(AlertComparison comparison) => switch (comparison) {
  AlertComparison.greaterThan => '>',
  AlertComparison.greaterOrEqual => '≥',
  AlertComparison.lessThan => '<',
  AlertComparison.lessOrEqual => '≤',
};
