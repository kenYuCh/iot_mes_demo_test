import 'device_claim_credentials.dart';

/// BLE 掃描到的周邊（UI 列表用）。
class BleScanHit {
  const BleScanHit({
    required this.peripheralId,
    required this.name,
    required this.rssi,
  });

  final String peripheralId;
  final String name;
  final int rssi;
}

class BleWifiNetwork {
  const BleWifiNetwork({required this.ssid});

  final String ssid;
}

/// 近距離配對：掃描 → 連線 → 讀取公開設備身分。
///
/// 實機階段以 `flutter_blue_plus` 實作；Simulator 使用 FakeBleProvisioner。
abstract class BleProvisioner {
  /// 是否為模擬實作（UI 顯示提示）。
  bool get isFake;

  /// 開始掃描，回傳去重後的發現串流。呼叫端負責 [stopScan]。
  Stream<List<BleScanHit>> startScan({
    Duration timeout = const Duration(seconds: 20),
  });

  Future<void> stopScan();

  /// 連線並讀取出廠身分（serial、model 與 BLE transport PoP）。
  Future<DeviceClaimCredentials> connectAndReadIdentity(String peripheralId);

  /// Ask the selected ESP32 to scan networks using its own Wi-Fi radio.
  Future<List<BleWifiNetwork>> scanWifiNetworks(String proofOfPossession);

  /// Send credentials through the encrypted ESP-IDF Security 1 session.
  Future<void> provisionWifi({
    required String proofOfPossession,
    required String ssid,
    required String password,
  });

  Future<void> disconnect();
}
