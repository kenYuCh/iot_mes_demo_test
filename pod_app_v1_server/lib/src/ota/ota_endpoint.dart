import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../device/device_presence_service.dart';
import '../generated/protocol.dart';
import '../mqtt/mqtt_bridge.dart';

/// OTA 韌體與灰度發布管理。
///
/// 此 Endpoint 管理可稽核的發布 Metadata 與單機 Job。實際檔案上傳應由
/// Object Storage 的短效簽名 URL 完成；裝置下載前必須驗證 SHA-256 與簽章。
class OtaEndpoint extends Endpoint {
  static const _maxTargets = 500;

  @override
  bool get requireLogin => true;

  Future<void> _finishCampaignIfTerminal(
    Session session,
    int campaignId,
  ) async {
    final campaign = await OtaCampaign.db.findById(session, campaignId);
    if (campaign == null) return;
    final jobs = await OtaDeviceJob.db.find(
      session,
      where: (t) => t.campaignId.equals(campaignId),
      limit: _maxTargets,
    );
    final succeeded = jobs
        .where((job) => job.state == OtaJobState.succeeded)
        .length;
    final failed = jobs
        .where(
          (job) =>
              job.state == OtaJobState.failed ||
              job.state == OtaJobState.rolledBack,
        )
        .length;
    final cancelled = jobs
        .where((job) => job.state == OtaJobState.cancelled)
        .length;
    if (succeeded + failed + cancelled != jobs.length) return;
    await OtaCampaign.db.updateRow(
      session,
      campaign.copyWith(
        state: failed > 0
            ? OtaCampaignState.failed
            : OtaCampaignState.completed,
        succeededDevices: succeeded,
        failedDevices: failed,
        completedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<bool> canManageFirmware(Session session) async {
    try {
      await TenantService.assertFirmwareAdmin(session);
      return true;
    } on ValidationException {
      return false;
    }
  }

  Future<List<FirmwarePackage>> listFirmwarePackages(
    Session session, {
    String? deviceType,
  }) async {
    final companyId = await TenantService.resolveCompanyId(session);
    return FirmwarePackage.db.find(
      session,
      where: (t) {
        var expression = t.companyId.equals(companyId);
        if (deviceType != null && deviceType.trim().isNotEmpty) {
          expression =
              expression & t.targetDeviceType.equals(deviceType.trim());
        }
        return expression;
      },
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 100,
    );
  }

  Future<List<FirmwareReleaseDetail>> listFirmwareReleases(
    Session session,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final releases = await FirmwarePackage.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 100,
    );
    final ids = releases.map((release) => release.id!).toSet();
    final artifacts = ids.isEmpty
        ? <FirmwareArtifact>[]
        : await FirmwareArtifact.db.find(
            session,
            where: (t) =>
                t.companyId.equals(companyId) & t.firmwarePackageId.inSet(ids),
            orderBy: (t) => t.fileName,
          );
    return [
      for (final release in releases)
        FirmwareReleaseDetail(
          release: release,
          artifacts: artifacts
              .where((item) => item.firmwarePackageId == release.id)
              .toList(),
        ),
    ];
  }

  Future<FirmwarePackage> createFirmwarePackage(
    Session session,
    String name,
    String version,
    String targetDeviceType,
    String? hardwareRevision,
    String? releaseNotes,
    String downloadUrl,
    String sha256,
    int sizeBytes,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final cleanVersion = version.trim();
    final cleanType = targetDeviceType.trim();
    final cleanSha = sha256.trim().toLowerCase();
    if (name.trim().isEmpty || cleanType.isEmpty) {
      throw ValidationException(message: '套件名稱與目標設備類型不可為空');
    }
    if (!RegExp(
      r'^\d+\.\d+\.\d+([+-][0-9A-Za-z.-]+)?$',
    ).hasMatch(cleanVersion)) {
      throw ValidationException(message: '韌體版本必須使用 SemVer，例如 1.4.0');
    }
    if (!RegExp(r'^[0-9a-f]{64}$').hasMatch(cleanSha)) {
      throw ValidationException(message: 'SHA-256 必須是 64 位十六進位字串');
    }
    final uri = Uri.tryParse(downloadUrl.trim());
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'https' && uri.host != 'localhost')) {
      throw ValidationException(message: '韌體下載位址必須使用 HTTPS');
    }
    if (sizeBytes <= 0 || sizeBytes > 1024 * 1024 * 1024) {
      throw ValidationException(message: '韌體大小必須介於 1 byte 與 1 GiB');
    }

    return FirmwarePackage.db.insertRow(
      session,
      FirmwarePackage(
        companyId: companyId,
        name: name.trim(),
        version: cleanVersion,
        targetDeviceType: cleanType,
        hardwareRevision: _optional(hardwareRevision),
        releaseNotes: _optional(releaseNotes),
        downloadUrl: uri.toString(),
        sha256: cleanSha,
        sizeBytes: sizeBytes,
        state: FirmwarePackageState.ready,
        createdBy: session.authenticated!.userIdentifier,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// 登錄已放入 Server 韌體目錄的 .bin，雜湊與大小一律由 Server 計算。
  Future<FirmwarePackage> importFirmwareBinary(
    Session session,
    String name,
    String version,
    String targetDeviceType,
    String? hardwareRevision,
    String? releaseNotes,
    String fileName,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final safeName = fileName.trim();
    if (!RegExp(r'^[A-Za-z0-9._-]+\.bin$').hasMatch(safeName)) {
      throw ValidationException(message: '檔名只能包含英數、._-，且副檔名必須為 .bin');
    }
    final root = Directory(
      Platform.environment['FIRMWARE_STORAGE_PATH'] ?? 'storage/firmware',
    ).absolute;
    await root.create(recursive: true);
    final file = File('${root.path}/$safeName');
    if (!await file.exists()) {
      throw NotFoundException(message: 'Server 韌體目錄找不到 $safeName');
    }
    final bytes = await file.readAsBytes();
    if (bytes.isEmpty) throw ValidationException(message: '韌體檔案不可為空');
    final cleanVersion = version.trim();
    final cleanType = targetDeviceType.trim();
    if (name.trim().isEmpty || cleanType.isEmpty) {
      throw ValidationException(message: '套件名稱與設備類型不可為空');
    }
    if (!RegExp(
      r'^\d+\.\d+\.\d+([+-][0-9A-Za-z.-]+)?$',
    ).hasMatch(cleanVersion)) {
      throw ValidationException(message: '韌體版本必須使用 SemVer，例如 1.4.0');
    }
    if (cleanType.toLowerCase().contains('esp32')) {
      _validateEsp32EmbeddedVersion(bytes, cleanVersion);
    }
    final existing = await FirmwarePackage.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.targetDeviceType.equals(cleanType) &
          t.version.equals(cleanVersion),
    );
    if (existing != null) throw ValidationException(message: '此設備類型與版本已存在');
    return FirmwarePackage.db.insertRow(
      session,
      FirmwarePackage(
        companyId: companyId,
        name: name.trim(),
        version: cleanVersion,
        targetDeviceType: cleanType,
        hardwareRevision: _optional(hardwareRevision),
        releaseNotes: _optional(releaseNotes),
        downloadUrl: '/firmware/$safeName',
        fileName: safeName,
        storagePath: file.absolute.path,
        sha256: sha256.convert(bytes).toString(),
        sizeBytes: bytes.length,
        state: FirmwarePackageState.ready,
        createdBy: session.authenticated!.userIdentifier,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// 從管理端直接上傳韌體檔案，寫入 Server storage 後建立版本資產。
  ///
  /// 開發環境先透過 Serverpod request 傳輸；正式環境可再替換成 Object
  /// Storage signed URL，而不影響 FirmwarePackage / FirmwareArtifact 結構。
  Future<FirmwareReleaseDetail> uploadFirmwareRelease(
    Session session,
    String name,
    String version,
    String productKey,
    String targetDeviceType,
    String chipFamily,
    String updateProtocol,
    String? hardwareRevision,
    String? releaseNotes,
    List<String> fileNames,
    List<ByteData> fileContents,
    int primaryFileIndex,
  ) async {
    await TenantService.assertFirmwareAdmin(session);
    if (fileNames.isEmpty || fileNames.length != fileContents.length) {
      throw ValidationException(message: '請選擇至少一個完整的韌體檔案');
    }
    if (primaryFileIndex < 0 || primaryFileIndex >= fileNames.length) {
      throw ValidationException(message: '主要 OTA 檔案選擇無效');
    }
    if (fileNames.length > 5) {
      throw ValidationException(message: '單一版本最多可上傳 5 個檔案');
    }

    const maxFileBytes = 32 * 1024 * 1024;
    const maxReleaseBytes = 64 * 1024 * 1024;
    var totalBytes = 0;
    final allowed = RegExp(r'^[A-Za-z0-9._-]+\.(bin|hex|zip|json|sig)$');
    for (var index = 0; index < fileNames.length; index++) {
      final fileName = fileNames[index].trim();
      final size = fileContents[index].lengthInBytes;
      if (!allowed.hasMatch(fileName.toLowerCase())) {
        throw ValidationException(
          message: '$fileName：僅支援 bin、hex、zip、json、sig',
        );
      }
      if (size <= 0 || size > maxFileBytes) {
        throw ValidationException(message: '$fileName：檔案必須介於 1 byte～32 MiB');
      }
      totalBytes += size;
    }
    if (totalBytes > maxReleaseBytes) {
      throw ValidationException(message: '單一版本檔案總量不可超過 64 MiB');
    }

    final safeProduct = productKey.trim().replaceAll(
      RegExp(r'[^A-Za-z0-9_-]'),
      '_',
    );
    final safeVersion = version.trim().replaceAll(
      RegExp(r'[^A-Za-z0-9_.-]'),
      '_',
    );
    final uploadId = DateTime.now().toUtc().microsecondsSinceEpoch;
    final storedNames = <String>[];
    final writtenFiles = <File>[];
    final root = Directory(
      Platform.environment['FIRMWARE_STORAGE_PATH'] ?? 'storage/firmware',
    ).absolute;
    await root.create(recursive: true);

    try {
      for (var index = 0; index < fileNames.length; index++) {
        final original = fileNames[index].trim();
        final storedName =
            '${safeProduct}_${safeVersion}_${uploadId}_$original';
        final file = File('${root.path}/$storedName');
        final data = fileContents[index];
        await file.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          flush: true,
        );
        storedNames.add(storedName);
        writtenFiles.add(file);
      }
      return await importFirmwareRelease(
        session,
        name,
        version,
        productKey,
        targetDeviceType,
        chipFamily,
        updateProtocol,
        hardwareRevision,
        releaseNotes,
        storedNames,
        storedNames[primaryFileIndex],
      );
    } catch (_) {
      for (final file in writtenFiles) {
        if (await file.exists()) await file.delete();
      }
      rethrow;
    }
  }

  /// 將同一版本的多個產物（HEX/BIN/ZIP/manifest/signature）登錄為一個 Release。
  Future<FirmwareReleaseDetail> importFirmwareRelease(
    Session session,
    String name,
    String version,
    String productKey,
    String targetDeviceType,
    String chipFamily,
    String updateProtocol,
    String? hardwareRevision,
    String? releaseNotes,
    List<String> fileNames,
    String primaryFileName,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final names = fileNames.map((name) => name.trim()).toSet().toList();
    if (names.isEmpty || !names.contains(primaryFileName.trim())) {
      throw ValidationException(message: '至少需要一個檔案，且必須指定主要 OTA 產物');
    }
    final allowed = RegExp(r'^[A-Za-z0-9._-]+\.(bin|hex|zip|json|sig)$');
    if (names.any((name) => !allowed.hasMatch(name.toLowerCase()))) {
      throw ValidationException(message: '僅支援 bin、hex、zip、json、sig 檔案');
    }
    final root = Directory(
      Platform.environment['FIRMWARE_STORAGE_PATH'] ?? 'storage/firmware',
    ).absolute;
    final files = <String, File>{};
    final contents = <String, List<int>>{};
    for (final fileName in names) {
      final file = File('${root.path}/$fileName');
      if (!await file.exists()) {
        throw NotFoundException(message: 'Server 韌體目錄找不到 $fileName');
      }
      files[fileName] = file;
      contents[fileName] = await file.readAsBytes();
      if (contents[fileName]!.isEmpty) {
        throw ValidationException(message: '$fileName 是空檔案');
      }
    }
    final primary = primaryFileName.trim();
    final primaryBytes = contents[primary]!;
    if (chipFamily.toLowerCase().startsWith('esp32') &&
        (primary.toLowerCase().endsWith('.bin') &&
            primaryBytes.first != 0xe9)) {
      throw ValidationException(
        message: '主要檔案不是有效的 ESP32 image（缺少 0xE9 header）',
      );
    }
    final hexName = names
        .where((name) => name.toLowerCase().endsWith('.hex'))
        .firstOrNull;
    final binName = names
        .where((name) => name.toLowerCase().endsWith('.bin'))
        .firstOrNull;
    if (hexName != null && binName != null) {
      final decoded = _decodeIntelHex(contents[hexName]!);
      if (decoded == null || !_sameBytes(decoded, contents[binName]!)) {
        throw ValidationException(message: 'HEX 與 BIN 內容不一致或 HEX 格式無效');
      }
    }
    final cleanVersion = version.trim();
    if (!RegExp(
      r'^\d+\.\d+\.\d+([+-][0-9A-Za-z.-]+)?$',
    ).hasMatch(cleanVersion)) {
      throw ValidationException(message: '韌體版本必須使用 SemVer，例如 1.4.0');
    }
    if (chipFamily.toLowerCase().startsWith('esp32') &&
        primary.toLowerCase().endsWith('.bin')) {
      _validateEsp32EmbeddedVersion(primaryBytes, cleanVersion);
    }
    final existing = await FirmwarePackage.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.targetDeviceType.equals(targetDeviceType.trim()) &
          t.version.equals(cleanVersion),
    );
    if (existing != null) throw ValidationException(message: '此設備類型與版本已存在');

    late FirmwarePackage release;
    late List<FirmwareArtifact> artifacts;
    await session.db.transaction((transaction) async {
      release = await FirmwarePackage.db.insertRow(
        session,
        FirmwarePackage(
          companyId: companyId,
          name: name.trim(),
          version: cleanVersion,
          productKey: productKey.trim(),
          targetDeviceType: targetDeviceType.trim(),
          chipFamily: chipFamily.trim().toLowerCase(),
          updateProtocol: updateProtocol.trim().toLowerCase(),
          hardwareRevision: _optional(hardwareRevision),
          releaseNotes: _optional(releaseNotes),
          downloadUrl: '/firmware/$primary',
          fileName: primary,
          storagePath: files[primary]!.absolute.path,
          sha256: sha256.convert(primaryBytes).toString(),
          sizeBytes: primaryBytes.length,
          state: FirmwarePackageState.ready,
          createdBy: session.authenticated!.userIdentifier,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      artifacts = await FirmwareArtifact.db.insert(
        session,
        [
          for (final fileName in names)
            FirmwareArtifact(
              companyId: companyId,
              firmwarePackageId: release.id!,
              fileName: fileName,
              fileType: fileName.split('.').last.toLowerCase(),
              core: chipFamily.toLowerCase() == 'nrf5340'
                  ? 'application'
                  : 'single',
              storagePath: files[fileName]!.absolute.path,
              sha256: sha256.convert(contents[fileName]!).toString(),
              sizeBytes: contents[fileName]!.length,
              isPrimary: fileName == primary,
              createdAt: DateTime.now().toUtc(),
            ),
        ],
        transaction: transaction,
      );
    });
    return FirmwareReleaseDetail(release: release, artifacts: artifacts);
  }

  Future<bool> deleteFirmwareArtifact(Session session, int artifactId) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final artifact = await FirmwareArtifact.db.findFirstRow(
      session,
      where: (t) => t.id.equals(artifactId) & t.companyId.equals(companyId),
    );
    if (artifact == null) throw NotFoundException(message: '韌體檔案不存在');
    if (artifact.isPrimary) {
      throw ValidationException(message: '主要 OTA 產物不可單獨刪除');
    }
    final file = File(artifact.storagePath);
    if (await file.exists()) await file.delete();
    await FirmwareArtifact.db.updateRow(
      session,
      artifact.copyWith(deletedAt: DateTime.now().toUtc()),
    );
    return true;
  }

  /// 清除 Server 上的 .bin。已被發布引用時保留 Metadata 與歷史稽核。
  Future<bool> deleteFirmwareBinary(Session session, int packageId) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final package = await FirmwarePackage.db.findFirstRow(
      session,
      where: (t) => t.id.equals(packageId) & t.companyId.equals(companyId),
    );
    if (package == null) throw NotFoundException(message: '韌體版本不存在');
    final activeCampaign = await OtaCampaign.db.findFirstRow(
      session,
      where: (t) =>
          t.firmwarePackageId.equals(packageId) &
          (t.state.equals(OtaCampaignState.running) |
              t.state.equals(OtaCampaignState.scheduled)),
    );
    if (activeCampaign != null) {
      throw ValidationException(message: '韌體正在發布或已排程，無法清除');
    }
    final path = package.storagePath;
    if (path != null) {
      final file = File(path);
      if (await file.exists()) await file.delete();
    }
    final referenced = await OtaCampaign.db.findFirstRow(
      session,
      where: (t) => t.firmwarePackageId.equals(packageId),
    );
    if (referenced == null) {
      await FirmwarePackage.db.deleteRow(session, package);
    } else {
      await FirmwarePackage.db.updateRow(
        session,
        package.copyWith(
          state: FirmwarePackageState.deprecated,
          storagePath: null,
          deletedAt: DateTime.now().toUtc(),
          deletedBy: session.authenticated!.userIdentifier,
        ),
      );
    }
    return true;
  }

  Future<List<OtaCampaign>> listCampaigns(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    return OtaCampaign.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 100,
    );
  }

  /// 統一列出可更新的感測／致動設備與 Gateway，供前端以實體設備選版本。
  Future<List<OtaTarget>> listTargets(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final devices = await Device.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.name,
      limit: _maxTargets,
    );
    final gateways = await Gateway.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.name,
      limit: _maxTargets,
    );
    final deviceStatuses = await DevicePresenceService.refresh(
      session,
      devices,
      await DeviceStatus.db.find(
        session,
        where: (t) => t.companyId.equals(companyId),
      ),
    );
    final deviceState = {
      for (final status in deviceStatuses)
        status.deviceId: status.connectionState,
    };
    return [
      for (final gateway in gateways)
        OtaTarget(
          targetKey: 'gateway:${gateway.id}',
          targetKind: 'gateway',
          targetId: gateway.id!,
          serialNumber: gateway.serialNumber,
          name: gateway.name,
          model: gateway.model ?? 'Gateway',
          productKey: gateway.productKey ?? 'gateway_controller',
          chipFamily: gateway.chipFamily,
          updateProtocol: gateway.updateProtocol,
          hardwareRevision: gateway.hardwareRevision,
          firmwareVersion: gateway.firmwareVersion,
          connectionState: gateway.connectionState,
        ),
      for (final device in devices)
        OtaTarget(
          targetKey: 'device:${device.id}',
          targetKind: 'device',
          targetId: device.id!,
          name: device.name,
          model: device.model,
          productKey: device.deviceType,
          hardwareRevision: device.hardwareRevision,
          firmwareVersion: device.firmwareVersion,
          connectionState:
              deviceState[device.id] ?? DeviceConnectionState.unknown,
        ),
    ];
  }

  /// 取得單台設備尚未結束的 OTA，讓設備頁重開後能接續顯示進度。
  Future<OtaCampaignDetail?> getActiveDeviceCampaign(
    Session session,
    int deviceId,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final device = await Device.db.findFirstRow(
      session,
      where: (t) => t.id.equals(deviceId) & t.companyId.equals(companyId),
    );
    if (device == null) throw NotFoundException(message: '設備不存在');
    final jobs = await OtaDeviceJob.db.find(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.deviceId.equals(deviceId) &
          (t.state.equals(OtaJobState.pending) |
              t.state.equals(OtaJobState.downloading) |
              t.state.equals(OtaJobState.installing) |
              t.state.equals(OtaJobState.verifying)),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      limit: 20,
    );
    for (final job in jobs) {
      final campaign = await OtaCampaign.db.findById(session, job.campaignId);
      if (campaign == null ||
          (campaign.state != OtaCampaignState.running &&
              campaign.state != OtaCampaignState.scheduled &&
              campaign.state != OtaCampaignState.draft)) {
        continue;
      }
      final firmware = await FirmwarePackage.db.findById(
        session,
        campaign.firmwarePackageId,
      );
      if (firmware == null) continue;
      return OtaCampaignDetail(
        campaign: campaign,
        firmware: firmware,
        jobs: [job],
      );
    }
    return null;
  }

  /// 以統一 targetKey 建立任務，支援指定單台設備升級或降版。
  Future<OtaCampaign> createTargetCampaign(
    Session session,
    int firmwarePackageId,
    String name,
    OtaStrategy strategy,
    List<String> targetKeys,
    DateTime? scheduledAt,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final keys = targetKeys.map((value) => value.trim()).toSet();
    if (name.trim().isEmpty) {
      throw ValidationException(message: 'OTA 更新任務名稱不可為空');
    }
    if (keys.isEmpty || keys.length > _maxTargets) {
      throw ValidationException(message: '每次更新必須選擇 1～$_maxTargets 台設備');
    }
    final firmware = await FirmwarePackage.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(firmwarePackageId) &
          t.companyId.equals(companyId) &
          t.state.equals(FirmwarePackageState.ready),
    );
    if (firmware == null) {
      throw NotFoundException(message: '找不到可發布的韌體版本');
    }
    final deviceIds = <int>{};
    final gatewayIds = <int>{};
    for (final key in keys) {
      final parts = key.split(':');
      final id = parts.length == 2 ? int.tryParse(parts[1]) : null;
      if (id == null || (parts[0] != 'device' && parts[0] != 'gateway')) {
        throw ValidationException(message: 'OTA 目標格式無效：$key');
      }
      (parts[0] == 'device' ? deviceIds : gatewayIds).add(id);
    }
    final devices = deviceIds.isEmpty
        ? <Device>[]
        : await Device.db.find(
            session,
            where: (t) => t.companyId.equals(companyId) & t.id.inSet(deviceIds),
            limit: _maxTargets,
          );
    final gateways = gatewayIds.isEmpty
        ? <Gateway>[]
        : await Gateway.db.find(
            session,
            where: (t) =>
                t.companyId.equals(companyId) & t.id.inSet(gatewayIds),
            limit: _maxTargets,
          );
    if (devices.length != deviceIds.length ||
        gateways.length != gatewayIds.length) {
      throw ValidationException(message: '部分設備不存在或不屬於目前公司');
    }
    final incompatibleDevice = devices.any(
      (device) =>
          device.deviceType != firmware.targetDeviceType ||
          (firmware.hardwareRevision != null &&
              device.hardwareRevision != firmware.hardwareRevision),
    );
    final incompatibleGateway = gateways.any(
      (gateway) =>
          gateway.productKey != firmware.productKey ||
          (firmware.chipFamily != null &&
              gateway.chipFamily != firmware.chipFamily) ||
          (firmware.updateProtocol != null &&
              gateway.updateProtocol != firmware.updateProtocol) ||
          (firmware.hardwareRevision != null &&
              gateway.hardwareRevision != firmware.hardwareRevision),
    );
    if (incompatibleDevice || incompatibleGateway) {
      throw ValidationException(message: '部分設備與所選韌體版本不相容');
    }
    if (strategy == OtaStrategy.scheduled && scheduledAt == null) {
      throw ValidationException(message: '排程更新必須指定時間');
    }

    final activeJob = await OtaDeviceJob.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          ((deviceIds.isEmpty
                  ? t.deviceId.equals(-1)
                  : t.deviceId.inSet(deviceIds)) |
              (gatewayIds.isEmpty
                  ? t.gatewayId.equals(-1)
                  : t.gatewayId.inSet(gatewayIds))) &
          (t.state.equals(OtaJobState.pending) |
              t.state.equals(OtaJobState.downloading) |
              t.state.equals(OtaJobState.installing) |
              t.state.equals(OtaJobState.verifying)),
    );
    if (activeJob != null) {
      throw ValidationException(message: '所選設備已有進行中的 OTA，請等待完成或先處理既有任務');
    }

    final now = DateTime.now().toUtc();
    late OtaCampaign campaign;
    await session.db.transaction((transaction) async {
      campaign = await OtaCampaign.db.insertRow(
        session,
        OtaCampaign(
          companyId: companyId,
          firmwarePackageId: firmware.id!,
          name: name.trim(),
          targetDeviceType: firmware.targetDeviceType,
          strategy: strategy,
          state: strategy == OtaStrategy.scheduled
              ? OtaCampaignState.scheduled
              : OtaCampaignState.draft,
          scheduledAt: scheduledAt?.toUtc(),
          totalDevices: devices.length + gateways.length,
          succeededDevices: 0,
          failedDevices: 0,
          createdBy: session.authenticated!.userIdentifier,
          createdAt: now,
        ),
        transaction: transaction,
      );
      await OtaDeviceJob.db.insert(
        session,
        [
          for (final device in devices)
            OtaDeviceJob(
              companyId: companyId,
              campaignId: campaign.id!,
              deviceId: device.id,
              state: OtaJobState.pending,
              progress: 0,
              previousVersion: device.firmwareVersion,
              updatedAt: now,
            ),
          for (final gateway in gateways)
            OtaDeviceJob(
              companyId: companyId,
              campaignId: campaign.id!,
              gatewayId: gateway.id,
              state: OtaJobState.pending,
              progress: 0,
              previousVersion: gateway.firmwareVersion,
              updatedAt: now,
            ),
        ],
        transaction: transaction,
      );
    });
    return campaign;
  }

  Future<OtaCampaign> createCampaign(
    Session session,
    int firmwarePackageId,
    String name,
    OtaStrategy strategy,
    List<int> targetDeviceIds,
    DateTime? scheduledAt,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    if (name.trim().isEmpty) {
      throw ValidationException(message: '發布活動名稱不可為空');
    }
    final targetIds = targetDeviceIds.toSet();
    if (targetIds.isEmpty || targetIds.length > _maxTargets) {
      throw ValidationException(message: '每次發布必須選擇 1～$_maxTargets 台設備');
    }
    final firmware = await FirmwarePackage.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(firmwarePackageId) &
          t.companyId.equals(companyId) &
          t.state.equals(FirmwarePackageState.ready),
    );
    if (firmware == null) {
      throw NotFoundException(message: '找不到可發布的韌體套件');
    }
    final devices = await Device.db.find(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.id.inSet(targetIds) &
          t.deviceType.equals(firmware.targetDeviceType),
      limit: _maxTargets,
    );
    if (devices.length != targetIds.length) {
      throw ValidationException(message: '部分設備不存在、跨租戶或與韌體類型不相容');
    }
    if (firmware.hardwareRevision != null &&
        devices.any(
          (device) => device.hardwareRevision != firmware.hardwareRevision,
        )) {
      throw ValidationException(message: '部分設備硬體版次與韌體不相容');
    }
    if (strategy == OtaStrategy.scheduled && scheduledAt == null) {
      throw ValidationException(message: '排程發布必須指定時間');
    }

    final now = DateTime.now().toUtc();
    late OtaCampaign campaign;
    await session.db.transaction((transaction) async {
      campaign = await OtaCampaign.db.insertRow(
        session,
        OtaCampaign(
          companyId: companyId,
          firmwarePackageId: firmware.id!,
          name: name.trim(),
          targetDeviceType: firmware.targetDeviceType,
          strategy: strategy,
          state: strategy == OtaStrategy.scheduled
              ? OtaCampaignState.scheduled
              : OtaCampaignState.draft,
          scheduledAt: scheduledAt?.toUtc(),
          totalDevices: devices.length,
          succeededDevices: 0,
          failedDevices: 0,
          createdBy: session.authenticated!.userIdentifier,
          createdAt: now,
        ),
        transaction: transaction,
      );
      await OtaDeviceJob.db.insert(
        session,
        [
          for (final device in devices)
            OtaDeviceJob(
              companyId: companyId,
              campaignId: campaign.id!,
              deviceId: device.id!,
              state: OtaJobState.pending,
              progress: 0,
              previousVersion: device.firmwareVersion,
              updatedAt: now,
            ),
        ],
        transaction: transaction,
      );
    });
    return campaign;
  }

  Future<OtaCampaignDetail> getCampaign(Session session, int campaignId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final campaign = await OtaCampaign.db.findFirstRow(
      session,
      where: (t) => t.id.equals(campaignId) & t.companyId.equals(companyId),
    );
    if (campaign == null) throw NotFoundException(message: 'OTA 發布活動不存在');
    final firmware = await FirmwarePackage.db.findById(
      session,
      campaign.firmwarePackageId,
    );
    if (firmware == null || firmware.companyId != companyId) {
      throw NotFoundException(message: '韌體套件不存在');
    }
    final jobs = await OtaDeviceJob.db.find(
      session,
      where: (t) =>
          t.campaignId.equals(campaign.id!) & t.companyId.equals(companyId),
      orderBy: (t) => t.id,
      limit: _maxTargets,
    );
    return OtaCampaignDetail(
      campaign: campaign,
      firmware: firmware,
      jobs: jobs,
    );
  }

  /// 前端無進度 watchdog：只有 Job 的狀態與進度仍等於觀察值時才結束，
  /// 避免逾時請求與剛到達的設備進度更新互相覆蓋。
  Future<OtaCampaignDetail> stopStalledCampaign(
    Session session,
    int campaignId,
    int deviceId,
    OtaJobState expectedState,
    int expectedProgress,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final campaign = await OtaCampaign.db.findFirstRow(
      session,
      where: (t) => t.id.equals(campaignId) & t.companyId.equals(companyId),
    );
    if (campaign == null) throw NotFoundException(message: 'OTA 發布活動不存在');
    final job = await OtaDeviceJob.db.findFirstRow(
      session,
      where: (t) =>
          t.campaignId.equals(campaignId) &
          t.deviceId.equals(deviceId) &
          t.companyId.equals(companyId),
    );
    if (job == null) throw NotFoundException(message: 'OTA 設備任務不存在');
    final terminal = {
      OtaJobState.succeeded,
      OtaJobState.failed,
      OtaJobState.cancelled,
      OtaJobState.rolledBack,
    }.contains(job.state);
    if (!terminal &&
        job.state == expectedState &&
        job.progress == expectedProgress) {
      await OtaDeviceJob.db.updateRow(
        session,
        job.copyWith(
          state: OtaJobState.failed,
          errorMessage: '連續 30 秒沒有收到新的 OTA 進度',
          updatedAt: DateTime.now().toUtc(),
        ),
      );
      await _finishCampaignIfTerminal(session, campaignId);
    }
    return getCampaign(session, campaignId);
  }

  Future<OtaCampaign> startCampaign(Session session, int campaignId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final campaign = await OtaCampaign.db.findFirstRow(
      session,
      where: (t) => t.id.equals(campaignId) & t.companyId.equals(companyId),
    );
    if (campaign == null) throw NotFoundException(message: 'OTA 發布活動不存在');
    if (campaign.state != OtaCampaignState.draft &&
        campaign.state != OtaCampaignState.paused &&
        campaign.state != OtaCampaignState.scheduled) {
      throw ValidationException(message: '目前狀態無法開始發布');
    }
    final updated = await OtaCampaign.db.updateRow(
      session,
      campaign.copyWith(
        state: OtaCampaignState.running,
        startedAt: campaign.startedAt ?? DateTime.now().toUtc(),
      ),
    );
    final firmware = await FirmwarePackage.db.findById(
      session,
      campaign.firmwarePackageId,
    );
    final jobs = await OtaDeviceJob.db.find(
      session,
      where: (t) => t.campaignId.equals(campaignId),
      limit: _maxTargets,
    );
    if (firmware != null && mqttBridge != null) {
      for (final job in jobs) {
        final provisioned = await ProvisionedDevice.db.findFirstRow(
          session,
          where: (t) => job.deviceId != null
              ? t.linkedDeviceId.equals(job.deviceId)
              : t.linkedGatewayId.equals(job.gatewayId),
        );
        if (provisioned != null) {
          await mqttBridge!.publishOtaRequest(
            serial: provisioned.serial,
            campaignId: campaignId,
            firmware: firmware,
          );
        }
      }
    }
    return updated;
  }

  /// 開發環境 OTA 模擬：將既有活動重設為待下載，供 App 重播完整流程。
  ///
  /// 實機版本會改由 MQTT 指令觸發 ESP32，並由裝置上報相同的 Job 狀態。
  Future<OtaCampaign> restartSimulation(
    Session session,
    int campaignId,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final campaign = await OtaCampaign.db.findFirstRow(
      session,
      where: (t) => t.id.equals(campaignId) & t.companyId.equals(companyId),
    );
    if (campaign == null) throw NotFoundException(message: 'OTA 發布活動不存在');
    final jobs = await OtaDeviceJob.db.find(
      session,
      where: (t) =>
          t.campaignId.equals(campaignId) & t.companyId.equals(companyId),
      limit: _maxTargets,
    );
    if (jobs.isEmpty) throw ValidationException(message: '發布活動沒有目標設備');

    final now = DateTime.now().toUtc();
    await OtaDeviceJob.db.update(
      session,
      [
        for (final job in jobs)
          job.copyWith(
            state: OtaJobState.pending,
            progress: 0,
            errorMessage: null,
            updatedAt: now,
          ),
      ],
    );
    return OtaCampaign.db.updateRow(
      session,
      campaign.copyWith(
        state: OtaCampaignState.running,
        succeededDevices: 0,
        failedDevices: 0,
        startedAt: now,
        completedAt: null,
      ),
    );
  }

  /// 推進一次模擬裝置狀態：下載 → 寫入 OTA 分區 → 驗證 → 重啟成功。
  Future<OtaCampaignDetail> advanceSimulation(
    Session session,
    int campaignId,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    var campaign = await OtaCampaign.db.findFirstRow(
      session,
      where: (t) => t.id.equals(campaignId) & t.companyId.equals(companyId),
    );
    if (campaign == null) throw NotFoundException(message: 'OTA 發布活動不存在');
    final firmware = await FirmwarePackage.db.findById(
      session,
      campaign.firmwarePackageId,
    );
    if (firmware == null || firmware.companyId != companyId) {
      throw NotFoundException(message: '韌體套件不存在');
    }
    var jobs = await OtaDeviceJob.db.find(
      session,
      where: (t) =>
          t.campaignId.equals(campaignId) & t.companyId.equals(companyId),
      orderBy: (t) => t.id,
      limit: _maxTargets,
    );
    if (campaign.state != OtaCampaignState.running) {
      return OtaCampaignDetail(
        campaign: campaign,
        firmware: firmware,
        jobs: jobs,
      );
    }

    final now = DateTime.now().toUtc();
    final advanced = <OtaDeviceJob>[];
    for (final job in jobs) {
      final next = switch (job.state) {
        OtaJobState.pending => job.copyWith(
          state: OtaJobState.downloading,
          progress: 8,
          updatedAt: now,
        ),
        OtaJobState.downloading when job.progress < 68 => job.copyWith(
          progress: job.progress + 15,
          updatedAt: now,
        ),
        OtaJobState.downloading => job.copyWith(
          state: OtaJobState.installing,
          progress: 82,
          updatedAt: now,
        ),
        OtaJobState.installing => job.copyWith(
          state: OtaJobState.verifying,
          progress: 94,
          updatedAt: now,
        ),
        OtaJobState.verifying => job.copyWith(
          state: OtaJobState.succeeded,
          progress: 100,
          updatedAt: now,
        ),
        _ => job,
      };
      advanced.add(next);
      if (job.state == OtaJobState.verifying &&
          next.state == OtaJobState.succeeded) {
        if (job.deviceId != null) {
          final device = await Device.db.findFirstRow(
            session,
            where: (t) =>
                t.id.equals(job.deviceId) & t.companyId.equals(companyId),
          );
          if (device != null) {
            await Device.db.updateRow(
              session,
              device.copyWith(firmwareVersion: firmware.version),
            );
          }
        } else if (job.gatewayId != null) {
          final gateway = await Gateway.db.findFirstRow(
            session,
            where: (t) =>
                t.id.equals(job.gatewayId) & t.companyId.equals(companyId),
          );
          if (gateway != null) {
            await Gateway.db.updateRow(
              session,
              gateway.copyWith(firmwareVersion: firmware.version),
            );
          }
        }
      }
    }
    jobs = await OtaDeviceJob.db.update(session, advanced);
    final succeeded = jobs
        .where((job) => job.state == OtaJobState.succeeded)
        .length;
    final failed = jobs
        .where(
          (job) =>
              job.state == OtaJobState.failed ||
              job.state == OtaJobState.rolledBack,
        )
        .length;
    final finished = succeeded + failed == jobs.length;
    campaign = await OtaCampaign.db.updateRow(
      session,
      campaign.copyWith(
        state: finished
            ? (failed == 0
                  ? OtaCampaignState.completed
                  : OtaCampaignState.failed)
            : OtaCampaignState.running,
        succeededDevices: succeeded,
        failedDevices: failed,
        completedAt: finished ? now : null,
      ),
    );
    return OtaCampaignDetail(
      campaign: campaign,
      firmware: firmware,
      jobs: jobs,
    );
  }

  String? _optional(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  /// Reads `esp_app_desc_t.version` from an ESP-IDF application image.
  /// The descriptor starts with little-endian ESP_APP_DESC_MAGIC_WORD
  /// (0xABCD5432), followed by 12 bytes and a 32-byte NUL-terminated version.
  void _validateEsp32EmbeddedVersion(List<int> bytes, String declaredVersion) {
    const magic = <int>[0x32, 0x54, 0xcd, 0xab];
    for (var index = 0; index + 48 <= bytes.length; index++) {
      if (bytes[index] != magic[0] ||
          bytes[index + 1] != magic[1] ||
          bytes[index + 2] != magic[2] ||
          bytes[index + 3] != magic[3]) {
        continue;
      }
      final versionBytes = bytes.sublist(index + 16, index + 48);
      final terminator = versionBytes.indexOf(0);
      final embedded = String.fromCharCodes(
        terminator < 0 ? versionBytes : versionBytes.take(terminator),
      ).trim();
      if (embedded != declaredVersion) {
        throw ValidationException(
          message: 'ESP32 韌體內部版本為 $embedded，與填寫版本 $declaredVersion 不一致',
        );
      }
      return;
    }
    throw ValidationException(message: '無法讀取 ESP32 韌體內部版本，請確認 BIN 檔案');
  }

  List<int>? _decodeIntelHex(List<int> bytes) {
    try {
      final lines = String.fromCharCodes(bytes).split(RegExp(r'\r?\n'));
      final memory = <int, int>{};
      var base = 0;
      for (final line in lines.where((line) => line.isNotEmpty)) {
        if (!line.startsWith(':')) return null;
        final raw = <int>[
          for (var i = 1; i < line.length; i += 2)
            int.parse(line.substring(i, i + 2), radix: 16),
        ];
        if (raw.fold<int>(0, (sum, value) => sum + value) & 0xff != 0) {
          return null;
        }
        final count = raw[0];
        final address = (raw[1] << 8) | raw[2];
        final type = raw[3];
        if (type == 0) {
          for (var i = 0; i < count; i++) {
            memory[base + address + i] = raw[4 + i];
          }
        } else if (type == 4) {
          base = ((raw[4] << 8) | raw[5]) << 16;
        } else if (type == 2) {
          base = ((raw[4] << 8) | raw[5]) << 4;
        }
      }
      if (memory.isEmpty) return null;
      final first = memory.keys.reduce((a, b) => a < b ? a : b);
      final last = memory.keys.reduce((a, b) => a > b ? a : b);
      return [
        for (var address = first; address <= last; address++)
          memory[address] ?? 0xff,
      ];
    } catch (_) {
      return null;
    }
  }

  bool _sameBytes(List<int> left, List<int> right) {
    if (left.length != right.length) return false;
    for (var i = 0; i < left.length; i++) {
      if (left[i] != right[i]) return false;
    }
    return true;
  }
}
