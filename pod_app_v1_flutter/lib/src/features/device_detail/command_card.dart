import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/offline_providers.dart';
import '../../core/providers.dart';
import 'command_providers.dart';

/// 控制命令卡片：下發命令並顯示歷史與即時狀態。
class CommandCard extends ConsumerStatefulWidget {
  const CommandCard({super.key, required this.device, required this.status});

  final Device device;
  final DeviceStatus? status;

  int get deviceId => device.id!;

  @override
  ConsumerState<CommandCard> createState() => _CommandCardState();
}

class _CommandCardState extends ConsumerState<CommandCard> {
  /// 串流收到的命令更新，以 id 覆蓋歷史查詢結果。
  final _overrides = <int, DeviceCommand>{};
  bool _sending = false;

  Future<bool> _confirmCommand({
    required String title,
    required String message,
    required String confirmLabel,
  }) async {
    return await showAdaptiveDialog<bool>(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(confirmLabel),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _confirmReboot() async {
    final confirmed = await _confirmCommand(
      title: '確認重新啟動設備？',
      message: '${widget.device.name} 將暫時離線並重新連線。\n\n確認後才會送出命令。',
      confirmLabel: '確認重新啟動',
    );
    if (confirmed && mounted) await _send('reboot');
  }

  Future<void> _send(
    String commandType, {
    Map<String, String>? commandPayload,
  }) async {
    setState(() => _sending = true);
    try {
      final client = ref.read(clientProvider);
      final payload =
          commandPayload ??
          switch (commandType) {
            'reboot' => {'featureKey': 'system_reboot', 'value': 'true'},
            _ => <String, String>{},
          };
      await client.command.sendCommand(
        widget.deviceId,
        commandType,
        payload,
        // 冪等鍵：一次操作一鍵；重試同一鍵不會重複建立命令。
        'app-${widget.deviceId}-${DateTime.now().microsecondsSinceEpoch}',
      );
      ref.invalidate(commandsProvider(widget.deviceId));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('命令下發失敗：$e')));
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _openCalibration() async {
    final measurements = [
      for (final feature in widget.device.features ?? const <DeviceFeature>[])
        if (feature.kind == FeatureKind.measurement &&
            feature.dataType != FeatureDataType.boolean &&
            feature.dataType != FeatureDataType.enumeration)
          feature,
    ];
    if (measurements.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('此設備沒有可校正的數值量測特徵')),
      );
      return;
    }
    final result = await showDialog<({String key, double standardValue})>(
      context: context,
      builder: (context) => _CalibrationDialog(
        features: measurements,
        latestValues: widget.status?.latestValues ?? const {},
      ),
    );
    if (result == null) return;
    final feature = measurements.firstWhere((item) => item.key == result.key);
    final confirmed = await _confirmCommand(
      title: '確認感測校正？',
      message:
          '設備：${widget.device.name}\n'
          '特徵：${feature.label}（${feature.key}）\n'
          '標準值：${result.standardValue} ${feature.unit}\n\n'
          '此操作會修改並保存設備校正偏移量。',
      confirmLabel: '確認並送出',
    );
    if (!confirmed || !mounted) return;
    await _send(
      'calibrate',
      commandPayload: {
        'featureKey': result.key,
        'standardValue': '${result.standardValue}',
      },
    );
  }

  List<DeviceCommand> _merge(List<DeviceCommand> base) {
    final baseIds = {for (final c in base) c.id};
    final incoming =
        _overrides.values.where((c) => !baseIds.contains(c.id)).toList()
          ..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
    return [
      ...incoming,
      for (final c in base) _overrides[c.id] ?? c,
    ].take(8).toList();
  }

  @override
  Widget build(BuildContext context) {
    final commands = ref.watch(commandsProvider(widget.deviceId));

    ref.listen(commandUpdatesProvider(widget.deviceId), (previous, next) {
      final update = next.value;
      if (update?.id != null) {
        setState(() => _overrides[update!.id!] = update);
      }
    });

    final items = _merge(commands.value?.items ?? const []);
    // 離線時禁止即時控制（docs 說明書 21.4）。
    final isOnline = ref.watch(isOnlineProvider);
    final canSend = isOnline && !_sending;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '控制命令',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  tooltip: '查看全部控制紀錄',
                  onPressed: () => context.push(
                    '${GoRouterState.of(context).uri.path}/commands',
                  ),
                  icon: const Icon(Icons.history_rounded),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: canSend ? _confirmReboot : null,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('重新啟動'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: canSend ? _openCalibration : null,
                  icon: const Icon(Icons.tune),
                  label: const Text('感測校正'),
                ),
              ],
            ),
            if (!isOnline)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '離線模式，控制功能已停用',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.orange.shade800,
                  ),
                ),
              ),
            if (items.isNotEmpty) ...[
              const Divider(height: 24),
              for (final command in items.take(3))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${commandLabel(command.commandType)}'
                          '${command.commandType == 'setParam' ? '（${command.payload['featureKey']}→${command.payload['value']}）' : ''}'
                          ' · '
                          '${DateFormat('HH:mm:ss').format(command.createdAt.toLocal())}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      CommandStateChip(state: command.state),
                    ],
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => context.push(
                    '${GoRouterState.of(context).uri.path}/commands',
                  ),
                  icon: const Icon(Icons.open_in_new_rounded, size: 18),
                  label: const Text('查看全部紀錄'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String commandLabel(String commandType) => switch (commandType) {
  'reboot' => '重新啟動',
  'calibrate' => '感測校正',
  'setParam' => '參數設定',
  _ => commandType,
};

class _CalibrationDialog extends StatefulWidget {
  const _CalibrationDialog({
    required this.features,
    required this.latestValues,
  });

  final List<DeviceFeature> features;
  final Map<String, double> latestValues;

  @override
  State<_CalibrationDialog> createState() => _CalibrationDialogState();
}

class _CalibrationDialogState extends State<_CalibrationDialog> {
  late DeviceFeature _feature = widget.features.first;
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = double.tryParse(_controller.text.trim());
    if (value == null) {
      setState(() => _error = '請輸入有效的標準量測值');
      return;
    }
    if (value < _feature.minValue || value > _feature.maxValue) {
      setState(
        () => _error =
            '允許範圍 ${_feature.minValue}～${_feature.maxValue} ${_feature.unit}',
      );
      return;
    }
    Navigator.pop(context, (key: _feature.key, standardValue: value));
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.latestValues[_feature.key];
    return AlertDialog(
      title: const Text('感測器單點校正'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('請先將感測器與可信任的標準儀器放在相同環境，再輸入標準儀器讀值。'),
            const SizedBox(height: 16),
            DropdownButtonFormField<DeviceFeature>(
              initialValue: _feature,
              decoration: const InputDecoration(labelText: '校正特徵'),
              items: [
                for (final feature in widget.features)
                  DropdownMenuItem(
                    value: feature,
                    child: Text('${feature.label}（${feature.key}）'),
                  ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _feature = value);
              },
            ),
            const SizedBox(height: 12),
            Text(
              current == null
                  ? '設備目前讀值：尚未收到資料'
                  : '設備目前讀值：$current ${_feature.unit}',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: InputDecoration(
                labelText: '標準儀器讀值',
                suffixText: _feature.unit,
                hintText: current == null ? '例如 25.0' : '例如 $current',
                errorText: _error,
                helperText: '設備將計算偏移量並保存於 NVS，重新啟動後仍有效。',
              ),
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(onPressed: _submit, child: const Text('確認校正')),
      ],
    );
  }
}

/// 命令生命週期狀態標籤。
class CommandStateChip extends StatelessWidget {
  const CommandStateChip({super.key, required this.state});

  final DeviceCommandState state;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (state) {
      DeviceCommandState.created => (Colors.grey, '已建立'),
      DeviceCommandState.sent => (Colors.blue, '已送出'),
      DeviceCommandState.acknowledged => (Colors.orange, '裝置已確認'),
      DeviceCommandState.completed => (Colors.green, '完成'),
      DeviceCommandState.failed => (Colors.red, '失敗'),
      DeviceCommandState.timedOut => (Colors.red, '逾時'),
      DeviceCommandState.cancelled => (Colors.grey, '已取消'),
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
