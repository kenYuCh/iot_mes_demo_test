import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../company/tenant_service.dart';
import '../generated/protocol.dart';
import 'device_profiles.dart';

/// 設備查詢與管理。
class DeviceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 可選用的設備型別檔（量測通道＋控制參數組合）。
  Future<List<DeviceProfile>> listProfiles(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final custom = await CustomDeviceProfile.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.name,
    );
    // 「設備特徵管理」只列出公司實際建立的設備型別。
    // DeviceProfiles.all 僅作為特徵資料庫的系統建議範本，不應被誤認為
    // 已存在且無法刪除的設備型別資料。
    return custom.map(DeviceProfiles.fromCustom).toList(growable: false);
  }

  /// 公司可重用特徵目錄；同 key 的公司定義會覆蓋系統建議範本。
  Future<List<FeatureCatalogItem>> listFeatureCatalog(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final custom = await FeatureDefinition.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.featureKey,
    );
    final catalog = <String, ({int? id, DeviceFeature feature, bool system})>{};
    for (final profile in DeviceProfiles.all) {
      for (final feature in profile.features) {
        catalog.putIfAbsent(
          feature.key,
          () => (id: null, feature: feature, system: true),
        );
      }
    }
    for (final row in custom) {
      catalog[row.featureKey] = (
        id: row.id,
        feature: _featureFromDefinition(row),
        system: false,
      );
    }
    final customProfiles = await CustomDeviceProfile.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
    );
    final devices = await Device.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
    );
    return [
      for (final entry in catalog.values)
        FeatureCatalogItem(
          definitionId: entry.id,
          feature: entry.feature,
          system: entry.system,
          usageCount:
              customProfiles
                  .where(
                    (profile) => profile.features.any(
                      (feature) => feature.key == entry.feature.key,
                    ),
                  )
                  .length +
              devices
                  .where(
                    (device) =>
                        device.features?.any(
                          (feature) => feature.key == entry.feature.key,
                        ) ??
                        false,
                  )
                  .length,
        ),
    ]..sort((a, b) => a.feature.label.compareTo(b.feature.label));
  }

  Future<FeatureCatalogItem> createFeatureDefinition(
    Session session,
    DeviceFeature feature,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    _validateFeature(feature);
    final exists = await FeatureDefinition.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) & t.featureKey.equals(feature.key),
    );
    if (exists != null) throw ValidationException(message: '特徵代碼已存在');
    final row = await FeatureDefinition.db.insertRow(
      session,
      _definitionFromFeature(companyId, feature),
    );
    return FeatureCatalogItem(
      definitionId: row.id,
      feature: _featureFromDefinition(row),
      system: false,
      usageCount: 0,
    );
  }

  Future<FeatureCatalogItem> updateFeatureDefinition(
    Session session,
    int definitionId,
    DeviceFeature feature,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    _validateFeature(feature);
    final row = await _featureDefinition(session, companyId, definitionId);
    if (feature.key != row.featureKey) {
      throw ValidationException(message: '建立後不可變更特徵代碼，以免破壞 MQTT 協定');
    }
    final updated = await FeatureDefinition.db.updateRow(
      session,
      _definitionFromFeature(
        companyId,
        feature,
        id: row.id,
        createdAt: row.createdAt,
      ),
    );
    return FeatureCatalogItem(
      definitionId: updated.id,
      feature: _featureFromDefinition(updated),
      system: false,
      usageCount: await _featureUsageCount(session, companyId, feature.key),
    );
  }

  Future<void> deleteFeatureDefinition(
    Session session,
    int definitionId,
    String email,
    String password,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final row = await _featureDefinition(session, companyId, definitionId);
    await _assertCurrentPassword(session, email, password);
    final usage = await _featureUsageCount(session, companyId, row.featureKey);
    if (usage > 0) {
      throw ValidationException(message: '仍有 $usage 個設備型別或設備使用此特徵，請先移除關聯');
    }
    await FeatureDefinition.db.deleteRow(session, row);
  }

  /// 建立公司級設備型別檔。僅管理者可異動。
  Future<DeviceProfile> createProfile(
    Session session,
    String profileKey,
    String name,
    String description,
    String mcuFamily,
    List<DeviceFeature> features,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final key = _validateProfile(profileKey, name, features);
    if (DeviceProfiles.byId(key) != null) {
      throw ValidationException(message: '不可覆蓋系統內建型別');
    }
    final exists = await CustomDeviceProfile.db.findFirstRow(
      session,
      where: (t) => t.companyId.equals(companyId) & t.profileKey.equals(key),
    );
    if (exists != null) throw ValidationException(message: '型別代碼已存在');
    final now = DateTime.now().toUtc();
    final row = await CustomDeviceProfile.db.insertRow(
      session,
      CustomDeviceProfile(
        companyId: companyId,
        profileKey: key,
        name: name.trim(),
        description: description.trim().isEmpty ? null : description.trim(),
        mcuFamily: mcuFamily.trim().isEmpty ? null : mcuFamily.trim(),
        category: _categoryFor(features),
        features: features,
        createdAt: now,
        updatedAt: now,
      ),
    );
    return DeviceProfiles.fromCustom(row);
  }

  /// 編輯公司級設備型別檔；型別代碼固定，避免歷史資料失去對應。
  Future<DeviceProfile> updateProfile(
    Session session,
    String profileKey,
    String name,
    String description,
    String mcuFamily,
    List<DeviceFeature> features,
    String? email,
    String? password,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final key = _validateProfile(profileKey, name, features);
    final row = await CustomDeviceProfile.db.findFirstRow(
      session,
      where: (t) => t.companyId.equals(companyId) & t.profileKey.equals(key),
    );
    final now = DateTime.now().toUtc();
    if (row == null && DeviceProfiles.byId(key) == null) {
      throw NotFoundException(message: '設備型別不存在');
    }
    final previousFeatures =
        row?.features ?? DeviceProfiles.byId(key)!.features;
    final newKeys = features.map((feature) => feature.key).toSet();
    final removedFeatures = previousFeatures.where(
      (feature) => !newKeys.contains(feature.key),
    );
    if (removedFeatures.isNotEmpty) {
      await _assertCurrentPassword(session, email, password);
    }
    final updated = row == null
        ? await CustomDeviceProfile.db.insertRow(
            session,
            CustomDeviceProfile(
              companyId: companyId,
              profileKey: key,
              name: name.trim(),
              description: description.trim().isEmpty
                  ? null
                  : description.trim(),
              mcuFamily: mcuFamily.trim().isEmpty ? null : mcuFamily.trim(),
              category: _categoryFor(features),
              features: features,
              createdAt: now,
              updatedAt: now,
            ),
          )
        : await CustomDeviceProfile.db.updateRow(
            session,
            row.copyWith(
              name: name.trim(),
              description: description.trim().isEmpty
                  ? null
                  : description.trim(),
              mcuFamily: mcuFamily.trim().isEmpty ? null : mcuFamily.trim(),
              category: _categoryFor(features),
              features: features,
              updatedAt: now,
            ),
          );
    return DeviceProfiles.fromCustom(updated);
  }

  /// 將型別檔最新特徵套用至所有使用該型別的設備。
  Future<int> applyProfileToDevices(
    Session session,
    String profileKey,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final profile = await _resolveProfile(session, companyId, profileKey);
    final devices = await Device.db.find(
      session,
      where: (t) =>
          t.companyId.equals(companyId) & t.deviceType.equals(profile.id),
    );
    for (final device in devices) {
      await Device.db.updateRow(
        session,
        device.copyWith(features: profile.features),
      );
    }
    return devices.length;
  }

  Future<void> deleteProfile(
    Session session,
    String profileKey,
    String email,
    String password,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    await _assertCurrentPassword(session, email, password);
    final row = await _customProfile(session, companyId, profileKey.trim());
    final inUse = await Device.db.count(
      session,
      where: (t) =>
          t.companyId.equals(companyId) & t.deviceType.equals(row.profileKey),
    );
    if (inUse > 0) {
      throw ValidationException(message: '仍有 $inUse 台設備使用此型別，無法刪除');
    }
    await CustomDeviceProfile.db.deleteRow(session, row);
  }

  /// 破壞性 UI 操作前先重新驗證；實際寫入端點仍會再次驗證。
  Future<void> verifyDestructivePassword(
    Session session,
    String email,
    String password,
  ) async {
    await TenantService.assertFirmwareAdmin(session);
    await _assertCurrentPassword(session, email, password);
  }

  /// 註冊設備並建立初始狀態（unknown，等待第一筆資料）。
  /// [deviceType] 為型別檔 id，特徵清單由型別檔目錄套用。
  Future<Device> createDevice(
    Session session,
    int siteId,
    int? gatewayId,
    String name,
    String model,
    String deviceType,
    int expectedIntervalSeconds,
  ) async {
    final companyId = await TenantService.assertPermission(
      session,
      PlatformPermission.deviceManage,
    );
    await TenantService.assertSiteAccess(session, companyId, siteId);
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
    if (name.trim().isEmpty) {
      throw ValidationException(message: '名稱不可為空');
    }
    final profile = await _resolveProfile(session, companyId, deviceType);
    if (expectedIntervalSeconds <= 0) {
      throw ValidationException(message: '上報間隔必須大於 0 秒');
    }

    final device = await Device.db.insertRow(
      session,
      Device(
        companyId: companyId,
        siteId: siteId,
        gatewayId: gatewayId,
        name: name.trim(),
        model: model.trim(),
        deviceType: profile.id,
        features: profile.features,
        expectedIntervalSeconds: expectedIntervalSeconds,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    await DeviceStatus.db.insertRow(
      session,
      DeviceStatus(
        companyId: companyId,
        deviceId: device.id!,
        connectionState: DeviceConnectionState.unknown,
        latestValues: {},
        lastUpdatedAt: null,
      ),
    );
    return device;
  }

  /// 更新設備基本資料（類型不可變更，避免歷史量測失去意義）。
  Future<Device> updateDevice(
    Session session,
    int deviceId,
    String name,
    String model,
    int expectedIntervalSeconds,
  ) async {
    final companyId = await TenantService.assertPermission(
      session,
      PlatformPermission.deviceManage,
    );
    final device = await TenantService.assertDeviceAccess(
      session,
      companyId,
      deviceId,
      write: true,
    );
    if (name.trim().isEmpty) {
      throw ValidationException(message: '名稱不可為空');
    }
    if (expectedIntervalSeconds <= 0) {
      throw ValidationException(message: '上報間隔必須大於 0 秒');
    }
    return Device.db.updateRow(
      session,
      device.copyWith(
        name: name.trim(),
        model: model.trim(),
        expectedIntervalSeconds: expectedIntervalSeconds,
      ),
    );
  }

  /// 儲存設備在 2D 廠房平面圖上的正規化座標。
  Future<Device> updateMapPosition(
    Session session,
    int deviceId,
    double mapX,
    double mapY,
  ) async {
    final companyId = await TenantService.assertPermission(
      session,
      PlatformPermission.deviceManage,
    );
    final device = await TenantService.assertDeviceAccess(
      session,
      companyId,
      deviceId,
      write: true,
    );
    if (!mapX.isFinite || !mapY.isFinite) {
      throw ValidationException(message: '地圖座標格式錯誤');
    }
    return Device.db.updateRow(
      session,
      device.copyWith(
        mapX: mapX.clamp(0.04, 0.96),
        mapY: mapY.clamp(0.06, 0.94),
      ),
    );
  }

  /// 刪除設備，並連帶清除其狀態、量測、命令、告警與規則。
  Future<void> deleteDevice(
    Session session,
    int deviceId,
    String email,
    String password,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final device = await TenantService.assertDeviceAccess(
      session,
      companyId,
      deviceId,
    );
    await _assertCurrentPassword(session, email, password);

    await session.db.transaction((transaction) async {
      await Measurement.db.deleteWhere(
        session,
        where: (t) => t.deviceId.equals(deviceId),
        transaction: transaction,
      );
      await DeviceCommand.db.deleteWhere(
        session,
        where: (t) => t.deviceId.equals(deviceId),
        transaction: transaction,
      );
      await Alert.db.deleteWhere(
        session,
        where: (t) => t.deviceId.equals(deviceId),
        transaction: transaction,
      );
      await AlertRule.db.deleteWhere(
        session,
        where: (t) => t.deviceId.equals(deviceId),
        transaction: transaction,
      );
      // 工單是維修歷史，保留紀錄但解除設備關聯。
      final workOrders = await WorkOrder.db.find(
        session,
        where: (t) => t.deviceId.equals(deviceId),
        transaction: transaction,
      );
      for (final workOrder in workOrders) {
        await WorkOrder.db.updateRow(
          session,
          workOrder.copyWith(deviceId: null),
          transaction: transaction,
        );
      }
      // OTA 作業為稽核歷史，保留但解除已刪除的平台設備關聯。
      final otaJobs = await OtaDeviceJob.db.find(
        session,
        where: (t) => t.deviceId.equals(deviceId),
        transaction: transaction,
      );
      for (final otaJob in otaJobs) {
        await OtaDeviceJob.db.updateRow(
          session,
          otaJob.copyWith(deviceId: null),
          transaction: transaction,
        );
      }
      // 保留出廠註冊與配對身分，只解除平台 Device，以便重新掛載。
      final provisionedDevices = await ProvisionedDevice.db.find(
        session,
        where: (t) => t.linkedDeviceId.equals(deviceId),
        transaction: transaction,
      );
      for (final provisionedDevice in provisionedDevices) {
        await ProvisionedDevice.db.updateRow(
          session,
          provisionedDevice.copyWith(linkedDeviceId: null),
          transaction: transaction,
        );
      }
      await DeviceStatus.db.deleteWhere(
        session,
        where: (t) => t.deviceId.equals(deviceId),
        transaction: transaction,
      );
      await Device.db.deleteRow(session, device, transaction: transaction);
    });
  }

  /// 列出場域底下的設備。舊資料的特徵清單由型別檔目錄補齊。
  Future<List<Device>> listBySite(Session session, int siteId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    await TenantService.assertSiteAccess(session, companyId, siteId);
    final devices = await Device.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & t.siteId.equals(siteId),
      orderBy: (t) => t.createdAt,
      limit: 100,
    );
    final accessible = await TenantService.filterReadableDevices(
      session,
      devices,
    );
    return [for (final d in accessible) _hydrate(d)];
  }

  /// 取得單一設備。舊資料的特徵清單由型別檔目錄補齊。
  Future<Device> getDevice(Session session, int deviceId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final device = await TenantService.assertDeviceAccess(
      session,
      companyId,
      deviceId,
    );
    return _hydrate(device);
  }

  Device _hydrate(Device device) => device.features != null
      ? device
      : device.copyWith(features: DeviceProfiles.featuresFor(device));

  Future<DeviceProfile> _resolveProfile(
    Session session,
    int companyId,
    String profileKey,
  ) async {
    final key = profileKey.trim();
    final builtIn = DeviceProfiles.byId(key);
    if (builtIn != null) return builtIn;
    final custom = await CustomDeviceProfile.db.findFirstRow(
      session,
      where: (t) => t.companyId.equals(companyId) & t.profileKey.equals(key),
    );
    if (custom == null) {
      throw ValidationException(message: '未知的設備型別檔：$profileKey');
    }
    return DeviceProfiles.fromCustom(custom);
  }

  Future<CustomDeviceProfile> _customProfile(
    Session session,
    int companyId,
    String profileKey,
  ) async {
    final row = await CustomDeviceProfile.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) & t.profileKey.equals(profileKey),
    );
    if (row == null) throw NotFoundException(message: '自訂設備型別不存在');
    return row;
  }

  Future<FeatureDefinition> _featureDefinition(
    Session session,
    int companyId,
    int definitionId,
  ) async {
    final row = await FeatureDefinition.db.findById(session, definitionId);
    if (row == null || row.companyId != companyId) {
      throw NotFoundException(message: '特徵定義不存在');
    }
    return row;
  }

  Future<int> _featureUsageCount(
    Session session,
    int companyId,
    String featureKey,
  ) async {
    final profiles = await CustomDeviceProfile.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
    );
    final devices = await Device.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
    );
    return profiles
            .where(
              (profile) => profile.features.any(
                (feature) => feature.key == featureKey,
              ),
            )
            .length +
        devices
            .where(
              (device) =>
                  device.features?.any(
                    (feature) => feature.key == featureKey,
                  ) ??
                  false,
            )
            .length;
  }

  FeatureDefinition _definitionFromFeature(
    int companyId,
    DeviceFeature feature, {
    int? id,
    DateTime? createdAt,
  }) {
    final now = DateTime.now().toUtc();
    return FeatureDefinition(
      id: id,
      companyId: companyId,
      featureKey: feature.key,
      label: feature.label.trim(),
      unit: feature.unit.trim(),
      kind: feature.kind,
      dataType: feature.dataType,
      controlPresentation: feature.controlPresentation,
      enumOptions: feature.enumOptions,
      precision: feature.precision,
      description: feature.description?.trim(),
      minValue: feature.minValue,
      maxValue: feature.maxValue,
      defaultValue: feature.defaultValue,
      createdAt: createdAt ?? now,
      updatedAt: now,
    );
  }

  DeviceFeature _featureFromDefinition(FeatureDefinition row) => DeviceFeature(
    key: row.featureKey,
    label: row.label,
    unit: row.unit,
    kind: row.kind,
    dataType: row.dataType,
    controlPresentation: row.controlPresentation,
    enumOptions: row.enumOptions,
    precision: row.precision,
    description: row.description,
    minValue: row.minValue,
    maxValue: row.maxValue,
    defaultValue: row.defaultValue,
  );

  void _validateFeature(DeviceFeature feature) {
    if (!RegExp(r'^[A-Za-z][A-Za-z0-9_]{0,63}$').hasMatch(feature.key)) {
      throw ValidationException(message: '特徵代碼格式錯誤：${feature.key}');
    }
    if (feature.label.trim().isEmpty ||
        !feature.minValue.isFinite ||
        !feature.maxValue.isFinite ||
        feature.minValue > feature.maxValue) {
      throw ValidationException(message: '特徵名稱或上下限無效');
    }
    final defaultValue = feature.defaultValue;
    if (defaultValue != null &&
        (defaultValue < feature.minValue || defaultValue > feature.maxValue)) {
      throw ValidationException(message: '特徵預設值超出範圍');
    }
    if (feature.dataType == FeatureDataType.enumeration &&
        (feature.enumOptions == null || feature.enumOptions!.length < 2)) {
      throw ValidationException(message: '列舉特徵至少需要兩個狀態選項');
    }
    if (feature.kind == FeatureKind.control &&
        feature.controlPresentation == null) {
      throw ValidationException(message: '控制特徵必須指定操作介面');
    }
  }

  Future<void> _assertCurrentPassword(
    Session session,
    String? email,
    String? password,
  ) async {
    if (email == null ||
        email.trim().isEmpty ||
        password == null ||
        password.isEmpty) {
      throw ValidationException(message: '請輸入目前帳號 Email 與密碼');
    }
    try {
      final verifiedUserId = await AuthServices
          .instance
          .emailIdp
          .utils
          .authentication
          .authenticate(
            session,
            email: email.trim(),
            password: password,
            transaction: null,
          );
      if (verifiedUserId.toString() != session.authenticated!.userIdentifier) {
        throw ValidationException(message: '密碼驗證帳號與目前登入者不符');
      }
    } on ValidationException {
      rethrow;
    } catch (_) {
      throw ValidationException(message: 'Email 或密碼錯誤，無法刪除');
    }
  }

  String _validateProfile(
    String profileKey,
    String name,
    List<DeviceFeature> features,
  ) {
    final key = profileKey.trim();
    if (!RegExp(r'^[a-z][a-z0-9_]{2,47}$').hasMatch(key)) {
      throw ValidationException(message: '型別代碼需為 3–48 字元的小寫英文、數字或底線');
    }
    if (name.trim().isEmpty || name.trim().length > 80) {
      throw ValidationException(message: '名稱不可為空且最多 80 字元');
    }
    if (features.isEmpty || features.length > 64) {
      throw ValidationException(message: '特徵數量必須介於 1–64');
    }
    final keys = <String>{};
    for (final feature in features) {
      if (!keys.add(feature.key)) {
        throw ValidationException(message: '特徵代碼重複：${feature.key}');
      }
      _validateFeature(feature);
    }
    return key;
  }

  String _categoryFor(List<DeviceFeature> features) {
    final hasMeasurement = features.any(
      (feature) => feature.kind == FeatureKind.measurement,
    );
    final hasControl = features.any(
      (feature) => feature.kind == FeatureKind.control,
    );
    if (hasMeasurement && hasControl) return 'mixed';
    if (hasControl) return 'controller';
    return 'sensor';
  }
}
