import 'dart:io';

import 'package:pod_app_v1_client/pod_app_v1_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

class _MemoryStorage implements ClientAuthSuccessStorage {
  AuthSuccess? value;

  @override
  Future<AuthSuccess?> get() async => value;

  @override
  Future<void> set(AuthSuccess? data) async => value = data;
}

Future<void> main(List<String> args) async {
  final client = Client('http://localhost:8080/');
  final auth = ClientAuthSessionManager(storage: _MemoryStorage());
  client.authSessionManager = auth;

  final login = await client.emailIdp.login(
    email: 'dev@demo.local',
    password: 'demo12345',
  );
  await auth.updateSignedInUser(login);

  final existing = await client.ota.listFirmwarePackages();
  Future<FirmwarePackage> ensureRelease({
    required String version,
    required String fileName,
    required String notes,
  }) async {
    for (final item in existing) {
      if (item.version == version &&
          item.targetDeviceType == 'esp32_motor_contoller') {
        return item;
      }
    }
    final release = await client.ota.importFirmwareRelease(
      'ESP32 馬達控制器 $version',
      version,
      'esp32_motor_contoller',
      'esp32_motor_contoller',
      'esp32',
      'esp_https_ota',
      null,
      notes,
      [fileName],
      fileName,
    );
    return release.release;
  }

  final stable = await ensureRelease(
    version: '1.1.2',
    fileName: 'esp32_motor_1.1.2.bin',
    notes: '實機 OTA 穩定版；連線及健康檢查成功後確認映像。',
  );
  final rollback = await ensureRelease(
    version: '1.2.2',
    fileName: 'esp32_motor_1.2.2_rollback_test.bin',
    notes: '回滾驗證版；啟動後刻意讓健康檢查失敗，應自動回到 1.1.0。',
  );

  stdout.writeln('Stable package: ${stable.id} / ${stable.version}');
  stdout.writeln('Rollback package: ${rollback.id} / ${rollback.version}');

  if (args.contains('--start-stable')) {
    final campaign = await client.ota.createTargetCampaign(
      stable.id!,
      'ESP32-00192837 升級至 1.1.2',
      OtaStrategy.immediate,
      ['device:1'],
      null,
    );
    await client.ota.startCampaign(campaign.id!);
    stdout.writeln('Started stable campaign ${campaign.id}.');
  }

  if (args.contains('--start-rollback-test')) {
    final campaign = await client.ota.createTargetCampaign(
      rollback.id!,
      'ESP32-00192837 1.2.2 回滾測試',
      OtaStrategy.immediate,
      ['device:1'],
      null,
    );
    await client.ota.startCampaign(campaign.id!);
    stdout.writeln('Started rollback campaign ${campaign.id}.');
  }

  client.close();
}
