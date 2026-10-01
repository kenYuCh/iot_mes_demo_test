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

abstract class MaterialLot
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MaterialLot._({
    this.id,
    required this.companyId,
    required this.materialId,
    required this.lotNumber,
    required this.quantity,
    required this.receivedAt,
    this.expiresAt,
    this.supplierLot,
    this.qrCode,
    this.rfidEpc,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MaterialLot({
    int? id,
    required int companyId,
    required int materialId,
    required String lotNumber,
    required double quantity,
    required DateTime receivedAt,
    DateTime? expiresAt,
    String? supplierLot,
    String? qrCode,
    String? rfidEpc,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MaterialLotImpl;

  factory MaterialLot.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaterialLot(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      materialId: jsonSerialization['materialId'] as int,
      lotNumber: jsonSerialization['lotNumber'] as String,
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      receivedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      supplierLot: jsonSerialization['supplierLot'] as String?,
      qrCode: jsonSerialization['qrCode'] as String?,
      rfidEpc: jsonSerialization['rfidEpc'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = MaterialLotTable();

  static const db = MaterialLotRepository._();

  @override
  int? id;

  int companyId;

  int materialId;

  String lotNumber;

  double quantity;

  DateTime receivedAt;

  DateTime? expiresAt;

  String? supplierLot;

  String? qrCode;

  String? rfidEpc;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MaterialLot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MaterialLot copyWith({
    int? id,
    int? companyId,
    int? materialId,
    String? lotNumber,
    double? quantity,
    DateTime? receivedAt,
    DateTime? expiresAt,
    String? supplierLot,
    String? qrCode,
    String? rfidEpc,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaterialLot',
      if (id != null) 'id': id,
      'companyId': companyId,
      'materialId': materialId,
      'lotNumber': lotNumber,
      'quantity': quantity,
      'receivedAt': receivedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (supplierLot != null) 'supplierLot': supplierLot,
      if (qrCode != null) 'qrCode': qrCode,
      if (rfidEpc != null) 'rfidEpc': rfidEpc,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MaterialLot',
      if (id != null) 'id': id,
      'companyId': companyId,
      'materialId': materialId,
      'lotNumber': lotNumber,
      'quantity': quantity,
      'receivedAt': receivedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (supplierLot != null) 'supplierLot': supplierLot,
      if (qrCode != null) 'qrCode': qrCode,
      if (rfidEpc != null) 'rfidEpc': rfidEpc,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MaterialLotInclude include() {
    return MaterialLotInclude._();
  }

  static MaterialLotIncludeList includeList({
    _i1.WhereExpressionBuilder<MaterialLotTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialLotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialLotTable>? orderByList,
    MaterialLotInclude? include,
  }) {
    return MaterialLotIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaterialLot.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MaterialLot.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaterialLotImpl extends MaterialLot {
  _MaterialLotImpl({
    int? id,
    required int companyId,
    required int materialId,
    required String lotNumber,
    required double quantity,
    required DateTime receivedAt,
    DateTime? expiresAt,
    String? supplierLot,
    String? qrCode,
    String? rfidEpc,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         materialId: materialId,
         lotNumber: lotNumber,
         quantity: quantity,
         receivedAt: receivedAt,
         expiresAt: expiresAt,
         supplierLot: supplierLot,
         qrCode: qrCode,
         rfidEpc: rfidEpc,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MaterialLot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MaterialLot copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? materialId,
    String? lotNumber,
    double? quantity,
    DateTime? receivedAt,
    Object? expiresAt = _Undefined,
    Object? supplierLot = _Undefined,
    Object? qrCode = _Undefined,
    Object? rfidEpc = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MaterialLot(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      materialId: materialId ?? this.materialId,
      lotNumber: lotNumber ?? this.lotNumber,
      quantity: quantity ?? this.quantity,
      receivedAt: receivedAt ?? this.receivedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      supplierLot: supplierLot is String? ? supplierLot : this.supplierLot,
      qrCode: qrCode is String? ? qrCode : this.qrCode,
      rfidEpc: rfidEpc is String? ? rfidEpc : this.rfidEpc,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MaterialLotUpdateTable extends _i1.UpdateTable<MaterialLotTable> {
  MaterialLotUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> materialId(int value) => _i1.ColumnValue(
    table.materialId,
    value,
  );

  _i1.ColumnValue<String, String> lotNumber(String value) => _i1.ColumnValue(
    table.lotNumber,
    value,
  );

  _i1.ColumnValue<double, double> quantity(double value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> receivedAt(DateTime value) =>
      _i1.ColumnValue(
        table.receivedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<String, String> supplierLot(String? value) => _i1.ColumnValue(
    table.supplierLot,
    value,
  );

  _i1.ColumnValue<String, String> qrCode(String? value) => _i1.ColumnValue(
    table.qrCode,
    value,
  );

  _i1.ColumnValue<String, String> rfidEpc(String? value) => _i1.ColumnValue(
    table.rfidEpc,
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

class MaterialLotTable extends _i1.Table<int?> {
  MaterialLotTable({super.tableRelation}) : super(tableName: 'material_lot') {
    updateTable = MaterialLotUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    materialId = _i1.ColumnInt(
      'materialId',
      this,
    );
    lotNumber = _i1.ColumnString(
      'lotNumber',
      this,
    );
    quantity = _i1.ColumnDouble(
      'quantity',
      this,
    );
    receivedAt = _i1.ColumnDateTime(
      'receivedAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    supplierLot = _i1.ColumnString(
      'supplierLot',
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
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final MaterialLotUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt materialId;

  late final _i1.ColumnString lotNumber;

  late final _i1.ColumnDouble quantity;

  late final _i1.ColumnDateTime receivedAt;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnString supplierLot;

  late final _i1.ColumnString qrCode;

  late final _i1.ColumnString rfidEpc;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    materialId,
    lotNumber,
    quantity,
    receivedAt,
    expiresAt,
    supplierLot,
    qrCode,
    rfidEpc,
    createdAt,
    updatedAt,
  ];
}

class MaterialLotInclude extends _i1.IncludeObject {
  MaterialLotInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MaterialLot.t;
}

class MaterialLotIncludeList extends _i1.IncludeList {
  MaterialLotIncludeList._({
    _i1.WhereExpressionBuilder<MaterialLotTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MaterialLot.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MaterialLot.t;
}

class MaterialLotRepository {
  const MaterialLotRepository._();

  /// Returns a list of [MaterialLot]s matching the given query parameters.
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
  Future<List<MaterialLot>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MaterialLotTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialLotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialLotTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MaterialLot>(
      where: where?.call(MaterialLot.t),
      orderBy: orderBy?.call(MaterialLot.t),
      orderByList: orderByList?.call(MaterialLot.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MaterialLot] matching the given query parameters.
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
  Future<MaterialLot?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MaterialLotTable>? where,
    int? offset,
    _i1.OrderByBuilder<MaterialLotTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialLotTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MaterialLot>(
      where: where?.call(MaterialLot.t),
      orderBy: orderBy?.call(MaterialLot.t),
      orderByList: orderByList?.call(MaterialLot.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MaterialLot] by its [id] or null if no such row exists.
  Future<MaterialLot?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MaterialLot>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MaterialLot]s in the list and returns the inserted rows.
  ///
  /// The returned [MaterialLot]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MaterialLot>> insert(
    _i1.DatabaseSession session,
    List<MaterialLot> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MaterialLot>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MaterialLot] and returns the inserted row.
  ///
  /// The returned [MaterialLot] will have its `id` field set.
  Future<MaterialLot> insertRow(
    _i1.DatabaseSession session,
    MaterialLot row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MaterialLot>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MaterialLot]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MaterialLot>> update(
    _i1.DatabaseSession session,
    List<MaterialLot> rows, {
    _i1.ColumnSelections<MaterialLotTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MaterialLot>(
      rows,
      columns: columns?.call(MaterialLot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MaterialLot]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MaterialLot> updateRow(
    _i1.DatabaseSession session,
    MaterialLot row, {
    _i1.ColumnSelections<MaterialLotTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MaterialLot>(
      row,
      columns: columns?.call(MaterialLot.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MaterialLot] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MaterialLot?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<MaterialLotUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MaterialLot>(
      id,
      columnValues: columnValues(MaterialLot.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MaterialLot]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MaterialLot>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MaterialLotUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MaterialLotTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialLotTable>? orderBy,
    _i1.OrderByListBuilder<MaterialLotTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MaterialLot>(
      columnValues: columnValues(MaterialLot.t.updateTable),
      where: where(MaterialLot.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaterialLot.t),
      orderByList: orderByList?.call(MaterialLot.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MaterialLot]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MaterialLot>> delete(
    _i1.DatabaseSession session,
    List<MaterialLot> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MaterialLot>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MaterialLot].
  Future<MaterialLot> deleteRow(
    _i1.DatabaseSession session,
    MaterialLot row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MaterialLot>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MaterialLot>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MaterialLotTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MaterialLot>(
      where: where(MaterialLot.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MaterialLotTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MaterialLot>(
      where: where?.call(MaterialLot.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MaterialLot] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MaterialLotTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MaterialLot>(
      where: where(MaterialLot.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
