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
import '../production/production_order_status.dart' as _i2;

abstract class ProductionOrder
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProductionOrder._({
    this.id,
    required this.companyId,
    required this.orderNumber,
    required this.productDefinitionId,
    required this.routeId,
    required this.plannedQuantity,
    int? completedQuantity,
    int? rejectedQuantity,
    required this.status,
    this.scheduledStart,
    this.scheduledEnd,
    this.startedAt,
    this.completedAt,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  }) : completedQuantity = completedQuantity ?? 0,
       rejectedQuantity = rejectedQuantity ?? 0;

  factory ProductionOrder({
    int? id,
    required int companyId,
    required String orderNumber,
    required int productDefinitionId,
    required int routeId,
    required int plannedQuantity,
    int? completedQuantity,
    int? rejectedQuantity,
    required _i2.ProductionOrderStatus status,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    DateTime? startedAt,
    DateTime? completedAt,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProductionOrderImpl;

  factory ProductionOrder.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductionOrder(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      orderNumber: jsonSerialization['orderNumber'] as String,
      productDefinitionId: jsonSerialization['productDefinitionId'] as int,
      routeId: jsonSerialization['routeId'] as int,
      plannedQuantity: jsonSerialization['plannedQuantity'] as int,
      completedQuantity: jsonSerialization['completedQuantity'] as int?,
      rejectedQuantity: jsonSerialization['rejectedQuantity'] as int?,
      status: _i2.ProductionOrderStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      scheduledStart: jsonSerialization['scheduledStart'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scheduledStart'],
            ),
      scheduledEnd: jsonSerialization['scheduledEnd'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scheduledEnd'],
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ProductionOrderTable();

  static const db = ProductionOrderRepository._();

  @override
  int? id;

  int companyId;

  String orderNumber;

  int productDefinitionId;

  int routeId;

  int plannedQuantity;

  int completedQuantity;

  int rejectedQuantity;

  _i2.ProductionOrderStatus status;

  DateTime? scheduledStart;

  DateTime? scheduledEnd;

  DateTime? startedAt;

  DateTime? completedAt;

  String createdBy;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProductionOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductionOrder copyWith({
    int? id,
    int? companyId,
    String? orderNumber,
    int? productDefinitionId,
    int? routeId,
    int? plannedQuantity,
    int? completedQuantity,
    int? rejectedQuantity,
    _i2.ProductionOrderStatus? status,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    DateTime? startedAt,
    DateTime? completedAt,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductionOrder',
      if (id != null) 'id': id,
      'companyId': companyId,
      'orderNumber': orderNumber,
      'productDefinitionId': productDefinitionId,
      'routeId': routeId,
      'plannedQuantity': plannedQuantity,
      'completedQuantity': completedQuantity,
      'rejectedQuantity': rejectedQuantity,
      'status': status.toJson(),
      if (scheduledStart != null) 'scheduledStart': scheduledStart?.toJson(),
      if (scheduledEnd != null) 'scheduledEnd': scheduledEnd?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProductionOrder',
      if (id != null) 'id': id,
      'companyId': companyId,
      'orderNumber': orderNumber,
      'productDefinitionId': productDefinitionId,
      'routeId': routeId,
      'plannedQuantity': plannedQuantity,
      'completedQuantity': completedQuantity,
      'rejectedQuantity': rejectedQuantity,
      'status': status.toJson(),
      if (scheduledStart != null) 'scheduledStart': scheduledStart?.toJson(),
      if (scheduledEnd != null) 'scheduledEnd': scheduledEnd?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProductionOrderInclude include() {
    return ProductionOrderInclude._();
  }

  static ProductionOrderIncludeList includeList({
    _i1.WhereExpressionBuilder<ProductionOrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductionOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductionOrderTable>? orderByList,
    ProductionOrderInclude? include,
  }) {
    return ProductionOrderIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductionOrder.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProductionOrder.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductionOrderImpl extends ProductionOrder {
  _ProductionOrderImpl({
    int? id,
    required int companyId,
    required String orderNumber,
    required int productDefinitionId,
    required int routeId,
    required int plannedQuantity,
    int? completedQuantity,
    int? rejectedQuantity,
    required _i2.ProductionOrderStatus status,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    DateTime? startedAt,
    DateTime? completedAt,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         orderNumber: orderNumber,
         productDefinitionId: productDefinitionId,
         routeId: routeId,
         plannedQuantity: plannedQuantity,
         completedQuantity: completedQuantity,
         rejectedQuantity: rejectedQuantity,
         status: status,
         scheduledStart: scheduledStart,
         scheduledEnd: scheduledEnd,
         startedAt: startedAt,
         completedAt: completedAt,
         createdBy: createdBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProductionOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductionOrder copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? orderNumber,
    int? productDefinitionId,
    int? routeId,
    int? plannedQuantity,
    int? completedQuantity,
    int? rejectedQuantity,
    _i2.ProductionOrderStatus? status,
    Object? scheduledStart = _Undefined,
    Object? scheduledEnd = _Undefined,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductionOrder(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      orderNumber: orderNumber ?? this.orderNumber,
      productDefinitionId: productDefinitionId ?? this.productDefinitionId,
      routeId: routeId ?? this.routeId,
      plannedQuantity: plannedQuantity ?? this.plannedQuantity,
      completedQuantity: completedQuantity ?? this.completedQuantity,
      rejectedQuantity: rejectedQuantity ?? this.rejectedQuantity,
      status: status ?? this.status,
      scheduledStart: scheduledStart is DateTime?
          ? scheduledStart
          : this.scheduledStart,
      scheduledEnd: scheduledEnd is DateTime?
          ? scheduledEnd
          : this.scheduledEnd,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProductionOrderUpdateTable extends _i1.UpdateTable<ProductionOrderTable> {
  ProductionOrderUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> orderNumber(String value) => _i1.ColumnValue(
    table.orderNumber,
    value,
  );

  _i1.ColumnValue<int, int> productDefinitionId(int value) => _i1.ColumnValue(
    table.productDefinitionId,
    value,
  );

  _i1.ColumnValue<int, int> routeId(int value) => _i1.ColumnValue(
    table.routeId,
    value,
  );

  _i1.ColumnValue<int, int> plannedQuantity(int value) => _i1.ColumnValue(
    table.plannedQuantity,
    value,
  );

  _i1.ColumnValue<int, int> completedQuantity(int value) => _i1.ColumnValue(
    table.completedQuantity,
    value,
  );

  _i1.ColumnValue<int, int> rejectedQuantity(int value) => _i1.ColumnValue(
    table.rejectedQuantity,
    value,
  );

  _i1.ColumnValue<_i2.ProductionOrderStatus, _i2.ProductionOrderStatus> status(
    _i2.ProductionOrderStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> scheduledStart(DateTime? value) =>
      _i1.ColumnValue(
        table.scheduledStart,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> scheduledEnd(DateTime? value) =>
      _i1.ColumnValue(
        table.scheduledEnd,
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

  _i1.ColumnValue<String, String> createdBy(String value) => _i1.ColumnValue(
    table.createdBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ProductionOrderTable extends _i1.Table<int?> {
  ProductionOrderTable({super.tableRelation})
    : super(tableName: 'production_order') {
    updateTable = ProductionOrderUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    orderNumber = _i1.ColumnString(
      'orderNumber',
      this,
    );
    productDefinitionId = _i1.ColumnInt(
      'productDefinitionId',
      this,
    );
    routeId = _i1.ColumnInt(
      'routeId',
      this,
    );
    plannedQuantity = _i1.ColumnInt(
      'plannedQuantity',
      this,
    );
    completedQuantity = _i1.ColumnInt(
      'completedQuantity',
      this,
      hasDefault: true,
    );
    rejectedQuantity = _i1.ColumnInt(
      'rejectedQuantity',
      this,
      hasDefault: true,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    scheduledStart = _i1.ColumnDateTime(
      'scheduledStart',
      this,
    );
    scheduledEnd = _i1.ColumnDateTime(
      'scheduledEnd',
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
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ProductionOrderUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnString orderNumber;

  late final _i1.ColumnInt productDefinitionId;

  late final _i1.ColumnInt routeId;

  late final _i1.ColumnInt plannedQuantity;

  late final _i1.ColumnInt completedQuantity;

  late final _i1.ColumnInt rejectedQuantity;

  late final _i1.ColumnEnum<_i2.ProductionOrderStatus> status;

  late final _i1.ColumnDateTime scheduledStart;

  late final _i1.ColumnDateTime scheduledEnd;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    orderNumber,
    productDefinitionId,
    routeId,
    plannedQuantity,
    completedQuantity,
    rejectedQuantity,
    status,
    scheduledStart,
    scheduledEnd,
    startedAt,
    completedAt,
    createdBy,
    createdAt,
    updatedAt,
  ];
}

class ProductionOrderInclude extends _i1.IncludeObject {
  ProductionOrderInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProductionOrder.t;
}

class ProductionOrderIncludeList extends _i1.IncludeList {
  ProductionOrderIncludeList._({
    _i1.WhereExpressionBuilder<ProductionOrderTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductionOrder.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProductionOrder.t;
}

class ProductionOrderRepository {
  const ProductionOrderRepository._();

  /// Returns a list of [ProductionOrder]s matching the given query parameters.
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
  Future<List<ProductionOrder>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductionOrderTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductionOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductionOrderTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductionOrder>(
      where: where?.call(ProductionOrder.t),
      orderBy: orderBy?.call(ProductionOrder.t),
      orderByList: orderByList?.call(ProductionOrder.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProductionOrder] matching the given query parameters.
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
  Future<ProductionOrder?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductionOrderTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProductionOrderTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductionOrderTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductionOrder>(
      where: where?.call(ProductionOrder.t),
      orderBy: orderBy?.call(ProductionOrder.t),
      orderByList: orderByList?.call(ProductionOrder.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductionOrder] by its [id] or null if no such row exists.
  Future<ProductionOrder?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProductionOrder>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProductionOrder]s in the list and returns the inserted rows.
  ///
  /// The returned [ProductionOrder]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProductionOrder>> insert(
    _i1.DatabaseSession session,
    List<ProductionOrder> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProductionOrder>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProductionOrder] and returns the inserted row.
  ///
  /// The returned [ProductionOrder] will have its `id` field set.
  Future<ProductionOrder> insertRow(
    _i1.DatabaseSession session,
    ProductionOrder row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductionOrder>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProductionOrder]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProductionOrder>> update(
    _i1.DatabaseSession session,
    List<ProductionOrder> rows, {
    _i1.ColumnSelections<ProductionOrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProductionOrder>(
      rows,
      columns: columns?.call(ProductionOrder.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductionOrder]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductionOrder> updateRow(
    _i1.DatabaseSession session,
    ProductionOrder row, {
    _i1.ColumnSelections<ProductionOrderTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProductionOrder>(
      row,
      columns: columns?.call(ProductionOrder.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductionOrder] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProductionOrder?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProductionOrderUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductionOrder>(
      id,
      columnValues: columnValues(ProductionOrder.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductionOrder]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProductionOrder>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProductionOrderUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ProductionOrderTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductionOrderTable>? orderBy,
    _i1.OrderByListBuilder<ProductionOrderTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProductionOrder>(
      columnValues: columnValues(ProductionOrder.t.updateTable),
      where: where(ProductionOrder.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductionOrder.t),
      orderByList: orderByList?.call(ProductionOrder.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProductionOrder]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProductionOrder>> delete(
    _i1.DatabaseSession session,
    List<ProductionOrder> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProductionOrder>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProductionOrder].
  Future<ProductionOrder> deleteRow(
    _i1.DatabaseSession session,
    ProductionOrder row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductionOrder>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProductionOrder>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductionOrderTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProductionOrder>(
      where: where(ProductionOrder.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductionOrderTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProductionOrder>(
      where: where?.call(ProductionOrder.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductionOrder] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductionOrderTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductionOrder>(
      where: where(ProductionOrder.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
