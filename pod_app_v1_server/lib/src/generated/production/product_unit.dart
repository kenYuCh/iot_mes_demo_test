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
import '../production/product_unit_status.dart' as _i2;

abstract class ProductUnit
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProductUnit._({
    this.id,
    required this.companyId,
    required this.productionOrderId,
    required this.productDefinitionId,
    required this.serialNumber,
    required this.qrCode,
    this.rfidEpc,
    required this.status,
    this.currentNodeId,
    this.currentStationCode,
    this.enteredNodeAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductUnit({
    int? id,
    required int companyId,
    required int productionOrderId,
    required int productDefinitionId,
    required String serialNumber,
    required String qrCode,
    String? rfidEpc,
    required _i2.ProductUnitStatus status,
    int? currentNodeId,
    String? currentStationCode,
    DateTime? enteredNodeAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProductUnitImpl;

  factory ProductUnit.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductUnit(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      productionOrderId: jsonSerialization['productionOrderId'] as int,
      productDefinitionId: jsonSerialization['productDefinitionId'] as int,
      serialNumber: jsonSerialization['serialNumber'] as String,
      qrCode: jsonSerialization['qrCode'] as String,
      rfidEpc: jsonSerialization['rfidEpc'] as String?,
      status: _i2.ProductUnitStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      currentNodeId: jsonSerialization['currentNodeId'] as int?,
      currentStationCode: jsonSerialization['currentStationCode'] as String?,
      enteredNodeAt: jsonSerialization['enteredNodeAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['enteredNodeAt'],
            ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ProductUnitTable();

  static const db = ProductUnitRepository._();

  @override
  int? id;

  int companyId;

  int productionOrderId;

  int productDefinitionId;

  String serialNumber;

  String qrCode;

  String? rfidEpc;

  _i2.ProductUnitStatus status;

  int? currentNodeId;

  String? currentStationCode;

  DateTime? enteredNodeAt;

  DateTime? completedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProductUnit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductUnit copyWith({
    int? id,
    int? companyId,
    int? productionOrderId,
    int? productDefinitionId,
    String? serialNumber,
    String? qrCode,
    String? rfidEpc,
    _i2.ProductUnitStatus? status,
    int? currentNodeId,
    String? currentStationCode,
    DateTime? enteredNodeAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductUnit',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productionOrderId': productionOrderId,
      'productDefinitionId': productDefinitionId,
      'serialNumber': serialNumber,
      'qrCode': qrCode,
      if (rfidEpc != null) 'rfidEpc': rfidEpc,
      'status': status.toJson(),
      if (currentNodeId != null) 'currentNodeId': currentNodeId,
      if (currentStationCode != null) 'currentStationCode': currentStationCode,
      if (enteredNodeAt != null) 'enteredNodeAt': enteredNodeAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProductUnit',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productionOrderId': productionOrderId,
      'productDefinitionId': productDefinitionId,
      'serialNumber': serialNumber,
      'qrCode': qrCode,
      if (rfidEpc != null) 'rfidEpc': rfidEpc,
      'status': status.toJson(),
      if (currentNodeId != null) 'currentNodeId': currentNodeId,
      if (currentStationCode != null) 'currentStationCode': currentStationCode,
      if (enteredNodeAt != null) 'enteredNodeAt': enteredNodeAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProductUnitInclude include() {
    return ProductUnitInclude._();
  }

  static ProductUnitIncludeList includeList({
    _i1.WhereExpressionBuilder<ProductUnitTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductUnitTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductUnitTable>? orderByList,
    ProductUnitInclude? include,
  }) {
    return ProductUnitIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductUnit.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProductUnit.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductUnitImpl extends ProductUnit {
  _ProductUnitImpl({
    int? id,
    required int companyId,
    required int productionOrderId,
    required int productDefinitionId,
    required String serialNumber,
    required String qrCode,
    String? rfidEpc,
    required _i2.ProductUnitStatus status,
    int? currentNodeId,
    String? currentStationCode,
    DateTime? enteredNodeAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         productionOrderId: productionOrderId,
         productDefinitionId: productDefinitionId,
         serialNumber: serialNumber,
         qrCode: qrCode,
         rfidEpc: rfidEpc,
         status: status,
         currentNodeId: currentNodeId,
         currentStationCode: currentStationCode,
         enteredNodeAt: enteredNodeAt,
         completedAt: completedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProductUnit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductUnit copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? productionOrderId,
    int? productDefinitionId,
    String? serialNumber,
    String? qrCode,
    Object? rfidEpc = _Undefined,
    _i2.ProductUnitStatus? status,
    Object? currentNodeId = _Undefined,
    Object? currentStationCode = _Undefined,
    Object? enteredNodeAt = _Undefined,
    Object? completedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductUnit(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      productionOrderId: productionOrderId ?? this.productionOrderId,
      productDefinitionId: productDefinitionId ?? this.productDefinitionId,
      serialNumber: serialNumber ?? this.serialNumber,
      qrCode: qrCode ?? this.qrCode,
      rfidEpc: rfidEpc is String? ? rfidEpc : this.rfidEpc,
      status: status ?? this.status,
      currentNodeId: currentNodeId is int? ? currentNodeId : this.currentNodeId,
      currentStationCode: currentStationCode is String?
          ? currentStationCode
          : this.currentStationCode,
      enteredNodeAt: enteredNodeAt is DateTime?
          ? enteredNodeAt
          : this.enteredNodeAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProductUnitUpdateTable extends _i1.UpdateTable<ProductUnitTable> {
  ProductUnitUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> productionOrderId(int value) => _i1.ColumnValue(
    table.productionOrderId,
    value,
  );

  _i1.ColumnValue<int, int> productDefinitionId(int value) => _i1.ColumnValue(
    table.productDefinitionId,
    value,
  );

  _i1.ColumnValue<String, String> serialNumber(String value) => _i1.ColumnValue(
    table.serialNumber,
    value,
  );

  _i1.ColumnValue<String, String> qrCode(String value) => _i1.ColumnValue(
    table.qrCode,
    value,
  );

  _i1.ColumnValue<String, String> rfidEpc(String? value) => _i1.ColumnValue(
    table.rfidEpc,
    value,
  );

  _i1.ColumnValue<_i2.ProductUnitStatus, _i2.ProductUnitStatus> status(
    _i2.ProductUnitStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> currentNodeId(int? value) => _i1.ColumnValue(
    table.currentNodeId,
    value,
  );

  _i1.ColumnValue<String, String> currentStationCode(String? value) =>
      _i1.ColumnValue(
        table.currentStationCode,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> enteredNodeAt(DateTime? value) =>
      _i1.ColumnValue(
        table.enteredNodeAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
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

class ProductUnitTable extends _i1.Table<int?> {
  ProductUnitTable({super.tableRelation}) : super(tableName: 'product_unit') {
    updateTable = ProductUnitUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    productionOrderId = _i1.ColumnInt(
      'productionOrderId',
      this,
    );
    productDefinitionId = _i1.ColumnInt(
      'productDefinitionId',
      this,
    );
    serialNumber = _i1.ColumnString(
      'serialNumber',
      this,
    );
    qrCode = _i1.ColumnString(
      'qrCode',
      this,
    );
    rfidEpc = _i1.ColumnString(
      'rfidEpc',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    currentNodeId = _i1.ColumnInt(
      'currentNodeId',
      this,
    );
    currentStationCode = _i1.ColumnString(
      'currentStationCode',
      this,
    );
    enteredNodeAt = _i1.ColumnDateTime(
      'enteredNodeAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
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

  late final ProductUnitUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt productionOrderId;

  late final _i1.ColumnInt productDefinitionId;

  late final _i1.ColumnString serialNumber;

  late final _i1.ColumnString qrCode;

  late final _i1.ColumnString rfidEpc;

  late final _i1.ColumnEnum<_i2.ProductUnitStatus> status;

  late final _i1.ColumnInt currentNodeId;

  late final _i1.ColumnString currentStationCode;

  late final _i1.ColumnDateTime enteredNodeAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    productionOrderId,
    productDefinitionId,
    serialNumber,
    qrCode,
    rfidEpc,
    status,
    currentNodeId,
    currentStationCode,
    enteredNodeAt,
    completedAt,
    createdAt,
    updatedAt,
  ];
}

class ProductUnitInclude extends _i1.IncludeObject {
  ProductUnitInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProductUnit.t;
}

class ProductUnitIncludeList extends _i1.IncludeList {
  ProductUnitIncludeList._({
    _i1.WhereExpressionBuilder<ProductUnitTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductUnit.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProductUnit.t;
}

class ProductUnitRepository {
  const ProductUnitRepository._();

  /// Returns a list of [ProductUnit]s matching the given query parameters.
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
  Future<List<ProductUnit>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductUnitTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductUnitTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductUnitTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductUnit>(
      where: where?.call(ProductUnit.t),
      orderBy: orderBy?.call(ProductUnit.t),
      orderByList: orderByList?.call(ProductUnit.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProductUnit] matching the given query parameters.
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
  Future<ProductUnit?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductUnitTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProductUnitTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductUnitTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductUnit>(
      where: where?.call(ProductUnit.t),
      orderBy: orderBy?.call(ProductUnit.t),
      orderByList: orderByList?.call(ProductUnit.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductUnit] by its [id] or null if no such row exists.
  Future<ProductUnit?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProductUnit>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProductUnit]s in the list and returns the inserted rows.
  ///
  /// The returned [ProductUnit]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProductUnit>> insert(
    _i1.DatabaseSession session,
    List<ProductUnit> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProductUnit>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProductUnit] and returns the inserted row.
  ///
  /// The returned [ProductUnit] will have its `id` field set.
  Future<ProductUnit> insertRow(
    _i1.DatabaseSession session,
    ProductUnit row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductUnit>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProductUnit]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProductUnit>> update(
    _i1.DatabaseSession session,
    List<ProductUnit> rows, {
    _i1.ColumnSelections<ProductUnitTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProductUnit>(
      rows,
      columns: columns?.call(ProductUnit.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductUnit]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductUnit> updateRow(
    _i1.DatabaseSession session,
    ProductUnit row, {
    _i1.ColumnSelections<ProductUnitTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProductUnit>(
      row,
      columns: columns?.call(ProductUnit.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductUnit] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProductUnit?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProductUnitUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductUnit>(
      id,
      columnValues: columnValues(ProductUnit.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductUnit]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProductUnit>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProductUnitUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProductUnitTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductUnitTable>? orderBy,
    _i1.OrderByListBuilder<ProductUnitTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProductUnit>(
      columnValues: columnValues(ProductUnit.t.updateTable),
      where: where(ProductUnit.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductUnit.t),
      orderByList: orderByList?.call(ProductUnit.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProductUnit]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProductUnit>> delete(
    _i1.DatabaseSession session,
    List<ProductUnit> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProductUnit>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProductUnit].
  Future<ProductUnit> deleteRow(
    _i1.DatabaseSession session,
    ProductUnit row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductUnit>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProductUnit>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductUnitTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProductUnit>(
      where: where(ProductUnit.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductUnitTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProductUnit>(
      where: where?.call(ProductUnit.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductUnit] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductUnitTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductUnit>(
      where: where(ProductUnit.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
