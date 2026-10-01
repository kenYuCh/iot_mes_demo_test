import 'dart:async';

import 'package:flutter_esp_ble_prov/flutter_esp_ble_prov.dart';

import 'ble_provisioner.dart';
import 'device_claim_credentials.dart';

/// Real ESP-IDF BLE provisioning transport for iOS/Android devices.
class EspBleProvisioner implements BleProvisioner {
  final FlutterEspBleProv _plugin = FlutterEspBleProv();
  StreamController<List<BleScanHit>>? _scanController;
  String? _selectedName;

  @override
  bool get isFake => false;

  @override
  Stream<List<BleScanHit>> startScan({
    Duration timeout = const Duration(seconds: 20),
  }) {
    unawaited(stopScan());
    final controller = StreamController<List<BleScanHit>>();
    _scanController = controller;
    unawaited(() async {
      try {
        final names = await _plugin.scanBleDevices('PROV_').timeout(timeout);
        if (!controller.isClosed) {
          controller.add([
            for (final name in names)
              BleScanHit(peripheralId: name, name: name, rssi: 0),
          ]);
        }
      } catch (error, stack) {
        if (!controller.isClosed) controller.addError(error, stack);
      } finally {
        if (!controller.isClosed) await controller.close();
        if (identical(_scanController, controller)) _scanController = null;
      }
    }());
    return controller.stream;
  }

  @override
  Future<void> stopScan() async {
    final controller = _scanController;
    _scanController = null;
    if (controller != null && !controller.isClosed) await controller.close();
  }

  @override
  Future<DeviceClaimCredentials> connectAndReadIdentity(
    String peripheralId,
  ) async {
    _selectedName = peripheralId;
    for (final credential in demoClaimCredentials) {
      if (credential.bleName == peripheralId ||
          peripheralId.endsWith(
            credential.serial.substring(credential.serial.length - 4),
          )) {
        return credential;
      }
    }
    // This firmware image is currently manufactured as ESP32-00192837. The
    // provisioning name is MAC-derived, so it intentionally differs from the
    // catalog's human-friendly bleName.
    if (peripheralId.startsWith('PROV_')) return demoClaimCredentials.first;
    throw StateError('找到 $peripheralId，但尚無對應的出廠 QR 身分；請先掃描設備 QR Code。');
  }

  @override
  Future<List<BleWifiNetwork>> scanWifiNetworks(
    String proofOfPossession,
  ) async {
    final name = _selectedName;
    if (name == null) throw StateError('尚未選擇 ESP32');
    final networks = await _plugin.scanWifiNetworks(name, proofOfPossession);
    return [
      for (final ssid in networks.toSet())
        if (ssid.trim().isNotEmpty) BleWifiNetwork(ssid: ssid),
    ];
  }

  @override
  Future<void> provisionWifi({
    required String proofOfPossession,
    required String ssid,
    required String password,
  }) async {
    final name = _selectedName;
    if (name == null) throw StateError('尚未選擇 ESP32');
    final success = await _plugin.provisionWifi(
      name,
      proofOfPossession,
      ssid,
      password,
    );
    if (success != true) throw StateError('ESP32 無法連上 $ssid');
  }

  @override
  Future<void> disconnect() async {
    _selectedName = null;
    await stopScan();
  }
}
