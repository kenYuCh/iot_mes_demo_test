import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../design/factory_theme.dart';
import '../../widgets/destructive_reauth_dialog.dart';
import '../../widgets/list_search_bar.dart';
import '../../widgets/tech_ui.dart';
import '../site_detail/site_detail_providers.dart';

class FeatureCatalogScreen extends ConsumerStatefulWidget {
  const FeatureCatalogScreen({super.key});

  @override
  ConsumerState<FeatureCatalogScreen> createState() =>
      _FeatureCatalogScreenState();
}

class _FeatureCatalogScreenState extends ConsumerState<FeatureCatalogScreen> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(featureCatalogProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('特徵資料庫'),
        actions: [
          TextButton.icon(
            onPressed: catalog.value == null
                ? null
                : () => _addExamples(context, ref, catalog.value!),
            icon: const Icon(Icons.auto_awesome_outlined),
            label: const Text('加入範例'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _edit(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('新增特徵'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(featureCatalogProvider.future),
        child: catalog.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ListView(
            children: [
              const SizedBox(height: 160),
              Center(child: Text('載入失敗：$error')),
            ],
          ),
          data: (items) {
            final filtered = items.where((item) {
              final feature = item.feature;
              return matchesListSearch(_query, [
                feature.label,
                feature.key,
                feature.unit,
                feature.description ?? '',
              ]);
            }).toList();
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 110),
              children: [
                const TechHero(
                  eyebrow: 'FEATURE CATALOG',
                  title: '可重用設備特徵',
                  subtitle: '統一維護 JSON Key、單位、型態與量程，再組合到設備型別',
                  icon: Icons.dataset_outlined,
                  accent: FactoryColors.green,
                ),
                const SizedBox(height: 12),
                ListSearchBar(
                  controller: _search,
                  query: _query,
                  hintText: '搜尋名稱、JSON Key、單位或說明',
                  onChanged: (value) => setState(() => _query = value),
                ),
                const SizedBox(height: 12),
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: Center(child: Text('找不到符合條件的特徵')),
                  ),
                for (final item in filtered)
                  _FeatureCard(
                    item: item,
                    onEdit: item.system
                        ? null
                        : () => _edit(context, ref, item),
                    onDelete: item.system
                        ? null
                        : () => _delete(context, ref, item),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, [
    FeatureCatalogItem? item,
  ]) async {
    final feature = await showModalBottomSheet<DeviceFeature>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _FeatureDefinitionEditor(feature: item?.feature),
    );
    if (feature == null) return;
    try {
      final api = ref.read(clientProvider).device;
      if (item == null) {
        await api.createFeatureDefinition(feature);
      } else {
        await api.updateFeatureDefinition(item.definitionId!, feature);
      }
      ref.invalidate(featureCatalogProvider);
    } catch (error) {
      if (context.mounted) _showError(context, error);
    }
  }

  Future<void> _addExamples(
    BuildContext context,
    WidgetRef ref,
    List<FeatureCatalogItem> current,
  ) async {
    final existingKeys = current.map((item) => item.feature.key).toSet();
    final examples = <DeviceFeature>[
      DeviceFeature(
        key: 'example_temperature',
        label: '範例．溫度量測',
        unit: '°C',
        kind: FeatureKind.measurement,
        dataType: FeatureDataType.number,
        precision: 1,
        description: '一般溫度感測器數值範例',
        minValue: -40,
        maxValue: 125,
      ),
      DeviceFeature(
        key: 'example_machine_status',
        label: '範例．設備運轉狀態',
        unit: '',
        kind: FeatureKind.measurement,
        dataType: FeatureDataType.enumeration,
        enumOptions: const ['停止', '運轉中', '故障'],
        precision: 0,
        description: '三狀態列舉：停止 = 0、運轉中 = 1、故障 = 2',
        minValue: 0,
        maxValue: 2,
      ),
      DeviceFeature(
        key: 'example_motor_enable',
        label: '範例．馬達啟停',
        unit: '',
        kind: FeatureKind.control,
        dataType: FeatureDataType.boolean,
        controlPresentation: ControlPresentation.toggle,
        precision: 0,
        description: 'OFF = 0、ON = 1',
        minValue: 0,
        maxValue: 1,
        defaultValue: 0,
      ),
      DeviceFeature(
        key: 'example_target_speed',
        label: '範例．目標轉速',
        unit: 'rpm',
        kind: FeatureKind.control,
        dataType: FeatureDataType.number,
        controlPresentation: ControlPresentation.slider,
        precision: 0,
        description: '馬達轉速數值控制範例',
        minValue: 0,
        maxValue: 3000,
        defaultValue: 1500,
      ),
    ];
    final missing = examples
        .where((feature) => !existingKeys.contains(feature.key))
        .toList();
    if (missing.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('範例特徵已經存在')),
      );
      return;
    }
    try {
      final api = ref.read(clientProvider).device;
      for (final feature in missing) {
        await api.createFeatureDefinition(feature);
      }
      ref.invalidate(featureCatalogProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('已加入 ${missing.length} 個可編輯範例特徵')),
        );
      }
    } catch (error) {
      if (context.mounted) _showError(context, error);
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    FeatureCatalogItem item,
  ) async {
    if (item.usageCount > 0) {
      _showError(context, '仍有 ${item.usageCount} 個設備型別或設備使用此特徵');
      return;
    }
    final credentials = await showDestructiveReauthDialog(
      context,
      resourceName: '特徵 ${item.feature.label}',
    );
    if (credentials == null) return;
    try {
      await ref
          .read(clientProvider)
          .device
          .deleteFeatureDefinition(
            item.definitionId!,
            credentials.email,
            credentials.password,
          );
      ref.invalidate(featureCatalogProvider);
    } catch (error) {
      if (context.mounted) _showError(context, error);
    }
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.item, this.onEdit, this.onDelete});
  final FeatureCatalogItem item;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final feature = item.feature;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: TechIcon(
          icon: feature.kind == FeatureKind.control
              ? Icons.tune_rounded
              : Icons.sensors_rounded,
          color: feature.kind == FeatureKind.control
              ? FactoryColors.purple
              : FactoryColors.blue,
        ),
        title: Row(
          children: [
            Expanded(child: Text(feature.label)),
            if (item.system) const Chip(label: Text('系統')),
          ],
        ),
        subtitle: Text(
          '${feature.key}  ·  ${feature.minValue}–${feature.maxValue} ${feature.unit}\n'
          '${feature.kind == FeatureKind.control ? '控制參數' : '感測／狀態'}  ·  使用 ${item.usageCount} 處',
        ),
        isThreeLine: true,
        trailing: item.system
            ? const Icon(Icons.lock_outline)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: '編輯特徵',
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    tooltip: '刪除特徵',
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
      ),
    );
  }
}

class _FeatureDefinitionEditor extends StatefulWidget {
  const _FeatureDefinitionEditor({this.feature});
  final DeviceFeature? feature;

  @override
  State<_FeatureDefinitionEditor> createState() =>
      _FeatureDefinitionEditorState();
}

class _FeatureDefinitionEditorState extends State<_FeatureDefinitionEditor> {
  late final TextEditingController key;
  late final TextEditingController label;
  late final TextEditingController unit;
  late final TextEditingController min;
  late final TextEditingController max;
  late final TextEditingController defaultValue;
  late final TextEditingController enumOptions;
  late final TextEditingController description;
  late FeatureKind kind;
  late FeatureDataType dataType;

  @override
  void initState() {
    super.initState();
    final feature = widget.feature;
    key = TextEditingController(text: feature?.key ?? '');
    label = TextEditingController(text: feature?.label ?? '');
    unit = TextEditingController(text: feature?.unit ?? '');
    min = TextEditingController(text: '${feature?.minValue ?? 0}');
    max = TextEditingController(text: '${feature?.maxValue ?? 100}');
    defaultValue = TextEditingController(
      text: feature?.defaultValue == null ? '' : '${feature!.defaultValue}',
    );
    enumOptions = TextEditingController(
      text: (feature?.enumOptions ?? const <String>[]).join(', '),
    );
    description = TextEditingController(text: feature?.description ?? '');
    kind = feature?.kind ?? FeatureKind.measurement;
    dataType = feature?.dataType ?? FeatureDataType.number;
  }

  @override
  void dispose() {
    for (final controller in [
      key,
      label,
      unit,
      min,
      max,
      defaultValue,
      enumOptions,
      description,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _save() {
    final options = enumOptions.text
        .split(',')
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList();
    final low = dataType == FeatureDataType.number
        ? double.tryParse(min.text)
        : 0.0;
    final high = switch (dataType) {
      FeatureDataType.boolean => 1.0,
      FeatureDataType.enumeration => (options.length - 1).toDouble(),
      _ => double.tryParse(max.text),
    };
    if (key.text.trim().isEmpty ||
        label.text.trim().isEmpty ||
        low == null ||
        high == null ||
        low > high ||
        (dataType == FeatureDataType.enumeration && options.length < 2)) {
      return;
    }
    final initial = double.tryParse(defaultValue.text);
    Navigator.pop(
      context,
      DeviceFeature(
        key: key.text.trim(),
        label: label.text.trim(),
        unit: unit.text.trim(),
        kind: kind,
        dataType: dataType,
        controlPresentation: kind == FeatureKind.control
            ? switch (dataType) {
                FeatureDataType.boolean => ControlPresentation.toggle,
                FeatureDataType.enumeration => ControlPresentation.segmented,
                _ => ControlPresentation.slider,
              }
            : null,
        enumOptions: dataType == FeatureDataType.enumeration ? options : null,
        precision: 1,
        description: description.text.trim().isEmpty
            ? null
            : description.text.trim(),
        minValue: low,
        maxValue: high,
        defaultValue: kind == FeatureKind.control ? (initial ?? low) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.feature == null ? '新增特徵' : '編輯特徵',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: key,
              enabled: widget.feature == null,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'JSON Key／特徵代碼',
                helperText: '例如 mt_1_temp',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: label,
              decoration: const InputDecoration(labelText: '顯示名稱'),
            ),
            const SizedBox(height: 12),
            SegmentedButton<FeatureKind>(
              segments: const [
                ButtonSegment(
                  value: FeatureKind.measurement,
                  label: Text('感測／狀態'),
                ),
                ButtonSegment(value: FeatureKind.control, label: Text('控制參數')),
              ],
              selected: {kind},
              onSelectionChanged: (values) =>
                  setState(() => kind = values.first),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<FeatureDataType>(
              initialValue: dataType,
              decoration: const InputDecoration(labelText: '資料型態'),
              items: const [
                DropdownMenuItem(
                  value: FeatureDataType.number,
                  child: Text('數值'),
                ),
                DropdownMenuItem(
                  value: FeatureDataType.boolean,
                  child: Text('開關（0 / 1）'),
                ),
                DropdownMenuItem(
                  value: FeatureDataType.enumeration,
                  child: Text('狀態列舉'),
                ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => dataType = value);
              },
            ),
            if (dataType == FeatureDataType.enumeration) ...[
              const SizedBox(height: 12),
              TextField(
                controller: enumOptions,
                onChanged: (_) => setState(() {}),
                decoration:
                    const InputDecoration(
                      labelText: '狀態選項',
                      helperText: '輸入狀態名稱，使用逗號分隔；順序對應 0、1、2…',
                    ).copyWith(
                      hintText: kind == FeatureKind.control
                          ? '關閉, 開啟, 自動, 連動'
                          : '停止, 運轉中, 故障',
                    ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _enumUsageExample(
                    key.text.trim().isEmpty ? 'status' : key.text.trim(),
                    enumOptions.text,
                    control: kind == FeatureKind.control,
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
            const SizedBox(height: 12),
            TextField(
              controller: unit,
              decoration: const InputDecoration(labelText: '單位'),
            ),
            if (dataType == FeatureDataType.number) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: min,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: '最小值'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: max,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: '最大值'),
                    ),
                  ),
                ],
              ),
            ],
            if (kind == FeatureKind.control) ...[
              const SizedBox(height: 12),
              TextField(
                controller: defaultValue,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '預設值',
                  hintText: switch (dataType) {
                    FeatureDataType.boolean => '例如 0（OFF）或 1（ON）',
                    FeatureDataType.enumeration => '例如 0',
                    _ => '例如 50',
                  },
                  helperText: dataType == FeatureDataType.enumeration
                      ? _enumIndexExample(
                          enumOptions.text,
                          control: kind == FeatureKind.control,
                        )
                      : dataType == FeatureDataType.boolean
                      ? '0 = OFF，1 = ON'
                      : '必須位於最小值與最大值之間',
                ),
              ),
            ],
            const SizedBox(height: 12),
            TextField(
              controller: description,
              maxLines: 2,
              decoration: const InputDecoration(labelText: '說明'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(onPressed: _save, child: const Text('儲存特徵')),
            ),
          ],
        ),
      ),
    );
  }
}

String _enumIndexExample(String rawOptions, {bool control = false}) {
  final options = rawOptions
      .split(',')
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toList();
  if (options.isEmpty) {
    return control ? '關閉 = 0，開啟 = 1，自動 = 2，連動 = 3' : '停止 = 0，運轉中 = 1，故障 = 2';
  }
  return [
    for (var index = 0; index < options.length; index++)
      '${options[index]} = $index',
  ].join('，');
}

String _enumUsageExample(
  String featureKey,
  String rawOptions, {
  bool control = false,
}) {
  final options = rawOptions
      .split(',')
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toList();
  final values = options.length >= 2
      ? options
      : control
      ? ['關閉', '開啟', '自動', '連動']
      : ['停止', '運轉中', '故障'];
  final mapping = [
    for (var index = 0; index < values.length; index++)
      '${values[index]} = $index',
  ].join('、');
  final sampleIndex = values.length - 1;
  return '${control ? '控制模式' : '設備狀態'}範例：$mapping\n'
      'ESP32 可上報 {"$featureKey":"${values[sampleIndex]}"} '
      '或 {"$featureKey":$sampleIndex}。';
}

void _showError(BuildContext context, Object error) {
  final message = error is ValidationException ? error.message : '$error';
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
