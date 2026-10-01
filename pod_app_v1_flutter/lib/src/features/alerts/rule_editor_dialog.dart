import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import 'alerts_providers.dart';
import 'alerts_screen.dart' show comparisonSymbol;
import 'severity.dart';

/// 建立告警規則對話框。
class RuleEditorDialog extends ConsumerStatefulWidget {
  const RuleEditorDialog({super.key});

  @override
  ConsumerState<RuleEditorDialog> createState() => _RuleEditorDialogState();
}

class _RuleEditorDialogState extends ConsumerState<RuleEditorDialog> {
  Device? _device;
  DeviceFeature? _feature;
  AlertComparison _comparison = AlertComparison.greaterThan;
  AlertSeverity _severity = AlertSeverity.warning;
  bool _mobileNotificationEnabled = true;
  final _thresholdController = TextEditingController();
  bool _saving = false;

  /// 選定設備的量測通道（多通道設備有 2~6 個）。
  List<DeviceFeature> get _measurements => [
    for (final f in _device?.features ?? const <DeviceFeature>[])
      if (f.kind == FeatureKind.measurement) f,
  ];

  @override
  void dispose() {
    _thresholdController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final device = _device;
    final feature = _feature;
    final threshold = double.tryParse(_thresholdController.text.trim());
    if (device == null || feature == null || threshold == null) return;

    setState(() => _saving = true);
    try {
      final name =
          '${device.name} ${feature.label} '
          '${comparisonSymbol(_comparison)} $threshold';
      await ref
          .read(clientProvider)
          .alert
          .createRule(
            device.id!,
            feature.key,
            _comparison,
            threshold,
            name,
            _severity,
            _mobileNotificationEnabled,
          );
      ref.invalidate(alertRulesProvider);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('建立規則失敗：$e')));
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final devices = ref.watch(allDevicesProvider);

    return AlertDialog(
      title: const Text('新增告警規則'),
      content: devices.when(
        loading: () => const SizedBox(
          height: 120,
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => Text('$error'),
        data: (items) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Device>(
              initialValue: _device,
              isExpanded: true,
              decoration: const InputDecoration(labelText: '設備'),
              items: [
                for (final device in items)
                  DropdownMenuItem(
                    value: device,
                    child: Text(
                      '${device.name}（${device.deviceType}）',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: (value) => setState(() {
                _device = value;
                // 換設備後重設通道（預設第一個量測通道）。
                _feature = null;
                final measurements = _measurements;
                if (measurements.isNotEmpty) {
                  _feature = measurements.first;
                }
              }),
            ),
            const SizedBox(height: 12),
            if (_device != null) ...[
              DropdownButtonFormField<DeviceFeature>(
                initialValue: _measurements.contains(_feature)
                    ? _feature
                    : null,
                isExpanded: true,
                decoration: const InputDecoration(labelText: '量測通道'),
                items: [
                  for (final feature in _measurements)
                    DropdownMenuItem(
                      value: feature,
                      child: Text(
                        '${feature.label}'
                        '${feature.unit.isEmpty ? '' : '（${feature.unit}）'}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: (value) => setState(() => _feature = value),
              ),
              const SizedBox(height: 12),
            ],
            DropdownButtonFormField<AlertComparison>(
              initialValue: _comparison,
              decoration: const InputDecoration(labelText: '條件'),
              items: [
                for (final comparison in AlertComparison.values)
                  DropdownMenuItem(
                    value: comparison,
                    child: Text('量測值 ${comparisonSymbol(comparison)} 閾值'),
                  ),
              ],
              onChanged: (value) =>
                  setState(() => _comparison = value ?? _comparison),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<AlertSeverity>(
              initialValue: _severity,
              decoration: const InputDecoration(labelText: '等級'),
              items: [
                for (final severity in AlertSeverity.values)
                  DropdownMenuItem(
                    value: severity,
                    child: Text(severityStyle(severity).$2),
                  ),
              ],
              onChanged: (value) =>
                  setState(() => _severity = value ?? _severity),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _thresholdController,
              decoration: const InputDecoration(labelText: '閾值'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
            ),
            const SizedBox(height: 8),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _mobileNotificationEnabled,
              onChanged: (value) =>
                  setState(() => _mobileNotificationEnabled = value),
              secondary: const Icon(Icons.notifications_active_outlined),
              title: const Text('發送手機通知'),
              subtitle: const Text('告警首次觸發時顯示通知；恢復正常不重複通知'),
            ),
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
          child: const Text('建立'),
        ),
      ],
    );
  }
}
