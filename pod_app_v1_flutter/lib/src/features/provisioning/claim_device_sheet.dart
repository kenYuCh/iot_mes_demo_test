import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../data/ble/ble_providers.dart';
import '../../data/ble/ble_provisioner.dart';
import 'claim_qr_payload.dart';
import 'provisioning_providers.dart';

enum ClaimEntryMode { qr, ble, manual }

enum _Phase { collect, claiming, provisioning, done, error }

enum _BleUiStep {
  idle,
  scanning,
  connecting,
  scanningWifi,
  ready,
  provisioningWifi,
}

/// 配對新設備：公開序號定位設備，產品真偽由 Server 驗證 Factory Certificate。
class ClaimDeviceSheet extends ConsumerStatefulWidget {
  const ClaimDeviceSheet({super.key, this.presetSerial});

  /// 從列表點「配對」時帶入的序號；仍需透過 BLE 接近性驗證與配網。
  final String? presetSerial;

  @override
  ConsumerState<ClaimDeviceSheet> createState() => _ClaimDeviceSheetState();
}

class _ClaimDeviceSheetState extends ConsumerState<ClaimDeviceSheet> {
  late ClaimEntryMode _mode = widget.presetSerial != null
      ? ClaimEntryMode.ble
      : ClaimEntryMode.qr;

  late final _serialController = TextEditingController(
    text: widget.presetSerial ?? '',
  );

  _Phase _phase = _Phase.collect;
  String? _error;
  ClaimSessionResult? _session;
  CertificateIssueResult? _issued;

  // QR
  final _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );
  bool _qrHandled = false;
  bool _cameraFailed = false;

  // BLE
  late final BleProvisioner _ble = ref.read(bleProvisionerProvider);
  _BleUiStep _bleStep = _BleUiStep.idle;
  List<BleScanHit> _bleHits = const [];
  bool _bleScanFinishedEmpty = false;
  StreamSubscription<List<BleScanHit>>? _bleSub;
  String? _connectingId;
  DeviceClaimCredentials? _bleCredentials;
  List<BleWifiNetwork> _wifiNetworks = const [];
  String? _selectedSsid;
  final _wifiPasswordController = TextEditingController();
  bool _wifiProvisioned = false;

  @override
  void dispose() {
    _bleSub?.cancel();
    unawaited(_ble.stopScan());
    _scannerController.dispose();
    _serialController.dispose();
    _wifiPasswordController.dispose();
    super.dispose();
  }

  void _applyCredentials(DeviceClaimCredentials cred) {
    _serialController.text = cred.serial;
  }

  Future<void> _startClaim() async {
    final serial = _serialController.text.trim();
    if (serial.isEmpty) {
      setState(() => _error = '請先取得設備序號');
      return;
    }
    if (_mode == ClaimEntryMode.ble && !_wifiProvisioned) {
      setState(() => _error = '請先將 Wi-Fi 安全傳送給 ESP32');
      return;
    }

    final client = ref.read(clientProvider);
    setState(() {
      _phase = _Phase.claiming;
      _error = null;
    });
    try {
      final session = await client.provisioning.beginManufacturerPairing(
        serial,
      );
      setState(() {
        _session = session;
        _phase = _Phase.provisioning;
      });

      final issued = await client.provisioning.simulateDeviceProvision(
        session.claimSessionId,
      );
      ref.invalidate(provisionedDevicesProvider);
      ref.invalidate(unlinkedDevicesProvider);
      setState(() {
        _issued = issued;
        _phase = _Phase.done;
      });
    } catch (e) {
      setState(() {
        _error = e is ValidationException
            ? e.message
            : e is NotFoundException
            ? e.message
            : '$e';
        _phase = _Phase.error;
      });
    }
  }

  Future<void> _startBleScan() async {
    await _bleSub?.cancel();
    setState(() {
      _bleStep = _BleUiStep.scanning;
      _bleHits = const [];
      _bleScanFinishedEmpty = false;
      _bleCredentials = null;
      _wifiNetworks = const [];
      _wifiProvisioned = false;
      _error = null;
    });
    final stream = _ble.startScan(timeout: const Duration(seconds: 20));
    _bleSub = stream.listen(
      (hits) {
        if (!mounted) return;
        setState(() {
          _bleHits = hits;
          if (hits.isNotEmpty) _bleScanFinishedEmpty = false;
        });
      },
      onDone: () {
        if (!mounted) return;
        if (_bleStep == _BleUiStep.scanning) {
          setState(() {
            _bleStep = _BleUiStep.idle;
            _bleScanFinishedEmpty = _bleHits.isEmpty;
          });
        }
      },
      onError: (Object e) {
        if (!mounted) return;
        setState(() {
          _bleStep = _BleUiStep.idle;
          if (e is TimeoutException) {
            _bleScanFinishedEmpty = _bleHits.isEmpty;
            _error = null;
          } else {
            _error = '無法掃描 BLE 設備，請確認藍牙與定位權限後重試';
          }
        });
      },
    );
  }

  Future<void> _stopBleScan() async {
    await _bleSub?.cancel();
    _bleSub = null;
    await _ble.stopScan();
    if (mounted && _bleStep == _BleUiStep.scanning) {
      setState(() {
        _bleStep = _BleUiStep.idle;
        _bleScanFinishedEmpty = false;
      });
    }
  }

  Future<void> _connectBle(BleScanHit hit) async {
    setState(() {
      _bleStep = _BleUiStep.connecting;
      _connectingId = hit.peripheralId;
      _error = null;
    });
    try {
      final cred = await _ble.connectAndReadIdentity(hit.peripheralId);
      if (!mounted) return;
      _applyCredentials(cred);
      setState(() {
        _bleCredentials = cred;
        _bleStep = _BleUiStep.scanningWifi;
        _connectingId = null;
      });
      final networks = await _ble.scanWifiNetworks(cred.provisioningProof);
      if (!mounted) return;
      setState(() {
        _wifiNetworks = networks;
        _selectedSsid = networks.isEmpty ? null : networks.first.ssid;
        _bleStep = _BleUiStep.ready;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
        _bleStep = _BleUiStep.idle;
        _connectingId = null;
      });
    }
  }

  Future<void> _provisionBleWifi() async {
    final cred = _bleCredentials;
    final ssid = _selectedSsid?.trim();
    if (cred == null || ssid == null || ssid.isEmpty) {
      setState(() => _error = '請選擇 Wi-Fi');
      return;
    }
    setState(() {
      _bleStep = _BleUiStep.provisioningWifi;
      _error = null;
    });
    try {
      await _ble.provisionWifi(
        proofOfPossession: cred.provisioningProof,
        ssid: ssid,
        password: _wifiPasswordController.text,
      );
      if (!mounted) return;
      setState(() {
        _wifiProvisioned = true;
        _bleStep = _BleUiStep.ready;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = 'Wi-Fi 連線失敗，請確認密碼後重新送出。ESP32 會保持 BLE 配對模式。';
        _wifiProvisioned = false;
        _bleStep = _BleUiStep.ready;
      });
      return;
    }

    // Wi-Fi 配網與平台認領是連續但相互獨立的步驟。此處若 Server 認領
    // 失敗，不可把已成功的 Wi-Fi 狀態改回失敗，否則 BLE transport 已
    // 正常結束後，使用者反而無法直接重試 Server 認領。
    await _startClaim();
  }

  void _onQrDetect(BarcodeCapture capture) {
    if (_qrHandled || _phase != _Phase.collect) return;
    for (final barcode in capture.barcodes) {
      final raw = barcode.rawValue;
      if (raw == null) continue;
      final cred = parseClaimQrPayload(raw);
      if (cred == null) continue;
      _qrHandled = true;
      _applyCredentials(cred);
      setState(() => _error = null);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已掃到 ${cred.serial}')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: switch (_phase) {
          _Phase.collect || _Phase.error => _buildCollect(context),
          _Phase.claiming || _Phase.provisioning => _buildProgress(context),
          _Phase.done => _buildDone(context),
        },
      ),
    );
  }

  Widget _buildCollect(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('配對新設備', style: theme.textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(
          'Server 將驗證公司 Factory Certificate；不需要輸入 Claim Code。',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        SegmentedButton<ClaimEntryMode>(
          segments: const [
            ButtonSegment(
              value: ClaimEntryMode.qr,
              icon: Icon(Icons.qr_code_scanner),
              label: Text('QR'),
            ),
            ButtonSegment(
              value: ClaimEntryMode.ble,
              icon: Icon(Icons.bluetooth_searching),
              label: Text('BLE'),
            ),
            ButtonSegment(
              value: ClaimEntryMode.manual,
              icon: Icon(Icons.keyboard_alt_outlined),
              label: Text('手動'),
            ),
          ],
          selected: {_mode},
          onSelectionChanged: (next) async {
            final mode = next.first;
            if (mode != ClaimEntryMode.ble) await _stopBleScan();
            setState(() {
              _mode = mode;
              _error = null;
              _qrHandled = false;
              if (mode == ClaimEntryMode.ble) {
                _bleStep = _BleUiStep.idle;
                _bleCredentials = null;
              }
            });
          },
        ),
        const SizedBox(height: 12),
        Expanded(
          child: switch (_mode) {
            ClaimEntryMode.qr => _buildQrPane(context),
            ClaimEntryMode.ble => _buildBlePane(context),
            ClaimEntryMode.manual => _buildManualPane(context),
          },
        ),
        if (_error != null) ...[
          const SizedBox(height: 8),
          Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
        ],
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _startClaim,
            icon: const Icon(Icons.link),
            label: Text(
              _mode == ClaimEntryMode.ble && !_wifiProvisioned
                  ? '先完成 Wi-Fi 配網'
                  : '驗證並加入公司',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQrPane(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        Text('Step 1 · 掃描出廠 QR Code', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: _cameraFailed
                ? ColoredBox(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          '相機不可用（常見於 Simulator）。'
                          '請用下方示範資料，或改 BLE／手動。',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  )
                : MobileScanner(
                    controller: _scannerController,
                    onDetect: _onQrDetect,
                    errorBuilder: (context, error) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted && !_cameraFailed) {
                          setState(() => _cameraFailed = true);
                        }
                      });
                      return Center(child: Text('相機錯誤：$error'));
                    },
                  ),
          ),
        ),
        const SizedBox(height: 12),
        Text('示範 QR（Simulator）', style: theme.textTheme.labelLarge),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final cred in demoClaimCredentials)
              ActionChip(
                label: Text(cred.serial),
                onPressed: () {
                  _applyCredentials(cred);
                  setState(() {
                    _qrHandled = true;
                    _error = null;
                  });
                },
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text('Step 2 · 確認身分', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        _credentialsFields(readOnly: _qrHandled && !_cameraFailed),
      ],
    );
  }

  Widget _buildBlePane(BuildContext context) {
    final theme = Theme.of(context);
    final ble = ref.watch(bleProvisionerProvider);
    final scanning = _bleStep == _BleUiStep.scanning;
    final connecting = _bleStep == _BleUiStep.connecting;
    final scanningWifi = _bleStep == _BleUiStep.scanningWifi;
    final provisioningWifi = _bleStep == _BleUiStep.provisioningWifi;

    return ListView(
      children: [
        if (ble.isFake)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '目前為模擬藍牙（僅供 Simulator 開發）。',
              style: theme.textTheme.bodySmall,
            ),
          ),
        Text('Step 1 · 開啟藍牙掃描', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: FilledButton.tonalIcon(
                onPressed: connecting
                    ? null
                    : scanning
                    ? _stopBleScan
                    : _startBleScan,
                icon: Icon(scanning ? Icons.stop : Icons.bluetooth_searching),
                label: Text(scanning ? '停止掃描' : '開始掃描'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (scanning && _bleHits.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (!scanning && _bleScanFinishedEmpty)
          Card(
            child: ListTile(
              leading: const Icon(Icons.bluetooth_disabled_outlined),
              title: const Text('沒有找到任何設備'),
              subtitle: const Text('請確認設備已開機並進入 BLE 配對模式，再重新掃描。'),
              trailing: TextButton(
                onPressed: _startBleScan,
                child: const Text('重新掃描'),
              ),
            ),
          ),
        for (final hit in _bleHits)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.memory),
            title: Text(hit.name),
            subtitle: Text('RSSI ${hit.rssi} dBm'),
            trailing: connecting && _connectingId == hit.peripheralId
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : TextButton(
                    onPressed: connecting ? null : () => _connectBle(hit),
                    child: const Text('連線'),
                  ),
          ),
        const SizedBox(height: 12),
        Text(
          'Step 2 · 讀取設備身分並驗證製造商',
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        if (_bleCredentials != null)
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text(_bleCredentials!.serial),
              subtitle: Text(
                [
                  if (_bleCredentials!.model != null)
                    '型號 ${_bleCredentials!.model}',
                  '等待公司 CA 驗證',
                ].join(' · '),
              ),
            ),
          )
        else
          Text(
            connecting ? '連線並讀取特徵中…' : '請選擇上方設備連線。',
            style: theme.textTheme.bodySmall,
          ),
        const SizedBox(height: 12),
        _credentialsFields(readOnly: _bleCredentials != null),
        if (_bleCredentials != null) ...[
          const SizedBox(height: 20),
          Text(
            'Step 3 · 將 Wi-Fi 安全傳給 ESP32',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          if (scanningWifi)
            const Center(child: CircularProgressIndicator())
          else ...[
            DropdownButtonFormField<String>(
              initialValue:
                  _wifiNetworks.any((item) => item.ssid == _selectedSsid)
                  ? _selectedSsid
                  : null,
              decoration: const InputDecoration(
                labelText: 'ESP32 掃描到的 Wi-Fi',
                prefixIcon: Icon(Icons.wifi),
              ),
              items: [
                for (final network in _wifiNetworks)
                  DropdownMenuItem(
                    value: network.ssid,
                    child: Text(network.ssid),
                  ),
              ],
              onChanged: provisioningWifi
                  ? null
                  : (value) => setState(() => _selectedSsid = value),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _wifiPasswordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Wi-Fi 密碼',
                prefixIcon: Icon(Icons.password),
                helperText: '只透過 BLE 加密 session 傳給 ESP32，不上傳 Server',
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: provisioningWifi || _wifiProvisioned
                    ? null
                    : _provisionBleWifi,
                icon: Icon(
                  _wifiProvisioned ? Icons.check_circle : Icons.wifi_tethering,
                ),
                label: Text(
                  _wifiProvisioned
                      ? 'ESP32 已連上 Wi-Fi'
                      : provisioningWifi
                      ? '連線中…'
                      : '傳送並連線 Wi-Fi',
                ),
              ),
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildManualPane(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        Text(
          '輸入設備公開序號；只有持有公司 Factory Certificate 的設備能完成配對。',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        _credentialsFields(readOnly: false),
        if (kDebugMode) ...[
          const SizedBox(height: 12),
          Text('快速填入示範', style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final cred in demoClaimCredentials)
                ActionChip(
                  label: Text(cred.serial.split('-').last),
                  onPressed: () {
                    _applyCredentials(cred);
                    setState(() => _error = null);
                  },
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _credentialsFields({required bool readOnly}) {
    return Column(
      children: [
        TextField(
          controller: _serialController,
          readOnly: readOnly,
          decoration: const InputDecoration(
            labelText: '設備序號（Device ID）',
            hintText: 'ESP32-00192839',
            prefixIcon: Icon(Icons.qr_code_2),
          ),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        const Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: Icon(Icons.verified_user_outlined),
            title: Text('製造商身分驗證'),
            subtitle: Text('由 Server 驗證 Factory CA、憑證 CN 與設備序號'),
          ),
        ),
      ],
    );
  }

  Widget _buildProgress(BuildContext context) {
    Widget step(String label, bool active, bool done) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          if (done)
            const Icon(Icons.check_circle, color: Colors.green, size: 20)
          else if (active)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            const Icon(Icons.circle_outlined, color: Colors.grey, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(label)),
        ],
      ),
    );

    final claiming = _phase == _Phase.claiming;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('配對中…', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        step('驗證公司 Factory Certificate', claiming, !claiming),
        step('確認序號、憑證 CN 與出廠指紋', !claiming, false),
        step('設備產生 CSR，內部 CA 簽發憑證', false, false),
      ],
    );
  }

  Widget _buildDone(BuildContext context) {
    final issued = _issued!;
    final mono = Theme.of(context).textTheme.bodySmall?.copyWith(
      fontFamily: 'Menlo',
    );
    return ListView(
      children: [
        Row(
          children: [
            const Icon(Icons.verified, color: Colors.green),
            const SizedBox(width: 8),
            Text('配對完成', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 12),
        const Text('公司 Factory CA 驗證通過，設備已啟用並簽發正式 MQTT 憑證：'),
        const SizedBox(height: 8),
        Text('CN / Client ID：${issued.mqttClientId}', style: mono),
        Text(
          'MQTT：${issued.mqttHost}:${issued.mqttPort}（mTLS）',
          style: mono,
        ),
        Text(
          '效期至：${issued.expiresAt.toLocal().toString().split('.').first}'
          '（v${issued.certificateVersion}）',
          style: mono,
        ),
        const SizedBox(height: 12),
        Text(
          '下一步：把設備加入設備庫（掛到場域/閘道器），'
          '平台才會開始顯示它的量測數據。',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(_session?.serial),
                child: const Text('稍後再說'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () =>
                    Navigator.of(context).pop('attach:${_session?.serial}'),
                icon: const Icon(Icons.playlist_add),
                label: const Text('加入設備庫'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
