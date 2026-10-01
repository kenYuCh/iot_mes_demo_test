import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../generated/protocol.dart';

/// 場域查詢與管理。
class SiteEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 建立場域。
  Future<Site> createSite(
    Session session,
    String name,
    String? description,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw ValidationException(message: '場域名稱不可為空');
    }
    return Site.db.insertRow(
      session,
      Site(
        companyId: companyId,
        name: trimmed,
        description: description?.trim().isEmpty ?? true
            ? null
            : description!.trim(),
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// 更新場域名稱與描述。
  Future<Site> updateSite(
    Session session,
    int siteId,
    String name,
    String? description,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final site = await TenantService.assertSiteAccess(
      session,
      companyId,
      siteId,
    );
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw ValidationException(message: '場域名稱不可為空');
    }
    return Site.db.updateRow(
      session,
      site.copyWith(
        name: trimmed,
        description: description?.trim().isEmpty ?? true
            ? null
            : description!.trim(),
      ),
    );
  }

  /// 刪除場域。場域內仍有閘道器或設備時拒絕，避免誤刪整批資料。
  Future<void> deleteSite(Session session, int siteId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final site = await TenantService.assertSiteAccess(
      session,
      companyId,
      siteId,
    );

    final gatewayCount = await Gateway.db.count(
      session,
      where: (t) => t.siteId.equals(siteId),
    );
    final deviceCount = await Device.db.count(
      session,
      where: (t) => t.siteId.equals(siteId),
    );
    if (gatewayCount > 0 || deviceCount > 0) {
      throw ValidationException(
        message: '場域內仍有 $gatewayCount 台閘道器、$deviceCount 台設備，請先移除',
      );
    }
    final openWorkOrders = await WorkOrder.db.count(
      session,
      where: (t) =>
          t.siteId.equals(siteId) &
          t.status.inSet({WorkOrderStatus.open, WorkOrderStatus.inProgress}),
    );
    if (openWorkOrders > 0) {
      throw ValidationException(
        message: '場域內仍有 $openWorkOrders 張未結案工單，請先結案',
      );
    }

    await session.db.transaction((transaction) async {
      await WorkOrder.db.deleteWhere(
        session,
        where: (t) => t.siteId.equals(siteId),
        transaction: transaction,
      );
      await ProductionStat.db.deleteWhere(
        session,
        where: (t) => t.siteId.equals(siteId),
        transaction: transaction,
      );
      await Site.db.deleteRow(session, site, transaction: transaction);
    });
  }

  /// 列出目前租戶的場域（場域數量有限，單頁上限 100）。
  Future<List<Site>> listSites(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    return Site.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.createdAt,
      limit: 100,
    );
  }

  /// 取得單一場域。
  Future<Site> getSite(Session session, int siteId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    return TenantService.assertSiteAccess(session, companyId, siteId);
  }
}
