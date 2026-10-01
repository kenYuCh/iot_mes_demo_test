/// 配對所需的公開設備身分與 BLE 傳輸層 PoP。
class DeviceClaimCredentials {
  const DeviceClaimCredentials({
    required this.serial,
    required this.provisioningProof,
    this.model,
    this.bleName,
  });

  final String serial;

  /// 僅供 ESP-IDF BLE Security session 使用，不送 Server、不作產品認領碼。
  final String provisioningProof;
  final String? model;
  final String? bleName;

  bool get isComplete => serial.trim().isNotEmpty;
}

/// 開發用示範身分（對應 server demo_seed 出廠登錄）。
const demoClaimCredentials = <DeviceClaimCredentials>[
  DeviceClaimCredentials(
    serial: 'ESP32-00192837',
    provisioningProof: '7JPD-K8NQ-QZ51-39XT',
    model: 'ESP32-MOTOR-01',
    bleName: 'ESP32_GW_2837',
  ),
  DeviceClaimCredentials(
    serial: 'ESP32-00192838',
    provisioningProof: 'M2XA-77RB-PL04-CQ8V',
    model: 'GW-A01',
    bleName: 'ESP32_GW_2838',
  ),
  DeviceClaimCredentials(
    serial: 'ESP32-00192839',
    provisioningProof: 'KK1C-BN95-2FWD-YH36',
    model: 'SENSOR-T02',
    bleName: 'ESP32_SENSOR_2839',
  ),
];
