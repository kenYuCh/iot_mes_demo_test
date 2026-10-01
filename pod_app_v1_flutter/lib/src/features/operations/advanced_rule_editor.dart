import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';

class AdvancedRuleEditor extends ConsumerStatefulWidget {
  const AdvancedRuleEditor({super.key, required this.devices, this.rule});

  final List<Device> devices;
  final AutomationRule? rule;

  @override
  ConsumerState<AdvancedRuleEditor> createState() => _AdvancedRuleEditorState();
}

class _AdvancedRuleEditorState extends ConsumerState<AdvancedRuleEditor> {
  late final TextEditingController _name;
  late final TextEditingController _timeout;
  late final TextEditingController _cooldown;
  late final TextEditingController _repeats;
  late final TextEditingController _mixingDelay;
  late final List<_BranchDraft> _branches;
  bool _saving = false;

  List<Device> get _sensorDevices => widget.devices
      .where((device) => _sensors(device.id!).isNotEmpty)
      .toList(growable: false);
  List<Device> get _controlDevices => widget.devices
      .where((device) => _controls(device.id!).isNotEmpty)
      .toList(growable: false);
  List<DeviceFeature> _features(int deviceId) =>
      widget.devices.firstWhere((device) => device.id == deviceId).features ??
      const [];
  List<DeviceFeature> _sensors(int deviceId) => _features(
    deviceId,
  ).where((feature) => feature.kind != FeatureKind.control).toList();
  List<DeviceFeature> _controls(int deviceId) => _features(
    deviceId,
  ).where((feature) => feature.kind == FeatureKind.control).toList();

  @override
  void initState() {
    super.initState();
    final rule = widget.rule;
    _name = TextEditingController(text: rule?.name ?? 'pH 雙向加藥控制');
    _timeout = TextEditingController(
      text: '${rule?.sensorTimeoutSeconds ?? 60}',
    );
    _cooldown = TextEditingController(text: '${rule?.cooldownSeconds ?? 10}');
    _repeats = TextEditingController(text: '${rule?.maxRepeats ?? 3}');
    _mixingDelay = TextEditingController(
      text: '${rule?.mixingDelaySeconds ?? 10}',
    );
    final stored = rule?.branches;
    if (stored != null && stored.isNotEmpty) {
      _branches = stored.map(_BranchDraft.fromModel).toList();
    } else if (rule != null) {
      _branches = [
        _BranchDraft(
          label: 'IF',
          matchAll: true,
          conditions: [
            _ConditionDraft(
              deviceId: rule.triggerDeviceId,
              featureKey: rule.triggerFeatureKey,
              comparison: rule.comparison,
              value: '${rule.threshold}',
            ),
          ],
          actions: [
            _ActionDraft(
              deviceId: rule.actionDeviceId,
              featureKey: rule.actionFeatureKey,
              value: '${rule.actionValue}',
              duration: '${rule.pulseOnSeconds}',
              delay: '${rule.intervalSeconds - rule.pulseOnSeconds}',
            ),
          ],
        ),
      ];
    } else {
      _branches = [_newConditionalBranch('IF')];
    }
  }

  _BranchDraft _newConditionalBranch(String label) {
    final sensor = _sensorDevices.first;
    final action = _controlDevices.first;
    return _BranchDraft(
      label: label,
      matchAll: true,
      conditions: [
        _ConditionDraft(
          deviceId: sensor.id!,
          featureKey: _sensors(sensor.id!).first.key,
          comparison: AlertComparison.greaterThan,
          value: '7.5',
        ),
      ],
      actions: [_newAction(action.id!)],
    );
  }

  _ActionDraft _newAction(int deviceId) => _ActionDraft(
    deviceId: deviceId,
    featureKey: _controls(deviceId).first.key,
    value: '0',
    duration: '0',
    delay: '0',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rule == null ? '新增規則引擎' : '編輯規則引擎'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? '儲存中…' : '儲存'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: '規則名稱',
              hintText: '例如：pH 雙向加藥控制',
            ),
          ),
          const SizedBox(height: 12),
          const _SafetyNotice(),
          const SizedBox(height: 16),
          for (var index = 0; index < _branches.length; index++) ...[
            _branchCard(index),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _branches.any((branch) => branch.isElse)
                      ? null
                      : () => setState(
                          () => _branches.add(
                            _newConditionalBranch('ELSE IF'),
                          ),
                        ),
                  icon: const Icon(Icons.call_split),
                  label: const Text('新增 ELSE IF'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _branches.any((branch) => branch.isElse)
                      ? null
                      : () => setState(() {
                          final device = _controlDevices.first;
                          _branches.add(
                            _BranchDraft(
                              label: 'ELSE（正常／安全狀態）',
                              matchAll: true,
                              conditions: [],
                              actions: [_newAction(device.id!)],
                            ),
                          );
                        }),
                  icon: const Icon(Icons.health_and_safety_outlined),
                  label: const Text('新增 ELSE'),
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Text('安全與節流', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _integerField(_timeout, '感測逾時（秒）')),
              const SizedBox(width: 10),
              Expanded(child: _integerField(_cooldown, '冷卻時間（秒）')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _integerField(_repeats, '最多重複次數')),
              const SizedBox(width: 10),
              Expanded(child: _integerField(_mixingDelay, '混合等待（秒）')),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _saving ? null : _save,
            icon: const Icon(Icons.save_outlined),
            label: const Text('儲存並保持停用'),
          ),
        ],
      ),
    );
  }

  Widget _branchCard(int branchIndex) {
    final branch = _branches[branchIndex];
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(branch.label),
                ),
                const Spacer(),
                if (branchIndex > 0)
                  IconButton(
                    tooltip: '刪除分支',
                    onPressed: () =>
                        setState(() => _branches.removeAt(branchIndex)),
                    icon: const Icon(Icons.delete_outline),
                  ),
              ],
            ),
            if (!branch.isElse) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('符合'),
                  const SizedBox(width: 8),
                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(value: true, label: Text('全部 AND')),
                      ButtonSegment(value: false, label: Text('任一 OR')),
                    ],
                    selected: {branch.matchAll},
                    onSelectionChanged: (value) =>
                        setState(() => branch.matchAll = value.first),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (var i = 0; i < branch.conditions.length; i++)
                _conditionEditor(branch, i),
              TextButton.icon(
                onPressed: () => setState(() {
                  final device = _sensorDevices.first;
                  branch.conditions.add(
                    _ConditionDraft(
                      deviceId: device.id!,
                      featureKey: _sensors(device.id!).first.key,
                      comparison: AlertComparison.greaterThan,
                      value: '0',
                    ),
                  );
                }),
                icon: const Icon(Icons.add),
                label: const Text('新增條件'),
              ),
            ] else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('以上條件皆未命中時，執行安全狀態動作。'),
              ),
            const Divider(),
            const Text('THEN 執行動作'),
            const SizedBox(height: 8),
            for (var i = 0; i < branch.actions.length; i++)
              _actionEditor(branch, i),
            TextButton.icon(
              onPressed: () => setState(() {
                branch.actions.add(_newAction(_controlDevices.first.id!));
              }),
              icon: const Icon(Icons.add),
              label: const Text('新增控制動作'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _conditionEditor(_BranchDraft branch, int index) {
    final condition = branch.conditions[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  key: ValueKey(
                    'condition-device-${condition.hashCode}-${condition.deviceId}',
                  ),
                  initialValue: condition.deviceId,
                  decoration: const InputDecoration(labelText: '感測設備'),
                  items: [
                    for (final device in _sensorDevices)
                      DropdownMenuItem(
                        value: device.id,
                        child: Text(device.name),
                      ),
                  ],
                  onChanged: (value) => setState(() {
                    condition.deviceId = value!;
                    condition.featureKey = _sensors(value).first.key;
                  }),
                ),
              ),
              if (branch.conditions.length > 1)
                IconButton(
                  onPressed: () =>
                      setState(() => branch.conditions.removeAt(index)),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  key: ValueKey(
                    'condition-feature-${condition.hashCode}-${condition.deviceId}',
                  ),
                  initialValue: condition.featureKey,
                  decoration: const InputDecoration(labelText: '測量參數'),
                  items: [
                    for (final feature in _sensors(condition.deviceId))
                      DropdownMenuItem(
                        value: feature.key,
                        child: Text(feature.label),
                      ),
                  ],
                  onChanged: (value) =>
                      setState(() => condition.featureKey = value!),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<AlertComparison>(
                  initialValue: condition.comparison,
                  decoration: const InputDecoration(labelText: '比較'),
                  items: [
                    for (final value in AlertComparison.values)
                      DropdownMenuItem(
                        value: value,
                        child: Text(_operator(value)),
                      ),
                  ],
                  onChanged: (value) =>
                      setState(() => condition.comparison = value!),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _numberField(
                  condition.value,
                  '數值',
                  (v) => condition.value = v,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionEditor(_BranchDraft branch, int index) {
    final action = branch.actions[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  key: ValueKey(
                    'action-device-${action.hashCode}-${action.deviceId}',
                  ),
                  initialValue: action.deviceId,
                  decoration: const InputDecoration(labelText: '控制設備'),
                  items: [
                    for (final device in _controlDevices)
                      DropdownMenuItem(
                        value: device.id,
                        child: Text(device.name),
                      ),
                  ],
                  onChanged: (value) => setState(() {
                    action.deviceId = value!;
                    action.featureKey = _controls(value).first.key;
                  }),
                ),
              ),
              if (branch.actions.length > 1)
                IconButton(
                  onPressed: () =>
                      setState(() => branch.actions.removeAt(index)),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
            ],
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            key: ValueKey(
              'action-feature-${action.hashCode}-${action.deviceId}',
            ),
            initialValue: action.featureKey,
            decoration: const InputDecoration(labelText: '控制參數'),
            items: [
              for (final feature in _controls(action.deviceId))
                DropdownMenuItem(
                  value: feature.key,
                  child: Text('${feature.label} (${feature.key})'),
                ),
            ],
            onChanged: (value) => setState(() => action.featureKey = value!),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _numberField(
                  action.value,
                  '控制值',
                  (v) => action.value = v,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _numberField(
                  action.duration,
                  '運行秒數',
                  (v) => action.duration = v,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _numberField(
                  action.delay,
                  '延遲秒數',
                  (v) => action.delay = v,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _numberField(
    String initial,
    String label,
    ValueChanged<String> changed,
  ) => TextFormField(
    initialValue: initial,
    keyboardType: const TextInputType.numberWithOptions(
      decimal: true,
      signed: true,
    ),
    decoration: InputDecoration(labelText: label),
    onChanged: changed,
  );

  Widget _integerField(TextEditingController controller, String label) =>
      TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
      );

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final branches = [
        for (final branch in _branches)
          AutomationBranch(
            label: branch.label,
            matchAll: branch.matchAll,
            conditions: [
              for (final condition in branch.conditions)
                AutomationCondition(
                  deviceId: condition.deviceId,
                  featureKey: condition.featureKey,
                  comparison: condition.comparison,
                  value: double.parse(condition.value),
                ),
            ],
            actions: [
              for (final action in branch.actions)
                AutomationAction(
                  deviceId: action.deviceId,
                  featureKey: action.featureKey,
                  value: double.parse(action.value),
                  durationSeconds: int.parse(action.duration),
                  delaySeconds: int.parse(action.delay),
                ),
            ],
          ),
      ];
      await ref
          .read(clientProvider)
          .operations
          .saveAdvancedAutomationRule(
            widget.rule?.id,
            _name.text,
            branches,
            int.parse(_timeout.text),
            int.parse(_cooldown.text),
            int.parse(_repeats.text),
            int.parse(_mixingDelay.text),
          );
      if (mounted) Navigator.pop(context, true);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('規則儲存失敗：$error')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _SafetyNotice extends StatelessWidget {
  const _SafetyNotice();
  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.secondaryContainer,
    child: const ListTile(
      leading: Icon(Icons.shield_outlined),
      title: Text('安全策略'),
      subtitle: Text('規則由上往下只命中第一個分支；感測逾時時停止執行。編輯後保持停用，需人工覆核。'),
    ),
  );
}

class _BranchDraft {
  _BranchDraft({
    required this.label,
    required this.matchAll,
    required this.conditions,
    required this.actions,
  });
  factory _BranchDraft.fromModel(AutomationBranch value) => _BranchDraft(
    label: value.label,
    matchAll: value.matchAll,
    conditions: value.conditions.map(_ConditionDraft.fromModel).toList(),
    actions: value.actions.map(_ActionDraft.fromModel).toList(),
  );
  String label;
  bool matchAll;
  List<_ConditionDraft> conditions;
  List<_ActionDraft> actions;
  bool get isElse => conditions.isEmpty;
}

class _ConditionDraft {
  _ConditionDraft({
    required this.deviceId,
    required this.featureKey,
    required this.comparison,
    required this.value,
  });
  factory _ConditionDraft.fromModel(AutomationCondition value) =>
      _ConditionDraft(
        deviceId: value.deviceId,
        featureKey: value.featureKey,
        comparison: value.comparison,
        value: '${value.value}',
      );
  int deviceId;
  String featureKey;
  AlertComparison comparison;
  String value;
}

class _ActionDraft {
  _ActionDraft({
    required this.deviceId,
    required this.featureKey,
    required this.value,
    required this.duration,
    required this.delay,
  });
  factory _ActionDraft.fromModel(AutomationAction value) => _ActionDraft(
    deviceId: value.deviceId,
    featureKey: value.featureKey,
    value: '${value.value}',
    duration: '${value.durationSeconds}',
    delay: '${value.delaySeconds}',
  );
  int deviceId;
  String featureKey;
  String value;
  String duration;
  String delay;
}

String _operator(AlertComparison value) => switch (value) {
  AlertComparison.greaterThan => '>',
  AlertComparison.greaterOrEqual => '≥',
  AlertComparison.lessThan => '<',
  AlertComparison.lessOrEqual => '≤',
};
