import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// 租戶解析與範圍檢查。
///
/// 垂直切片階段僅支援單一公司與單一角色；完整 Membership → Role →
/// Permission → Scope 授權鏈於第二階段實作（見 docs/backend/api-rules.md）。
class TenantService {
  static const _adminPermissions = PlatformPermission.values;
  static const _maintainerPermissions = <PlatformPermission>[
    PlatformPermission.settingsRead,
    PlatformPermission.deviceRead,
    PlatformPermission.deviceControl,
    PlatformPermission.deviceManage,
    PlatformPermission.automationManage,
    PlatformPermission.auditRead,
  ];
  static const _viewerPermissions = <PlatformPermission>[
    PlatformPermission.settingsRead,
    PlatformPermission.deviceRead,
  ];

  static List<PlatformPermission> effectivePermissions(
    CompanyMembership membership,
  ) {
    if (!membership.isActive) return const [];
    if (membership.permissions != null) return membership.permissions!;
    return switch (membership.role ?? CompanyRole.admin) {
      CompanyRole.admin => _adminPermissions,
      CompanyRole.maintainer => _maintainerPermissions,
      CompanyRole.viewer => _viewerPermissions,
    };
  }

  static Future<CompanyMembership> currentMembership(Session session) async {
    final companyId = await resolveCompanyId(session);
    final membership = await CompanyMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.authUserId.equals(session.authenticated!.userIdentifier),
    );
    if (membership == null || !membership.isActive) {
      throw ValidationException(message: '帳戶已停用或不屬於此公司');
    }
    return membership;
  }

  static Future<int> assertPermission(
    Session session,
    PlatformPermission permission,
  ) async {
    final membership = await currentMembership(session);
    if (!effectivePermissions(membership).contains(permission)) {
      throw ValidationException(message: '此帳戶沒有執行該操作的權限');
    }
    return membership.companyId;
  }

  /// 解析目前登入使用者所屬的 companyId。
  ///
  /// 開發環境 bootstrap：使用者第一次呼叫 API 時若尚無隸屬關係，
  /// 自動加入第一間（demo）公司。正式環境應改為邀請制。
  static Future<int> resolveCompanyId(Session session) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw NotFoundException(message: '未登入');
    }

    final membership = await CompanyMembership.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(auth.userIdentifier),
    );
    if (membership != null) return membership.companyId;

    final company = await Company.db.findFirstRow(
      session,
      orderBy: (t) => t.id,
    );
    if (company == null) {
      throw NotFoundException(message: '尚未建立任何公司資料');
    }
    await CompanyMembership.db.insertRow(
      session,
      CompanyMembership(
        companyId: company.id!,
        authUserId: auth.userIdentifier,
        role: CompanyRole.viewer,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return company.id!;
  }

  /// 韌體檔案屬高風險資產，只有租戶管理者可新增、停用或清除。
  static Future<int> assertFirmwareAdmin(Session session) async {
    final companyId = await resolveCompanyId(session);
    final membership = await CompanyMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.authUserId.equals(session.authenticated!.userIdentifier),
    );
    // 既有開發資料沒有 role，為了 migration 相容視為 admin。
    if (membership == null ||
        (membership.role != null && membership.role != CompanyRole.admin)) {
      throw ValidationException(message: '此操作僅限公司管理者');
    }
    return companyId;
  }

  /// 確認場域屬於目前租戶，回傳場域。
  static Future<Site> assertSiteAccess(
    Session session,
    int companyId,
    int siteId,
  ) async {
    final site = await Site.db.findFirstRow(
      session,
      where: (t) => t.id.equals(siteId) & t.companyId.equals(companyId),
    );
    if (site == null) {
      throw NotFoundException(message: '場域不存在');
    }
    return site;
  }

  /// 確認閘道器屬於目前租戶，回傳閘道器。
  static Future<Gateway> assertGatewayAccess(
    Session session,
    int companyId,
    int gatewayId,
  ) async {
    final gateway = await Gateway.db.findFirstRow(
      session,
      where: (t) => t.id.equals(gatewayId) & t.companyId.equals(companyId),
    );
    if (gateway == null) {
      throw NotFoundException(message: '閘道器不存在');
    }
    return gateway;
  }

  /// 確認設備屬於目前租戶，回傳設備。
  static Future<Device> assertDeviceAccess(
    Session session,
    int companyId,
    int deviceId, {
    bool write = false,
  }) async {
    final device = await Device.db.findFirstRow(
      session,
      where: (t) => t.id.equals(deviceId) & t.companyId.equals(companyId),
    );
    if (device == null) {
      throw NotFoundException(message: '設備不存在');
    }
    final membership = await currentMembership(session);
    final permissions = effectivePermissions(membership);
    final globalPermission = write
        ? permissions.contains(PlatformPermission.deviceControl) ||
              permissions.contains(PlatformPermission.deviceManage)
        : permissions.contains(PlatformPermission.deviceRead);
    if (!globalPermission) {
      final share = await DeviceShare.db.findFirstRow(
        session,
        where: (t) =>
            t.companyId.equals(companyId) &
            t.deviceId.equals(deviceId) &
            t.membershipId.equals(membership.id!) &
            (write ? t.canWrite.equals(true) : t.canRead.equals(true)),
      );
      if (share == null) {
        throw ValidationException(message: write ? '沒有此設備的控制權限' : '沒有此設備的讀取權限');
      }
    }
    return device;
  }

  /// 將設備列表依目前帳戶的全域權限或逐設備分享範圍過濾。
  static Future<List<Device>> filterReadableDevices(
    Session session,
    List<Device> devices,
  ) async {
    if (devices.isEmpty) return devices;
    final membership = await currentMembership(session);
    if (effectivePermissions(
      membership,
    ).contains(PlatformPermission.deviceRead)) {
      return devices;
    }
    final shares = await DeviceShare.db.find(
      session,
      where: (t) =>
          t.membershipId.equals(membership.id!) & t.canRead.equals(true),
      limit: 1000,
    );
    final allowed = {for (final share in shares) share.deviceId};
    return devices.where((device) => allowed.contains(device.id)).toList();
  }
}
