import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import 'tenant_service.dart';

/// 公司成員、模組權限與逐設備分享管理。
class AccessEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<MemberAccessSummary> getMyAccess(Session session) async {
    final member = await TenantService.currentMembership(session);
    return _summary(session, member, currentUser: true);
  }

  Future<List<MemberAccessSummary>> listMembers(Session session) async {
    final companyId = await TenantService.assertPermission(
      session,
      PlatformPermission.settingsRead,
    );
    final current = session.authenticated!.userIdentifier;
    final members = await CompanyMembership.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.createdAt,
      limit: 200,
    );
    return Future.wait([
      for (final member in members)
        _summary(session, member, currentUser: member.authUserId == current),
    ]);
  }

  Future<MemberAccessSummary> addMember(
    Session session,
    String email,
    String? displayName,
    CompanyRole role,
    List<PlatformPermission> permissions,
  ) async {
    final companyId = await TenantService.assertPermission(
      session,
      PlatformPermission.settingsWrite,
    );
    final normalized = email.trim().toLowerCase();
    final account = await AuthServices.instance.emailIdp.admin.findAccount(
      session,
      email: normalized,
    );
    if (account == null) {
      throw ValidationException(message: '此 Email 尚未註冊平台帳戶');
    }
    final authUserId = account.authUserId.toString();
    final existing = await CompanyMembership.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing != null) throw ValidationException(message: '此帳戶已加入公司');
    final member = await CompanyMembership.db.insertRow(
      session,
      CompanyMembership(
        companyId: companyId,
        authUserId: authUserId,
        role: role,
        permissions: permissions,
        email: normalized,
        displayName: displayName?.trim(),
        isActive: true,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return _summary(session, member, currentUser: false);
  }

  Future<MemberAccessSummary> updateMember(
    Session session,
    int membershipId,
    CompanyRole role,
    List<PlatformPermission> permissions,
    bool isActive,
  ) async {
    final companyId = await TenantService.assertPermission(
      session,
      PlatformPermission.settingsWrite,
    );
    final member = await CompanyMembership.db.findFirstRow(
      session,
      where: (t) => t.id.equals(membershipId) & t.companyId.equals(companyId),
    );
    if (member == null) throw NotFoundException(message: '公司成員不存在');
    if (member.authUserId == session.authenticated!.userIdentifier &&
        !isActive) {
      throw ValidationException(message: '不可停用自己的帳戶');
    }
    final updated = await CompanyMembership.db.updateRow(
      session,
      member.copyWith(role: role, permissions: permissions, isActive: isActive),
    );
    return _summary(
      session,
      updated,
      currentUser: updated.authUserId == session.authenticated!.userIdentifier,
    );
  }

  Future<void> setDeviceShare(
    Session session,
    int deviceId,
    int membershipId,
    bool canRead,
    bool canWrite,
  ) async {
    final companyId = await TenantService.assertPermission(
      session,
      PlatformPermission.deviceManage,
    );
    await TenantService.assertDeviceAccess(session, companyId, deviceId);
    final member = await CompanyMembership.db.findFirstRow(
      session,
      where: (t) => t.id.equals(membershipId) & t.companyId.equals(companyId),
    );
    if (member == null) throw NotFoundException(message: '公司成員不存在');
    final existing = await DeviceShare.db.findFirstRow(
      session,
      where: (t) =>
          t.deviceId.equals(deviceId) & t.membershipId.equals(membershipId),
    );
    if (!canRead && !canWrite) {
      if (existing != null) await DeviceShare.db.deleteRow(session, existing);
      return;
    }
    final now = DateTime.now().toUtc();
    final row = DeviceShare(
      id: existing?.id,
      companyId: companyId,
      deviceId: deviceId,
      membershipId: membershipId,
      canRead: canRead || canWrite,
      canWrite: canWrite,
      createdBy: existing?.createdBy ?? session.authenticated!.userIdentifier,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    if (existing == null) {
      await DeviceShare.db.insertRow(session, row);
    } else {
      await DeviceShare.db.updateRow(session, row);
    }
  }

  Future<MemberAccessSummary> _summary(
    Session session,
    CompanyMembership member, {
    required bool currentUser,
  }) async {
    final shares = await DeviceShare.db.find(
      session,
      where: (t) => t.membershipId.equals(member.id!),
      limit: 500,
    );
    return MemberAccessSummary(
      membershipId: member.id!,
      email: member.email ?? member.authUserId,
      displayName: member.displayName,
      role: member.role ?? CompanyRole.admin,
      permissions: TenantService.effectivePermissions(member),
      isActive: member.isActive,
      sharedDeviceIds: [
        for (final share in shares.where((s) => s.canRead)) share.deviceId,
      ],
      writableDeviceIds: [
        for (final share in shares.where((s) => s.canWrite)) share.deviceId,
      ],
      isCurrentUser: currentUser,
    );
  }
}
