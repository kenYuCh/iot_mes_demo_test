import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../dashboard/dashboard_providers.dart';
import 'site_detail_providers.dart';

/// 註冊／編輯閘道器。
class GatewayEditorDialog extends ConsumerStatefulWidget {
  const GatewayEditorDialog({super.key, required this.siteId, this.gateway});

  final int siteId;

  /// null 表示註冊新閘道器。
  final Gateway? gateway;

  @override
  ConsumerState<GatewayEditorDialog> createState() =>
      _GatewayEditorDialogState();
}

class _GatewayEditorDialogState extends ConsumerState<GatewayEditorDialog> {
  late final _serialController = TextEditingController(
    text: widget.gateway?.serialNumber ?? '',
  );
  late final _nameController = TextEditingController(
    text: widget.gateway?.name ?? '',
  );
  bool _saving = false;

  @override
  void dispose() {
    _serialController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final client = ref.read(clientProvider);
      if (widget.gateway == null) {
        await client.gateway.createGateway(
          widget.siteId,
          _serialController.text,
          _nameController.text,
        );
      } else {
        await client.gateway.updateGateway(
          widget.gateway!.id!,
          _nameController.text,
        );
      }
      ref.invalidate(gatewaysProvider(widget.siteId));
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
      title: Text(widget.gateway == null ? '註冊閘道器' : '編輯閘道器'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _serialController,
            // 序號為裝置唯一識別，註冊後不可變更。
            enabled: widget.gateway == null,
            decoration: const InputDecoration(labelText: '序號'),
            autofocus: widget.gateway == null,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: '名稱'),
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
          child: Text(widget.gateway == null ? '註冊' : '儲存'),
        ),
      ],
    );
  }
}
