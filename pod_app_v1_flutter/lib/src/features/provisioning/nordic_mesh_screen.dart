import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Element;
import 'package:nrf_mesh_flutter/nrf_mesh_flutter.dart';

import '../../design/factory_theme.dart';
import '../../widgets/tech_ui.dart';

String _secureMeshKey() {
  final random = Random.secure();
  return List.generate(
    16,
    (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ).join().toUpperCase();
}

/// Nordic Bluetooth Mesh 的獨立佈署頁。
///
/// Mesh Network、NetKey、AppKey、Node 與 Address 均由 Nordic 原生 Mesh DB
/// 保存；金鑰不會寫入 Serverpod 或顯示於操作紀錄。
class NordicMeshScreen extends StatefulWidget {
  const NordicMeshScreen({super.key});

  @override
  State<NordicMeshScreen> createState() => _NordicMeshScreenState();
}

class _NordicMeshScreenState extends State<NordicMeshScreen> {
  final _mesh = PlatoJobsNrfMeshManager.instance;
  final _devices = <UnprovisionedDevice>[];
  List<ProvisionedNode> _nodes = const [];
  MeshNetwork? _network;
  StreamSubscription<UnprovisionedDevice>? _scanSubscription;
  StreamSubscription<ProvisioningEvent>? _eventSubscription;
  Timer? _scanTimer;
  bool _initializing = true;
  bool _scanning = false;
  bool _busy = false;
  String _status = '正在初始化 Nordic Mesh…';

  bool get _isSimulator =>
      !kIsWeb &&
      defaultTargetPlatform == TargetPlatform.iOS &&
      Platform.environment.containsKey('SIMULATOR_DEVICE_NAME');

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _mesh.initialize();
      _eventSubscription = _mesh.provisioningEventStream.listen((event) {
        if (!mounted) return;
        setState(() {
          _status = event.message?.isNotEmpty == true
              ? event.message!
              : 'Provisioning：${event.type?.name ?? '處理中'}';
        });
        _refreshTopology();
      });
      await _refreshTopology();
      _setStatus(_network == null ? '請先建立 Mesh Network' : 'Mesh 已就緒');
    } catch (error) {
      _setStatus('Nordic Mesh 初始化失敗：$error');
    } finally {
      if (mounted) setState(() => _initializing = false);
    }
  }

  Future<void> _refreshTopology() async {
    try {
      final network = await _mesh.loadNetwork();
      final nodes = await _mesh.getNodes();
      if (!mounted) return;
      setState(() {
        _network = network.networkId.isEmpty ? null : network;
        _nodes = nodes;
      });
    } catch (_) {
      // 尚未建立 Network 時，部分原生 SDK 會以 exception 表示空資料庫。
    }
  }

  void _setStatus(String value) {
    if (mounted) setState(() => _status = value);
  }

  Future<void> _createNetwork() async {
    final controller = TextEditingController(text: 'Factory Mesh');
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('建立 Mesh Network'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Network 名稱',
            hintText: '例如：A廠區 Nordic Mesh',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('建立'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.isEmpty) return;
    await _run('正在建立 Mesh Network…', () async {
      _network = await _mesh.createNetwork(name);
      await _mesh.saveNetwork();
      await _refreshTopology();
    }, success: 'Mesh Network 已建立');
  }

  Future<void> _startScan() async {
    if (_network == null) {
      _showMessage('請先建立 Mesh Network');
      return;
    }
    await _scanSubscription?.cancel();
    setState(() {
      _devices.clear();
      _scanning = true;
      _status = '掃描未 Provision 的 Mesh Node…';
    });
    _scanSubscription = _mesh.scanForDevices().listen(
      (device) {
        if (!mounted) return;
        setState(() {
          final index = _devices.indexWhere(
            (d) => d.deviceId == device.deviceId,
          );
          if (index < 0) {
            _devices.add(device);
          } else {
            _devices[index] = device;
          }
          _devices.sort((a, b) => b.rssi.compareTo(a.rssi));
        });
      },
      onError: (Object error) {
        _setStatus('掃描失敗：$error');
        if (mounted) setState(() => _scanning = false);
      },
    );
    _scanTimer?.cancel();
    _scanTimer = Timer(const Duration(seconds: 20), () {
      if (_scanning) _stopScan();
    });
  }

  Future<void> _stopScan() async {
    _scanTimer?.cancel();
    _scanTimer = null;
    await _mesh.stopScan();
    await _scanSubscription?.cancel();
    _scanSubscription = null;
    if (mounted) setState(() => _scanning = false);
    _setStatus(_devices.isEmpty ? '沒有找到可配對的 Mesh Node' : '掃描已停止');
  }

  Future<void> _provision(UnprovisionedDevice device) async {
    final result =
        await showModalBottomSheet<
          ({String name, bool privacy, String? staticOob})
        >(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (context) => _ProvisionNodeSheet(device: device),
        );
    if (result == null) return;
    await _stopScan();
    await _run('正在建立安全 Provisioning Bearer…', () async {
      final connected = await _mesh.connectProvisioning(device.deviceId);
      if (!connected) throw StateError('無法連接 PB-GATT');
      final parameters = result.staticOob == null
          ? ProvisioningParameters.noOob(
              deviceName: result.name,
              enablePrivacy: result.privacy,
            )
          : ProvisioningParameters.staticOob(
              deviceName: result.name,
              hex: result.staticOob!,
              enablePrivacy: result.privacy,
            );
      final node = await _mesh.provisionDevice(device, parameters);
      await _mesh.saveNetwork();
      await _refreshTopology();
      _showMessage('Node 已配置，Unicast Address：${node.unicastAddress}');
    }, success: 'Node Provisioning 完成');
  }

  Future<void> _addAppKey() async {
    final result = await showDialog<({int index, String key})>(
      context: context,
      builder: (context) => const _AppKeyDialog(),
    );
    if (result == null) return;
    await _run('正在新增 AppKey…', () async {
      final ok = await _mesh.addAppKey(result.index, result.key);
      if (!ok) throw StateError('原生 Mesh DB 拒絕新增 AppKey');
      await _mesh.saveNetwork();
      await _refreshTopology();
    }, success: 'AppKey ${result.index} 已安全保存');
  }

  Future<void> _bindModel(ProvisionedNode node, {bool unbind = false}) async {
    final models = [
      for (final element in node.elements)
        for (final model in element.models)
          if (model.modelId.toUpperCase() != '0X0000' &&
              model.modelId.toUpperCase() != '0X0001')
            (element: element, model: model),
    ];
    if (models.isEmpty) {
      _showMessage('尚無 Composition Data，請先確認 Node 已完成設定');
      return;
    }
    final appKeys = await _mesh.getAppKeys();
    if (appKeys.isEmpty) {
      _showMessage('請先新增 AppKey');
      return;
    }
    if (!mounted) return;
    final selection =
        await showDialog<
          ({List<({Element element, Model model})> targets, int appKey})
        >(
          context: context,
          builder: (context) => _BindModelDialog(
            models: models,
            appKeys: appKeys,
            unbind: unbind,
          ),
        );
    if (selection == null) return;
    setState(() {
      _busy = true;
      _status =
          '準備批次${unbind ? '解除' : ''}綁定 ${selection.targets.length} 個 Model…';
    });
    var succeeded = 0;
    var skipped = 0;
    final failed = <String>[];
    for (var index = 0; index < selection.targets.length; index++) {
      final target = selection.targets[index];
      final label = '${target.element.address}/${target.model.modelId}';
      final isBound = target.model.boundAppKeyIndexes.contains(
        selection.appKey,
      );
      if ((!unbind && isBound) || (unbind && !isBound)) {
        skipped++;
        continue;
      }
      _setStatus(
        'AppKey ${selection.appKey} ${unbind ? '解除綁定' : '綁定'}中：'
        '${index + 1}/${selection.targets.length}　$label',
      );
      try {
        final ok = unbind
            ? await _mesh.unbindAppKey(
                _hexValue(target.element.address),
                _hexValue(target.model.modelId),
                selection.appKey,
              )
            : await _mesh.bindAppKey(
                _hexValue(target.element.address),
                _hexValue(target.model.modelId),
                selection.appKey,
              );
        if (ok) {
          succeeded++;
        } else {
          failed.add(label);
        }
      } catch (_) {
        failed.add(label);
      }
    }
    try {
      await _mesh.saveNetwork();
      await _refreshTopology();
      _setStatus(
        failed.isEmpty
            ? '批次${unbind ? '解除' : ''}綁定完成：成功 $succeeded、略過 $skipped'
            : '批次${unbind ? '解除' : ''}綁定完成：成功 $succeeded、略過 $skipped、'
                  '失敗 ${failed.length}',
      );
      if (failed.isNotEmpty) {
        _showMessage('失敗項目：${failed.join('、')}，可再次執行以重試');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  int _hexValue(String value) =>
      int.parse(value.toUpperCase().replaceFirst('0X', ''), radix: 16);

  Future<void> _removeNode(ProvisionedNode node) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('重設並移除 Mesh Node？'),
        content: Text(
          '${node.uuid}\nAddress ${node.unicastAddress}\n\n'
          '將先透過 Config Node Reset 清除設備的 Mesh 身分，成功後才從本機 Mesh DB 移除。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('確認重設並移除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _run('正在送出 Config Node Reset…', () async {
      final reset = await _mesh.nodeReset(_hexValue(node.unicastAddress));
      if (!reset) throw StateError('Node 沒有確認 Reset；未從 Mesh DB 移除');
      await _mesh.removeNode(node.uuid);
      await _mesh.saveNetwork();
      await _refreshTopology();
    }, success: 'Node 已重設並移除，可重新 Provision');
  }

  Future<void> _run(
    String pending,
    Future<void> Function() action, {
    required String success,
  }) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _status = pending;
    });
    try {
      await action();
      _setStatus(success);
    } catch (error) {
      _setStatus('操作失敗：$error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _scanTimer?.cancel();
    _scanSubscription?.cancel();
    _eventSubscription?.cancel();
    _mesh.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final network = _network;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nordic Mesh 配對'),
        actions: [
          IconButton(
            tooltip: '重新整理',
            onPressed: _busy ? null : _refreshTopology,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _initializing
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
              children: [
                const TechHero(
                  eyebrow: 'NORDIC BLUETOOTH MESH',
                  title: 'Mesh Node Provisioning',
                  subtitle: '管理 Mesh、Node、NetKey、AppKey 與 Unicast Address',
                  icon: Icons.hub_outlined,
                  accent: FactoryColors.secondary,
                ),
                if (_isSimulator)
                  const _NoticeCard(
                    text:
                        'iOS Simulator 無 Bluetooth；請使用實體 iPhone 執行掃描與 Provisioning。',
                  ),
                _StatusCard(status: _status, busy: _busy),
                const TechSectionLabel(
                  'Mesh Network',
                  detail: 'SECURE DATABASE',
                ),
                _NetworkCard(
                  network: network,
                  onCreate: _busy ? null : _createNetwork,
                  onAddAppKey: network == null || _busy ? null : _addAppKey,
                ),
                const TechSectionLabel('未配置 Node', detail: 'PB-GATT SCAN'),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _busy
                            ? null
                            : (_scanning ? _stopScan : _startScan),
                        icon: Icon(
                          _scanning ? Icons.stop : Icons.bluetooth_searching,
                        ),
                        label: Text(_scanning ? '停止掃描' : '掃描 Mesh Node'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (_devices.isEmpty)
                  const _NoticeCard(
                    text: '掃描 Bluetooth Mesh Provisioning Service（UUID 0x1827）',
                  )
                else
                  for (final device in _devices)
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.bluetooth),
                        title: Text(
                          device.name.isEmpty ? '未命名 Mesh Node' : device.name,
                        ),
                        subtitle: Text(
                          '${device.deviceId}\nRSSI ${device.rssi} dBm',
                        ),
                        isThreeLine: true,
                        trailing: FilledButton.tonal(
                          onPressed: _busy ? null : () => _provision(device),
                          child: const Text('配置'),
                        ),
                      ),
                    ),
                const TechSectionLabel('已配置 Node', detail: 'TOPOLOGY'),
                if (_nodes.isEmpty)
                  const _NoticeCard(text: '尚未有 Node 加入目前的 Mesh Network')
                else
                  for (final node in _nodes)
                    _NodeCard(
                      node: node,
                      onBind: () => _bindModel(node),
                      onUnbind: () => _bindModel(node, unbind: true),
                      onRemove: () => _removeNode(node),
                    ),
              ],
            ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.status, required this.busy});
  final String status;
  final bool busy;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          if (busy)
            const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            const Icon(Icons.info_outline, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(status)),
        ],
      ),
    ),
  );
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const Icon(Icons.tips_and_updates_outlined),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    ),
  );
}

class _NetworkCard extends StatelessWidget {
  const _NetworkCard({required this.network, this.onCreate, this.onAddAppKey});
  final MeshNetwork? network;
  final VoidCallback? onCreate;
  final VoidCallback? onAddAppKey;

  @override
  Widget build(BuildContext context) {
    final value = network;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: value == null
            ? Column(
                children: [
                  const Text('尚未建立 Mesh Network'),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: onCreate,
                    icon: const Icon(Icons.add),
                    label: const Text('建立 Network'),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text('Network ID：${value.networkId}'),
                  Text(
                    'NetKey：${value.networkKeys.length}　AppKey：${value.appKeys.length}',
                  ),
                  Text(
                    'Node：${value.nodes.length}　Group：${value.groups.length}',
                  ),
                  const SizedBox(height: 12),
                  FilledButton.tonalIcon(
                    onPressed: onAddAppKey,
                    icon: const Icon(Icons.key),
                    label: const Text('新增 AppKey'),
                  ),
                ],
              ),
      ),
    );
  }
}

class _NodeCard extends StatelessWidget {
  const _NodeCard({
    required this.node,
    required this.onBind,
    required this.onUnbind,
    required this.onRemove,
  });
  final ProvisionedNode node;
  final VoidCallback onBind;
  final VoidCallback onUnbind;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => Card(
    child: ExpansionTile(
      leading: const Icon(Icons.memory),
      title: Text(node.uuid),
      subtitle: Text(
        'Primary Address ${node.unicastAddress} · ${node.elements.length} Elements',
      ),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'NetKey ${node.networkKeys.map((e) => e.index).join(', ')}　'
            'AppKey ${node.appKeys.map((e) => e.index).join(', ')}',
          ),
        ),
        const SizedBox(height: 10),
        for (final element in node.elements)
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text('Element ${element.address}'),
            subtitle: Text(
              element.models.isEmpty
                  ? '尚無 Composition Model'
                  : element.models
                        .map((m) => '${m.modelName} (${m.modelId})')
                        .join('、'),
            ),
          ),
        Wrap(
          alignment: WrapAlignment.end,
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(
              onPressed: onUnbind,
              child: const Text('解除 AppKey 綁定'),
            ),
            FilledButton.tonal(
              onPressed: onBind,
              child: const Text('綁定 AppKey / Model'),
            ),
            TextButton.icon(
              onPressed: onRemove,
              icon: const Icon(Icons.delete_outline),
              label: const Text('重設並移除 Node'),
            ),
          ],
        ),
      ],
    ),
  );
}

class _ProvisionNodeSheet extends StatefulWidget {
  const _ProvisionNodeSheet({required this.device});
  final UnprovisionedDevice device;

  @override
  State<_ProvisionNodeSheet> createState() => _ProvisionNodeSheetState();
}

class _ProvisionNodeSheetState extends State<_ProvisionNodeSheet> {
  late final TextEditingController _name = TextEditingController(
    text: widget.device.name.isEmpty ? 'Nordic Mesh Node' : widget.device.name,
  );
  bool _privacy = true;
  bool _useStaticOob = false;
  final _staticOob = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _staticOob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('配置 Mesh Node', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Device ID：${widget.device.deviceId}'),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Node 名稱'),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('啟用 Provisioning Privacy'),
            subtitle: const Text('若 Node/韌體不支援，請關閉後重試'),
            value: _privacy,
            onChanged: (value) => setState(() => _privacy = value),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('使用 Static OOB'),
            subtitle: const Text('建議正式設備使用出廠 QR Code／標籤中的 Mesh OOB Secret'),
            value: _useStaticOob,
            onChanged: (value) => setState(() => _useStaticOob = value),
          ),
          if (_useStaticOob)
            TextField(
              controller: _staticOob,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                labelText: 'Static OOB（Hex）',
                hintText: '例如：00112233445566778899AABBCCDDEEFF',
              ),
            ),
          const Text('Address 將由 Provisioner 依 Element 數量自動配置，避免位址重疊。'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                final name = _name.text.trim();
                if (name.isEmpty) return;
                final oob = _staticOob.text
                    .replaceAll(RegExp(r'\s'), '')
                    .toUpperCase();
                if (_useStaticOob &&
                    !RegExp(r'^(?:[0-9A-F]{2}){1,16}$').hasMatch(oob)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Static OOB 必須是 1–16 bytes 的 Hex'),
                    ),
                  );
                  return;
                }
                Navigator.pop(context, (
                  name: name,
                  privacy: _privacy,
                  staticOob: _useStaticOob ? oob : null,
                ));
              },
              child: const Text('開始 Provisioning'),
            ),
          ),
        ],
      ),
    ),
  );
}

class _AppKeyDialog extends StatefulWidget {
  const _AppKeyDialog();
  @override
  State<_AppKeyDialog> createState() => _AppKeyDialogState();
}

class _AppKeyDialogState extends State<_AppKeyDialog> {
  final _index = TextEditingController(text: '0');
  final _key = TextEditingController(text: _secureMeshKey());
  String? _error;

  @override
  void dispose() {
    _index.dispose();
    _key.dispose();
    super.dispose();
  }

  void _submit() {
    final index = int.tryParse(_index.text);
    final key = _key.text.replaceAll(RegExp(r'\s'), '').toUpperCase();
    if (index == null ||
        index < 0 ||
        index > 4095 ||
        !RegExp(r'^[0-9A-F]{32}$').hasMatch(key)) {
      setState(() => _error = 'Index 必須為 0–4095；AppKey 必須是 32 位十六進位字元');
      return;
    }
    Navigator.pop(context, (index: index, key: key));
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('新增 AppKey'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _index,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'AppKey Index',
            hintText: '例如：0',
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _key,
          autocorrect: false,
          enableSuggestions: false,
          decoration: InputDecoration(
            labelText: '128-bit AppKey',
            hintText: '例如：00112233445566778899AABBCCDDEEFF',
            errorText: _error,
          ),
        ),
        const SizedBox(height: 8),
        const Text('AppKey 是 Access Layer 密鑰；請勿與 NetKey 共用，也不要放入日誌。'),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('取消'),
      ),
      FilledButton(onPressed: _submit, child: const Text('新增')),
    ],
  );
}

class _BindModelDialog extends StatefulWidget {
  const _BindModelDialog({
    required this.models,
    required this.appKeys,
    required this.unbind,
  });
  final List<({Element element, Model model})> models;
  final List<AppKey> appKeys;
  final bool unbind;

  @override
  State<_BindModelDialog> createState() => _BindModelDialogState();
}

class _BindModelDialogState extends State<_BindModelDialog> {
  late AppKey _appKey = widget.appKeys.first;
  late final Set<int> _selected = _initialSelection();

  Set<int> _initialSelection() => {
    for (var index = 0; index < widget.models.length; index++)
      if (!widget.unbind ||
          widget.models[index].model.boundAppKeyIndexes.contains(_appKey.index))
        index,
  };

  void _changeAppKey(AppKey key) {
    setState(() {
      _appKey = key;
      if (widget.unbind) {
        _selected
          ..clear()
          ..addAll(_initialSelection());
      }
    });
  }

  void _selectByRole({required bool client, required bool server}) {
    setState(() {
      _selected.clear();
      for (var index = 0; index < widget.models.length; index++) {
        final model = widget.models[index].model;
        if ((client && model.isClient) || (server && model.isServer)) {
          _selected.add(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      '${widget.unbind ? '解除' : ''}綁定 AppKey ${widget.unbind ? '與' : '至'} Model',
    ),
    content: SizedBox(
      width: double.maxFinite,
      height: MediaQuery.sizeOf(context).height * 0.62,
      child: Column(
        children: [
          DropdownButtonFormField<AppKey>(
            initialValue: _appKey,
            decoration: const InputDecoration(labelText: 'AppKey'),
            items: [
              for (final key in widget.appKeys)
                DropdownMenuItem(
                  value: key,
                  child: Text('AppKey Index ${key.index}'),
                ),
            ],
            onChanged: (value) {
              if (value != null) _changeAppKey(value);
            },
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: [
              ActionChip(
                label: const Text('全部'),
                onPressed: () => setState(() {
                  _selected
                    ..clear()
                    ..addAll(List.generate(widget.models.length, (i) => i));
                }),
              ),
              ActionChip(
                label: const Text('Client Models'),
                onPressed: () => _selectByRole(client: true, server: false),
              ),
              ActionChip(
                label: const Text('Server Models'),
                onPressed: () => _selectByRole(client: false, server: true),
              ),
              ActionChip(
                label: const Text('清除'),
                onPressed: () => setState(_selected.clear),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '已選 ${_selected.length}/${widget.models.length} 個 Model',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.models.length,
              itemBuilder: (context, index) {
                final item = widget.models[index];
                final roles = [
                  if (item.model.isClient) 'Client',
                  if (item.model.isServer) 'Server',
                ].join('/');
                final alreadyBound = item.model.boundAppKeyIndexes.contains(
                  _appKey.index,
                );
                return CheckboxListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: _selected.contains(index),
                  onChanged: (checked) => setState(() {
                    checked == true
                        ? _selected.add(index)
                        : _selected.remove(index);
                  }),
                  title: Text(
                    '${item.element.address} · ${item.model.modelName}',
                  ),
                  subtitle: Text(
                    '${item.model.modelId} · ${roles.isEmpty ? 'Model' : roles}'
                    '${alreadyBound ? ' · 已綁定' : ''}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('取消'),
      ),
      FilledButton(
        onPressed: _selected.isEmpty
            ? null
            : () => Navigator.pop(context, (
                targets: [
                  for (final index in _selected) widget.models[index],
                ],
                appKey: _appKey.index,
              )),
        child: Text('批次${widget.unbind ? '解除' : ''}綁定（${_selected.length}）'),
      ),
    ],
  );
}
