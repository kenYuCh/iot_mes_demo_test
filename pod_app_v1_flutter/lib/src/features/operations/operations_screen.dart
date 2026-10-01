import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../design/factory_theme.dart';
import '../../widgets/tech_ui.dart';
import 'advanced_rule_editor.dart';

final automationRulesProvider = FutureProvider<List<AutomationRule>>(
  (ref) => ref.watch(clientProvider).operations.listAutomationRules(),
);
final automationRunsProvider = FutureProvider<List<AutomationRun>>(
  (ref) => ref.watch(clientProvider).operations.listAutomationRuns(),
);
final auditLogsProvider = FutureProvider<List<AuditLog>>(
  (ref) => ref.watch(clientProvider).operations.listAuditLogs(limit: 100),
);
final automationDevicesProvider = FutureProvider<List<Device>>(
  (ref) => ref.watch(clientProvider).operations.listAutomationDevices(),
);

class OperationsScreen extends ConsumerStatefulWidget {
  const OperationsScreen({super.key});

  @override
  ConsumerState<OperationsScreen> createState() => _OperationsScreenState();
}

class _OperationsScreenState extends ConsumerState<OperationsScreen> {
  int section = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('運維中心')),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref.invalidate(automationRulesProvider);
          ref.invalidate(automationRunsProvider);
          ref.invalidate(auditLogsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
          children: [
            const TechHero(
              eyebrow: 'OPERATIONS ORCHESTRATION',
              title: '自動化與操作可追溯',
              subtitle: '跨設備連動、安全限制、執行歷史與 App 操作稽核',
              icon: Icons.account_tree_outlined,
              accent: FactoryColors.purple,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const TechIcon(
                  icon: Icons.precision_manufacturing_outlined,
                  color: FactoryColors.secondary,
                ),
                title: const Text('製程追蹤中心'),
                subtitle: const Text('QR／RFID 過站、WIP、產品、物料與生產追溯'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => context.push('/operations/production'),
              ),
            ),
            const SizedBox(height: 12),
            CupertinoSlidingSegmentedControl<int>(
              groupValue: section,
              children: const {
                0: Padding(padding: EdgeInsets.all(8), child: Text('自動化')),
                1: Padding(padding: EdgeInsets.all(8), child: Text('執行歷史')),
                2: Padding(padding: EdgeInsets.all(8), child: Text('操作稽核')),
                3: Padding(padding: EdgeInsets.all(8), child: Text('工單')),
              },
              onValueChanged: (value) => setState(() => section = value ?? 0),
            ),
            const SizedBox(height: 16),
            if (section == 0)
              _Rules(
                ref.watch(automationRulesProvider),
                ref.watch(automationDevicesProvider),
              ),
            if (section == 1) _Runs(ref.watch(automationRunsProvider)),
            if (section == 2) _Logs(ref.watch(auditLogsProvider)),
            if (section == 3)
              Card(
                child: ListTile(
                  leading: const TechIcon(icon: Icons.assignment_outlined),
                  title: const Text('維修與巡檢工單'),
                  subtitle: const Text('開啟現有 CMMS 工單列表與結案流程'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/operations/workorders'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Rules extends ConsumerWidget {
  const _Rules(this.value, this.devices);
  final AsyncValue<List<AutomationRule>> value;
  final AsyncValue<List<Device>> devices;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final available = devices.asData?.value ?? const <Device>[];
    final canCreate =
        available.any(
          (d) => d.features?.any((f) => f.kind != FeatureKind.control) ?? false,
        ) &&
        available.any(
          (d) => d.features?.any((f) => f.kind == FeatureKind.control) ?? false,
        );
    return value.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('載入失敗：$error'),
      data: (items) => Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: canCreate
                  ? () => _openRuleEditor(context, ref, devices.requireValue)
                  : null,
              icon: const Icon(Icons.add),
              label: const Text('新增自動化規則'),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const TechIcon(icon: Icons.science_outlined),
              title: const Text('pH 加藥連動範本'),
              subtitle: const Text(
                'pH > 7.5 → 幫浦運行 3 秒 → 間隔 5 秒，最多 3 次，並等待混合後重測',
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (items.isEmpty)
            const TechEmptyState(
              icon: Icons.account_tree_outlined,
              title: '尚無自動化規則',
              subtitle: '後端安全規則模型已就緒，可開始建立跨設備連動',
            )
          else
            for (final rule in items)
              Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    SwitchListTile.adaptive(
                      title: Text(rule.name),
                      subtitle: Text(
                        rule.branches?.isNotEmpty == true
                            ? '${rule.branches!.length} 個 IF／ELSE 分支 · ${rule.branches!.fold<int>(0, (sum, branch) => sum + branch.actions.length)} 個控制動作\n逾時 ${rule.sensorTimeoutSeconds ?? 60}s · 冷卻 ${rule.cooldownSeconds ?? 10}s'
                            : '${rule.triggerFeatureKey} ${_comparisonText(rule.comparison)} ${rule.threshold}  →  ${rule.actionFeatureKey} = ${rule.actionValue}\n運行 ${rule.pulseOnSeconds}s／週期 ${rule.intervalSeconds}s × ${rule.maxRepeats}',
                      ),
                      value: rule.enabled,
                      onChanged: (enabled) async {
                        await ref
                            .read(clientProvider)
                            .operations
                            .setAutomationEnabled(rule.id!, enabled);
                        ref.invalidate(automationRulesProvider);
                        ref.invalidate(auditLogsProvider);
                      },
                    ),
                    const Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => _openRuleEditor(
                            context,
                            ref,
                            devices.requireValue,
                            rule: rule,
                          ),
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('編輯'),
                        ),
                        TextButton.icon(
                          onPressed: () => _deleteRule(context, ref, rule),
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('刪除'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

class _Runs extends StatelessWidget {
  const _Runs(this.value);
  final AsyncValue<List<AutomationRun>> value;
  @override
  Widget build(BuildContext context) => value.when(
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (error, _) => Text('載入失敗：$error'),
    data: (items) => items.isEmpty
        ? const TechEmptyState(
            icon: Icons.history_toggle_off,
            title: '尚無執行紀錄',
            subtitle: '自動化每一步、重試與停止原因都會保留',
          )
        : Column(
            children: [
              for (final run in items)
                Card(
                  child: ListTile(
                    title: Text(run.state),
                    subtitle: Text('${run.currentStep} · ${run.repeatCount} 次'),
                  ),
                ),
            ],
          ),
  );
}

class _Logs extends StatefulWidget {
  const _Logs(this.value);
  final AsyncValue<List<AuditLog>> value;
  @override
  State<_Logs> createState() => _LogsState();
}

class _LogsState extends State<_Logs> {
  String query = '';
  bool? success;
  @override
  Widget build(BuildContext context) => widget.value.when(
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (error, _) => Text('載入失敗：$error'),
    data: (items) {
      final filtered = items.where((log) {
        final q = query.trim().toLowerCase();
        return (success == null || log.success == success) &&
            (q.isEmpty ||
                log.summary.toLowerCase().contains(q) ||
                log.action.toLowerCase().contains(q) ||
                log.userIdentifier.toLowerCase().contains(q));
      }).toList();
      return Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: '搜尋操作、使用者或內容',
            ),
            onChanged: (value) => setState(() => query = value),
          ),
          const SizedBox(height: 8),
          SegmentedButton<bool?>(
            segments: const [
              ButtonSegment(value: null, label: Text('全部')),
              ButtonSegment(value: true, label: Text('成功')),
              ButtonSegment(value: false, label: Text('失敗')),
            ],
            selected: {success},
            onSelectionChanged: (value) =>
                setState(() => success = value.first),
          ),
          const SizedBox(height: 12),
          if (filtered.isEmpty)
            const TechEmptyState(
              icon: Icons.fact_check_outlined,
              title: '沒有符合條件的稽核紀錄',
              subtitle: '稽核資料不可編輯，以保留操作證據',
            )
          else
            Column(
              children: [
                for (final log in filtered)
                  Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        log.success
                            ? Icons.check_circle_outline
                            : Icons.error_outline,
                      ),
                      title: Text(log.summary),
                      subtitle: Text(
                        '${log.userIdentifier} · ${log.source}\n${log.createdAt.toLocal()}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => showDialog<void>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(log.summary),
                          content: SelectableText(
                            '動作：${log.action}\n資源：${log.resourceType} #${log.resourceId ?? '-'}\n設備：${log.deviceId ?? '-'}\n來源：${log.source}\n使用者：${log.userIdentifier}\n結果：${log.success ? '成功' : '失敗'}\n時間：${log.createdAt.toLocal()}\n詳細：${log.details ?? '-'}',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('關閉'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      );
    },
  );
}

String _comparisonText(AlertComparison value) => switch (value) {
  AlertComparison.greaterThan => '>',
  AlertComparison.greaterOrEqual => '≥',
  AlertComparison.lessThan => '<',
  AlertComparison.lessOrEqual => '≤',
};

Future<void> _deleteRule(
  BuildContext context,
  WidgetRef ref,
  AutomationRule rule,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('刪除自動化規則？'),
      content: Text(
        rule.enabled
            ? '「${rule.name}」仍在啟用中，請先停用後再刪除。'
            : '將永久刪除「${rule.name}」，操作會寫入稽核紀錄。',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('取消'),
        ),
        if (!rule.enabled)
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('確認刪除'),
          ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;
  try {
    await ref.read(clientProvider).operations.deleteAutomationRule(rule.id!);
    ref.invalidate(automationRulesProvider);
    ref.invalidate(auditLogsProvider);
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('刪除失敗：$error')));
    }
  }
}

Future<void> _openRuleEditor(
  BuildContext context,
  WidgetRef ref,
  List<Device> devices, {
  AutomationRule? rule,
}) async {
  final saved = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => AdvancedRuleEditor(devices: devices, rule: rule),
  );
  if (saved == true) {
    ref.invalidate(automationRulesProvider);
    ref.invalidate(auditLogsProvider);
  }
}
