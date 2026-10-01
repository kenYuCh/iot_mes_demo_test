import 'dart:async';

import 'ble_provisioner.dart';
import 'device_claim_credentials.dart';

/// Simulator／無藍牙環境用的假 BLE：掃描示範設備，連線後回傳出廠身分。
class FakeBleProvisioner implements BleProvisioner {
  StreamController<List<BleScanHit>>? _controller;
  Timer? _timer;
  final _hits = <String, BleScanHit>{};
  String? _selectedId;

  static final _catalog =
      <({String id, DeviceClaimCredentials cred, int rssi})>[
        (id: 'fake-ble-2837', cred: demoClaimCredentials[0], rssi: -48),
        (id: 'fake-ble-2838', cred: demoClaimCredentials[1], rssi: -62),
        (id: 'fake-ble-2839', cred: demoClaimCredentials[2], rssi: -71),
      ];

  @override
  bool get isFake => true;

  @override
  Stream<List<BleScanHit>> startScan({
    Duration timeout = const Duration(seconds: 20),
  }) {
    stopScan();
    _hits.clear();
    final controller = StreamController<List<BleScanHit>>();
    _controller = controller;

    var index = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (index >= _catalog.length) {
        timer.cancel();
        return;
      }
      final item = _catalog[index++];
      _hits[item.id] = BleScanHit(
        peripheralId: item.id,
        name: item.cred.bleName ?? item.cred.serial,
        rssi: item.rssi,
      );
      if (!controller.isClosed) {
        controller.add(_hits.values.toList(growable: false));
      }
    });

    Future<void>.delayed(timeout, () {
      if (identical(_controller, controller)) {
        stopScan();
      }
    });

    return controller.stream;
  }

  @override
  Future<void> stopScan() async {
    _timer?.cancel();
    _timer = null;
    await _controller?.close();
    _controller = null;
  }

  @override
  Future<DeviceClaimCredentials> connectAndReadIdentity(
    String peripheralId,
  ) async {
    await stopScan();
    await Future<void>.delayed(const Duration(milliseconds: 900));
    for (final item in _catalog) {
      if (item.id == peripheralId) {
        _selectedId = peripheralId;
        return item.cred;
      }
    }
    throw StateError('未知的 BLE 周邊：$peripheralId');
  }

  @override
  Future<List<BleWifiNetwork>> scanWifiNetworks(
    String proofOfPossession,
  ) async {
    if (_selectedId == null) throw StateError('尚未連線 ESP32');
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return const [
      BleWifiNetwork(ssid: 'Factory-IoT'),
      BleWifiNetwork(ssid: 'Office-WiFi'),
    ];
  }

  @override
  Future<void> provisionWifi({
    required String proofOfPossession,
    required String ssid,
    required String password,
  }) async {
    if (_selectedId == null) throw StateError('尚未連線 ESP32');
    await Future<void>.delayed(const Duration(seconds: 1));
    if (password == 'wrong') throw StateError('Wi-Fi 密碼錯誤');
  }

  @override
  Future<void> disconnect() async => _selectedId = null;
}
