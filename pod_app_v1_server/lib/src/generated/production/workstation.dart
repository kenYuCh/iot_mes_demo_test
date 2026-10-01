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

abstract class Workstation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Workstation._({
    this.id,
    required this.companyId,
    this.productionLineId,
    required this.code,
    required this.name,
    this.description,
    bool? active,
    required this.createdAt,
    required this.updatedAt,
  }) : active = active ?? true;

  factory Workstation({
    int? id,
    required int companyId,
    int? productionLineId,
    required String code,
    required String name,
    String? description,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WorkstationImpl;

  factory Workstation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Workstation(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      productionLineId: jsonSerialization['productionLineId'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      active: jsonSerialization['active'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['active']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = WorkstationTable();

  static const db = WorkstationRepository._();

  @override
  int? id;

  int companyId;

  /// 舊版工作站可為 null；新增與編輯時 Endpoint 強制指定產線。
  int? productionLineId;

  String code;

  String name;

  String? description;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Workstation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Workstation copyWith({
    int? id,
    int? companyId,
    int? productionLineId,
    String? code,
    String? name,
    String? description,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Workstation',
      if (id != null) 'id': id,
      'companyId': companyId,
      if (productionLineId != null) 'productionLineId': productionLineId,
      'code': code,
      'name': name,
      if (description != null) 'description': description,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Workstation',
      if (id != null) 'id': id,
      'companyId': companyId,
      if (productionLineId != null) 'productionLineId': productionLineId,
      'code': code,
      'name': name,
      if (description != null) 'description': description,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static WorkstationInclude include() {
    return WorkstationInclude._();
  }

  static WorkstationIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkstationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkstationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkstationTable>? orderByList,
    WorkstationInclude? include,
  }) {
    return WorkstationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Workstation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Workstation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkstationImpl extends Workstation {
  _WorkstationImpl({
    int? id,
    required int companyId,
    int? productionLineId,
    required String code,
    required String name,
    String? description,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         productionLineId: productionLineId,
         code: code,
         name: name,
         description: description,
         active: active,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Workstation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Workstation copyWith({
    Object? id = _Undefined,
    int? companyId,
    Object? productionLineId = _Undefined,
    String? code,
    String? name,
    Object? description = _Undefined,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Workstation(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      productionLineId: productionLineId is int?
          ? productionLineId
          : this.productionLineId,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WorkstationUpdateTable extends _i1.UpdateTable<WorkstationTable> {
  WorkstationUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> productionLineId(int? value) => _i1.ColumnValue(
    table.productionLineId,
    value,
  );

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<bool, bool> active(bool value) => _i1.ColumnValue(
    table.active,
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

class WorkstationTable extends _i1.Table<int?> {
  WorkstationTable({super.tableRelation}) : super(tableName: 'workstation') {
    updateTable = WorkstationUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    productionLineId = _i1.ColumnInt(
      'productionLineId',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    active = _i1.ColumnBool(
      'active',
      this,
      hasDefault: true,
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

  late final WorkstationUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  /// 舊版工作站可為 null；新增與編輯時 Endpoint 強制指定產線。
  late final _i1.ColumnInt productionLineId;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnBool active;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    productionLineId,
    code,
    name,
    description,
    active,
    createdAt,
    updatedAt,
  ];
}

class WorkstationInclude extends _i1.IncludeObject {
  WorkstationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Workstation.t;
}

class WorkstationIncludeList extends _i1.IncludeList {
  WorkstationIncludeList._({
    _i1.WhereExpressionBuilder<WorkstationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Workstation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Workstation.t;
}

class WorkstationRepository {
  const WorkstationRepository._();

  /// Returns a list of [Workstation]s matching the given query parameters.
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
  Future<List<Workstation>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkstationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkstationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkstationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Workstation>(
      where: where?.call(Workstation.t),
      orderBy: orderBy?.call(Workstation.t),
      orderByList: orderByList?.call(Workstation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Workstation] matching the given query parameters.
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
  Future<Workstation?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkstationTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkstationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkstationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Workstation>(
      where: where?.call(Workstation.t),
      orderBy: orderBy?.call(Workstation.t),
      orderByList: orderByList?.call(Workstation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Workstation] by its [id] or null if no such row exists.
  Future<Workstation?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Workstation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Workstation]s in the list and returns the inserted rows.
  ///
  /// The returned [Workstation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Workstation>> insert(
    _i1.DatabaseSession session,
    List<Workstation> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Workstation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Workstation] and returns the inserted row.
  ///
  /// The returned [Workstation] will have its `id` field set.
  Future<Workstation> insertRow(
    _i1.DatabaseSession session,
    Workstation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Workstation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Workstation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Workstation>> update(
    _i1.DatabaseSession session,
    List<Workstation> rows, {
    _i1.ColumnSelections<WorkstationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Workstation>(
      rows,
      columns: columns?.call(Workstation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Workstation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Workstation> updateRow(
    _i1.DatabaseSession session,
    Workstation row, {
    _i1.ColumnSelections<WorkstationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Workstation>(
      row,
      columns: columns?.call(Workstation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Workstation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Workstation?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkstationUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Workstation>(
      id,
      columnValues: columnValues(Workstation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Workstation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Workstation>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WorkstationUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WorkstationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkstationTable>? orderBy,
    _i1.OrderByListBuilder<WorkstationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Workstation>(
      columnValues: columnValues(Workstation.t.updateTable),
      where: where(Workstation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Workstation.t),
      orderByList: orderByList?.call(Workstation.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Workstation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Workstation>> delete(
    _i1.DatabaseSession session,
    List<Workstation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Workstation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Workstation].
  Future<Workstation> deleteRow(
    _i1.DatabaseSession session,
    Workstation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Workstation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Workstation>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkstationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Workstation>(
      where: where(Workstation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkstationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Workstation>(
      where: where?.call(Workstation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Workstation] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkstationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Workstation>(
      where: where(Workstation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
