import 'dart:io';

import '../provisioning/ca_service.dart';

/// 開發專用：配對成功後把「設備端」憑證落地，供本機 Esp32MqttSimulator 使用。
///
/// 正式 ESP32 私鑰永留晶片，不會經過 Server。
/// 此目錄僅模擬「設備已拿到證」，讓開發環境能驗證 MQTTS 上行鏈。
class DeviceLocalMqttStore {
  DeviceLocalMqttStore._();

  static const root = 'certs/mqtt/devices';

  static String dirFor(String serial) => '$root/$serial';

  static String keyPath(String serial) => '${dirFor(serial)}/client.key';

  static String certPath(String serial) => '${dirFor(serial)}/client.crt';

  static String chainPath(String serial) =>
      '${dirFor(serial)}/client-chain.crt';

  static String physicalMarkerPath(String serial) =>
      '${dirFor(serial)}/.physical-device';

  static bool hasIdentity(String serial) =>
      File(keyPath(serial)).existsSync() &&
      File(chainPath(serial)).existsSync();

  /// Physical devices may keep development build credentials in this folder,
  /// but must never be started by [Esp32MqttSimulator] with the same client ID.
  static bool isPhysicalDevice(String serial) =>
      File(physicalMarkerPath(serial)).existsSync();

  /// 列出目前本機有設備身分的序號（已配對寫入）。
  static List<String> listSerials() {
    final rootDir = Directory(root);
    if (!rootDir.existsSync()) return const [];
    return [
          for (final entity in rootDir.listSync())
            if (entity is Directory)
              entity.path.split(Platform.pathSeparator).last,
        ]
        .where(
          (s) => s.isNotEmpty && hasIdentity(s) && !isPhysicalDevice(s),
        )
        .toList();
  }

  static void save({
    required String serial,
    required String keyPem,
    required String certificatePem,
  }) {
    final dir = Directory(dirFor(serial))..createSync(recursive: true);
    File('${dir.path}/client.key').writeAsStringSync(keyPem);
    File('${dir.path}/client.crt').writeAsStringSync(certificatePem);
    File('${dir.path}/client-chain.crt').writeAsStringSync(
      '$certificatePem\n${CaService.readIntermediateCa()}',
    );
    File('${dir.path}/client.key').setLastModifiedSync(DateTime.now());
    // 私鑰僅本機可讀
    Process.runSync('chmod', ['600', keyPath(serial)]);
  }

  static void clear(String serial) {
    final dir = Directory(dirFor(serial));
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
  }
}
