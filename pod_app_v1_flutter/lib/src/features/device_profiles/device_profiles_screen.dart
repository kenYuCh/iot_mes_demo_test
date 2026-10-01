import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../widgets/destructive_reauth_dialog.dart';
import '../../widgets/list_search_bar.dart';
import '../../design/factory_theme.dart';
import '../../widgets/tech_ui.dart';
import '../site_detail/site_detail_providers.dart';

class DeviceProfilesScreen extends ConsumerStatefulWidget {
  const DeviceProfilesScreen({super.key});

  @override
  ConsumerState<DeviceProfilesScreen> createState() =>
      _DeviceProfilesScreenState();
}

class _DeviceProfilesScreenState extends ConsumerState<DeviceProfilesScreen> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profiles = ref.watch(deviceProfilesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('設備特徵管理'),
        actions: [
          IconButton.filledTonal(
            tooltip: '特徵資料庫',
            onPressed: () => context.push('/settings/features'),
            icon: const Icon(Icons.dataset_outlined),
          ),
          const SizedBox(width: 12),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: const Text('新增型別'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(deviceProfilesProvider.future),
        child: profiles.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ListView(
            children: [
              const SizedBox(height: 160),
              Center(child: Text('載入失敗：$error')),
            ],
          ),
          data: (items) {
            final filtered = items.where((profile) {
              return matchesListSearch(_query, [
                profile.id,
                profile.name,
                profile.description,
                for (final feature in profile.features) ...[
                  feature.key,
                  feature.label,
                  feature.unit,
                  feature.description,
                ],
              ]);
            }).toList();
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 110),
              children: [
                const TechHero(
                  eyebrow: 'DEVICE CAPABILITY SCHEMA',
                  title: '設備能力型別庫',
                  subtitle: '統一定義感測值、狀態與控制參數，並套用到同型設備',
                  icon: Icons.schema_outlined,
                  accent: FactoryColors.blue,
                ),
                const SizedBox(height: 12),
                ListSearchBar(
                  controller: _search,
                  query: _query,
                  hintText: '搜尋 MCU、設備型別、感測器或 JSON Key',
                  onChanged: (value) => setState(() => _query = value),
                ),
                const SizedBox(height: 12),
                if (filtered.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Center(
                      child: Text(
                        _query.trim().isEmpty
                            ? '尚未建立設備型別\n請點選「新增型別」，並從特徵資料庫選擇特徵'
                            : '找不到符合條件的設備型別',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                for (final profile in filtered)
                  _ProfileCard(
                    profile: profile,
                    onEdit: () => _openEditor(context, ref, profile: profile),
                    onApply: () => _apply(context, ref, profile),
                    onDelete: () => _delete(context, ref, profile),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _openEditor(
    BuildContext context,
    WidgetRef ref, {
    DeviceProfile? profile,
  }) async {
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => _ProfileEditor(profile: profile)),
    );
    if (saved == true) ref.invalidate(deviceProfilesProvider);
  }

  Future<void> _apply(
    BuildContext context,
    WidgetRef ref,
    DeviceProfile profile,
  ) async {
    try {
      final count = await ref
          .read(clientProvider)
          .device
          .applyProfileToDevices(profile.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已將最新特徵套用至 $count 台設備')),
      );
    } catch (error) {
      if (context.mounted) _showError(context, error);
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    DeviceProfile profile,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('刪除「${profile.name}」？'),
        content: const Text(
          '這會永久刪除整個設備型別與所有特徵定義。仍被設備使用的型別不允許刪除。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('刪除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!context.mounted) return;
    final credentials = await showDestructiveReauthDialog(
      context,
      resourceName: profile.name,
    );
    if (credentials == null) return;
    try {
      await ref
          .read(clientProvider)
          .device
          .deleteProfile(
            profile.id,
            credentials.email,
            credentials.password,
          );
      ref.invalidate(deviceProfilesProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('已刪除設備型別「${profile.name}」')),
        );
      }
    } catch (error) {
      if (context.mounted) _showError(context, error);
    }
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.profile,
    required this.onEdit,
    required this.onApply,
    required this.onDelete,
  });

  final DeviceProfile profile;
  final VoidCallback onEdit;
  final VoidCallback onApply;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final measurements = profile.features
        .where((feature) => feature.kind == FeatureKind.measurement)
        .length;
    final controls = profile.features.length - measurements;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const TechIcon(icon: Icons.memory_rounded),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        profile.id,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if ((profile.description ?? '').isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(profile.description!),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('$measurements 個感測／狀態')),
                Chip(label: Text('$controls 個控制參數')),
              ],
            ),
            const Divider(height: 24),
            for (final feature in profile.features)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(
                      feature.kind == FeatureKind.control
                          ? Icons.tune_rounded
                          : Icons.sensors_rounded,
                      size: 18,
                      color: feature.kind == FeatureKind.control
                          ? FactoryColors.purple
                          : FactoryColors.blue,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('${feature.label}  ·  ${feature.key}'),
                    ),
                    Text(
                      '${_number(feature.minValue)}–${_number(feature.maxValue)} ${feature.unit}',
                    ),
                  ],
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onApply,
                  icon: const Icon(Icons.sync_rounded),
                  label: const Text('套用至設備'),
                ),
                IconButton(
                  tooltip: '編輯型別',
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  tooltip: '刪除整個設備型別',
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileEditor extends ConsumerStatefulWidget {
  const _ProfileEditor({this.profile});
  final DeviceProfile? profile;

  @override
  ConsumerState<_ProfileEditor> createState() => _ProfileEditorState();
}

class _ProfileEditorState extends ConsumerState<_ProfileEditor> {
  late final TextEditingController _key;
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _mcuFamily;
  late List<DeviceFeature> _features;
  bool _saving = false;
  DestructiveCredentials? _featureDeleteCredentials;

  @override
  void initState() {
    super.initState();
    _key = TextEditingController(text: widget.profile?.id ?? '');
    _name = TextEditingController(text: widget.profile?.name ?? '');
    _description = TextEditingController(
      text: widget.profile?.description ?? '',
    );
    _mcuFamily = TextEditingController(text: widget.profile?.mcuFamily ?? '');
    _features =
        widget.profile?.features.map((e) => e.copyWith()).toList() ?? [];
  }

  @override
  void dispose() {
    _key.dispose();
    _name.dispose();
    _description.dispose();
    _mcuFamily.dispose();
    super.dispose();
  }

  Future<void> _editFeature([int? index]) async {
    if (index == null) {
      final selected = await showModalBottomSheet<DeviceFeature>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => _CatalogPicker(
          excludedKeys: _features.map((feature) => feature.key).toSet(),
        ),
      );
      if (selected != null) {
        setState(() => _features.add(selected.copyWith()));
      }
      return;
    }
    final result = await showModalBottomSheet<DeviceFeature>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _FeatureEditor(feature: _features[index]),
    );
    if (result == null) return;
    setState(() {
      _features[index] = result;
    });
  }

  Future<void> _deleteFeature(int index) async {
    final feature = _features[index];
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('刪除特徵「${feature.label}」？'),
        content: Text(
          '參數 ${feature.key} 將從此設備型別移除。儲存型別後才會正式生效。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('刪除特徵'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final credentials = await showDestructiveReauthDialog(
      context,
      resourceName: '特徵 ${feature.label}',
    );
    if (credentials == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(clientProvider)
          .device
          .verifyDestructivePassword(
            credentials.email,
            credentials.password,
          );
      if (!mounted) return;
      setState(() {
        _saving = false;
        _featureDeleteCredentials = credentials;
        _features.removeAt(index);
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      _showError(context, error);
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final api = ref.read(clientProvider).device;
      if (widget.profile == null) {
        await api.createProfile(
          _key.text,
          _name.text,
          _description.text,
          _mcuFamily.text,
          _features,
        );
      } else {
        await api.updateProfile(
          _key.text,
          _name.text,
          _description.text,
          _mcuFamily.text,
          _features,
          _featureDeleteCredentials?.email,
          _featureDeleteCredentials?.password,
        );
      }
      if (mounted) Navigator.pop(context, true);
    } catch (error) {
      if (mounted) {
        setState(() => _saving = false);
        _showError(context, error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.profile == null ? '新增設備型別' : '編輯設備型別')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: _key,
            enabled: widget.profile == null,
            decoration: const InputDecoration(
              labelText: '型別代碼',
              helperText: '穩定識別碼，用於設備建檔與 OTA 目標匹配；建立後不可變更',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: '顯示名稱'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _description,
            maxLines: 2,
            decoration: const InputDecoration(labelText: '說明'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _mcuFamily,
            decoration: const InputDecoration(
              labelText: 'MCU 家族',
              hintText: '例如 ESP32、nRF52840、nRF5340',
              helperText: '用於設備型別搜尋與 OTA 相容性分類',
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  '特徵參數',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              FilledButton.tonalIcon(
                onPressed: () => _editFeature(),
                icon: const Icon(Icons.add_rounded),
                label: const Text('從特徵庫選擇'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_features.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('至少加入一個感測或控制參數')),
              ),
            ),
          for (var i = 0; i < _features.length; i++)
            Card(
              child: ListTile(
                leading: Icon(
                  _features[i].kind == FeatureKind.control
                      ? Icons.tune
                      : Icons.sensors,
                ),
                title: Text(_features[i].label),
                subtitle: Text(
                  '${_features[i].key}  ·  ${_number(_features[i].minValue)}–${_number(_features[i].maxValue)} ${_features[i].unit}',
                ),
                onTap: () => _editFeature(i),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: '編輯特徵',
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => _editFeature(i),
                    ),
                    IconButton(
                      tooltip: '刪除特徵',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _deleteFeature(i),
                    ),
                  ],
                ),
              ),
            ),
          if (_features.isNotEmpty)
            Text(
              '點選特徵可編輯；垃圾桶按鈕可刪除。儲存後才會生效。',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _saving ? null : _save,
            icon: const Icon(Icons.save_outlined),
            label: Text(_saving ? '儲存中…' : '儲存型別'),
          ),
        ],
      ),
    );
  }
}

class _CatalogPicker extends ConsumerStatefulWidget {
  const _CatalogPicker({required this.excludedKeys});

  final Set<String> excludedKeys;

  @override
  ConsumerState<_CatalogPicker> createState() => _CatalogPickerState();
}

class _CatalogPickerState extends ConsumerState<_CatalogPicker> {
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
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: .75,
      maxChildSize: .94,
      builder: (context, controller) => Column(
        children: [
          ListTile(
            title: const Text('從特徵資料庫選擇'),
            subtitle: const Text('同一特徵可套用至多個設備型別'),
            trailing: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                context.push('/settings/features');
              },
              icon: const Icon(Icons.add),
              label: const Text('新增'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: ListSearchBar(
              controller: _search,
              query: _query,
              hintText: '搜尋名稱、JSON Key 或單位',
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: catalog.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('載入失敗：$error')),
              data: (items) {
                final available = items
                    .where(
                      (item) => !widget.excludedKeys.contains(item.feature.key),
                    )
                    .where((item) {
                      final feature = item.feature;
                      return matchesListSearch(_query, [
                        feature.label,
                        feature.key,
                        feature.unit,
                        feature.description ?? '',
                      ]);
                    })
                    .toList();
                if (available.isEmpty) {
                  return const Center(child: Text('沒有其他可加入的特徵'));
                }
                return ListView.builder(
                  controller: controller,
                  itemCount: available.length,
                  itemBuilder: (context, index) {
                    final item = available[index];
                    final feature = item.feature;
                    return ListTile(
                      leading: Icon(
                        feature.kind == FeatureKind.control
                            ? Icons.tune
                            : Icons.sensors,
                      ),
                      title: Text(feature.label),
                      subtitle: Text(
                        '${feature.key}  ·  ${_number(feature.minValue)}–${_number(feature.maxValue)} ${feature.unit}',
                      ),
                      trailing: item.system
                          ? const Chip(label: Text('系統'))
                          : const Icon(Icons.add_circle_outline),
                      onTap: () => Navigator.pop(context, feature),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureEditor extends StatefulWidget {
  const _FeatureEditor({this.feature});
  final DeviceFeature? feature;

  @override
  State<_FeatureEditor> createState() => _FeatureEditorState();
}

class _FeatureEditorState extends State<_FeatureEditor> {
  late final TextEditingController key;
  late final TextEditingController label;
  late final TextEditingController unit;
  late final TextEditingController min;
  late final TextEditingController max;
  late final TextEditingController defaultValue;
  late FeatureKind kind;

  @override
  void initState() {
    super.initState();
    final f = widget.feature;
    key = TextEditingController(text: f?.key ?? '');
    label = TextEditingController(text: f?.label ?? '');
    unit = TextEditingController(text: f?.unit ?? '');
    min = TextEditingController(text: f == null ? '0' : _number(f.minValue));
    max = TextEditingController(text: f == null ? '100' : _number(f.maxValue));
    defaultValue = TextEditingController(
      text: f?.defaultValue == null ? '' : _number(f!.defaultValue!),
    );
    kind = f?.kind ?? FeatureKind.measurement;
  }

  @override
  void dispose() {
    for (final controller in [key, label, unit, min, max, defaultValue]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _done() {
    final low = double.tryParse(min.text);
    final high = double.tryParse(max.text);
    final initial = double.tryParse(defaultValue.text);
    if (key.text.trim().isEmpty ||
        label.text.trim().isEmpty ||
        low == null ||
        high == null ||
        low > high) {
      _showError(context, '請確認代碼、名稱與上下限');
      return;
    }
    Navigator.pop(
      context,
      DeviceFeature(
        key: key.text.trim(),
        label: label.text.trim(),
        unit: unit.text.trim(),
        kind: kind,
        dataType: FeatureDataType.number,
        controlPresentation: kind == FeatureKind.control
            ? ControlPresentation.slider
            : null,
        precision: 1,
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
        12,
        20,
        MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.feature == null ? '加入特徵' : '編輯特徵',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SegmentedButton<FeatureKind>(
              segments: const [
                ButtonSegment(
                  value: FeatureKind.measurement,
                  label: Text('感測／狀態'),
                  icon: Icon(Icons.sensors),
                ),
                ButtonSegment(
                  value: FeatureKind.control,
                  label: Text('控制參數'),
                  icon: Icon(Icons.tune),
                ),
              ],
              selected: {kind},
              onSelectionChanged: (value) => setState(() => kind = value.first),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: key,
              decoration: const InputDecoration(labelText: '參數代碼（JSON key）'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: label,
              decoration: const InputDecoration(labelText: '顯示名稱'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: unit,
              decoration: const InputDecoration(labelText: '單位'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: min,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    decoration: const InputDecoration(labelText: '最小值'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: max,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    decoration: const InputDecoration(labelText: '最大值'),
                  ),
                ),
              ],
            ),
            if (kind == FeatureKind.control) ...[
              const SizedBox(height: 10),
              TextField(
                controller: defaultValue,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: const InputDecoration(labelText: '預設值'),
              ),
            ],
            const SizedBox(height: 20),
            FilledButton(onPressed: _done, child: const Text('完成')),
          ],
        ),
      ),
    );
  }
}

void _showError(BuildContext context, Object error) {
  final message = error is ValidationException ? error.message : '$error';
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

String _number(double value) => value == value.roundToDouble()
    ? value.toInt().toString()
    : value.toString();
