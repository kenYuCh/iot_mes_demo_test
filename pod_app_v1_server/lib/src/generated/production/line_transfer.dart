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
import '../production/line_transfer_status.dart' as _i2;

abstract class LineTransfer
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LineTransfer._({
    this.id,
    required this.companyId,
    required this.productUnitId,
    required this.productionOrderId,
    required this.fromLineId,
    required this.toLineId,
    required this.fromWorkstationId,
    required this.toWorkstationId,
    required this.fromNodeId,
    required this.toNodeId,
    required this.status,
    this.dispatchedBy,
    this.dispatchedAt,
    this.receivedBy,
    this.receivedAt,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LineTransfer({
    int? id,
    required int companyId,
    required int productUnitId,
    required int productionOrderId,
    required int fromLineId,
    required int toLineId,
    required int fromWorkstationId,
    required int toWorkstationId,
    required int fromNodeId,
    required int toNodeId,
    required _i2.LineTransferStatus status,
    String? dispatchedBy,
    DateTime? dispatchedAt,
    String? receivedBy,
    DateTime? receivedAt,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LineTransferImpl;

  factory LineTransfer.fromJson(Map<String, dynamic> jsonSerialization) {
    return LineTransfer(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      productUnitId: jsonSerialization['productUnitId'] as int,
      productionOrderId: jsonSerialization['productionOrderId'] as int,
      fromLineId: jsonSerialization['fromLineId'] as int,
      toLineId: jsonSerialization['toLineId'] as int,
      fromWorkstationId: jsonSerialization['fromWorkstationId'] as int,
      toWorkstationId: jsonSerialization['toWorkstationId'] as int,
      fromNodeId: jsonSerialization['fromNodeId'] as int,
      toNodeId: jsonSerialization['toNodeId'] as int,
      status: _i2.LineTransferStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      dispatchedBy: jsonSerialization['dispatchedBy'] as String?,
      dispatchedAt: jsonSerialization['dispatchedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['dispatchedAt'],
            ),
      receivedBy: jsonSerialization['receivedBy'] as String?,
      receivedAt: jsonSerialization['receivedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['receivedAt']),
      note: jsonSerialization['note'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = LineTransferTable();

  static const db = LineTransferRepository._();

  @override
  int? id;

  int companyId;

  int productUnitId;

  int productionOrderId;

  int fromLineId;

  int toLineId;

  int fromWorkstationId;

  int toWorkstationId;

  int fromNodeId;

  int toNodeId;

  _i2.LineTransferStatus status;

  String? dispatchedBy;

  DateTime? dispatchedAt;

  String? receivedBy;

  DateTime? receivedAt;

  String? note;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LineTransfer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LineTransfer copyWith({
    int? id,
    int? companyId,
    int? productUnitId,
    int? productionOrderId,
    int? fromLineId,
    int? toLineId,
    int? fromWorkstationId,
    int? toWorkstationId,
    int? fromNodeId,
    int? toNodeId,
    _i2.LineTransferStatus? status,
    String? dispatchedBy,
    DateTime? dispatchedAt,
    String? receivedBy,
    DateTime? receivedAt,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LineTransfer',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productUnitId': productUnitId,
      'productionOrderId': productionOrderId,
      'fromLineId': fromLineId,
      'toLineId': toLineId,
      'fromWorkstationId': fromWorkstationId,
      'toWorkstationId': toWorkstationId,
      'fromNodeId': fromNodeId,
      'toNodeId': toNodeId,
      'status': status.toJson(),
      if (dispatchedBy != null) 'dispatchedBy': dispatchedBy,
      if (dispatchedAt != null) 'dispatchedAt': dispatchedAt?.toJson(),
      if (receivedBy != null) 'receivedBy': receivedBy,
      if (receivedAt != null) 'receivedAt': receivedAt?.toJson(),
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LineTransfer',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productUnitId': productUnitId,
      'productionOrderId': productionOrderId,
      'fromLineId': fromLineId,
      'toLineId': toLineId,
      'fromWorkstationId': fromWorkstationId,
      'toWorkstationId': toWorkstationId,
      'fromNodeId': fromNodeId,
      'toNodeId': toNodeId,
      'status': status.toJson(),
      if (dispatchedBy != null) 'dispatchedBy': dispatchedBy,
      if (dispatchedAt != null) 'dispatchedAt': dispatchedAt?.toJson(),
      if (receivedBy != null) 'receivedBy': receivedBy,
      if (receivedAt != null) 'receivedAt': receivedAt?.toJson(),
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static LineTransferInclude include() {
    return LineTransferInclude._();
  }

  static LineTransferIncludeList includeList({
    _i1.WhereExpressionBuilder<LineTransferTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LineTransferTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LineTransferTable>? orderByList,
    LineTransferInclude? include,
  }) {
    return LineTransferIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LineTransfer.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LineTransfer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LineTransferImpl extends LineTransfer {
  _LineTransferImpl({
    int? id,
    required int companyId,
    required int productUnitId,
    required int productionOrderId,
    required int fromLineId,
    required int toLineId,
    required int fromWorkstationId,
    required int toWorkstationId,
    required int fromNodeId,
    required int toNodeId,
    required _i2.LineTransferStatus status,
    String? dispatchedBy,
    DateTime? dispatchedAt,
    String? receivedBy,
    DateTime? receivedAt,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         productUnitId: productUnitId,
         productionOrderId: productionOrderId,
         fromLineId: fromLineId,
         toLineId: toLineId,
         fromWorkstationId: fromWorkstationId,
         toWorkstationId: toWorkstationId,
         fromNodeId: fromNodeId,
         toNodeId: toNodeId,
         status: status,
         dispatchedBy: dispatchedBy,
         dispatchedAt: dispatchedAt,
         receivedBy: receivedBy,
         receivedAt: receivedAt,
         note: note,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [LineTransfer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LineTransfer copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? productUnitId,
    int? productionOrderId,
    int? fromLineId,
    int? toLineId,
    int? fromWorkstationId,
    int? toWorkstationId,
    int? fromNodeId,
    int? toNodeId,
    _i2.LineTransferStatus? status,
    Object? dispatchedBy = _Undefined,
    Object? dispatchedAt = _Undefined,
    Object? receivedBy = _Undefined,
    Object? receivedAt = _Undefined,
    Object? note = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LineTransfer(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      productUnitId: productUnitId ?? this.productUnitId,
      productionOrderId: productionOrderId ?? this.productionOrderId,
      fromLineId: fromLineId ?? this.fromLineId,
      toLineId: toLineId ?? this.toLineId,
      fromWorkstationId: fromWorkstationId ?? this.fromWorkstationId,
      toWorkstationId: toWorkstationId ?? this.toWorkstationId,
      fromNodeId: fromNodeId ?? this.fromNodeId,
      toNodeId: toNodeId ?? this.toNodeId,
      status: status ?? this.status,
      dispatchedBy: dispatchedBy is String? ? dispatchedBy : this.dispatchedBy,
      dispatchedAt: dispatchedAt is DateTime?
          ? dispatchedAt
          : this.dispatchedAt,
      receivedBy: receivedBy is String? ? receivedBy : this.receivedBy,
      receivedAt: receivedAt is DateTime? ? receivedAt : this.receivedAt,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class LineTransferUpdateTable extends _i1.UpdateTable<LineTransferTable> {
  LineTransferUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> productUnitId(int value) => _i1.ColumnValue(
    table.productUnitId,
    value,
  );

  _i1.ColumnValue<int, int> productionOrderId(int value) => _i1.ColumnValue(
    table.productionOrderId,
    value,
  );

  _i1.ColumnValue<int, int> fromLineId(int value) => _i1.ColumnValue(
    table.fromLineId,
    value,
  );

  _i1.ColumnValue<int, int> toLineId(int value) => _i1.ColumnValue(
    table.toLineId,
    value,
  );

  _i1.ColumnValue<int, int> fromWorkstationId(int value) => _i1.ColumnValue(
    table.fromWorkstationId,
    value,
  );

  _i1.ColumnValue<int, int> toWorkstationId(int value) => _i1.ColumnValue(
    table.toWorkstationId,
    value,
  );

  _i1.ColumnValue<int, int> fromNodeId(int value) => _i1.ColumnValue(
    table.fromNodeId,
    value,
  );

  _i1.ColumnValue<int, int> toNodeId(int value) => _i1.ColumnValue(
    table.toNodeId,
    value,
  );

  _i1.ColumnValue<_i2.LineTransferStatus, _i2.LineTransferStatus> status(
    _i2.LineTransferStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> dispatchedBy(String? value) =>
      _i1.ColumnValue(
        table.dispatchedBy,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> dispatchedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.dispatchedAt,
        value,
      );

  _i1.ColumnValue<String, String> receivedBy(String? value) => _i1.ColumnValue(
    table.receivedBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> receivedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.receivedAt,
        value,
      );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
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

class LineTransferTable extends _i1.Table<int?> {
  LineTransferTable({super.tableRelation}) : super(tableName: 'line_transfer') {
    updateTable = LineTransferUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    productUnitId = _i1.ColumnInt(
      'productUnitId',
      this,
    );
    productionOrderId = _i1.ColumnInt(
      'productionOrderId',
      this,
    );
    fromLineId = _i1.ColumnInt(
      'fromLineId',
      this,
    );
    toLineId = _i1.ColumnInt(
      'toLineId',
      this,
    );
    fromWorkstationId = _i1.ColumnInt(
      'fromWorkstationId',
      this,
    );
    toWorkstationId = _i1.ColumnInt(
      'toWorkstationId',
      this,
    );
    fromNodeId = _i1.ColumnInt(
      'fromNodeId',
      this,
    );
    toNodeId = _i1.ColumnInt(
      'toNodeId',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    dispatchedBy = _i1.ColumnString(
      'dispatchedBy',
      this,
    );
    dispatchedAt = _i1.ColumnDateTime(
      'dispatchedAt',
      this,
    );
    receivedBy = _i1.ColumnString(
      'receivedBy',
      this,
    );
    receivedAt = _i1.ColumnDateTime(
      'receivedAt',
      this,
    );
    note = _i1.ColumnString(
      'note',
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

  late final LineTransferUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt productUnitId;

  late final _i1.ColumnInt productionOrderId;

  late final _i1.ColumnInt fromLineId;

  late final _i1.ColumnInt toLineId;

  late final _i1.ColumnInt fromWorkstationId;

  late final _i1.ColumnInt toWorkstationId;

  late final _i1.ColumnInt fromNodeId;

  late final _i1.ColumnInt toNodeId;

  late final _i1.ColumnEnum<_i2.LineTransferStatus> status;

  late final _i1.ColumnString dispatchedBy;

  late final _i1.ColumnDateTime dispatchedAt;

  late final _i1.ColumnString receivedBy;

  late final _i1.ColumnDateTime receivedAt;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    productUnitId,
    productionOrderId,
    fromLineId,
    toLineId,
    fromWorkstationId,
    toWorkstationId,
    fromNodeId,
    toNodeId,
    status,
    dispatchedBy,
    dispatchedAt,
    receivedBy,
    receivedAt,
    note,
    createdAt,
    updatedAt,
  ];
}

class LineTransferInclude extends _i1.IncludeObject {
  LineTransferInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LineTransfer.t;
}

class LineTransferIncludeList extends _i1.IncludeList {
  LineTransferIncludeList._({
    _i1.WhereExpressionBuilder<LineTransferTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LineTransfer.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LineTransfer.t;
}

class LineTransferRepository {
  const LineTransferRepository._();

  /// Returns a list of [LineTransfer]s matching the given query parameters.
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
  Future<List<LineTransfer>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LineTransferTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LineTransferTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LineTransferTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LineTransfer>(
      where: where?.call(LineTransfer.t),
      orderBy: orderBy?.call(LineTransfer.t),
      orderByList: orderByList?.call(LineTransfer.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LineTransfer] matching the given query parameters.
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
  Future<LineTransfer?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LineTransferTable>? where,
    int? offset,
    _i1.OrderByBuilder<LineTransferTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LineTransferTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LineTransfer>(
      where: where?.call(LineTransfer.t),
      orderBy: orderBy?.call(LineTransfer.t),
      orderByList: orderByList?.call(LineTransfer.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LineTransfer] by its [id] or null if no such row exists.
  Future<LineTransfer?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LineTransfer>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LineTransfer]s in the list and returns the inserted rows.
  ///
  /// The returned [LineTransfer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LineTransfer>> insert(
    _i1.DatabaseSession session,
    List<LineTransfer> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LineTransfer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LineTransfer] and returns the inserted row.
  ///
  /// The returned [LineTransfer] will have its `id` field set.
  Future<LineTransfer> insertRow(
    _i1.DatabaseSession session,
    LineTransfer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LineTransfer>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LineTransfer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LineTransfer>> update(
    _i1.DatabaseSession session,
    List<LineTransfer> rows, {
    _i1.ColumnSelections<LineTransferTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LineTransfer>(
      rows,
      columns: columns?.call(LineTransfer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LineTransfer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LineTransfer> updateRow(
    _i1.DatabaseSession session,
    LineTransfer row, {
    _i1.ColumnSelections<LineTransferTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LineTransfer>(
      row,
      columns: columns?.call(LineTransfer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LineTransfer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LineTransfer?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LineTransferUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LineTransfer>(
      id,
      columnValues: columnValues(LineTransfer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LineTransfer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LineTransfer>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LineTransferUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<LineTransferTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LineTransferTable>? orderBy,
    _i1.OrderByListBuilder<LineTransferTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LineTransfer>(
      columnValues: columnValues(LineTransfer.t.updateTable),
      where: where(LineTransfer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LineTransfer.t),
      orderByList: orderByList?.call(LineTransfer.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LineTransfer]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LineTransfer>> delete(
    _i1.DatabaseSession session,
    List<LineTransfer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LineTransfer>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LineTransfer].
  Future<LineTransfer> deleteRow(
    _i1.DatabaseSession session,
    LineTransfer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LineTransfer>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LineTransfer>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LineTransferTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LineTransfer>(
      where: where(LineTransfer.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LineTransferTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LineTransfer>(
      where: where?.call(LineTransfer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LineTransfer] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LineTransferTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LineTransfer>(
      where: where(LineTransfer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
