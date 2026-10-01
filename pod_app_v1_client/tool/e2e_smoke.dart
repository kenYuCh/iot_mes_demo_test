// 開發用煙霧測試：對本機執行中的 Server 驗證垂直切片整條資料鏈。
// 執行：dart run tool/e2e_smoke.dart（於 pod_app_v1_client）
//
// 驗證項目：登入 → 場域列表 → Gateway/Device 列表 → 狀態 snapshot
// → Serverpod Streaming 即時更新 → 歷史量測分頁。
import 'dart:async';
import 'dart:io';

import 'package:pod_app_v1_client/pod_app_v1_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

class _MemoryStorage implements ClientAuthSuccessStorage {
  AuthSuccess? _data;

  @override
  Future<void> set(AuthSuccess? data) async => _data = data;

  @override
  Future<AuthSuccess?> get() async => _data;
}

Future<void> main() async {
  final client = Client('http://localhost:8080/');
  final sessionManager = ClientAuthSessionManager(storage: _MemoryStorage());
  client.authSessionManager = sessionManager;

  var failures = 0;
  void check(String name, bool condition, [String? detail]) {
    stdout.writeln(
      '${condition ? 'PASS' : 'FAIL'}  $name${detail == null ? '' : '  ($detail)'}',
    );
    if (!condition) failures++;
  }

  try {
    // 未登入時應被拒絕
    var unauthorized = false;
    try {
      await client.site.listSites();
    } catch (_) {
      unauthorized = true;
    }
    check('未登入呼叫被拒絕', unauthorized);

    final authSuccess = await client.emailIdp.login(
      email: 'dev@demo.local',
      password: 'demo12345',
    );
    await sessionManager.updateSignedInUser(authSuccess);
    check('登入成功', true);

    final sites = await client.site.listSites();
    check('場域列表', sites.length == 2, '取得 ${sites.length} 筆');

    final siteId = sites.first.id!;
    final gateways = await client.gateway.listBySite(siteId);
    check('Gateway 列表', gateways.length == 2, '取得 ${gateways.length} 筆');

    final devices = await client.device.listBySite(siteId);
    check('設備列表', devices.length == 7, '取得 ${devices.length} 筆');

    final statuses = await client.telemetry.listSiteStatuses(siteId);
    check('狀態 snapshot', statuses.length == 7, '取得 ${statuses.length} 筆');

    final updates = await client.telemetry
        .watchSiteStatus(siteId)
        .take(3)
        .toList()
        .timeout(const Duration(seconds: 15));
    check(
      'Streaming 即時更新',
      updates.length == 3 && updates.every((u) => u.latestValues.isNotEmpty),
      '10 秒內收到 ${updates.length} 筆',
    );

    final deviceId = devices.first.id!;
    final page1 = await client.telemetry.listMeasurements(deviceId, limit: 20);
    check('歷史量測第一頁', page1.items.length == 20 && page1.nextCursorId != null);

    final page2 = await client.telemetry.listMeasurements(
      deviceId,
      limit: 20,
      cursorId: page1.nextCursorId,
    );
    check(
      '歷史量測 cursor 分頁',
      page2.items.isNotEmpty &&
          page2.items.every((m) => m.id! < page1.nextCursorId!),
    );

    final crossTenantBlocked = await client.telemetry
        .listMeasurements(999999, limit: 10)
        .then((_) => false)
        .catchError((_) => true);
    check('不存在設備被拒絕', crossTenantBlocked);

    // ---- 多通道設備（2~6 量測＋2~3 控制參數）----
    final profiles = await client.device.listProfiles();
    check('設備型別檔目錄', profiles.length >= 7, '取得 ${profiles.length} 種');

    final motorProfile = profiles.firstWhere((p) => p.id == 'motor_drive');
    final motorMeas = motorProfile.features
        .where((f) => f.kind == FeatureKind.measurement)
        .length;
    final motorCtrl = motorProfile.features
        .where((f) => f.kind == FeatureKind.control)
        .length;
    check('馬達驅動器 6 量測＋3 控制', motorMeas == 6 && motorCtrl == 3);

    final motor = devices.firstWhere((d) => d.deviceType == 'motor_drive');
    check('多通道設備特徵已載入', (motor.features?.length ?? 0) == 9);

    // 等一個模擬器 tick（2 秒），讓所有通道與控制參數都有值。
    await Future<void>.delayed(const Duration(seconds: 3));
    final motorStatus = (await client.telemetry.listSiteStatuses(
      siteId,
    )).firstWhere((s) => s.deviceId == motor.id);
    check(
      '多通道即時值（量測＋控制參數回報）',
      motorStatus.latestValues.length >= 9,
      '${motorStatus.latestValues.length} 個通道',
    );

    final rpmHistory = await client.telemetry.listMeasurements(
      motor.id!,
      featureKey: 'rpm',
      limit: 10,
    );
    check(
      '逐通道歷史查詢（rpm）',
      rpmHistory.items.isNotEmpty &&
          rpmHistory.items.every((m) => m.featureKey == 'rpm'),
    );

    final ts = DateTime.now().microsecondsSinceEpoch;
    final outOfRange = await client.command
        .sendCommand(motor.id!, 'setParam', {
          'featureKey': 'targetRpm',
          'value': '99999',
        }, 'sp-bad-$ts')
        .then((_) => false)
        .catchError((_) => true);
    check('setParam 超出範圍被拒絕', outOfRange);

    final notControl = await client.command
        .sendCommand(motor.id!, 'setParam', {
          'featureKey': 'rpm',
          'value': '100',
        }, 'sp-nc-$ts')
        .then((_) => false)
        .catchError((_) => true);
    check('setParam 非控制參數被拒絕', notControl);

    final setCmd = await client.command.sendCommand(
      motor.id!,
      'setParam',
      {'featureKey': 'targetRpm', 'value': '2200'},
      'sp-ok-$ts',
    );
    await client.command
        .watchDeviceCommands(motor.id!)
        .firstWhere(
          (c) => c.id == setCmd.id && c.state == DeviceCommandState.completed,
        )
        .timeout(const Duration(seconds: 20));
    // 再等一個 tick 讓 rpm 追隨新目標。
    await Future<void>.delayed(const Duration(seconds: 3));
    final afterApply = (await client.telemetry.listSiteStatuses(
      siteId,
    )).firstWhere((s) => s.deviceId == motor.id);
    final rpmNow = afterApply.latestValues['rpm'] ?? 0;
    check(
      'setParam 套用（targetRpm=2200）',
      afterApply.latestValues['targetRpm'] == 2200,
      'targetRpm=${afterApply.latestValues['targetRpm']}',
    );
    check('轉速追隨目標轉速', (rpmNow - 2200).abs() < 100, 'rpm=$rpmNow');

    // ---- 控制命令 ----
    final idemKey = 'smoke-$deviceId-${DateTime.now().microsecondsSinceEpoch}';
    final command = await client.command.sendCommand(
      deviceId,
      'reboot',
      {},
      idemKey,
    );
    check('命令下發', command.state == DeviceCommandState.created);

    final duplicate = await client.command.sendCommand(
      deviceId,
      'reboot',
      {},
      idemKey,
    );
    check('命令冪等（同鍵回傳原命令）', duplicate.id == command.id);

    // 模擬器每 2 秒推進一步：created→sent→acknowledged→completed。
    final finished = await client.command
        .watchDeviceCommands(deviceId)
        .firstWhere(
          (c) => c.id == command.id && c.state == DeviceCommandState.completed,
        )
        .timeout(const Duration(seconds: 20));
    check('命令狀態機走完（completed）', finished.completedAt != null);

    final history = await client.command.listCommands(deviceId, limit: 10);
    check('命令歷史查詢', history.items.any((c) => c.id == command.id));

    // ---- 告警 ----
    final rules = await client.alert.listRules();
    check('告警規則列表', rules.isNotEmpty, '取得 ${rules.length} 筆');

    // 建一條必然觸發的規則（溫度 > -100），等待告警事件。
    final tempDevice = devices.firstWhere(
      (d) => d.deviceType == 'temperature',
    );
    final alertFuture = client.alert
        .watchAlerts()
        .firstWhere((a) => a.deviceId == tempDevice.id)
        .timeout(const Duration(seconds: 20));
    final rule = await client.alert.createRule(
      tempDevice.id!,
      'temperature',
      AlertComparison.greaterThan,
      -100,
      'smoke 測試規則',
      AlertSeverity.critical,
      false,
    );
    final alert = await alertFuture;
    check('告警觸發（streaming）', alert.state == AlertState.active);
    check('告警等級沿用規則（critical）', alert.severity == AlertSeverity.critical);

    final acknowledged = await client.alert.acknowledgeAlert(alert.id!);
    check('告警確認', acknowledged.state == AlertState.acknowledged);

    final openAlerts = await client.alert.listAlerts(openOnly: true, limit: 50);
    check('未結束告警查詢', openAlerts.items.any((a) => a.id == alert.id));

    // ---- 工單（Mobile CMMS）----
    final woFromAlert = await client.workOrder.createFromAlert(alert.id!);
    check(
      '告警轉工單（critical → urgent）',
      woFromAlert.alertId == alert.id &&
          woFromAlert.priority == WorkOrderPriority.urgent,
    );

    final woDuplicate = await client.workOrder.createFromAlert(alert.id!);
    check('告警轉工單冪等', woDuplicate.id == woFromAlert.id);

    final manualWo = await client.workOrder.createWorkOrder(
      siteId,
      null,
      'E2E 巡檢工單',
      '每月例行巡檢',
      WorkOrderPriority.normal,
    );
    check('手動開立工單', manualWo.status == WorkOrderStatus.open);

    final inProgress = await client.workOrder.updateStatus(
      manualWo.id!,
      WorkOrderStatus.inProgress,
    );
    check('工單開始處理', inProgress.startedAt != null);

    final done = await client.workOrder.updateStatus(
      manualWo.id!,
      WorkOrderStatus.done,
      note: '巡檢完成，無異常',
    );
    check(
      '工單結案（含備註）',
      done.completedAt != null && done.note == '巡檢完成，無異常',
    );

    final illegalTransition = await client.workOrder
        .updateStatus(manualWo.id!, WorkOrderStatus.inProgress)
        .then((_) => false)
        .catchError((_) => true);
    check('結案工單拒絕再流轉', illegalTransition);

    final openWos = await client.workOrder.listWorkOrders(
      openOnly: true,
      limit: 50,
    );
    check(
      '未結案工單查詢',
      openWos.items.any((w) => w.id == woFromAlert.id) &&
          openWos.items.every((w) => w.id != manualWo.id),
    );

    // 清理由告警轉出的工單。
    await client.workOrder.updateStatus(
      woFromAlert.id!,
      WorkOrderStatus.cancelled,
    );

    // ---- OEE ----
    final oee = await client.dashboard.getOee();
    check(
      'OEE 彙總（近 8 小時）',
      oee.oee > 0 &&
          oee.oee <= 1 &&
          oee.availability >= oee.oee &&
          oee.sites.isNotEmpty,
      'OEE ${(oee.oee * 100).toStringAsFixed(1)}% = '
          'A ${(oee.availability * 100).toStringAsFixed(0)}% × '
          'P ${(oee.performance * 100).toStringAsFixed(0)}% × '
          'Q ${(oee.quality * 100).toStringAsFixed(0)}%',
    );

    // ---- 2D 地圖座標 ----
    check(
      '設備地圖座標已配置',
      devices.every((d) => d.mapX != null && d.mapY != null),
    );

    // 清理：刪規則會自動 resolve 其告警。
    await client.alert.deleteRule(rule.id!);
    final afterDelete = await client.alert.listAlerts(
      openOnly: true,
      limit: 50,
    );
    check('刪除規則後告警自動恢復', afterDelete.items.every((a) => a.id != alert.id));

    // ---- 設備配對與 mTLS 憑證（模擬 ESP32，憑證為真實 OpenSSL 簽發）----
    final factoryDevices = await client.provisioning.listDevices();
    check(
      '出廠設備登錄',
      factoryDevices.length >= 3,
      '取得 ${factoryDevices.length} 台',
    );

    const provSerial = 'ESP32-00192839';

    // 若先前（手動或測試中斷）已綁定，先重置讓測試可重複執行。
    final preState = factoryDevices.firstWhere((d) => d.serial == provSerial);
    if (preState.state != ProvisioningState.unclaimed) {
      await client.provisioning.resetDevice(provSerial);
    }

    final claimSession = await client.provisioning.beginManufacturerPairing(
      provSerial,
    );
    check(
      'Claim Session 建立（5 分鐘效期）',
      claimSession.status == 'waiting_for_device' &&
          claimSession.expiresInSeconds == 300,
    );

    final issued = await client.provisioning.simulateDeviceProvision(
      claimSession.claimSessionId,
    );
    check(
      '憑證簽發（CN = 序號）',
      issued.deviceCertificate.contains('BEGIN CERTIFICATE') &&
          issued.mqttClientId == provSerial,
    );

    // 用本機 openssl 驗證伺服器回傳的信任鏈 Root → Intermediate → Device。
    final tmp = Directory.systemTemp.createTempSync('e2e-cert-');
    try {
      File('${tmp.path}/root.crt').writeAsStringSync(issued.rootCa);
      File('${tmp.path}/int.crt').writeAsStringSync(issued.intermediateCa);
      File('${tmp.path}/dev.crt').writeAsStringSync(issued.deviceCertificate);
      final verify = await Process.run('openssl', [
        'verify',
        '-CAfile',
        '${tmp.path}/root.crt',
        '-untrusted',
        '${tmp.path}/int.crt',
        '${tmp.path}/dev.crt',
      ]);
      check(
        'openssl verify 憑證鏈',
        verify.exitCode == 0,
        (verify.stdout as String).trim(),
      );

      final subject = await Process.run('openssl', [
        'x509',
        '-in',
        '${tmp.path}/dev.crt',
        '-noout',
        '-subject',
        '-ext',
        'subjectAltName',
      ]);
      final subjectOut = subject.stdout as String;
      check(
        '憑證 CN 與 SAN 正確',
        subjectOut.contains(provSerial) &&
            subjectOut.contains('urn:device:$provSerial'),
      );
    } finally {
      tmp.deleteSync(recursive: true);
    }

    final sessionReuse = await client.provisioning
        .simulateDeviceProvision(claimSession.claimSessionId)
        .then((_) => false)
        .catchError((_) => true);
    check('Claim Session 不可重複使用', sessionReuse);

    final provisioned = (await client.provisioning.listDevices()).firstWhere(
      (d) => d.serial == provSerial,
    );
    check('設備狀態機到 ACTIVE', provisioned.state == ProvisioningState.active);

    final certs = await client.provisioning.listCertificates(provSerial);
    check('憑證歷史入庫', certs.isNotEmpty && !certs.first.revoked);

    // ---- 加入設備庫：配對後掛載到場域/閘道器，開始出現量測值 ----
    final attachSite = sites.first;
    final attachGateways = await client.gateway.listBySite(attachSite.id!);
    final attached = await client.provisioning.attachToPlatform(
      provSerial,
      attachSite.id!,
      attachGateways.first.id,
      'E2E ESP32 感測器',
      '',
      5,
      '',
    );
    check(
      '加入設備庫（SENSOR-T02 → temperature 設備）',
      attached.linkedDeviceId != null,
    );

    final attachedDevice = (await client.device.listBySite(
      attachSite.id!,
    )).firstWhere((d) => d.id == attached.linkedDeviceId);
    check('型號對應感測類型', attachedDevice.deviceType == 'temperature');

    // 模擬器每 2 秒 tick 一次，等首筆量測與狀態上線。
    await Future<void>.delayed(const Duration(seconds: 5));
    final attachedMeasurements = await client.telemetry.listMeasurements(
      attached.linkedDeviceId!,
      limit: 5,
    );
    check(
      '掛載後開始回報量測值',
      attachedMeasurements.items.isNotEmpty,
      attachedMeasurements.items.isEmpty
          ? '無量測'
          : '最新 ${attachedMeasurements.items.first.featureKey}='
                '${attachedMeasurements.items.first.value.toStringAsFixed(2)}',
    );

    final duplicateAttach = await client.provisioning
        .attachToPlatform(
          provSerial,
          attachSite.id!,
          attachGateways.first.id,
          '重複掛載',
          '',
          5,
          '',
        )
        .then((_) => false)
        .catchError((_) => true);
    check('重複加入設備庫被拒絕', duplicateAttach);

    // 清理：刪除平台設備（量測/狀態連帶清除）。
    await client.device.deleteDevice(
      attached.linkedDeviceId!,
      'dev@demo.local',
      'demo12345',
    );

    // 清理：解除綁定並撤銷憑證，讓測試可重複執行。
    final resetDevice = await client.provisioning.resetDevice(provSerial);
    final certsAfterReset = await client.provisioning.listCertificates(
      provSerial,
    );
    check(
      '解除綁定（憑證撤銷、回到 UNCLAIMED）',
      resetDevice.state == ProvisioningState.unclaimed &&
          certsAfterReset.every((c) => c.revoked),
    );

    // ---- Dashboard ----
    final summary = await client.dashboard.getSummary();
    check(
      'Dashboard 彙總',
      summary.siteCount >= 2 &&
          summary.deviceCount >= 8 &&
          summary.sites.length == summary.siteCount,
      '${summary.siteCount} 場域 / ${summary.deviceCount} 設備 / '
          '在線 ${summary.onlineCount}',
    );

    // ---- CRUD：場域 → 閘道器 → 設備 ----
    final newSite = await client.site.createSite('E2E 測試場域', '煙霧測試');
    check('建立場域', newSite.id != null);

    final renamedSite = await client.site.updateSite(
      newSite.id!,
      'E2E 測試場域（改）',
      null,
    );
    check('更新場域', renamedSite.name == 'E2E 測試場域（改）');

    final newGateway = await client.gateway.createGateway(
      newSite.id!,
      'GW-E2E-${DateTime.now().millisecondsSinceEpoch}',
      'E2E 閘道器',
    );
    check('註冊閘道器', newGateway.id != null);

    final siteDeleteBlocked = await client.site
        .deleteSite(newSite.id!)
        .then((_) => false)
        .catchError((_) => true);
    check('場域仍有閘道器時拒絕刪除', siteDeleteBlocked);

    final newDevice = await client.device.createDevice(
      newSite.id!,
      newGateway.id!,
      'E2E 溫度計',
      'TMP-900',
      'temperature',
      10,
    );
    check(
      '註冊設備（含初始狀態與型別檔特徵）',
      newDevice.id != null && (newDevice.features?.length ?? 0) == 1,
    );

    final updatedDevice = await client.device.updateDevice(
      newDevice.id!,
      'E2E 溫度計（改）',
      'TMP-901',
      5,
    );
    check(
      '更新設備',
      updatedDevice.name == 'E2E 溫度計（改）' &&
          updatedDevice.expectedIntervalSeconds == 5,
    );

    await client.device.deleteDevice(
      newDevice.id!,
      'dev@demo.local',
      'demo12345',
    );
    final devicesAfterDelete = await client.device.listBySite(newSite.id!);
    check('刪除設備（連帶清除子資料）', devicesAfterDelete.isEmpty);

    await client.gateway.deleteGateway(newGateway.id!);
    await client.site.deleteSite(newSite.id!);
    final sitesAfterCleanup = await client.site.listSites();
    check(
      '刪除閘道器與場域',
      sitesAfterCleanup.every((s) => s.id != newSite.id),
    );
  } catch (e, st) {
    stdout.writeln('EXCEPTION: $e\n$st');
    failures++;
  } finally {
    client.close();
  }

  stdout.writeln(
    failures == 0 ? 'E2E_SMOKE_OK' : 'E2E_SMOKE_FAILED ($failures)',
  );
  exit(failures == 0 ? 0 : 1);
}
