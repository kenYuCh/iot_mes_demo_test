import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../dashboard/dashboard_providers.dart';
import '../site_detail/site_detail_providers.dart';
import 'sites_providers.dart';

/// 建立／編輯場域。
class SiteEditorDialog extends ConsumerStatefulWidget {
  const SiteEditorDialog({super.key, this.site});

  /// null 表示建立新場域。
  final Site? site;

  @override
  ConsumerState<SiteEditorDialog> createState() => _SiteEditorDialogState();
}

class _SiteEditorDialogState extends ConsumerState<SiteEditorDialog> {
  late final _nameController = TextEditingController(
    text: widget.site?.name ?? '',
  );
  late final _descriptionController = TextEditingController(
    text: widget.site?.description ?? '',
  );
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final client = ref.read(clientProvider);
      final name = _nameController.text;
      final description = _descriptionController.text;
      if (widget.site == null) {
        await client.site.createSite(name, description);
      } else {
        await client.site.updateSite(widget.site!.id!, name, description);
        ref.invalidate(siteProvider(widget.site!.id!));
      }
      ref.invalidate(sitesProvider);
      ref.invalidate(dashboardProvider);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e is ValidationException ? e.message : '$e'),
          ),
        );
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.site == null ? '新增場域' : '編輯場域'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: '名稱'),
            autofocus: true,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: '描述（選填）'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(widget.site == null ? '建立' : '儲存'),
        ),
      ],
    );
  }
}
