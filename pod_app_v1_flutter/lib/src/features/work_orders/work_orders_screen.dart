import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../design/factory_theme.dart';
import '../../widgets/tech_ui.dart';
import 'work_order_editor_dialog.dart';
import 'work_orders_providers.dart';

/// 工單中心（Mobile CMMS，docs/product/enterprise-iot-platform-spec.md）。
/// 掃碼、拍照與語音回傳需實體機，於 BLE/實機階段補上。
class WorkOrdersScreen extends ConsumerStatefulWidget {
  const WorkOrdersScreen({super.key});

  @override
  ConsumerState<WorkOrdersScreen> createState() => _WorkOrdersScreenState();
}

class _WorkOrdersScreenState extends ConsumerState<WorkOrdersScreen> {
  WorkOrderStatus? _filter;

  @override
  Widget build(BuildContext context) {
    final workOrders = ref.watch(workOrdersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('工單中心')),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'work_order_fab',
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const WorkOrderEditorDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('開立工單'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 10),
            child: TechHero(
              eyebrow: 'MAINTENANCE OPS',
              title: '行動維修中樞',
              subtitle: '從告警、派工到結案，全流程可追溯',
              icon: Icons.engineering_outlined,
              accent: FactoryColors.orange,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('全部'),
                  selected: _filter == null,
                  onSelected: (_) => setState(() => _filter = null),
                ),
                for (final status in WorkOrderStatus.values) ...[
                  const SizedBox(width: 8),
                  FilterChip(
                    label: Text(workOrderStatusLabel(status)),
                    selected: _filter == status,
                    onSelected: (_) => setState(() => _filter = status),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: workOrders.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('$error')),
              data: (result) {
                final items = _filter == null
                    ? result.items
                    : result.items.where((w) => w.status == _filter).toList();
                if (items.isEmpty) {
                  return const Center(child: Text('沒有符合條件的工單'));
                }
                return RefreshIndicator(
                  onRefresh: () => ref.refresh(workOrdersProvider.future),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 2, 16, 88),
                    itemCount: items.length,
                    itemBuilder: (context, index) =>
                        _WorkOrderTile(workOrder: items[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkOrderTile extends ConsumerWidget {
  const _WorkOrderTile({required this.workOrder});

  final WorkOrder workOrder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createdAt = DateFormat(
      'MM/dd HH:mm',
    ).format(workOrder.createdAt.toLocal());

    return Card(
      key: ValueKey(workOrder.id),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        minTileHeight: 72,
        leading: _PriorityIndicator(priority: workOrder.priority),
        title: Text(workOrder.title),
        subtitle: Text(
          '#WO-${workOrder.id}．$createdAt'
          '${workOrder.alertId != null ? '．來自告警' : ''}',
        ),
        trailing: WorkOrderStatusChip(status: workOrder.status),
        onTap: () => showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (context) => _WorkOrderActions(workOrder: workOrder),
        ),
      ),
    );
  }
}

/// 工單詳情與狀態流轉：open → inProgress → done / cancelled。
class _WorkOrderActions extends ConsumerWidget {
  const _WorkOrderActions({required this.workOrder});

  final WorkOrder workOrder;

  Future<void> _transition(
    BuildContext context,
    WidgetRef ref,
    WorkOrderStatus status,
  ) async {
    String? note;
    if (status == WorkOrderStatus.done || status == WorkOrderStatus.cancelled) {
      final isDone = status == WorkOrderStatus.done;
      note = await showDialog<String>(
        context: context,
        builder: (context) => _NoteDialog(
          title: isDone ? '完成工單' : '取消工單',
          label: isDone ? '解決方式說明' : '取消原因（選填）',
          // 結案必須留下解決方式，供後續巡檢與同型故障參考。
          required: isDone,
        ),
      );
      if (note == null) return; // 使用者取消。
    }
    await ref
        .read(clientProvider)
        .workOrder
        .updateStatus(workOrder.id!, status, note: note);
    ref.invalidate(workOrdersProvider);
    ref.invalidate(openWorkOrderCountProvider);
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    workOrder.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                WorkOrderStatusChip(status: workOrder.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '優先級：${priorityLabel(workOrder.priority)}'
              '${workOrder.deviceId != null ? '．設備 #${workOrder.deviceId}' : ''}',
            ),
            if (workOrder.description != null) ...[
              const SizedBox(height: 8),
              Text(workOrder.description!),
            ],
            if (workOrder.note != null) ...[
              const SizedBox(height: 8),
              Text(
                workOrder.status == WorkOrderStatus.done
                    ? '解決方式：${workOrder.note}'
                    : '處理備註：${workOrder.note}',
              ),
            ],
            const SizedBox(height: 16),
            if (workOrder.status == WorkOrderStatus.open)
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () =>
                          _transition(context, ref, WorkOrderStatus.inProgress),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('開始處理'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          _transition(context, ref, WorkOrderStatus.cancelled),
                      icon: const Icon(Icons.close),
                      label: const Text('取消工單'),
                    ),
                  ),
                ],
              )
            else if (workOrder.status == WorkOrderStatus.inProgress)
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () =>
                          _transition(context, ref, WorkOrderStatus.done),
                      icon: const Icon(Icons.check),
                      label: const Text('完成工單'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          _transition(context, ref, WorkOrderStatus.cancelled),
                      icon: const Icon(Icons.close),
                      label: const Text('取消工單'),
                    ),
                  ),
                ],
              )
            else
              const Text('工單已結案'),
          ],
        ),
      ),
    );
  }
}

class _NoteDialog extends StatefulWidget {
  const _NoteDialog({
    required this.title,
    required this.label,
    this.required = false,
  });

  final String title;
  final String label;

  /// 為 true 時必須填寫才能送出（完成工單需敘述解決方式）。
  final bool required;

  @override
  State<_NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<_NoteDialog> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.required && _controller.text.trim().isEmpty) {
      setState(() => _error = '請敘述解決方式（例如：更換感測器線材、重啟閘道器）');
      return;
    }
    Navigator.of(context).pop(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.required ? '如何排除此問題？' : null,
          errorText: _error,
        ),
        maxLines: 3,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('返回'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('確定'),
        ),
      ],
    );
  }
}

class _PriorityIndicator extends StatelessWidget {
  const _PriorityIndicator({required this.priority});

  final WorkOrderPriority priority;

  @override
  Widget build(BuildContext context) {
    final color = switch (priority) {
      WorkOrderPriority.low => Colors.blueGrey,
      WorkOrderPriority.normal => Colors.blue,
      WorkOrderPriority.high => Colors.orange,
      WorkOrderPriority.urgent => Colors.red,
    };
    return CircleAvatar(
      radius: 16,
      backgroundColor: color.withValues(alpha: 0.15),
      child: Icon(Icons.build_outlined, size: 18, color: color),
    );
  }
}

/// 工單狀態標籤。
class WorkOrderStatusChip extends StatelessWidget {
  const WorkOrderStatusChip({super.key, required this.status});

  final WorkOrderStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      WorkOrderStatus.open => (Colors.red, '待處理'),
      WorkOrderStatus.inProgress => (Colors.orange, '處理中'),
      WorkOrderStatus.done => (Colors.green, '已完成'),
      WorkOrderStatus.cancelled => (Colors.grey, '已取消'),
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

String workOrderStatusLabel(WorkOrderStatus status) => switch (status) {
  WorkOrderStatus.open => '待處理',
  WorkOrderStatus.inProgress => '處理中',
  WorkOrderStatus.done => '已完成',
  WorkOrderStatus.cancelled => '已取消',
};
