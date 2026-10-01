import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../device/device_profiles.dart';
import '../generated/protocol.dart';

/// 開發環境測試帳號（正式環境不會建立）。
const devUserEmail = 'dev@demo.local';
const devUserPassword = 'demo12345';

/// 開發環境示範資料：一間公司、兩個場域、三台 Gateway、八台設備與開發帳號。
/// 各區塊皆為冪等，可重複啟動。
Future<void> seedDemoData(Serverpod pod) async {
  final session = await pod.createSession(enableLogging: false);
  try {
    final company = await _seedIotData(session);
    await _seedDevUser(session, company);
    await _seedMultiChannelDevices(session, company);
    await _seedAlertRules(session, company);
    await _seedMapPositions(session);
    await _seedProductionStats(session, company);
    await _seedFactoryDevices(session);
    await _seedOtaData(session, company);
  } finally {
    await session.close();
  }
}

Future<Company> _seedIotData(Session session) async {
  final existing = await Company.db.findFirstRow(session);
  if (existing != null) return existing;

  final now = DateTime.now().toUtc();
  final company = await Company.db.insertRow(
    session,
    Company(name: 'Demo 智慧工廠股份有限公司', createdAt: now),
  );

  final siteA = await Site.db.insertRow(
    session,
    Site(
      companyId: company.id!,
      name: '台北一廠',
      description: '沖壓與組裝產線',
      createdAt: now,
    ),
  );
  final siteB = await Site.db.insertRow(
    session,
    Site(
      companyId: company.id!,
      name: '桃園二廠',
      description: '塗裝與倉儲',
      createdAt: now,
    ),
  );

  final gateways = await Gateway.db.insert(session, [
    Gateway(
      companyId: company.id!,
      siteId: siteA.id!,
      serialNumber: 'GW-TPE-001',
      name: '一廠 A 棟閘道器',
      connectionState: DeviceConnectionState.online,
      lastSeenAt: now,
      createdAt: now,
    ),
    Gateway(
      companyId: company.id!,
      siteId: siteA.id!,
      serialNumber: 'GW-TPE-002',
      name: '一廠 B 棟閘道器',
      connectionState: DeviceConnectionState.online,
      lastSeenAt: now,
      createdAt: now,
    ),
    Gateway(
      companyId: company.id!,
      siteId: siteB.id!,
      serialNumber: 'GW-TYN-001',
      name: '二廠塗裝區閘道器',
      connectionState: DeviceConnectionState.online,
      lastSeenAt: now,
      createdAt: now,
    ),
  ]);

  final deviceSpecs = <(int, int, String, String, String)>[
    (siteA.id!, gateways[0].id!, '沖壓機溫度計 T-01', 'TMP-100', 'temperature'),
    (siteA.id!, gateways[0].id!, '沖壓機溫度計 T-02', 'TMP-100', 'temperature'),
    (siteA.id!, gateways[0].id!, 'A 棟濕度計 H-01', 'HUM-200', 'humidity'),
    (siteA.id!, gateways[1].id!, 'B 棟電表 P-01', 'PWR-300', 'power'),
    (siteA.id!, gateways[1].id!, '組裝線震動感測 V-01', 'VIB-400', 'vibration'),
    (siteB.id!, gateways[2].id!, '塗裝房溫度計 T-11', 'TMP-100', 'temperature'),
    (siteB.id!, gateways[2].id!, '塗裝房濕度計 H-11', 'HUM-200', 'humidity'),
    (siteB.id!, gateways[2].id!, '倉儲電表 P-11', 'PWR-300', 'power'),
  ];

  final devices = await Device.db.insert(session, [
    for (final (siteId, gatewayId, name, model, type) in deviceSpecs)
      Device(
        companyId: company.id!,
        siteId: siteId,
        gatewayId: gatewayId,
        name: name,
        model: model,
        hardwareRevision: 'A1',
        firmwareVersion: '1.0.0',
        deviceType: type,
        expectedIntervalSeconds: 10,
        createdAt: now,
      ),
  ]);

  await DeviceStatus.db.insert(session, [
    for (final device in devices)
      DeviceStatus(
        companyId: company.id!,
        deviceId: device.id!,
        connectionState: DeviceConnectionState.unknown,
        latestValues: {},
        lastUpdatedAt: null,
      ),
  ]);

  session.log('已建立 Demo 資料：1 公司、2 場域、3 Gateway、8 設備');
  return company;
}

/// 多通道示範設備（2~6 量測通道＋2~3 控制參數）。
/// 獨立冪等區塊：既有資料庫升級後也會補建。
Future<void> _seedMultiChannelDevices(Session session, Company company) async {
  final existing = await Device.db.findFirstRow(
    session,
    where: (t) => t.deviceType.equals('motor_drive'),
  );
  if (existing != null) return;

  final gateways = await Gateway.db.find(
    session,
    where: (t) => t.companyId.equals(company.id!),
    orderBy: (t) => t.id,
  );
  if (gateways.isEmpty) return;

  final now = DateTime.now().toUtc();
  // (gateway, 名稱, 型號, 型別檔, 地圖座標)
  final specs = [
    (gateways.first, '組裝線馬達驅動器 M-01', 'MTR-D500', 'motor_drive', 0.30, 0.75),
    (gateways.first, 'A 棟環境監測站 E-01', 'ENV-M600', 'env_multi', 0.70, 0.20),
    (gateways.last, '塗裝房電力監測 PM-01', 'PWR-M700', 'power_meter', 0.55, 0.60),
    (gateways.first, '組裝線輸送帶 PLC-01', 'PLC-C900', 'conveyor_plc', 0.16, 0.48),
    (
      gateways.first,
      'A 棟空品排風 AQ-01',
      'AIR-C810',
      'air_quality_controller',
      0.82,
      0.48,
    ),
    (
      gateways.last,
      '塗料槽製程控制 TK-01',
      'TANK-C700',
      'tank_process_controller',
      0.24,
      0.30,
    ),
    (
      gateways.last,
      '冷藏庫控制器 CC-01',
      'COLD-C500',
      'cold_chain_controller',
      0.76,
      0.30,
    ),
    (
      gateways.first,
      '沖壓線液壓站 HY-01',
      'HYD-C400',
      'hydraulic_station',
      0.48,
      0.48,
    ),
  ];

  final devices = await Device.db.insert(session, [
    for (final (gateway, name, model, profileId, x, y) in specs)
      Device(
        companyId: company.id!,
        siteId: gateway.siteId,
        gatewayId: gateway.id!,
        name: name,
        model: model,
        hardwareRevision: 'A1',
        firmwareVersion: '1.2.0',
        deviceType: profileId,
        features: DeviceProfiles.byId(profileId)!.features,
        expectedIntervalSeconds: 10,
        mapX: x,
        mapY: y,
        createdAt: now,
      ),
  ]);
  await DeviceStatus.db.insert(session, [
    for (final device in devices)
      DeviceStatus(
        companyId: company.id!,
        deviceId: device.id!,
        connectionState: DeviceConnectionState.unknown,
        latestValues: {},
        lastUpdatedAt: null,
      ),
  ]);
  session.log('已建立 ${devices.length} 台多通道示範設備');
}

/// OTA 中心示範資料：已簽核套件與一筆完成的金絲雀發布。
Future<void> _seedOtaData(Session session, Company company) async {
  if (await FirmwarePackage.db.findFirstRow(session) != null) return;
  final motor = await Device.db.findFirstRow(
    session,
    where: (t) =>
        t.companyId.equals(company.id!) & t.deviceType.equals('motor_drive'),
  );
  if (motor == null) return;
  final now = DateTime.now().toUtc();
  final firmware = await FirmwarePackage.db.insertRow(
    session,
    FirmwarePackage(
      companyId: company.id!,
      name: '馬達驅動器穩定版',
      version: '1.3.0',
      targetDeviceType: 'motor_drive',
      hardwareRevision: 'A1',
      releaseNotes: '改善震動採樣穩定度，加入斷電續傳與安全回滾。',
      downloadUrl: 'https://firmware.example.com/motor-drive/1.3.0.bin',
      sha256:
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      sizeBytes: 4 * 1024 * 1024,
      state: FirmwarePackageState.ready,
      createdBy: 'demo-seed',
      createdAt: now.subtract(const Duration(days: 2)),
    ),
  );
  final campaign = await OtaCampaign.db.insertRow(
    session,
    OtaCampaign(
      companyId: company.id!,
      firmwarePackageId: firmware.id!,
      name: 'M-01 金絲雀更新',
      targetDeviceType: 'motor_drive',
      strategy: OtaStrategy.canary,
      state: OtaCampaignState.completed,
      totalDevices: 1,
      succeededDevices: 1,
      failedDevices: 0,
      createdBy: 'demo-seed',
      createdAt: now.subtract(const Duration(days: 1)),
      startedAt: now.subtract(const Duration(hours: 23)),
      completedAt: now.subtract(const Duration(hours: 22, minutes: 55)),
    ),
  );
  await OtaDeviceJob.db.insertRow(
    session,
    OtaDeviceJob(
      companyId: company.id!,
      campaignId: campaign.id!,
      deviceId: motor.id!,
      state: OtaJobState.succeeded,
      progress: 100,
      previousVersion: motor.firmwareVersion,
      updatedAt: campaign.completedAt!,
    ),
  );
  session.log('已建立 OTA 示範套件與金絲雀發布紀錄');
}

/// 建立示範告警規則：模擬數據會週期性跨越閾值，
/// 讓告警的觸發與自動恢復可以在 Simulator 上直接觀察。
Future<void> _seedAlertRules(Session session, Company company) async {
  final existing = await AlertRule.db.findFirstRow(session);
  if (existing != null) return;

  final devices = await Device.db.find(
    session,
    where: (t) => t.companyId.equals(company.id!),
  );
  final temperature = devices.where((d) => d.deviceType == 'temperature');
  final humidity = devices.where((d) => d.deviceType == 'humidity');
  final now = DateTime.now().toUtc();

  await AlertRule.db.insert(session, [
    for (final device in temperature)
      AlertRule(
        companyId: company.id!,
        deviceId: device.id!,
        featureKey: 'temperature',
        name: '${device.name} 高溫警報',
        comparison: AlertComparison.greaterThan,
        threshold: 28,
        severity: AlertSeverity.critical,
        enabled: true,
        createdAt: now,
      ),
    for (final device in humidity)
      AlertRule(
        companyId: company.id!,
        deviceId: device.id!,
        featureKey: 'humidity',
        name: '${device.name} 低濕度警報',
        comparison: AlertComparison.lessThan,
        threshold: 47,
        severity: AlertSeverity.warning,
        enabled: true,
        createdAt: now,
      ),
  ]);
  session.log('已建立示範告警規則（高溫 >28、低濕 <47）');
}

/// 為尚未擺放的設備分配 2D 廠房地圖座標（每場域 3 欄網格）。
Future<void> _seedMapPositions(Session session) async {
  final devices = await Device.db.find(session, orderBy: (t) => t.id);
  final unplaced = devices.where((d) => d.mapX == null).toList();
  if (unplaced.isEmpty) return;

  final indexBySite = <int, int>{};
  for (final device in unplaced) {
    final index = indexBySite[device.siteId] ?? 0;
    indexBySite[device.siteId] = index + 1;
    final col = index % 3;
    final row = index ~/ 3;
    await Device.db.updateRow(
      session,
      device.copyWith(mapX: 0.18 + col * 0.32, mapY: 0.2 + row * 0.28),
    );
  }
  session.log('已為 ${unplaced.length} 台設備分配地圖座標');
}

/// 回填近 8 小時產線統計，讓 OEE 卡片一啟動就有數據。
Future<void> _seedProductionStats(Session session, Company company) async {
  final existing = await ProductionStat.db.findFirstRow(session);
  if (existing != null) return;

  final sites = await Site.db.find(
    session,
    where: (t) => t.companyId.equals(company.id!),
  );
  final random = Random();
  final now = DateTime.now().toUtc();
  final currentHour = DateTime.utc(now.year, now.month, now.day, now.hour);

  final stats = <ProductionStat>[
    for (final site in sites)
      for (var i = 1; i <= 8; i++)
        () {
          final run = 60 * (0.85 + random.nextDouble() * 0.12);
          final ideal = (run * 60).round();
          final actual = (ideal * (0.90 + random.nextDouble() * 0.08)).round();
          final good = (actual * (0.965 + random.nextDouble() * 0.03)).round();
          return ProductionStat(
            companyId: company.id!,
            siteId: site.id!,
            windowStart: currentHour.subtract(Duration(hours: i)),
            plannedMinutes: 60,
            runMinutes: double.parse(run.toStringAsFixed(2)),
            idealCount: ideal,
            actualCount: actual,
            goodCount: good,
          );
        }(),
  ];
  await ProductionStat.db.insert(session, stats);
  session.log('已回填 ${stats.length} 筆產線統計（近 8 小時）');
}

/// 出廠設備登錄（產品真偽由 Factory Certificate 驗證）。
/// QR Code 內容見 docs/product/ESP32_Server_mTLS_Provisioning_完整設計手冊.md §3。
Future<void> _seedFactoryDevices(Session session) async {
  final existing = await ProvisionedDevice.db.findFirstRow(session);
  if (existing != null) return;

  // (serial, model) —— QR Code 只需要公開身分，不包含配對秘密。
  const factory = [
    ('ESP32-00192837', 'ESP32-MOTOR-01'),
    ('ESP32-00192838', 'GW-A01'),
    ('ESP32-00192839', 'SENSOR-T02'),
  ];
  final now = DateTime.now().toUtc();
  await ProvisionedDevice.db.insert(session, [
    for (final (serial, model) in factory)
      ProvisionedDevice(
        serial: serial,
        model: model,
        claimCodeHash: '',
        state: ProvisioningState.unclaimed,
        createdAt: now,
      ),
  ]);
  session.log('已登錄 ${factory.length} 台出廠設備（Device Registry）');
}

/// 建立開發用登入帳號並綁定到 Demo 公司，
/// 讓 App 可直接以 [devUserEmail] / [devUserPassword] 登入。
Future<void> _seedDevUser(Session session, Company company) async {
  final emailIdp = AuthServices.instance.emailIdp;
  final existing = await emailIdp.admin.findAccount(
    session,
    email: devUserEmail,
  );
  if (existing != null) return;

  final authUser = await AuthServices.instance.authUsers.create(session);
  await emailIdp.admin.createEmailAuthentication(
    session,
    authUserId: authUser.id,
    email: devUserEmail,
    password: devUserPassword,
  );
  await CompanyMembership.db.insertRow(
    session,
    CompanyMembership(
      companyId: company.id!,
      authUserId: authUser.id.toString(),
      role: CompanyRole.admin,
      createdAt: DateTime.now().toUtc(),
    ),
  );
  session.log('已建立開發帳號 $devUserEmail');
}
