import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/offline_providers.dart';
import '../../core/offline_sync_service.dart';
import '../../core/providers.dart';
import 'command_providers.dart';

/// 控制參數面板：以 setParam 命令下發設定值，
/// 裝置（開發環境為模擬器）套用後回寫到即時狀態。
class ControlPanelCard extends ConsumerStatefulWidget {
  const ControlPanelCard({
    super.key,
    required this.device,
    required this.status,
  });

  final Device device;
  final DeviceStatus? status;

  @override
  ConsumerState<ControlPanelCard> createState() => _ControlPanelCardState();
}

class _ControlPanelCardState extends ConsumerState<ControlPanelCard> {
  /// 使用者拖動中的暫存值（尚未下發）。
  final _pending = <String, double>{};

  /// 命令送出成功後的樂觀值；收到設備新的狀態回報後即交還 device twin。
  final _appliedOverrides = <String, double>{};
  String? _sendingKey;

  @override
  void didUpdateWidget(covariant ControlPanelCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    for (final key in _appliedOverrides.keys.toList()) {
      final current = widget.status?.latestValues[key];
      final desired = _appliedOverrides[key]!;
      // MQTT 可能先送達一包仍含舊設定值的週期 telemetry。只有設備
      // 明確回報與本次命令相同的目標值，才結束 optimistic 狀態。
      if (current != null && (current - desired).abs() < 0.001) {
        _appliedOverrides.remove(key);
      }
    }
  }

  List<DeviceFeature> get _controls => [
    for (final f in widget.device.features ?? const <DeviceFeature>[])
      if (f.kind == FeatureKind.control) f,
  ];

  double _appliedValue(DeviceFeature control) =>
      _appliedOverrides[control.key] ??
      widget.status?.latestValues[control.key] ??
      control.defaultValue ??
      control.minValue;

  Future<void> _apply(DeviceFeature control, double value) async {
    setState(() => _sendingKey = control.key);
    try {
      if (!ref.read(isOnlineProvider)) {
        final count = await OfflineSyncService.enqueueSetParam(
          deviceId: widget.device.id!,
          featureKey: control.key,
          value: value,
        );
        if (!mounted) return;
        setState(() {
          _pending.remove(control.key);
          _appliedOverrides[control.key] = value;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${control.label} 已加入離線同步佇列（共 $count 筆）')),
        );
        return;
      }
      final client = ref.read(clientProvider);
      await client.command.sendCommand(
        widget.device.id!,
        'setParam',
        {'featureKey': control.key, 'value': '$value'},
        'setparam-${widget.device.id}-${control.key}-'
            '${DateTime.now().microsecondsSinceEpoch}',
      );
      ref.invalidate(commandsProvider(widget.device.id!));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${control.label} → ${_format(value)} ${control.unit} 已下發，'
              '等待裝置套用',
            ),
          ),
        );
        setState(() {
          _pending.remove(control.key);
          _appliedOverrides[control.key] = value;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('下發失敗：$e')));
      }
    } finally {
      if (mounted) setState(() => _sendingKey = null);
    }
  }

  String _format(double value) => value == value.roundToDouble()
      ? '${value.round()}'
      : value.toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final controls = _controls;
    if (controls.isEmpty) return const SizedBox.shrink();

    final isOnline = ref.watch(isOnlineProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('控制參數', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              '調整後下發 setParam 命令，裝置確認套用後生效。',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            for (final control in controls) ...[
              const SizedBox(height: 4),
              _AdaptiveControlRow(
                control: control,
                applied: _appliedValue(control),
                pending: _pending[control.key],
                enabled: _sendingKey == null,
                sending: _sendingKey == control.key,
                onChanged: (value) =>
                    setState(() => _pending[control.key] = value),
                onApply: (value) => _apply(control, value),
                format: _format,
              ),
            ],
            if (!isOnline)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '離線模式：設定會安全保存，恢復連線後自動同步',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.orange.shade800,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 依 DeviceFeature Metadata 自動選擇 iOS 風格控制元件。
/// 同一台設備可同時混搭 slider、toggle、segmented 與 momentary 致動器。
class _AdaptiveControlRow extends StatelessWidget {
  const _AdaptiveControlRow({
    required this.control,
    required this.applied,
    required this.pending,
    required this.enabled,
    required this.sending,
    required this.onChanged,
    required this.onApply,
    required this.format,
  });

  final DeviceFeature control;
  final double applied;
  final double? pending;
  final bool enabled;
  final bool sending;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onApply;
  final String Function(double) format;

  @override
  Widget build(BuildContext context) {
    final presentation = control.controlPresentation;
    if (presentation == ControlPresentation.toggle) {
      final value = (pending ?? applied) >= 0.5;
      return SwitchListTile.adaptive(
        contentPadding: EdgeInsets.zero,
        title: Text(control.label),
        subtitle: control.description == null
            ? null
            : Text(control.description!),
        value: value,
        onChanged: enabled
            ? (next) {
                final numeric = next ? 1.0 : 0.0;
                onChanged(numeric);
                onApply(numeric);
              }
            : null,
        secondary: sending
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : null,
      );
    }
    if (presentation == ControlPresentation.segmented) {
      final options = control.enumOptions ?? const <String>[];
      final selected = options.isEmpty
          ? 0
          : (pending ?? applied).round().clamp(0, options.length - 1);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(control.label, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            if (options.isNotEmpty)
              SegmentedButton<int>(
                segments: [
                  for (var i = 0; i < options.length; i++)
                    ButtonSegment(value: i, label: Text(options[i])),
                ],
                selected: {selected},
                onSelectionChanged: enabled
                    ? (values) {
                        final value = values.first.toDouble();
                        onChanged(value);
                        onApply(value);
                      }
                    : null,
              ),
          ],
        ),
      );
    }
    if (presentation == ControlPresentation.momentary) {
      final destructive = control.key.toLowerCase().contains('emergency');
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.tonalIcon(
            onPressed: enabled ? () => onApply(1) : null,
            style: destructive
                ? FilledButton.styleFrom(foregroundColor: Colors.red)
                : null,
            icon: sending
                ? const SizedBox(
                    width: 17,
                    height: 17,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    destructive ? Icons.emergency : Icons.touch_app_outlined,
                  ),
            label: Text(control.label),
          ),
        ),
      );
    }
    return _ControlRow(
      control: control,
      applied: applied,
      pending: pending,
      enabled: enabled,
      sending: sending,
      onChanged: onChanged,
      onApply: onApply,
      format: format,
    );
  }
}

class _ControlRow extends StatelessWidget {
  const _ControlRow({
    required this.control,
    required this.applied,
    required this.pending,
    required this.enabled,
    required this.sending,
    required this.onChanged,
    required this.onApply,
    required this.format,
  });

  final DeviceFeature control;
  final double applied;
  final double? pending;
  final bool enabled;
  final bool sending;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onApply;
  final String Function(double) format;

  @override
  Widget build(BuildContext context) {
    final value = (pending ?? applied).clamp(
      control.minValue,
      control.maxValue,
    );
    final dirty = pending != null && pending != applied;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                control.label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text(
              '${format(value)} ${control.unit}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: dirty ? Theme.of(context).colorScheme.primary : null,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: value,
                min: control.minValue,
                max: control.maxValue,
                onChanged: enabled ? onChanged : null,
              ),
            ),
            SizedBox(
              width: 64,
              child: sending
                  ? const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : FilledButton.tonal(
                      onPressed: enabled && dirty ? () => onApply(value) : null,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: const Text('套用'),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
