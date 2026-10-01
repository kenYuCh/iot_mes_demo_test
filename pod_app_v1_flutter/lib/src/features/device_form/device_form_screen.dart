import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../widgets/destructive_reauth_dialog.dart';
import '../dashboard/dashboard_providers.dart';
import '../device_detail/device_detail_providers.dart';
import '../provisioning/provisioning_providers.dart';
import '../site_detail/site_detail_providers.dart';
import '../sites/sites_providers.dart';

/// 依出廠型號建議設備型別檔（與後端 deviceTypeForModel 對齊）。
String suggestedProfileForModel(String model) {
  if (model.startsWith('ESP32-MOTOR')) return 'esp32_motor_sensor';
  if (model.startsWith('SENSOR-T')) return 'temperature';
  if (model.startsWith('SENSOR-H')) return 'humidity';
  if (model.startsWith('SENSOR-P')) return 'power';
  if (model.startsWith('SENSOR-V')) return 'vibration';
  return 'temperature';
}

bool isGatewayModel(String model) => model.startsWith('GW');

/// 設備基本資料建檔／編輯頁：身分（序號、名稱、型號、場域／閘道、間隔）
/// ＋ 能力（型別檔與量測／控制預覽）。配對後「加入設備庫」與場域「註冊」共用。
class DeviceFormScreen extends ConsumerStatefulWidget {
  const DeviceFormScreen({
    super.key,
    this.siteId,
    this.deviceId,
    this.serial,
  });

  /// 預選場域（場域內註冊時帶入）。
  final int? siteId;

  /// 非 null 為編輯既有平台設備。
  final int? deviceId;

  /// 預選已配對序號（配對完成後「加入設備庫」帶入）。
  final String? serial;

  @override
  ConsumerState<DeviceFormScreen> createState() => _DeviceFormScreenState();
}

class _DeviceFormScreenState extends ConsumerState<DeviceFormScreen> {
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _intervalController = TextEditingController(text: '10');

  int? _siteId;
  int? _gatewayId;
  bool _directConnection = true;
  String? _serial;
  String? _profileId;
  bool _hydratedEdit = false;
  bool _hydratedSerial = false;
  bool _saving = false;
  String? _error;

  bool get _isEdit => widget.deviceId != null;

  ProvisionedDevice? _findSerial(
    List<ProvisionedDevice> items,
    String? serial,
  ) {
    if (serial == null) return null;
    for (final item in items) {
      if (item.serial == serial) return item;
    }
    return null;
  }

  bool _isGw(List<ProvisionedDevice> unlinked) {
    final device = _findSerial(unlinked, _serial);
    return device != null && isGatewayModel(device.model);
  }

  void _applySerialDefaults(ProvisionedDevice device) {
    final suffix = device.serial.length >= 4
        ? device.serial.substring(device.serial.length - 4)
        : device.serial;
    if (_nameController.text.trim().isEmpty) {
      _nameController.text = isGatewayModel(device.model)
          ? 'ESP32 閘道器 $suffix'
          : device.model.startsWith('ESP32-MOTOR')
          ? 'ESP32 馬達控制器 $suffix'
          : 'ESP32 感測器 $suffix';
    }
    if (_modelController.text.trim().isEmpty) {
      _modelController.text = device.model;
    }
    if (!isGatewayModel(device.model)) {
      _profileId ??= suggestedProfileForModel(device.model);
    }
  }

  @override
  void initState() {
    super.initState();
    _siteId = widget.siteId;
    _serial = widget.serial;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _modelController.dispose();
    _intervalController.dispose();
    super.dispose();
  }

  Future<void> _save({
    required List<ProvisionedDevice> unlinked,
    Device? editing,
  }) async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() => _error = '請輸入名稱');
      return;
    }
    if (_siteId == null) {
      setState(() => _error = '請選擇場域');
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      final client = ref.read(clientProvider);

      if (_isEdit && editing != null) {
        final interval = int.tryParse(_intervalController.text.trim());
        if (interval == null || interval <= 0) {
          setState(() {
            _saving = false;
            _error = '上報間隔必須為大於 0 的整數秒';
          });
          return;
        }
        await client.device.updateDevice(
          editing.id!,
          name,
          _modelController.text.trim(),
          interval,
        );
        ref.invalidate(deviceProvider(editing.id!));
        ref.invalidate(devicesProvider(_siteId!));
        ref.invalidate(dashboardProvider);
        if (mounted) context.pop();
        return;
      }

      final paired = _findSerial(unlinked, _serial);
      if (paired != null && isGatewayModel(paired.model)) {
        await client.provisioning.attachToPlatform(
          paired.serial,
          _siteId!,
          null,
          name,
          '',
          0,
          '',
        );
        ref.invalidate(provisionedDevicesProvider);
        ref.invalidate(unlinkedDevicesProvider);
        ref.invalidate(gatewaysProvider(_siteId!));
        ref.invalidate(dashboardProvider);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('閘道器已加入設備庫')),
          );
          context.pop();
        }
        return;
      }

      if (!_directConnection && _gatewayId == null) {
        setState(() {
          _saving = false;
          _error = '請選擇閘道器';
        });
        return;
      }
      final profileId = _profileId;
      if (profileId == null) {
        setState(() {
          _saving = false;
          _error = '請選擇設備型別';
        });
        return;
      }
      final interval = int.tryParse(_intervalController.text.trim());
      if (interval == null || interval <= 0) {
        setState(() {
          _saving = false;
          _error = '上報間隔必須為大於 0 的整數秒';
        });
        return;
      }

      if (paired != null) {
        await client.provisioning.attachToPlatform(
          paired.serial,
          _siteId!,
          _directConnection ? null : _gatewayId,
          name,
          profileId,
          interval,
          _modelController.text.trim(),
        );
        ref.invalidate(provisionedDevicesProvider);
        ref.invalidate(unlinkedDevicesProvider);
      } else {
        await client.device.createDevice(
          _siteId!,
          _directConnection ? null : _gatewayId,
          name,
          _modelController.text.trim(),
          profileId,
          interval,
        );
      }

      ref.invalidate(devicesProvider(_siteId!));
      ref.invalidate(dashboardProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              paired != null ? '已加入設備庫，數秒內開始回報數據' : '設備已註冊',
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      setState(() {
        _saving = false;
        _error = e is ValidationException ? e.message : '$e';
      });
    }
  }

  Future<void> _deleteDevice(Device device) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('刪除設備「${device.name}」？'),
        content: const Text(
          '此操作會刪除量測、狀態、命令與告警資料。'
          '實體機配對身分會保留，並回到可重新加入設備庫的狀態。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('繼續'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final credentials = await showDestructiveReauthDialog(
      context,
      resourceName: device.name,
    );
    if (credentials == null) return;

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(clientProvider)
          .device
          .deleteDevice(
            device.id!,
            credentials.email,
            credentials.password,
          );
      ref.invalidate(deviceProvider(device.id!));
      ref.invalidate(devicesProvider(device.siteId));
      ref.invalidate(provisionedDevicesProvider);
      ref.invalidate(unlinkedDevicesProvider);
      ref.invalidate(dashboardProvider);
      if (mounted) context.go('/assets/${device.siteId}');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = e is ValidationException ? e.message : '$e';
      });
    }
  }

  DeviceProfile? _profileOf(List<DeviceProfile> profiles, String? id) {
    if (id == null) return null;
    for (final profile in profiles) {
      if (profile.id == id) return profile;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sites = ref.watch(sitesProvider);
    final profiles = ref.watch(deviceProfilesProvider);
    final unlinked = ref.watch(unlinkedDevicesProvider);

    if (_isEdit) {
      final deviceAsync = ref.watch(deviceProvider(widget.deviceId!));
      return deviceAsync.when(
        loading: () => Scaffold(
          appBar: AppBar(title: const Text('編輯設備')),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Scaffold(
          appBar: AppBar(title: const Text('編輯設備')),
          body: Center(child: Text('$e')),
        ),
        data: (device) {
          if (!_hydratedEdit) {
            _hydratedEdit = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              setState(() {
                _siteId = device.siteId;
                _gatewayId = device.gatewayId;
                _directConnection = device.gatewayId == null;
                _profileId = device.deviceType;
                _nameController.text = device.name;
                _modelController.text = device.model;
                _intervalController.text = '${device.expectedIntervalSeconds}';
              });
            });
          }
          return _buildScaffold(
            theme: theme,
            title: '編輯設備',
            sites: sites,
            profiles: profiles,
            unlinkedItems: const [],
            editing: device,
          );
        },
      );
    }

    return unlinked.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('設備建檔')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('設備建檔')),
        body: Center(child: Text('$e')),
      ),
      data: (items) {
        if (!_hydratedSerial && widget.serial != null) {
          final preset = _findSerial(items, widget.serial);
          if (preset != null) {
            _hydratedSerial = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              setState(() => _applySerialDefaults(preset));
            });
          }
        }
        return _buildScaffold(
          theme: theme,
          title: _titleForCreate(items),
          sites: sites,
          profiles: profiles,
          unlinkedItems: items,
          editing: null,
        );
      },
    );
  }

  String _titleForCreate(List<ProvisionedDevice> items) {
    if (_serial != null && _isGw(items)) return '加入閘道器';
    if (_serial != null) return '加入設備庫';
    return '註冊設備';
  }

  Widget _buildScaffold({
    required ThemeData theme,
    required String title,
    required AsyncValue<List<Site>> sites,
    required AsyncValue<List<DeviceProfile>> profiles,
    required List<ProvisionedDevice> unlinkedItems,
    required Device? editing,
  }) {
    final isGw = !_isEdit && _isGw(unlinkedItems);
    final profileList = profiles.value ?? const <DeviceProfile>[];
    final selectedProfile = _profileOf(profileList, _profileId);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          Text('身分', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            isGw
                ? '將已配對的閘道硬體掛入場域。'
                : _isEdit
                ? '更新顯示名稱、型號與預期上報間隔。'
                : '選擇已配對硬體（可選）並指定場域／閘道器。',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          if (!_isEdit) ...[
            DropdownButtonFormField<String?>(
              key: ValueKey('serial-$_serial'),
              initialValue: unlinkedItems.any((d) => d.serial == _serial)
                  ? _serial
                  : null,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: '實體序號（已配對、未掛載）',
                prefixIcon: Icon(Icons.qr_code_2_outlined),
                helperText: '留空可只建邏輯設備；配對後再綁亦可',
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('（不綁實體）'),
                ),
                for (final device in unlinkedItems)
                  DropdownMenuItem(
                    value: device.serial,
                    child: Text(
                      '${device.serial}（${device.model}）',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: (value) {
                setState(() {
                  _serial = value;
                  _gatewayId = null;
                  final device = _findSerial(unlinkedItems, value);
                  if (device != null) {
                    _applySerialDefaults(device);
                  }
                });
              },
            ),
            const SizedBox(height: 12),
          ],
          sites.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('$e'),
            data: (items) => DropdownButtonFormField<int>(
              key: ValueKey('site-$_siteId'),
              initialValue: items.any((s) => s.id == _siteId) ? _siteId : null,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: '場域',
                prefixIcon: Icon(Icons.factory_outlined),
              ),
              items: [
                for (final site in items)
                  DropdownMenuItem(value: site.id, child: Text(site.name)),
              ],
              onChanged: _isEdit
                  ? null
                  : (value) => setState(() {
                      _siteId = value;
                      _gatewayId = null;
                    }),
            ),
          ),
          if (!isGw && _siteId != null) ...[
            const SizedBox(height: 12),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: true,
                  icon: Icon(Icons.wifi_rounded),
                  label: Text('直連 Wi-Fi'),
                ),
                ButtonSegment(
                  value: false,
                  icon: Icon(Icons.router_outlined),
                  label: Text('經 Gateway'),
                ),
              ],
              selected: {_directConnection},
              onSelectionChanged: _isEdit
                  ? null
                  : (values) => setState(() {
                      _directConnection = values.first;
                      if (_directConnection) _gatewayId = null;
                    }),
            ),
          ],
          if (!isGw && !_directConnection && _siteId != null) ...[
            const SizedBox(height: 12),
            ref
                .watch(gatewaysProvider(_siteId!))
                .when(
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text('$e'),
                  data: (gateways) => DropdownButtonFormField<int>(
                    key: ValueKey('gateway-$_siteId-$_gatewayId'),
                    initialValue: gateways.any((g) => g.id == _gatewayId)
                        ? _gatewayId
                        : null,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: '閘道器',
                      prefixIcon: Icon(Icons.router_outlined),
                    ),
                    items: [
                      for (final gateway in gateways)
                        DropdownMenuItem(
                          value: gateway.id,
                          child: Text(gateway.name),
                        ),
                    ],
                    onChanged: _isEdit
                        ? null
                        : (value) => setState(() => _gatewayId = value),
                  ),
                ),
          ],
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: '顯示名稱',
              prefixIcon: Icon(Icons.badge_outlined),
            ),
          ),
          if (!isGw) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _modelController,
              decoration: const InputDecoration(
                labelText: '型號',
                prefixIcon: Icon(Icons.memory_outlined),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _intervalController,
              decoration: const InputDecoration(
                labelText: '預期上報間隔（秒）',
                prefixIcon: Icon(Icons.timer_outlined),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 28),
            Text('能力', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              _isEdit ? '型別檔註冊後不可變更；以下為目前通道預覽。' : '選擇型別檔後會套用量測通道與控制參數。',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            if (_isEdit)
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: '設備型別',
                  prefixIcon: Icon(Icons.category_outlined),
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  selectedProfile?.name ?? editing?.deviceType ?? '—',
                ),
              )
            else
              profiles.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text('$e'),
                data: (items) => DropdownButtonFormField<String>(
                  key: ValueKey('profile-$_profileId'),
                  initialValue: items.any((p) => p.id == _profileId)
                      ? _profileId
                      : null,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: '設備型別',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: [
                    for (final profile in items)
                      DropdownMenuItem(
                        value: profile.id,
                        child: Text(
                          '${profile.name}'
                          '（${profile.features.where((f) => f.kind == FeatureKind.measurement).length} 量測）',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: (value) => setState(() => _profileId = value),
                ),
              ),
            if (selectedProfile != null) ...[
              const SizedBox(height: 12),
              if ((selectedProfile.description ?? '').isNotEmpty)
                Text(
                  selectedProfile.description!,
                  style: theme.textTheme.bodySmall,
                ),
              const SizedBox(height: 12),
              _FeaturePreview(profile: selectedProfile),
            ] else if (_isEdit && editing?.features != null) ...[
              const SizedBox(height: 12),
              _FeaturePreview(
                profile: DeviceProfile(
                  id: editing!.deviceType,
                  name: editing.deviceType,
                  description: '',
                  features: editing.features!,
                ),
              ),
            ],
          ],
          if (_error != null) ...[
            const SizedBox(height: 16),
            Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
          ],
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _saving
                ? null
                : () => _save(unlinked: unlinkedItems, editing: editing),
            icon: Icon(_isEdit ? Icons.save_outlined : Icons.playlist_add),
            label: Text(
              _saving
                  ? '儲存中…'
                  : _isEdit
                  ? '儲存'
                  : isGw
                  ? '加入閘道器'
                  : _serial != null
                  ? '加入設備庫'
                  : '註冊設備',
            ),
          ),
          if (_isEdit && editing != null) ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
                side: BorderSide(color: theme.colorScheme.error),
              ),
              onPressed: _saving ? null : () => _deleteDevice(editing),
              icon: const Icon(Icons.delete_forever_outlined),
              label: const Text('刪除這台設備'),
            ),
          ],
        ],
      ),
    );
  }
}

class _FeaturePreview extends StatelessWidget {
  const _FeaturePreview({required this.profile});

  final DeviceProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final measurements = [
      for (final f in profile.features)
        if (f.kind == FeatureKind.measurement) f,
    ];
    final controls = [
      for (final f in profile.features)
        if (f.kind == FeatureKind.control) f,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('唯讀特徵（感測值／狀態）', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        if (measurements.isEmpty)
          Text('無', style: theme.textTheme.bodySmall)
        else
          Column(
            children: [for (final f in measurements) _FeatureTile(feature: f)],
          ),
        const SizedBox(height: 16),
        Text('控制參數', style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        if (controls.isEmpty)
          Text('無', style: theme.textTheme.bodySmall)
        else
          Column(
            children: [for (final f in controls) _FeatureTile(feature: f)],
          ),
      ],
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({required this.feature});

  final DeviceFeature feature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isControl = feature.kind == FeatureKind.control;
    final typeLabel = switch (feature.dataType) {
      FeatureDataType.boolean => '開關',
      FeatureDataType.enumeration => '狀態列舉',
      _ => '數值',
    };
    final range = feature.dataType == FeatureDataType.enumeration
        ? (feature.enumOptions ?? const <String>[]).join(' / ')
        : '${feature.minValue} ~ ${feature.maxValue}${feature.unit.isEmpty ? '' : ' ${feature.unit}'}';
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(isControl ? Icons.tune : Icons.sensors),
        title: Text(feature.label),
        subtitle: Text('JSON key: ${feature.key}  •  $typeLabel\n$range'),
        trailing: Chip(label: Text(isControl ? '可寫控制' : '唯讀回報')),
        isThreeLine: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        tileColor: theme.colorScheme.surfaceContainerLow,
      ),
    );
  }
}
