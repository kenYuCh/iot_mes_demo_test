import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../generated/protocol.dart';

/// 巡檢與維修工單（Mobile CMMS，見 docs/product/enterprise-iot-platform-spec.md）。
///
/// 狀態機：open → inProgress → done / cancelled。
/// 拍照、掃碼與語音回傳需實體機，於 BLE/實機階段補上。
class WorkOrderEndpoint extends Endpoint {
  static const _defaultLimit = 30;
  static const _maxLimit = 100;

  @override
  bool get requireLogin => true;

  /// 手動開立工單。
  Future<WorkOrder> createWorkOrder(
    Session session,
    int siteId,
    int? deviceId,
    String title,
    String? description,
    WorkOrderPriority priority,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    await TenantService.assertSiteAccess(session, companyId, siteId);
    if (deviceId != null) {
      await TenantService.assertDeviceAccess(session, companyId, deviceId);
    }
    if (title.trim().isEmpty) {
      throw ValidationException(message: '工單標題不可為空');
    }

    return WorkOrder.db.insertRow(
      session,
      WorkOrder(
        companyId: companyId,
        siteId: siteId,
        deviceId: deviceId,
        title: title.trim(),
        description: description?.trim().isEmpty ?? true
            ? null
            : description!.trim(),
        status: WorkOrderStatus.open,
        priority: priority,
        createdBy: session.authenticated!.userIdentifier,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// 由告警轉開工單（產品規格「轉為維修工單」）。
  /// 冪等：同一告警已有工單時回傳既有工單。
  Future<WorkOrder> createFromAlert(Session session, int alertId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final alert = await Alert.db.findFirstRow(
      session,
      where: (t) => t.id.equals(alertId) & t.companyId.equals(companyId),
    );
    if (alert == null) {
      throw NotFoundException(message: '告警不存在');
    }

    final existing = await WorkOrder.db.findFirstRow(
      session,
      where: (t) => t.alertId.equals(alertId),
    );
    if (existing != null) return existing;

    final priority = switch (alert.severity) {
      AlertSeverity.emergency ||
      AlertSeverity.critical => WorkOrderPriority.urgent,
      AlertSeverity.major => WorkOrderPriority.high,
      AlertSeverity.warning => WorkOrderPriority.normal,
      AlertSeverity.info => WorkOrderPriority.low,
    };

    return WorkOrder.db.insertRow(
      session,
      WorkOrder(
        companyId: companyId,
        siteId: alert.siteId,
        deviceId: alert.deviceId,
        alertId: alert.id,
        title: '告警維修：${alert.featureKey} 異常',
        description: alert.message,
        status: WorkOrderStatus.open,
        priority: priority,
        createdBy: session.authenticated!.userIdentifier,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// 查詢工單（cursor 分頁，新到舊）。[openOnly] 為 true 時僅回傳未結案。
  Future<WorkOrderListResult> listWorkOrders(
    Session session, {
    bool openOnly = false,
    int limit = _defaultLimit,
    int? cursorId,
  }) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final effectiveLimit = limit.clamp(1, _maxLimit);
    final items = await WorkOrder.db.find(
      session,
      where: (t) {
        var expr = t.companyId.equals(companyId);
        if (openOnly) {
          expr =
              expr &
              t.status.inSet({
                WorkOrderStatus.open,
                WorkOrderStatus.inProgress,
              });
        }
        if (cursorId != null) {
          expr = expr & (t.id < cursorId);
        }
        return expr;
      },
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: effectiveLimit,
    );
    return WorkOrderListResult(
      items: items,
      nextCursorId: items.length == effectiveLimit ? items.last.id : null,
    );
  }

  /// 工單狀態流轉：open → inProgress → done / cancelled。
  /// 結案（done/cancelled）可附處理備註。
  Future<WorkOrder> updateStatus(
    Session session,
    int workOrderId,
    WorkOrderStatus status, {
    String? note,
  }) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final workOrder = await WorkOrder.db.findFirstRow(
      session,
      where: (t) => t.id.equals(workOrderId) & t.companyId.equals(companyId),
    );
    if (workOrder == null) {
      throw NotFoundException(message: '工單不存在');
    }

    final allowed = switch (workOrder.status) {
      WorkOrderStatus.open => {
        WorkOrderStatus.inProgress,
        WorkOrderStatus.cancelled,
      },
      WorkOrderStatus.inProgress => {
        WorkOrderStatus.done,
        WorkOrderStatus.cancelled,
      },
      _ => const <WorkOrderStatus>{},
    };
    if (!allowed.contains(status)) {
      throw ValidationException(
        message: '工單不可從 ${workOrder.status.name} 轉為 ${status.name}',
      );
    }

    final now = DateTime.now().toUtc();
    return WorkOrder.db.updateRow(
      session,
      workOrder.copyWith(
        status: status,
        note: note?.trim().isEmpty ?? true ? workOrder.note : note!.trim(),
        startedAt: status == WorkOrderStatus.inProgress
            ? now
            : workOrder.startedAt,
        completedAt:
            status == WorkOrderStatus.done ||
                status == WorkOrderStatus.cancelled
            ? now
            : null,
      ),
    );
  }
}
