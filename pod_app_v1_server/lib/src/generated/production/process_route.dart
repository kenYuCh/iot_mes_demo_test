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

abstract class ProcessRoute
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProcessRoute._({
    this.id,
    required this.companyId,
    required this.productDefinitionId,
    required this.code,
    required this.name,
    int? version,
    bool? active,
    required this.createdAt,
    required this.updatedAt,
  }) : version = version ?? 1,
       active = active ?? true;

  factory ProcessRoute({
    int? id,
    required int companyId,
    required int productDefinitionId,
    required String code,
    required String name,
    int? version,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProcessRouteImpl;

  factory ProcessRoute.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProcessRoute(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      productDefinitionId: jsonSerialization['productDefinitionId'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      version: jsonSerialization['version'] as int?,
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

  static final t = ProcessRouteTable();

  static const db = ProcessRouteRepository._();

  @override
  int? id;

  int companyId;

  int productDefinitionId;

  String code;

  String name;

  int version;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProcessRoute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProcessRoute copyWith({
    int? id,
    int? companyId,
    int? productDefinitionId,
    String? code,
    String? name,
    int? version,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProcessRoute',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productDefinitionId': productDefinitionId,
      'code': code,
      'name': name,
      'version': version,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProcessRoute',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productDefinitionId': productDefinitionId,
      'code': code,
      'name': name,
      'version': version,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProcessRouteInclude include() {
    return ProcessRouteInclude._();
  }

  static ProcessRouteIncludeList includeList({
    _i1.WhereExpressionBuilder<ProcessRouteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProcessRouteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProcessRouteTable>? orderByList,
    ProcessRouteInclude? include,
  }) {
    return ProcessRouteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProcessRoute.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProcessRoute.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProcessRouteImpl extends ProcessRoute {
  _ProcessRouteImpl({
    int? id,
    required int companyId,
    required int productDefinitionId,
    required String code,
    required String name,
    int? version,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         productDefinitionId: productDefinitionId,
         code: code,
         name: name,
         version: version,
         active: active,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProcessRoute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProcessRoute copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? productDefinitionId,
    String? code,
    String? name,
    int? version,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProcessRoute(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      productDefinitionId: productDefinitionId ?? this.productDefinitionId,
      code: code ?? this.code,
      name: name ?? this.name,
      version: version ?? this.version,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProcessRouteUpdateTable extends _i1.UpdateTable<ProcessRouteTable> {
  ProcessRouteUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> productDefinitionId(int value) => _i1.ColumnValue(
    table.productDefinitionId,
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

  _i1.ColumnValue<int, int> version(int value) => _i1.ColumnValue(
    table.version,
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

class ProcessRouteTable extends _i1.Table<int?> {
  ProcessRouteTable({super.tableRelation}) : super(tableName: 'process_route') {
    updateTable = ProcessRouteUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    productDefinitionId = _i1.ColumnInt(
      'productDefinitionId',
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
    version = _i1.ColumnInt(
      'version',
      this,
      hasDefault: true,
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

  late final ProcessRouteUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt productDefinitionId;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnInt version;

  late final _i1.ColumnBool active;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    productDefinitionId,
    code,
    name,
    version,
    active,
    createdAt,
    updatedAt,
  ];
}

class ProcessRouteInclude extends _i1.IncludeObject {
  ProcessRouteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProcessRoute.t;
}

class ProcessRouteIncludeList extends _i1.IncludeList {
  ProcessRouteIncludeList._({
    _i1.WhereExpressionBuilder<ProcessRouteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProcessRoute.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProcessRoute.t;
}

class ProcessRouteRepository {
  const ProcessRouteRepository._();

  /// Returns a list of [ProcessRoute]s matching the given query parameters.
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
  Future<List<ProcessRoute>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProcessRouteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProcessRouteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProcessRouteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProcessRoute>(
      where: where?.call(ProcessRoute.t),
      orderBy: orderBy?.call(ProcessRoute.t),
      orderByList: orderByList?.call(ProcessRoute.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProcessRoute] matching the given query parameters.
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
  Future<ProcessRoute?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProcessRouteTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProcessRouteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProcessRouteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProcessRoute>(
      where: where?.call(ProcessRoute.t),
      orderBy: orderBy?.call(ProcessRoute.t),
      orderByList: orderByList?.call(ProcessRoute.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProcessRoute] by its [id] or null if no such row exists.
  Future<ProcessRoute?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProcessRoute>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProcessRoute]s in the list and returns the inserted rows.
  ///
  /// The returned [ProcessRoute]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProcessRoute>> insert(
    _i1.DatabaseSession session,
    List<ProcessRoute> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProcessRoute>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProcessRoute] and returns the inserted row.
  ///
  /// The returned [ProcessRoute] will have its `id` field set.
  Future<ProcessRoute> insertRow(
    _i1.DatabaseSession session,
    ProcessRoute row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProcessRoute>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProcessRoute]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProcessRoute>> update(
    _i1.DatabaseSession session,
    List<ProcessRoute> rows, {
    _i1.ColumnSelections<ProcessRouteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProcessRoute>(
      rows,
      columns: columns?.call(ProcessRoute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProcessRoute]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProcessRoute> updateRow(
    _i1.DatabaseSession session,
    ProcessRoute row, {
    _i1.ColumnSelections<ProcessRouteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProcessRoute>(
      row,
      columns: columns?.call(ProcessRoute.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProcessRoute] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProcessRoute?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProcessRouteUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProcessRoute>(
      id,
      columnValues: columnValues(ProcessRoute.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProcessRoute]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProcessRoute>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProcessRouteUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProcessRouteTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProcessRouteTable>? orderBy,
    _i1.OrderByListBuilder<ProcessRouteTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProcessRoute>(
      columnValues: columnValues(ProcessRoute.t.updateTable),
      where: where(ProcessRoute.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProcessRoute.t),
      orderByList: orderByList?.call(ProcessRoute.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProcessRoute]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProcessRoute>> delete(
    _i1.DatabaseSession session,
    List<ProcessRoute> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProcessRoute>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProcessRoute].
  Future<ProcessRoute> deleteRow(
    _i1.DatabaseSession session,
    ProcessRoute row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProcessRoute>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProcessRoute>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProcessRouteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProcessRoute>(
      where: where(ProcessRoute.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProcessRouteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProcessRoute>(
      where: where?.call(ProcessRoute.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProcessRoute] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProcessRouteTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProcessRoute>(
      where: where(ProcessRoute.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
