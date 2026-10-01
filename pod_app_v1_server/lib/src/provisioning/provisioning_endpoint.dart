import 'dart:io';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../device/device_profiles.dart';
import '../generated/protocol.dart';
import '../mqtt/device_local_mqtt_store.dart';
import '../mqtt/esp32_mqtt_simulator.dart';
import '../mqtt/mqtt_bridge.dart';
import 'ca_service.dart';

/// 設備配對與憑證管理（手冊 §6～§8）。
///
/// 使用者登入＋公司 Factory CA 身分＋短效配對 Session。
class ProvisioningEndpoint extends Endpoint {
  /// Claim Token 效期（手冊 §11 建議 5 分鐘）。
  static const claimTtl = Duration(minutes: 5);

  @override
  bool get requireLogin => true;

  /// 出廠設備列表（含配對狀態，供 App 顯示）。
  Future<List<ProvisionedDevice>> listDevices(Session session) {
    return ProvisionedDevice.db.find(
      session,
      orderBy: (t) => t.serial,
    );
  }

  /// 建立製造商驗證配對 Session。使用者不輸入 Claim Code；Server 會驗證
  /// Factory Certificate 的公司 CA 信任鏈、CN 與既有指紋。
  Future<ClaimSessionResult> beginManufacturerPairing(
    Session session,
    String serial,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final device = await ProvisionedDevice.db.findFirstRow(
      session,
      where: (t) => t.serial.equals(serial.trim()),
    );
    if (device == null) {
      throw NotFoundException(message: '查無此設備序號，請確認 QR Code');
    }
    if (device.state == ProvisioningState.revoked) {
      throw ValidationException(message: '此設備已停用');
    }
    if (device.state != ProvisioningState.unclaimed &&
        device.state != ProvisioningState.claimPending) {
      throw ValidationException(message: '此設備已被綁定');
    }
    final factoryCert = File(
      'certs/mqtt/devices/${device.serial}/client-chain.crt',
    );
    if (!factoryCert.existsSync()) {
      throw ValidationException(message: '找不到此設備的 Factory Certificate');
    }
    await CaService.ensureCa(session);
    final fingerprint = await CaService.verifyFactoryCertificate(
      certificatePem: factoryCert.readAsStringSync(),
      expectedCn: device.serial,
    );
    final registeredFingerprint = device.factoryCertificateFingerprint;
    if (registeredFingerprint != null &&
        registeredFingerprint.isNotEmpty &&
        registeredFingerprint != fingerprint) {
      throw ValidationException(message: 'Factory Certificate 指紋與出廠資料不符');
    }

    final now = DateTime.now().toUtc();
    final sessionId =
        'claim_${now.microsecondsSinceEpoch.toRadixString(16)}'
        '${Random.secure().nextInt(0xffffff).toRadixString(16)}';
    await DeviceClaim.db.insertRow(
      session,
      DeviceClaim(
        sessionId: sessionId,
        serial: device.serial,
        userIdentifier: session.authenticated!.userIdentifier,
        companyId: companyId,
        status: 'waiting_for_device',
        expiresAt: now.add(claimTtl),
        createdAt: now,
      ),
    );
    await ProvisionedDevice.db.updateRow(
      session,
      device.copyWith(
        state: ProvisioningState.claimPending,
        manufacturerVerified: true,
        factoryCertificateFingerprint: fingerprint,
        manufacturerVerifiedAt: now,
      ),
    );

    return ClaimSessionResult(
      claimSessionId: sessionId,
      expiresInSeconds: claimTtl.inSeconds,
      status: 'waiting_for_device',
      serial: device.serial,
    );
  }

  /// 模擬 ESP32 完成配對（開發環境專用；實機階段由設備透過
  /// Bootstrap mTLS 呼叫 claim-confirm 與憑證申請）：
  /// 1) 確認 Claim Session 有效 → 綁定（CLAIMED）
  /// 2) 模擬設備本機產生私鑰與 CSR（私鑰不出設備）
  /// 3) 內部 CA 真實簽發憑證並驗證信任鏈（CERTIFICATE_ISSUED）
  /// 4) 設備啟用（ACTIVE）
  Future<CertificateIssueResult> simulateDeviceProvision(
    Session session,
    String claimSessionId,
  ) async {
    final claim = await DeviceClaim.db.findFirstRow(
      session,
      where: (t) => t.sessionId.equals(claimSessionId),
    );
    if (claim == null) {
      throw NotFoundException(message: 'Claim Session 不存在');
    }
    final now = DateTime.now().toUtc();
    if (claim.status != 'waiting_for_device') {
      throw ValidationException(message: 'Claim Session 已使用');
    }
    if (now.isAfter(claim.expiresAt)) {
      await DeviceClaim.db.updateRow(
        session,
        claim.copyWith(status: 'expired'),
      );
      throw ValidationException(message: 'Claim Token 已過期，請重新掃碼');
    }

    final device = await ProvisionedDevice.db.findFirstRow(
      session,
      where: (t) => t.serial.equals(claim.serial),
    );
    if (device == null) {
      throw NotFoundException(message: '設備不存在');
    }

    // 模擬設備端產生金鑰＋CSR，CA 真實簽發。
    // 開發環境：金鑰寫入本機 devices/ 目錄供 Esp32MqttSimulator 使用（正式產品金鑰不離設備）。
    final (keyPem, csrPem) = await CaService.simulateDeviceKeyAndCsr(
      device.serial,
    );
    final version =
        await DeviceCertificate.db.count(
          session,
          where: (t) => t.serial.equals(device.serial),
        ) +
        1;
    final (certPem, certSerial, expiresAt) = await CaService.signDeviceCsr(
      session,
      csrPem: csrPem,
      expectedCn: device.serial,
    );

    // 憑證已成功簽發後才確認 Claim 與設備綁定，避免 CA 異常時
    // 留下「已綁定但沒有可用憑證」的半完成狀態。
    await DeviceClaim.db.updateRow(
      session,
      claim.copyWith(status: 'confirmed', confirmedAt: now),
    );
    var updated = await ProvisionedDevice.db.updateRow(
      session,
      device.copyWith(
        state: ProvisioningState.claimed,
        companyId: claim.companyId,
        claimedBy: claim.userIdentifier,
        claimedAt: now,
      ),
    );
    await DeviceCertificate.db.insertRow(
      session,
      DeviceCertificate(
        serial: device.serial,
        certSerialNumber: certSerial,
        subjectCn: device.serial,
        certificatePem: certPem,
        version: version,
        issuedAt: now,
        expiresAt: expiresAt,
        revoked: false,
      ),
    );

    // CERTIFICATE_ISSUED → ACTIVE。
    updated = await ProvisionedDevice.db.updateRow(
      session,
      updated.copyWith(state: ProvisioningState.certificateIssued),
    );
    await ProvisionedDevice.db.updateRow(
      session,
      updated.copyWith(state: ProvisioningState.active),
    );

    // 實體開發板的憑證是韌體編譯輸入，也是下一次重新配對時要驗證的
    // Factory identity。模擬簽發結果不可覆寫同一路徑，否則解除綁定後
    // Server 會拿新檔案與原本記錄的 Factory 指紋比較而拒絕合法設備。
    if (!DeviceLocalMqttStore.isPhysicalDevice(device.serial)) {
      DeviceLocalMqttStore.save(
        serial: device.serial,
        keyPem: keyPem,
        certificatePem: certPem,
      );
    }
    await Esp32MqttSimulator.instance?.onCertificateIssued(device.serial);

    session.log('設備 ${device.serial} 配對完成，憑證 $certSerial 已簽發');

    return CertificateIssueResult(
      deviceCertificate: certPem,
      intermediateCa: CaService.readIntermediateCa(),
      rootCa: CaService.readRootCa(),
      mqttHost: Platform.environment['MQTT_PUBLIC_HOST'] ?? 'localhost',
      mqttPort: int.tryParse(Platform.environment['MQTT_PORT'] ?? '') ?? 8883,
      mqttClientId: device.serial,
      certificateVersion: version,
      expiresAt: expiresAt,
    );
  }

  /// 型號推斷感測類型（出廠型號規則）。
  static String deviceTypeForModel(String model) {
    if (model.startsWith('SENSOR-T')) return 'temperature';
    if (model.startsWith('SENSOR-H')) return 'humidity';
    if (model.startsWith('SENSOR-P')) return 'power';
    if (model.startsWith('SENSOR-V')) return 'vibration';
    return 'temperature';
  }

  /// 已配對（ACTIVE）且尚未掛到設備庫的實體清單（供建檔頁選序號）。
  Future<List<ProvisionedDevice>> listUnlinkedDevices(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    return ProvisionedDevice.db.find(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.state.equals(ProvisioningState.active) &
          t.linkedDeviceId.equals(null) &
          t.linkedGatewayId.equals(null),
      orderBy: (t) => t.serial,
    );
  }

  /// 把已啟用（ACTIVE）的配對設備加入設備庫（營運層）：
  /// - GW 型號 → 建立或重新連結平台 Gateway（序號即設備序號）
  /// - 感測器型號 → 掛在指定閘道器下建立平台 Device ＋ 初始狀態
  /// 加入後模擬器（實機為 MQTT 上行）即開始提供量測數據。
  ///
  /// [profileId] 空字串則依出廠型號推斷；[expectedIntervalSeconds] ≤0 則用 5；
  /// [model] 空字串則沿用出廠型號。
  Future<ProvisionedDevice> attachToPlatform(
    Session session,
    String serial,
    int siteId,
    int? gatewayId,
    String name,
    String profileId,
    int expectedIntervalSeconds,
    String model,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    await TenantService.assertSiteAccess(session, companyId, siteId);

    final device = await ProvisionedDevice.db.findFirstRow(
      session,
      where: (t) => t.serial.equals(serial),
    );
    if (device == null) {
      throw NotFoundException(message: '設備不存在');
    }
    if (device.state != ProvisioningState.active) {
      throw ValidationException(message: '設備尚未完成配對（需為 ACTIVE）');
    }
    if (device.companyId != companyId) {
      throw ValidationException(message: '設備不屬於目前公司');
    }
    if (device.linkedGatewayId != null || device.linkedDeviceId != null) {
      throw ValidationException(message: '設備已加入設備庫');
    }
    if (name.trim().isEmpty) {
      throw ValidationException(message: '名稱不可為空');
    }

    final now = DateTime.now().toUtc();
    if (device.model.startsWith('GW')) {
      final existingGateway = await Gateway.db.findFirstRow(
        session,
        where: (t) => t.serialNumber.equals(device.serial),
      );
      if (existingGateway != null && existingGateway.companyId != companyId) {
        throw ValidationException(message: '此設備序號已屬於其他公司');
      }

      final gateway = existingGateway == null
          ? await Gateway.db.insertRow(
              session,
              Gateway(
                companyId: companyId,
                siteId: siteId,
                serialNumber: device.serial,
                name: name.trim(),
                model: device.model,
                productKey: 'esp32_gateway',
                chipFamily: 'esp32',
                updateProtocol: 'esp_https_ota',
                hardwareRevision: 'A1',
                firmwareVersion: null,
                connectionState: DeviceConnectionState.unknown,
                lastSeenAt: null,
                createdAt: now,
              ),
            )
          : await Gateway.db.updateRow(
              session,
              existingGateway.copyWith(
                siteId: siteId,
                name: name.trim(),
                model: device.model,
                productKey: 'esp32_gateway',
                chipFamily: 'esp32',
                updateProtocol: 'esp_https_ota',
                connectionState: DeviceConnectionState.unknown,
                lastSeenAt: null,
              ),
            );
      return ProvisionedDevice.db.updateRow(
        session,
        device.copyWith(linkedGatewayId: gateway.id),
      );
    }

    // 感測器／控制器可直接以 Wi-Fi/MQTTS 上行；gatewayId 僅在經閘道器時提供。
    if (gatewayId != null) {
      final gateway = await TenantService.assertGatewayAccess(
        session,
        companyId,
        gatewayId,
      );
      if (gateway.siteId != siteId) {
        throw ValidationException(message: '閘道器不屬於此場域');
      }
    }
    final resolvedProfileId = profileId.trim().isEmpty
        ? deviceTypeForModel(device.model)
        : profileId.trim();
    var profile = DeviceProfiles.byId(resolvedProfileId);
    if (profile == null) {
      final custom = await CustomDeviceProfile.db.findFirstRow(
        session,
        where: (t) =>
            t.companyId.equals(companyId) &
            t.profileKey.equals(resolvedProfileId),
      );
      if (custom != null) profile = DeviceProfiles.fromCustom(custom);
    }
    if (profile == null) {
      throw ValidationException(message: '未知的設備型別檔：$resolvedProfileId');
    }
    final interval = expectedIntervalSeconds > 0 ? expectedIntervalSeconds : 5;
    final resolvedModel = model.trim().isEmpty ? device.model : model.trim();
    final existingDevice = await Device.db.findFirstRow(
      session,
      where: (t) => t.serialNumber.equals(device.serial),
    );
    if (existingDevice != null && existingDevice.companyId != companyId) {
      throw ValidationException(message: '此設備序號已屬於其他公司');
    }
    final platformDevice = existingDevice == null
        ? await Device.db.insertRow(
            session,
            Device(
              companyId: companyId,
              siteId: siteId,
              gatewayId: gatewayId,
              serialNumber: device.serial,
              name: name.trim(),
              model: resolvedModel,
              deviceType: profile.id,
              features: profile.features,
              expectedIntervalSeconds: interval,
              createdAt: now,
            ),
          )
        : await Device.db.updateRow(
            session,
            existingDevice.copyWith(
              siteId: siteId,
              gatewayId: gatewayId,
              name: name.trim(),
              model: resolvedModel,
              deviceType: profile.id,
              features: profile.features,
              expectedIntervalSeconds: interval,
            ),
          );
    final existingStatus = await DeviceStatus.db.findFirstRow(
      session,
      where: (t) => t.deviceId.equals(platformDevice.id!),
    );
    if (existingStatus == null) {
      await DeviceStatus.db.insertRow(
        session,
        DeviceStatus(
          companyId: companyId,
          deviceId: platformDevice.id!,
          connectionState: DeviceConnectionState.unknown,
          latestValues: {},
          lastUpdatedAt: null,
        ),
      );
    }
    return ProvisionedDevice.db.updateRow(
      session,
      device.copyWith(linkedDeviceId: platformDevice.id),
    );
  }

  /// 設備的憑證歷史（新到舊）。
  Future<List<DeviceCertificate>> listCertificates(
    Session session,
    String serial,
  ) {
    return DeviceCertificate.db.find(
      session,
      where: (t) => t.serial.equals(serial),
      orderBy: (t) => t.version,
      orderDescending: true,
    );
  }

  /// 撤銷憑證（手冊 §11）：憑證列入撤銷、設備轉為 REVOKED。
  Future<void> revokeCertificate(Session session, int certificateId) async {
    final cert = await DeviceCertificate.db.findById(session, certificateId);
    if (cert == null) {
      throw NotFoundException(message: '憑證不存在');
    }
    final now = DateTime.now().toUtc();
    await DeviceCertificate.db.updateRow(
      session,
      cert.copyWith(revoked: true, revokedAt: now),
    );
    final device = await ProvisionedDevice.db.findFirstRow(
      session,
      where: (t) => t.serial.equals(cert.serial),
    );
    if (device != null) {
      await ProvisionedDevice.db.updateRow(
        session,
        device.copyWith(state: ProvisioningState.revoked),
      );
    }
    DeviceLocalMqttStore.clear(cert.serial);
    Esp32MqttSimulator.instance?.onCertificateRevoked(cert.serial);
  }

  /// 開發用：解除綁定並撤銷所有憑證，讓同一設備可重複示範配對。
  Future<ProvisionedDevice> resetDevice(Session session, String serial) async {
    final device = await ProvisionedDevice.db.findFirstRow(
      session,
      where: (t) => t.serial.equals(serial),
    );
    if (device == null) {
      throw NotFoundException(message: '設備不存在');
    }
    // The reset command must arrive while the current mTLS identity is still
    // usable. The physical device clears Wi-Fi NVS, reboots and advertises BLE.
    final resetSent =
        await mqttBridge?.publishProvisioningReset(serial) ?? false;
    if (resetSent) {
      await Future<void>.delayed(const Duration(milliseconds: 800));
    }
    final now = DateTime.now().toUtc();
    final certs = await DeviceCertificate.db.find(
      session,
      where: (t) => t.serial.equals(serial) & t.revoked.equals(false),
    );
    for (final cert in certs) {
      await DeviceCertificate.db.updateRow(
        session,
        cert.copyWith(revoked: true, revokedAt: now),
      );
    }
    // Keep development build credentials for a marked physical device. They
    // are compile-time inputs, not a simulator session. A production device
    // stores its private key in secure NVS instead.
    if (!DeviceLocalMqttStore.isPhysicalDevice(serial)) {
      DeviceLocalMqttStore.clear(serial);
    }
    Esp32MqttSimulator.instance?.onCertificateRevoked(serial);
    // 解除平台關聯（平台端的閘道器/設備保留，可於設備庫另行刪除）。
    return ProvisionedDevice.db.updateRow(
      session,
      device.copyWith(
        state: ProvisioningState.unclaimed,
        companyId: null,
        claimedBy: null,
        claimedAt: null,
        linkedGatewayId: null,
        linkedDeviceId: null,
      ),
    );
  }
}
