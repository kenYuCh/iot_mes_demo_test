import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ble_provisioner.dart';
import 'fake_ble_provisioner.dart';
import 'esp_ble_provisioner.dart';

final bleProvisionerProvider = Provider<BleProvisioner>((ref) {
  const useFake = bool.fromEnvironment('USE_FAKE_BLE');
  final BleProvisioner provisioner = useFake
      ? FakeBleProvisioner()
      : EspBleProvisioner();
  ref.onDispose(() {
    provisioner.stopScan();
    provisioner.disconnect();
  });
  return provisioner;
});
