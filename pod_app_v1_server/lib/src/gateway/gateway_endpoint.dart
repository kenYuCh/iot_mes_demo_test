import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../generated/protocol.dart';

/// 閘道器查詢與管理。
class GatewayEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 註冊閘道器（序號全平台唯一）。
  Future<Gateway> createGateway(
    Session session,
    int siteId,
    String serialNumber,
    String name,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    await TenantService.assertSiteAccess(session, companyId, siteId);

    final serial = serialNumber.trim();
    final trimmedName = name.trim();
    if (serial.isEmpty || trimmedName.isEmpty) {
      throw ValidationException(message: '序號與名稱不可為空');
    }
    final existing = await Gateway.db.findFirstRow(
      session,
      where: (t) => t.serialNumber.equals(serial),
    );
    if (existing != null) {
      throw ValidationException(message: '序號 $serial 已被註冊');
    }

    return Gateway.db.insertRow(
      session,
      Gateway(
        companyId: companyId,
        siteId: siteId,
        serialNumber: serial,
        name: trimmedName,
        connectionState: DeviceConnectionState.unknown,
        lastSeenAt: null,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// 更新閘道器名稱。
  Future<Gateway> updateGateway(
    Session session,
    int gatewayId,
    String name,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final gateway = await TenantService.assertGatewayAccess(
      session,
      companyId,
      gatewayId,
    );
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw ValidationException(message: '名稱不可為空');
    }
    return Gateway.db.updateRow(session, gateway.copyWith(name: trimmed));
  }

  /// 刪除閘道器。底下仍有設備時拒絕。
  Future<void> deleteGateway(Session session, int gatewayId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final gateway = await TenantService.assertGatewayAccess(
      session,
      companyId,
      gatewayId,
    );
    final deviceCount = await Device.db.count(
      session,
      where: (t) => t.gatewayId.equals(gatewayId),
    );
    if (deviceCount > 0) {
      throw ValidationException(message: '閘道器底下仍有 $deviceCount 台設備，請先移除');
    }
    await Gateway.db.deleteRow(session, gateway);
  }

  /// 列出場域底下的 Gateway。
  Future<List<Gateway>> listBySite(Session session, int siteId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    await TenantService.assertSiteAccess(session, companyId, siteId);
    return Gateway.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & t.siteId.equals(siteId),
      orderBy: (t) => t.createdAt,
      limit: 100,
    );
  }
}
