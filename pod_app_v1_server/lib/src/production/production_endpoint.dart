import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../generated/protocol.dart';

/// 製程、WIP、產品與物料管理。
class ProductionEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<int> _readCompany(Session session) =>
      TenantService.resolveCompanyId(session);

  Future<int> _writeCompany(Session session) =>
      TenantService.assertFirmwareAdmin(session);

  String _required(String value, String label) {
    final normalized = value.trim();
    if (normalized.isEmpty) throw ValidationException(message: '$label 不可為空');
    return normalized;
  }

  Future<ProductionSummary> getSummary(Session session) async {
    final companyId = await _readCompany(session);
    final units = await ProductUnit.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      limit: 10000,
    );
    final activeOrders = await ProductionOrder.db.count(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.status.inSet({
            ProductionOrderStatus.released,
            ProductionOrderStatus.inProgress,
          }),
    );
    return ProductionSummary(
      totalUnits: units.length,
      inProgressUnits: units
          .where(
            (u) => {
              ProductUnitStatus.inProgress,
              ProductUnitStatus.waiting,
              ProductUnitStatus.rework,
            }.contains(u.status),
          )
          .length,
      completedUnits: units
          .where((u) => u.status == ProductUnitStatus.completed)
          .length,
      abnormalUnits: units
          .where(
            (u) => {
              ProductUnitStatus.failed,
              ProductUnitStatus.rework,
              ProductUnitStatus.scrapped,
            }.contains(u.status),
          )
          .length,
      activeOrders: activeOrders,
    );
  }

  Future<List<MaterialItem>> listMaterials(Session session) async {
    final companyId = await _readCompany(session);
    return MaterialItem.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.code,
    );
  }

  Future<MaterialItem> saveMaterial(
    Session session,
    int? id,
    String code,
    String name,
    MaterialType type,
    String unit,
    String? specification,
    String? supplier,
    double safetyStock,
    bool active,
  ) async {
    final companyId = await _writeCompany(session);
    final now = DateTime.now().toUtc();
    final old = id == null
        ? null
        : await MaterialItem.db.findFirstRow(
            session,
            where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
          );
    if (id != null && old == null) throw NotFoundException(message: '物料不存在');
    final row = MaterialItem(
      id: old?.id,
      companyId: companyId,
      code: _required(code, '料號'),
      name: _required(name, '物料名稱'),
      type: type,
      specification: specification?.trim().isEmpty == true
          ? null
          : specification?.trim(),
      unit: _required(unit, '單位'),
      supplier: supplier?.trim().isEmpty == true ? null : supplier?.trim(),
      safetyStock: safetyStock < 0 ? 0 : safetyStock,
      active: active,
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );
    return old == null
        ? MaterialItem.db.insertRow(session, row)
        : MaterialItem.db.updateRow(session, row);
  }

  Future<void> deleteMaterial(Session session, int id) async {
    final companyId = await _writeCompany(session);
    final row = await MaterialItem.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '物料不存在');
    final lots = await MaterialLot.db.count(
      session,
      where: (t) => t.materialId.equals(id),
    );
    final bom = await BomItem.db.count(
      session,
      where: (t) => t.materialId.equals(id),
    );
    if (lots + bom > 0) {
      throw ValidationException(message: '物料已有批次或 BOM 關聯，請停用而不要刪除');
    }
    await MaterialItem.db.deleteRow(session, row);
  }

  Future<List<MaterialLot>> listMaterialLots(
    Session session, {
    int? materialId,
  }) async {
    final companyId = await _readCompany(session);
    return MaterialLot.db.find(
      session,
      where: (t) => materialId == null
          ? t.companyId.equals(companyId)
          : t.companyId.equals(companyId) & t.materialId.equals(materialId),
      orderBy: (t) => t.id,
      orderDescending: true,
    );
  }

  Future<MaterialLot> saveMaterialLot(
    Session session,
    int? id,
    int materialId,
    String lotNumber,
    double quantity,
    DateTime receivedAt,
    DateTime? expiresAt,
    String? supplierLot,
    String? qrCode,
    String? rfidEpc,
  ) async {
    final companyId = await _writeCompany(session);
    final material = await MaterialItem.db.findFirstRow(
      session,
      where: (t) => t.id.equals(materialId) & t.companyId.equals(companyId),
    );
    if (material == null) throw NotFoundException(message: '物料不存在');
    if (quantity < 0) throw ValidationException(message: '數量不可小於 0');
    final old = id == null
        ? null
        : await MaterialLot.db.findFirstRow(
            session,
            where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
          );
    final now = DateTime.now().toUtc();
    final row = MaterialLot(
      id: old?.id,
      companyId: companyId,
      materialId: materialId,
      lotNumber: _required(lotNumber, '批號'),
      quantity: quantity,
      receivedAt: receivedAt.toUtc(),
      expiresAt: expiresAt?.toUtc(),
      supplierLot: supplierLot?.trim().isEmpty == true
          ? null
          : supplierLot?.trim(),
      qrCode: qrCode?.trim().isEmpty == true ? null : qrCode?.trim(),
      rfidEpc: rfidEpc?.trim().isEmpty == true ? null : rfidEpc?.trim(),
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );
    return old == null
        ? MaterialLot.db.insertRow(session, row)
        : MaterialLot.db.updateRow(session, row);
  }

  Future<void> deleteMaterialLot(Session session, int id) async {
    final companyId = await _writeCompany(session);
    final row = await MaterialLot.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '物料批次不存在');
    final events = await ProcessEvent.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      limit: 10000,
    );
    if (events.any(
      (event) => (event.materialLotIds ?? const <int>[]).contains(id),
    )) {
      throw ValidationException(message: '批次已有製程追溯記錄，不可刪除');
    }
    await MaterialLot.db.deleteRow(session, row);
  }

  Future<List<ProductDefinition>> listProducts(Session session) async {
    final companyId = await _readCompany(session);
    return ProductDefinition.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.code,
    );
  }

  Future<ProductDefinition> saveProduct(
    Session session,
    int? id,
    String code,
    String name,
    String unit,
    String? specification,
    bool active,
  ) async {
    final companyId = await _writeCompany(session);
    final old = id == null
        ? null
        : await ProductDefinition.db.findFirstRow(
            session,
            where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
          );
    final now = DateTime.now().toUtc();
    final row = ProductDefinition(
      id: old?.id,
      companyId: companyId,
      code: _required(code, '產品代碼'),
      name: _required(name, '產品名稱'),
      specification: specification?.trim().isEmpty == true
          ? null
          : specification?.trim(),
      unit: _required(unit, '單位'),
      active: active,
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );
    return old == null
        ? ProductDefinition.db.insertRow(session, row)
        : ProductDefinition.db.updateRow(session, row);
  }

  Future<void> deleteProduct(Session session, int id) async {
    final companyId = await _writeCompany(session);
    final row = await ProductDefinition.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '產品不存在');
    final routes = await ProcessRoute.db.count(
      session,
      where: (t) => t.productDefinitionId.equals(id),
    );
    final bom = await BomItem.db.count(
      session,
      where: (t) => t.productDefinitionId.equals(id),
    );
    if (routes + bom > 0) {
      throw ValidationException(message: '產品已有 BOM 或製程路線，請停用而不要刪除');
    }
    await ProductDefinition.db.deleteRow(session, row);
  }

  Future<List<BomItem>> listBom(Session session, int productId) async {
    final companyId = await _readCompany(session);
    return BomItem.db.find(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.productDefinitionId.equals(productId),
      orderBy: (t) => t.id,
    );
  }

  Future<BomItem> saveBomItem(
    Session session,
    int? id,
    int productId,
    int materialId,
    double quantity,
    String unit,
    double scrapRatePercent,
    String? note,
  ) async {
    final companyId = await _writeCompany(session);
    if (quantity <= 0) throw ValidationException(message: 'BOM 用量必須大於 0');
    final product = await ProductDefinition.db.findFirstRow(
      session,
      where: (t) => t.id.equals(productId) & t.companyId.equals(companyId),
    );
    final material = await MaterialItem.db.findFirstRow(
      session,
      where: (t) => t.id.equals(materialId) & t.companyId.equals(companyId),
    );
    if (product == null || material == null) {
      throw NotFoundException(message: '產品或物料不存在');
    }
    final old = id == null ? null : await BomItem.db.findById(session, id);
    final now = DateTime.now().toUtc();
    final row = BomItem(
      id: old?.id,
      companyId: companyId,
      productDefinitionId: productId,
      materialId: materialId,
      quantity: quantity,
      unit: _required(unit, 'BOM 單位'),
      scrapRatePercent: scrapRatePercent.clamp(0, 100),
      note: note?.trim().isEmpty == true ? null : note?.trim(),
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );
    return old == null
        ? BomItem.db.insertRow(session, row)
        : BomItem.db.updateRow(session, row);
  }

  Future<void> deleteBomItem(Session session, int id) async {
    final companyId = await _writeCompany(session);
    final row = await BomItem.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: 'BOM 項目不存在');
    await BomItem.db.deleteRow(session, row);
  }

  Future<List<ProcessRoute>> listRoutes(Session session) async {
    final companyId = await _readCompany(session);
    return ProcessRoute.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.code,
    );
  }

  Future<List<ProductionLine>> listProductionLines(Session session) async {
    final companyId = await _readCompany(session);
    return ProductionLine.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.code,
    );
  }

  Future<ProductionLine> saveProductionLine(
    Session session,
    int? id,
    String code,
    String name,
    String? description,
    bool active,
  ) async {
    final companyId = await _writeCompany(session);
    final old = id == null
        ? null
        : await ProductionLine.db.findFirstRow(
            session,
            where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
          );
    if (id != null && old == null) throw NotFoundException(message: '產線不存在');
    final now = DateTime.now().toUtc();
    final row = ProductionLine(
      id: old?.id,
      companyId: companyId,
      code: _required(code, '產線代碼'),
      name: _required(name, '產線名稱'),
      description: description?.trim().isEmpty == true
          ? null
          : description?.trim(),
      active: active,
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );
    return old == null
        ? ProductionLine.db.insertRow(session, row)
        : ProductionLine.db.updateRow(session, row);
  }

  Future<void> deleteProductionLine(Session session, int id) async {
    final companyId = await _writeCompany(session);
    final row = await ProductionLine.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '產線不存在');
    final stations = await Workstation.db.count(
      session,
      where: (t) => t.productionLineId.equals(id),
    );
    if (stations > 0) {
      throw ValidationException(message: '產線下尚有工作站，請停用而不要刪除');
    }
    await ProductionLine.db.deleteRow(session, row);
  }

  Future<List<Workstation>> listWorkstations(Session session) async {
    final companyId = await _readCompany(session);
    return Workstation.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.code,
    );
  }

  Future<Workstation> saveWorkstation(
    Session session,
    int? id,
    int productionLineId,
    String code,
    String name,
    String? description,
    bool active,
  ) async {
    final companyId = await _writeCompany(session);
    final line = await ProductionLine.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(productionLineId) &
          t.companyId.equals(companyId) &
          t.active.equals(true),
    );
    if (line == null) throw NotFoundException(message: '產線不存在或已停用');
    final old = id == null
        ? null
        : await Workstation.db.findFirstRow(
            session,
            where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
          );
    if (id != null && old == null) throw NotFoundException(message: '工作站不存在');
    final now = DateTime.now().toUtc();
    final row = Workstation(
      id: old?.id,
      companyId: companyId,
      productionLineId: productionLineId,
      code: _required(code, '工作站代碼'),
      name: _required(name, '工作站名稱'),
      description: description?.trim().isEmpty == true
          ? null
          : description?.trim(),
      active: active,
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );
    return old == null
        ? Workstation.db.insertRow(session, row)
        : Workstation.db.updateRow(session, row);
  }

  Future<void> deleteWorkstation(Session session, int id) async {
    final companyId = await _writeCompany(session);
    final row = await Workstation.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '工作站不存在');
    final nodes = await ProcessNode.db.count(
      session,
      where: (t) =>
          t.companyId.equals(companyId) & t.stationCode.equals(row.code),
    );
    if (nodes > 0) {
      throw ValidationException(message: '工作站已被製程節點使用，請停用而不要刪除');
    }
    final assignments = await WorkstationAssignment.db.find(
      session,
      where: (t) => t.workstationId.equals(id),
    );
    await WorkstationAssignment.db.delete(session, assignments);
    await Workstation.db.deleteRow(session, row);
  }

  Future<List<WorkstationAssignmentDetail>> listWorkstationAssignments(
    Session session,
  ) async {
    final companyId = await _writeCompany(session);
    final assignments = await WorkstationAssignment.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.createdAt,
    );
    final details = <WorkstationAssignmentDetail>[];
    for (final assignment in assignments) {
      final station = await Workstation.db.findById(
        session,
        assignment.workstationId,
      );
      final member = await CompanyMembership.db.findById(
        session,
        assignment.membershipId,
      );
      if (station == null || member == null) continue;
      details.add(
        WorkstationAssignmentDetail(
          assignment: assignment,
          workstation: station,
          memberEmail: member.email ?? member.authUserId,
          memberDisplayName: member.displayName,
        ),
      );
    }
    return details;
  }

  Future<WorkstationAssignment> assignWorkstation(
    Session session,
    int workstationId,
    int membershipId,
  ) async {
    final companyId = await _writeCompany(session);
    final station = await Workstation.db.findFirstRow(
      session,
      where: (t) => t.id.equals(workstationId) & t.companyId.equals(companyId),
    );
    final member = await CompanyMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(membershipId) &
          t.companyId.equals(companyId) &
          t.isActive.equals(true),
    );
    if (station == null || member == null) {
      throw NotFoundException(message: '工作站或員工不存在');
    }
    final old = await WorkstationAssignment.db.findFirstRow(
      session,
      where: (t) =>
          t.workstationId.equals(workstationId) &
          t.membershipId.equals(membershipId),
    );
    final now = DateTime.now().toUtc();
    final row = WorkstationAssignment(
      id: old?.id,
      companyId: companyId,
      workstationId: workstationId,
      membershipId: membershipId,
      active: true,
      assignedBy: session.authenticated!.userIdentifier,
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );
    return old == null
        ? WorkstationAssignment.db.insertRow(session, row)
        : WorkstationAssignment.db.updateRow(session, row);
  }

  Future<void> removeWorkstationAssignment(Session session, int id) async {
    final companyId = await _writeCompany(session);
    final row = await WorkstationAssignment.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '工位指派不存在');
    await WorkstationAssignment.db.deleteRow(session, row);
  }

  Future<List<Workstation>> listMyWorkstations(Session session) async {
    final membership = await TenantService.currentMembership(session);
    final assignments = await WorkstationAssignment.db.find(
      session,
      where: (t) =>
          t.membershipId.equals(membership.id!) & t.active.equals(true),
    );
    if (assignments.isEmpty) return const [];
    final ids = assignments.map((a) => a.workstationId).toSet();
    return Workstation.db.find(
      session,
      where: (t) =>
          t.companyId.equals(membership.companyId) &
          t.active.equals(true) &
          t.id.inSet(ids),
      orderBy: (t) => t.code,
    );
  }

  Future<List<LineTransfer>> listMyPendingTransfers(Session session) async {
    final stations = await listMyWorkstations(session);
    if (stations.isEmpty) return const [];
    final stationIds = stations.map((station) => station.id!).toSet();
    final companyId = await _readCompany(session);
    return LineTransfer.db.find(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          ((t.fromWorkstationId.inSet(stationIds) &
                  t.status.equals(LineTransferStatus.awaitingDispatch)) |
              (t.toWorkstationId.inSet(stationIds) &
                  t.status.equals(LineTransferStatus.inTransit))),
      orderBy: (t) => t.createdAt,
    );
  }

  Future<LineTransfer> dispatchLineTransfer(
    Session session,
    int transferId,
  ) async {
    final membership = await TenantService.currentMembership(session);
    final transfer = await LineTransfer.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(transferId) & t.companyId.equals(membership.companyId),
    );
    if (transfer == null) throw NotFoundException(message: '轉線交接不存在');
    if (transfer.status != LineTransferStatus.awaitingDispatch) {
      throw ValidationException(message: '轉線交接不在待轉出狀態');
    }
    await _assertWorkstationAssignment(
      session,
      membership.id!,
      transfer.fromWorkstationId,
    );
    final unit = await ProductUnit.db.findById(session, transfer.productUnitId);
    if (unit == null) throw NotFoundException(message: '產品不存在');
    final now = DateTime.now().toUtc();
    await recordProcessEvent(
      session,
      'transfer-out-${transfer.id}-${now.microsecondsSinceEpoch}',
      unit.serialNumber,
      transfer.fromNodeId,
      ProcessEventType.transferOut,
      ProcessResult.pass,
      now,
    );
    return LineTransfer.db.updateRow(
      session,
      transfer.copyWith(
        status: LineTransferStatus.inTransit,
        dispatchedBy: session.authenticated!.userIdentifier,
        dispatchedAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<LineTransfer> receiveLineTransfer(
    Session session,
    int transferId,
  ) async {
    final membership = await TenantService.currentMembership(session);
    final transfer = await LineTransfer.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(transferId) & t.companyId.equals(membership.companyId),
    );
    if (transfer == null) throw NotFoundException(message: '轉線交接不存在');
    if (transfer.status != LineTransferStatus.inTransit) {
      throw ValidationException(message: '轉線交接尚未轉出或已接收');
    }
    await _assertWorkstationAssignment(
      session,
      membership.id!,
      transfer.toWorkstationId,
    );
    final unit = await ProductUnit.db.findById(session, transfer.productUnitId);
    if (unit == null) throw NotFoundException(message: '產品不存在');
    final now = DateTime.now().toUtc();
    await recordProcessEvent(
      session,
      'transfer-in-${transfer.id}-${now.microsecondsSinceEpoch}',
      unit.serialNumber,
      transfer.toNodeId,
      ProcessEventType.transferIn,
      ProcessResult.pass,
      now,
    );
    await ProductUnit.db.updateRow(
      session,
      unit.copyWith(status: ProductUnitStatus.waiting, updatedAt: now),
    );
    return LineTransfer.db.updateRow(
      session,
      transfer.copyWith(
        status: LineTransferStatus.received,
        receivedBy: session.authenticated!.userIdentifier,
        receivedAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<void> _assertWorkstationAssignment(
    Session session,
    int membershipId,
    int workstationId,
  ) async {
    final assignment = await WorkstationAssignment.db.findFirstRow(
      session,
      where: (t) =>
          t.membershipId.equals(membershipId) &
          t.workstationId.equals(workstationId) &
          t.active.equals(true),
    );
    if (assignment == null) {
      throw ValidationException(message: '您未被指派到此工作站');
    }
  }

  Future<ProcessRoute> saveRoute(
    Session session,
    int? id,
    int productId,
    String code,
    String name,
    int version,
    bool active,
  ) async {
    final companyId = await _writeCompany(session);
    final product = await ProductDefinition.db.findFirstRow(
      session,
      where: (t) => t.id.equals(productId) & t.companyId.equals(companyId),
    );
    if (product == null) throw NotFoundException(message: '產品不存在');
    final old = id == null ? null : await ProcessRoute.db.findById(session, id);
    final now = DateTime.now().toUtc();
    final row = ProcessRoute(
      id: old?.id,
      companyId: companyId,
      productDefinitionId: productId,
      code: _required(code, '路線代碼'),
      name: _required(name, '路線名稱'),
      version: version < 1 ? 1 : version,
      active: active,
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );
    return old == null
        ? ProcessRoute.db.insertRow(session, row)
        : ProcessRoute.db.updateRow(session, row);
  }

  Future<void> deleteRoute(Session session, int id) async {
    final companyId = await _writeCompany(session);
    final row = await ProcessRoute.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '製程路線不存在');
    final orders = await ProductionOrder.db.count(
      session,
      where: (t) => t.routeId.equals(id),
    );
    if (orders > 0) {
      throw ValidationException(message: '路線已有生產工單，請停用而不要刪除');
    }
    final nodes = await ProcessNode.db.find(
      session,
      where: (t) => t.routeId.equals(id),
    );
    await ProcessNode.db.delete(session, nodes);
    await ProcessRoute.db.deleteRow(session, row);
  }

  Future<List<ProcessNode>> listProcessNodes(
    Session session,
    int routeId,
  ) async {
    final companyId = await _readCompany(session);
    return ProcessNode.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & t.routeId.equals(routeId),
      orderBy: (t) => t.sequence,
    );
  }

  Future<ProcessNode> saveProcessNode(
    Session session,
    int? id,
    int routeId,
    int sequence,
    String code,
    String name,
    String stationCode,
    int standardSeconds,
    String scanMode,
    bool allowSkip,
    bool allowRework,
    Map<String, String>? measurementRequirements,
  ) async {
    final companyId = await _writeCompany(session);
    final route = await ProcessRoute.db.findFirstRow(
      session,
      where: (t) => t.id.equals(routeId) & t.companyId.equals(companyId),
    );
    if (route == null) throw NotFoundException(message: '製程路線不存在');
    final normalizedStationCode = _required(stationCode, '工作站代碼');
    final workstation = await Workstation.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.code.equals(normalizedStationCode) &
          t.active.equals(true),
    );
    if (workstation == null) {
      throw ValidationException(message: '請先建立並啟用對應的工作站');
    }
    final old = id == null ? null : await ProcessNode.db.findById(session, id);
    final now = DateTime.now().toUtc();
    final row = ProcessNode(
      id: old?.id,
      companyId: companyId,
      routeId: routeId,
      sequence: sequence,
      code: _required(code, '節點代碼'),
      name: _required(name, '節點名稱'),
      stationCode: normalizedStationCode,
      standardSeconds: standardSeconds < 1 ? 1 : standardSeconds,
      scanMode: scanMode,
      allowSkip: allowSkip,
      allowRework: allowRework,
      measurementRequirements: measurementRequirements,
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );
    return old == null
        ? ProcessNode.db.insertRow(session, row)
        : ProcessNode.db.updateRow(session, row);
  }

  Future<void> deleteProcessNode(Session session, int id) async {
    final companyId = await _writeCompany(session);
    final row = await ProcessNode.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '製程節點不存在');
    final events = await ProcessEvent.db.count(
      session,
      where: (t) => t.processNodeId.equals(id),
    );
    if (events > 0) throw ValidationException(message: '節點已有追溯記錄，不可刪除');
    await ProcessNode.db.deleteRow(session, row);
  }

  Future<List<ProductionOrder>> listProductionOrders(Session session) async {
    final companyId = await _readCompany(session);
    return ProductionOrder.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.id,
      orderDescending: true,
    );
  }

  Future<ProductionOrder> createProductionOrder(
    Session session,
    String orderNumber,
    int productId,
    int routeId,
    int plannedQuantity,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
  ) async {
    final companyId = await _writeCompany(session);
    if (plannedQuantity <= 0) {
      throw ValidationException(message: '預計數量必須大於 0');
    }
    final route = await ProcessRoute.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(routeId) &
          t.companyId.equals(companyId) &
          t.productDefinitionId.equals(productId),
    );
    if (route == null) throw ValidationException(message: '產品與製程路線不匹配');
    final now = DateTime.now().toUtc();
    return ProductionOrder.db.insertRow(
      session,
      ProductionOrder(
        companyId: companyId,
        orderNumber: _required(orderNumber, '工單編號'),
        productDefinitionId: productId,
        routeId: routeId,
        plannedQuantity: plannedQuantity,
        completedQuantity: 0,
        rejectedQuantity: 0,
        status: ProductionOrderStatus.draft,
        scheduledStart: scheduledStart?.toUtc(),
        scheduledEnd: scheduledEnd?.toUtc(),
        createdBy: session.authenticated!.userIdentifier,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<ProductionOrder> setProductionOrderStatus(
    Session session,
    int id,
    ProductionOrderStatus status,
  ) async {
    final companyId = await _writeCompany(session);
    final order = await ProductionOrder.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (order == null) throw NotFoundException(message: '生產工單不存在');
    final allowed = switch (order.status) {
      ProductionOrderStatus.draft => {
        ProductionOrderStatus.released,
        ProductionOrderStatus.cancelled,
      },
      ProductionOrderStatus.released => {
        ProductionOrderStatus.inProgress,
        ProductionOrderStatus.cancelled,
      },
      ProductionOrderStatus.inProgress => {
        ProductionOrderStatus.completed,
        ProductionOrderStatus.cancelled,
      },
      _ => const <ProductionOrderStatus>{},
    };
    if (!allowed.contains(status)) {
      throw ValidationException(message: '不允許的工單狀態轉換');
    }
    final now = DateTime.now().toUtc();
    return ProductionOrder.db.updateRow(
      session,
      order.copyWith(
        status: status,
        startedAt: status == ProductionOrderStatus.inProgress
            ? now
            : order.startedAt,
        completedAt: status == ProductionOrderStatus.completed ? now : null,
        updatedAt: now,
      ),
    );
  }

  Future<void> deleteProductionOrder(Session session, int id) async {
    final companyId = await _writeCompany(session);
    final row = await ProductionOrder.db.findFirstRow(
      session,
      where: (t) => t.id.equals(id) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '生產工單不存在');
    if (row.status != ProductionOrderStatus.draft) {
      throw ValidationException(message: '只能刪除草稿工單');
    }
    final units = await ProductUnit.db.count(
      session,
      where: (t) => t.productionOrderId.equals(id),
    );
    if (units > 0) throw ValidationException(message: '工單已產生產品序號，不可刪除');
    await ProductionOrder.db.deleteRow(session, row);
  }

  Future<List<ProductUnit>> listProductUnits(
    Session session, {
    int? orderId,
  }) async {
    final companyId = await _readCompany(session);
    return ProductUnit.db.find(
      session,
      where: (t) => orderId == null
          ? t.companyId.equals(companyId)
          : t.companyId.equals(companyId) & t.productionOrderId.equals(orderId),
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: 1000,
    );
  }

  Future<List<ProductUnit>> generateProductUnits(
    Session session,
    int orderId,
    int quantity,
    String serialPrefix,
  ) async {
    final companyId = await _readCompany(session);
    final order = await ProductionOrder.db.findFirstRow(
      session,
      where: (t) => t.id.equals(orderId) & t.companyId.equals(companyId),
    );
    if (order == null) throw NotFoundException(message: '生產工單不存在');
    if (quantity < 1 || quantity > 1000) {
      throw ValidationException(message: '單次產生數量必須介於 1–1000');
    }
    final existing = await ProductUnit.db.count(
      session,
      where: (t) => t.productionOrderId.equals(orderId),
    );
    if (existing + quantity > order.plannedQuantity) {
      throw ValidationException(message: '產品序號數量不可超過工單預計數量');
    }
    final now = DateTime.now().toUtc();
    final prefix = _required(serialPrefix, '序號前綴');
    final rows = <ProductUnit>[];
    for (var i = 1; i <= quantity; i++) {
      final serial = '$prefix-${(existing + i).toString().padLeft(5, '0')}';
      rows.add(
        ProductUnit(
          companyId: companyId,
          productionOrderId: orderId,
          productDefinitionId: order.productDefinitionId,
          serialNumber: serial,
          qrCode: 'PRODUCT:$serial',
          status: ProductUnitStatus.created,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }
    return ProductUnit.db.insert(session, rows);
  }

  /// 現場工位模式：員工只提供被指派的工作站與產品識別，
  /// Server 依工單路線自動決定此工位可執行的節點。
  Future<ProcessEvent> recordWorkstationEvent(
    Session session,
    String clientEventId,
    int workstationId,
    String productIdentifier,
    ProcessEventType eventType,
    ProcessResult result,
    DateTime occurredAt, {
    List<int>? materialLotIds,
    Map<String, double>? measurements,
    String? note,
  }) async {
    final membership = await TenantService.currentMembership(session);
    final assignment = await WorkstationAssignment.db.findFirstRow(
      session,
      where: (t) =>
          t.workstationId.equals(workstationId) &
          t.membershipId.equals(membership.id!) &
          t.active.equals(true),
    );
    final station = await Workstation.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(workstationId) &
          t.companyId.equals(membership.companyId) &
          t.active.equals(true),
    );
    if (assignment == null || station == null) {
      throw ValidationException(message: '您未被指派到此工作站');
    }
    final identifier = _required(productIdentifier, '產品識別碼');
    final unit = await ProductUnit.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(membership.companyId) &
          (t.serialNumber.equals(identifier) |
              t.qrCode.equals(identifier) |
              t.rfidEpc.equals(identifier)),
    );
    if (unit == null) throw NotFoundException(message: '找不到產品序號／QR／RFID');
    if (unit.status == ProductUnitStatus.awaitingTransfer) {
      throw ValidationException(message: '產品正在跨產線交接，請先完成轉出與接收');
    }
    final order = await ProductionOrder.db.findById(
      session,
      unit.productionOrderId,
    );
    if (order == null || order.companyId != membership.companyId) {
      throw NotFoundException(message: '生產工單不存在');
    }
    final nodes = await listProcessNodes(session, order.routeId);
    final currentIndex = unit.currentNodeId == null
        ? -1
        : nodes.indexWhere((node) => node.id == unit.currentNodeId);
    final continuingCurrent =
        currentIndex >= 0 &&
        unit.status == ProductUnitStatus.inProgress &&
        nodes[currentIndex].stationCode == station.code;
    final targetIndex = continuingCurrent ? currentIndex : currentIndex + 1;
    if (targetIndex < 0 || targetIndex >= nodes.length) {
      throw ValidationException(message: '產品已無下一個製程節點');
    }
    final target = nodes[targetIndex];
    if (target.stationCode != station.code) {
      throw ValidationException(
        message: '此產品的下一站是 ${target.stationCode}，不是 ${station.code}',
      );
    }
    return recordProcessEvent(
      session,
      clientEventId,
      identifier,
      target.id!,
      eventType,
      result,
      occurredAt,
      materialLotIds: materialLotIds,
      measurements: measurements,
      note: note,
    );
  }

  Future<ProcessEvent> recordProcessEvent(
    Session session,
    String clientEventId,
    String productIdentifier,
    int processNodeId,
    ProcessEventType eventType,
    ProcessResult result,
    DateTime occurredAt, {
    int? deviceId,
    List<int>? materialLotIds,
    Map<String, double>? measurements,
    String? note,
  }) async {
    final companyId = await _readCompany(session);
    final eventId = _required(clientEventId, '事件識別碼');
    final duplicate = await ProcessEvent.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) & t.clientEventId.equals(eventId),
    );
    if (duplicate != null) return duplicate;
    final identifier = _required(productIdentifier, '產品識別碼');
    final unit = await ProductUnit.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          (t.serialNumber.equals(identifier) |
              t.qrCode.equals(identifier) |
              t.rfidEpc.equals(identifier)),
    );
    if (unit == null) throw NotFoundException(message: '找不到產品序號／QR／RFID');
    final order = await ProductionOrder.db.findFirstRow(
      session,
      where: (t) =>
          t.id.equals(unit.productionOrderId) & t.companyId.equals(companyId),
    );
    final node = await ProcessNode.db.findFirstRow(
      session,
      where: (t) => t.id.equals(processNodeId) & t.companyId.equals(companyId),
    );
    if (order == null || node == null || node.routeId != order.routeId) {
      throw ValidationException(message: '工單與製程節點不匹配');
    }
    final membership = await TenantService.currentMembership(session);
    if ((membership.role ?? CompanyRole.admin) != CompanyRole.admin) {
      final station = await Workstation.db.findFirstRow(
        session,
        where: (t) =>
            t.companyId.equals(companyId) &
            t.code.equals(node.stationCode) &
            t.active.equals(true),
      );
      final assigned = station == null
          ? null
          : await WorkstationAssignment.db.findFirstRow(
              session,
              where: (t) =>
                  t.workstationId.equals(station.id!) &
                  t.membershipId.equals(membership.id!) &
                  t.active.equals(true),
            );
      if (assigned == null) {
        throw ValidationException(message: '您沒有此工作站的過站權限');
      }
    }
    if (deviceId != null) {
      await TenantService.assertDeviceAccess(session, companyId, deviceId);
    }
    final nodes = await listProcessNodes(session, order.routeId);
    final currentIndex = unit.currentNodeId == null
        ? -1
        : nodes.indexWhere((n) => n.id == unit.currentNodeId);
    final targetIndex = nodes.indexWhere((n) => n.id == node.id);
    if (targetIndex < 0) throw ValidationException(message: '節點不在工單路線內');
    final entering =
        eventType == ProcessEventType.arrived ||
        eventType == ProcessEventType.started;
    if (entering && targetIndex > currentIndex + 1 && !node.allowSkip) {
      throw ValidationException(
        message: '不可跳站；下一站應為 ${nodes[currentIndex + 1].name}',
      );
    }
    final now = DateTime.now().toUtc();
    final event = await ProcessEvent.db.insertRow(
      session,
      ProcessEvent(
        companyId: companyId,
        clientEventId: eventId,
        productUnitId: unit.id!,
        productionOrderId: order.id!,
        processNodeId: node.id!,
        stationCode: node.stationCode,
        eventType: eventType,
        result: result,
        operatorId: session.authenticated!.userIdentifier,
        deviceId: deviceId,
        materialLotIds: materialLotIds,
        measurements: measurements,
        note: note?.trim().isEmpty == true ? null : note?.trim(),
        occurredAt: occurredAt.toUtc(),
        receivedAt: now,
      ),
    );
    var status = unit.status;
    int? currentNodeId = unit.currentNodeId;
    String? currentStation = unit.currentStationCode;
    DateTime? enteredAt = unit.enteredNodeAt;
    DateTime? completedAt = unit.completedAt;
    if (entering) {
      status = ProductUnitStatus.inProgress;
      currentNodeId = node.id;
      currentStation = node.stationCode;
      enteredAt = occurredAt.toUtc();
    } else if (eventType == ProcessEventType.scrapped) {
      status = ProductUnitStatus.scrapped;
      completedAt = occurredAt.toUtc();
    } else if (eventType == ProcessEventType.reworked ||
        result == ProcessResult.fail) {
      status = ProductUnitStatus.rework;
    } else if (eventType == ProcessEventType.completed ||
        eventType == ProcessEventType.inspected) {
      final isLast = targetIndex == nodes.length - 1;
      status = isLast ? ProductUnitStatus.completed : ProductUnitStatus.waiting;
      currentNodeId = node.id;
      currentStation = node.stationCode;
      if (isLast) completedAt = occurredAt.toUtc();
      if (!isLast) {
        final nextNode = nodes[targetIndex + 1];
        final stations = await Workstation.db.find(
          session,
          where: (t) =>
              t.companyId.equals(companyId) &
              t.code.inSet({node.stationCode, nextNode.stationCode}),
        );
        final fromStation = stations
            .where((station) => station.code == node.stationCode)
            .firstOrNull;
        final toStation = stations
            .where((station) => station.code == nextNode.stationCode)
            .firstOrNull;
        if (fromStation != null &&
            toStation != null &&
            fromStation.productionLineId != null &&
            toStation.productionLineId != null &&
            fromStation.productionLineId != toStation.productionLineId) {
          final existingTransfer = await LineTransfer.db.findFirstRow(
            session,
            where: (t) =>
                t.productUnitId.equals(unit.id!) &
                t.fromNodeId.equals(node.id!) &
                t.toNodeId.equals(nextNode.id!),
          );
          if (existingTransfer == null) {
            await LineTransfer.db.insertRow(
              session,
              LineTransfer(
                companyId: companyId,
                productUnitId: unit.id!,
                productionOrderId: order.id!,
                fromLineId: fromStation.productionLineId!,
                toLineId: toStation.productionLineId!,
                fromWorkstationId: fromStation.id!,
                toWorkstationId: toStation.id!,
                fromNodeId: node.id!,
                toNodeId: nextNode.id!,
                status: LineTransferStatus.awaitingDispatch,
                createdAt: now,
                updatedAt: now,
              ),
            );
          }
          status = ProductUnitStatus.awaitingTransfer;
        }
      }
    }
    await ProductUnit.db.updateRow(
      session,
      unit.copyWith(
        status: status,
        currentNodeId: currentNodeId,
        currentStationCode: currentStation,
        enteredNodeAt: enteredAt,
        completedAt: completedAt,
        updatedAt: now,
      ),
    );
    if (status == ProductUnitStatus.completed ||
        status == ProductUnitStatus.scrapped) {
      final units = await ProductUnit.db.find(
        session,
        where: (t) => t.productionOrderId.equals(order.id!),
      );
      await ProductionOrder.db.updateRow(
        session,
        order.copyWith(
          completedQuantity: units
              .where((u) => u.status == ProductUnitStatus.completed)
              .length,
          rejectedQuantity: units
              .where((u) => u.status == ProductUnitStatus.scrapped)
              .length,
          updatedAt: now,
        ),
      );
    }
    return event;
  }

  Future<ProductTrace> getProductTrace(
    Session session,
    String identifier,
  ) async {
    final companyId = await _readCompany(session);
    final value = _required(identifier, '產品識別碼');
    final unit = await ProductUnit.db.findFirstRow(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          (t.serialNumber.equals(value) |
              t.qrCode.equals(value) |
              t.rfidEpc.equals(value)),
    );
    if (unit == null) throw NotFoundException(message: '找不到產品');
    final order = await ProductionOrder.db.findById(
      session,
      unit.productionOrderId,
    );
    final product = await ProductDefinition.db.findById(
      session,
      unit.productDefinitionId,
    );
    if (order == null || product == null) {
      throw NotFoundException(message: '產品關聯資料不完整');
    }
    final events = await ProcessEvent.db.find(
      session,
      where: (t) => t.productUnitId.equals(unit.id!),
      orderBy: (t) => t.occurredAt,
    );
    return ProductTrace(
      unit: unit,
      order: order,
      product: product,
      events: events,
    );
  }
}
