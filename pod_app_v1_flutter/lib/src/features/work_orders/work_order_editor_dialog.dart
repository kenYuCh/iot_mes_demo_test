import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../sites/sites_providers.dart';
import 'work_orders_providers.dart';

/// 手動開立工單。可由設備詳情頁帶入場域/設備直接開單。
class WorkOrderEditorDialog extends ConsumerStatefulWidget {
  const WorkOrderEditorDialog({
    super.key,
    this.presetSiteId,
    this.presetDeviceId,
    this.presetDeviceName,
  });

  /// 從設備詳情頁開單時帶入；場域固定不可改。
  final int? presetSiteId;
  final int? presetDeviceId;
  final String? presetDeviceName;

  @override
  ConsumerState<WorkOrderEditorDialog> createState() =>
      _WorkOrderEditorDialogState();
}

class _WorkOrderEditorDialogState extends ConsumerState<WorkOrderEditorDialog> {
  late final _titleController = TextEditingController(
    text: widget.presetDeviceName == null
        ? ''
        : '${widget.presetDeviceName} 維修',
  );
  final _descriptionController = TextEditingController();
  late int? _siteId = widget.presetSiteId;
  WorkOrderPriority _priority = WorkOrderPriority.normal;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final siteId = _siteId;
    if (siteId == null || _titleController.text.trim().isEmpty) {
      setState(() => _error = '請選擇場域並填寫標題');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(clientProvider)
          .workOrder
          .createWorkOrder(
            siteId,
            widget.presetDeviceId,
            _titleController.text,
            _descriptionController.text,
            _priority,
          );
      ref.invalidate(workOrdersProvider);
      ref.invalidate(openWorkOrderCountProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('工單已建立，可於「工單」頁追蹤')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _saving = false;
        _error = '$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sites = ref.watch(sitesProvider).value ?? const <Site>[];

    return AlertDialog(
      title: const Text('開立工單'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<int>(
              // 場域清單載入前避免指到不存在的選項。
              initialValue: sites.any((s) => s.id == _siteId) ? _siteId : null,
              decoration: const InputDecoration(labelText: '場域'),
              items: [
                for (final site in sites)
                  DropdownMenuItem(value: site.id, child: Text(site.name)),
              ],
              onChanged: widget.presetSiteId != null
                  ? null
                  : (value) => setState(() => _siteId = value),
            ),
            if (widget.presetDeviceName != null) ...[
              const SizedBox(height: 8),
              InputDecorator(
                decoration: const InputDecoration(labelText: '關聯設備'),
                child: Text(widget.presetDeviceName!),
              ),
            ],
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '標題'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: '說明（選填）'),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<WorkOrderPriority>(
              initialValue: _priority,
              decoration: const InputDecoration(labelText: '優先級'),
              items: [
                for (final priority in WorkOrderPriority.values)
                  DropdownMenuItem(
                    value: priority,
                    child: Text(priorityLabel(priority)),
                  ),
              ],
              onChanged: (value) =>
                  setState(() => _priority = value ?? _priority),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('建立'),
        ),
      ],
    );
  }
}

String priorityLabel(WorkOrderPriority priority) => switch (priority) {
  WorkOrderPriority.low => '低',
  WorkOrderPriority.normal => '一般',
  WorkOrderPriority.high => '高',
  WorkOrderPriority.urgent => '緊急',
};
