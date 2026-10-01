/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../workorder/work_order_status.dart' as _i2;
import '../workorder/work_order_priority.dart' as _i3;

/// 維修/巡檢工單（Mobile CMMS，見 docs/product/design.md）。
abstract class WorkOrder
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WorkOrder._({
    this.id,
    required this.companyId,
    required this.siteId,
    this.deviceId,
    this.alertId,
    required this.title,
    this.description,
    required this.status,
    required this.priority,
    this.note,
    required this.createdBy,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
  });

  factory WorkOrder({
    int? id,
    required int companyId,
    required int siteId,
    int? deviceId,
    int? alertId,
    required String title,
    String? description,
    required _i2.WorkOrderStatus status,
    required _i3.WorkOrderPriority priority,
    String? note,
    required String createdBy,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _WorkOrderImpl;

  factory WorkOrder.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkOrder(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      siteId: jsonSerialization['siteId'] as int,
      deviceId: jsonSerialization['deviceId'] as int?,
      alertId: jsonSerialization['alertId'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      status: _i2.WorkOrderStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      priority: _i3.WorkOrderPriority.fromJson(
        (jsonSerialization['priority'] as String),
      ),
      note: jsonSerialization['note'] as String?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  static final t = WorkOrderTable();

  static const db = WorkOrderRepository._();

  @override
  int? id;

  int companyId;

  int siteId;

  /// 關聯設備；廠務類工單可不綁設備。
  int? deviceId;

  /// 由告警轉開的工單來源。
  int? alertId;

  String title;

  String? description;

  _i2.WorkOrderStatus status;

  _i3.WorkOrderPriority priority;

  /// 處理紀錄（結案備註）。
  String? note;

  String createdBy;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? completedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkOrder copyWith({
    int? id,
    int? companyId,
    int? siteId,
    int? deviceId,
    int? alertId,
    String? title,
    String? description,
    _i2.WorkOrderStatus? status,
    _i3.WorkOrderPriority? priority,
    String? note,
    String? createdBy,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkOrder',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      if (deviceId != null) 'deviceId': deviceId,
      if (alertId != null) 'alertId': alertId,
      'title': title,
      if (description != null) 'description': description,
      'status': status.toJson(),
      'priority': priority.toJson(),
      if (note != null) 'note': note,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkOrder',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      if (deviceId != null) 'deviceId': deviceId,
      if (alertId != null) 'alertId': alertId,
      'title': title,
      if (description != null) 'description': description,
      'status': status.toJson(),
      'priority': priority.toJson(),
      if (note != null) 'note': note,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  static WorkOrderInclude include() {
    return WorkOrderInclude._();
  }

  static WorkOrderIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkOrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkOrderTable>? orderByList,
    WorkOrderInclude? include,
  }) {
    return WorkOrderIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkOrder.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkOrder.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkOrderImpl extends WorkOrder {
  _WorkOrderImpl({
    int? id,
    required int companyId,
    required int siteId,
    int? deviceId,
    int? alertId,
    required String title,
    String? description,
    required _i2.WorkOrderStatus status,
    required _i3.WorkOrderPriority priority,
    String? note,
    required String createdBy,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         siteId: siteId,
         deviceId: deviceId,
         alertId: alertId,
         title: title,
         description: description,
         status: status,
         priority: priority,
         note: note,
         createdBy: createdBy,
         createdAt: createdAt,
         startedAt: startedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [WorkOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkOrder copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? siteId,
    Object? deviceId = _Undefined,
    Object? alertId = _Undefined,
    String? title,
    Object? description = _Undefined,
    _i2.WorkOrderStatus? status,
    _i3.WorkOrderPriority? priority,
    Object? note = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return WorkOrder(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      siteId: siteId ?? this.siteId,
      deviceId: deviceId is int? ? deviceId : this.deviceId,
      alertId: alertId is int? ? alertId : this.alertId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      note: note is String? ? note : this.note,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}

class WorkOrderUpdateTable extends _i1.UpdateTable<WorkOrderTable> {
  WorkOrderUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> siteId(int value) => _i1.ColumnValue(
    table.siteId,
    value,
  );

  _i1.ColumnValue<int, int> deviceId(int? value) => _i1.ColumnValue(
    table.deviceId,
    value,
  );

  _i1.ColumnValue<int, int> alertId(int? value) => _i1.ColumnValue(
    table.alertId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<_i2.WorkOrderStatus, _i2.WorkOrderStatus> status(
    _i2.WorkOrderStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<_i3.WorkOrderPriority, _i3.WorkOrderPriority> priority(
    _i3.WorkOrderPriority value,
  ) => _i1.ColumnValue(
    table.priority,
    value,
  );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
    value,
  );

  _i1.ColumnValue<String, String> createdBy(String value) => _i1.ColumnValue(
    table.createdBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );
}

class WorkOrderTable extends _i1.Table<int?> {
  WorkOrderTable({super.tableRelation}) : super(tableName: 'work_order') {
    updateTable = WorkOrderUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    siteId = _i1.ColumnInt(
      'siteId',
      this,
    );
    deviceId = _i1.ColumnInt(
      'deviceId',
      this,
    );
    alertId = _i1.ColumnInt(
      'alertId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    priority = _i1.ColumnEnum(
      'priority',
      this,
      _i1.EnumSerialization.byName,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final WorkOrderUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt siteId;

  /// 關聯設備；廠務類工單可不綁設備。
  late final _i1.ColumnInt deviceId;

  /// 由告警轉開的工單來源。
  late final _i1.ColumnInt alertId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnEnum<_i2.WorkOrderStatus> status;

  late final _i1.ColumnEnum<_i3.WorkOrderPriority> priority;

  /// 處理紀錄（結案備註）。
  late final _i1.ColumnString note;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime completedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    siteId,
    deviceId,
    alertId,
    title,
    description,
    status,
    priority,
    note,
    createdBy,
    createdAt,
    startedAt,
    completedAt,
  ];
}

class WorkOrderInclude extends _i1.IncludeObject {
  WorkOrderInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WorkOrder.t;
}

class WorkOrderIncludeList extends _i1.IncludeList {
  WorkOrderIncludeList._({
    _i1.WhereExpressionBuilder<WorkOrderTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkOrder.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WorkOrder.t;
}

class WorkOrderRepository {
  const WorkOrderRepository._();

  /// Returns a list of [WorkOrder]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<WorkOrder>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkOrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkOrderTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkOrder>(
      where: where?.call(WorkOrder.t),
      orderBy: orderBy?.call(WorkOrder.t),
      orderByList: orderByList?.call(WorkOrder.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkOrder] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<WorkOrder?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkOrderTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkOrderTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkOrder>(
      where: where?.call(WorkOrder.t),
      orderBy: orderBy?.call(WorkOrder.t),
      orderByList: orderByList?.call(WorkOrder.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkOrder] by its [id] or null if no such row exists.
  Future<WorkOrder?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkOrder>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkOrder]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkOrder]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WorkOrder>> insert(
    _i1.DatabaseSession session,
    List<WorkOrder> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WorkOrder>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WorkOrder] and returns the inserted row.
  ///
  /// The returned [WorkOrder] will have its `id` field set.
  Future<WorkOrder> insertRow(
    _i1.DatabaseSession session,
    WorkOrder row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkOrder>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkOrder]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkOrder>> update(
    _i1.DatabaseSession session,
    List<WorkOrder> rows, {
    _i1.ColumnSelections<WorkOrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkOrder>(
      rows,
      columns: columns?.call(WorkOrder.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkOrder]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkOrder> updateRow(
    _i1.DatabaseSession session,
    WorkOrder row, {
    _i1.ColumnSelections<WorkOrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkOrder>(
      row,
      columns: columns?.call(WorkOrder.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkOrder] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkOrder?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkOrderUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkOrder>(
      id,
      columnValues: columnValues(WorkOrder.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkOrder]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkOrder>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WorkOrderUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WorkOrderTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkOrderTable>? orderBy,
    _i1.OrderByListBuilder<WorkOrderTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkOrder>(
      columnValues: columnValues(WorkOrder.t.updateTable),
      where: where(WorkOrder.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkOrder.t),
      orderByList: orderByList?.call(WorkOrder.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkOrder]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkOrder>> delete(
    _i1.DatabaseSession session,
    List<WorkOrder> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkOrder>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkOrder].
  Future<WorkOrder> deleteRow(
    _i1.DatabaseSession session,
    WorkOrder row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkOrder>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkOrder>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkOrderTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkOrder>(
      where: where(WorkOrder.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkOrderTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkOrder>(
      where: where?.call(WorkOrder.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkOrder] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkOrderTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkOrder>(
      where: where(WorkOrder.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
