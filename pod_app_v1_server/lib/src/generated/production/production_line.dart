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

abstract class ProductionLine
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProductionLine._({
    this.id,
    required this.companyId,
    required this.code,
    required this.name,
    this.description,
    bool? active,
    required this.createdAt,
    required this.updatedAt,
  }) : active = active ?? true;

  factory ProductionLine({
    int? id,
    required int companyId,
    required String code,
    required String name,
    String? description,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProductionLineImpl;

  factory ProductionLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductionLine(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
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

  static final t = ProductionLineTable();

  static const db = ProductionLineRepository._();

  @override
  int? id;

  int companyId;

  String code;

  String name;

  String? description;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProductionLine]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductionLine copyWith({
    int? id,
    int? companyId,
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
      '__className__': 'ProductionLine',
      if (id != null) 'id': id,
      'companyId': companyId,
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
      '__className__': 'ProductionLine',
      if (id != null) 'id': id,
      'companyId': companyId,
      'code': code,
      'name': name,
      if (description != null) 'description': description,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProductionLineInclude include() {
    return ProductionLineInclude._();
  }

  static ProductionLineIncludeList includeList({
    _i1.WhereExpressionBuilder<ProductionLineTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductionLineTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductionLineTable>? orderByList,
    ProductionLineInclude? include,
  }) {
    return ProductionLineIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductionLine.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProductionLine.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductionLineImpl extends ProductionLine {
  _ProductionLineImpl({
    int? id,
    required int companyId,
    required String code,
    required String name,
    String? description,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         code: code,
         name: name,
         description: description,
         active: active,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProductionLine]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductionLine copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? code,
    String? name,
    Object? description = _Undefined,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductionLine(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProductionLineUpdateTable extends _i1.UpdateTable<ProductionLineTable> {
  ProductionLineUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
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

class ProductionLineTable extends _i1.Table<int?> {
  ProductionLineTable({super.tableRelation})
    : super(tableName: 'production_line') {
    updateTable = ProductionLineUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
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

  late final ProductionLineUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

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
    code,
    name,
    description,
    active,
    createdAt,
    updatedAt,
  ];
}

class ProductionLineInclude extends _i1.IncludeObject {
  ProductionLineInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProductionLine.t;
}

class ProductionLineIncludeList extends _i1.IncludeList {
  ProductionLineIncludeList._({
    _i1.WhereExpressionBuilder<ProductionLineTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductionLine.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProductionLine.t;
}

class ProductionLineRepository {
  const ProductionLineRepository._();

  /// Returns a list of [ProductionLine]s matching the given query parameters.
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
  Future<List<ProductionLine>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductionLineTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductionLineTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductionLineTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductionLine>(
      where: where?.call(ProductionLine.t),
      orderBy: orderBy?.call(ProductionLine.t),
      orderByList: orderByList?.call(ProductionLine.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProductionLine] matching the given query parameters.
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
  Future<ProductionLine?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductionLineTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProductionLineTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductionLineTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductionLine>(
      where: where?.call(ProductionLine.t),
      orderBy: orderBy?.call(ProductionLine.t),
      orderByList: orderByList?.call(ProductionLine.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductionLine] by its [id] or null if no such row exists.
  Future<ProductionLine?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProductionLine>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProductionLine]s in the list and returns the inserted rows.
  ///
  /// The returned [ProductionLine]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProductionLine>> insert(
    _i1.DatabaseSession session,
    List<ProductionLine> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProductionLine>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProductionLine] and returns the inserted row.
  ///
  /// The returned [ProductionLine] will have its `id` field set.
  Future<ProductionLine> insertRow(
    _i1.DatabaseSession session,
    ProductionLine row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductionLine>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProductionLine]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProductionLine>> update(
    _i1.DatabaseSession session,
    List<ProductionLine> rows, {
    _i1.ColumnSelections<ProductionLineTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProductionLine>(
      rows,
      columns: columns?.call(ProductionLine.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductionLine]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductionLine> updateRow(
    _i1.DatabaseSession session,
    ProductionLine row, {
    _i1.ColumnSelections<ProductionLineTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProductionLine>(
      row,
      columns: columns?.call(ProductionLine.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductionLine] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProductionLine?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProductionLineUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductionLine>(
      id,
      columnValues: columnValues(ProductionLine.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductionLine]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProductionLine>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProductionLineUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProductionLineTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductionLineTable>? orderBy,
    _i1.OrderByListBuilder<ProductionLineTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProductionLine>(
      columnValues: columnValues(ProductionLine.t.updateTable),
      where: where(ProductionLine.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductionLine.t),
      orderByList: orderByList?.call(ProductionLine.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProductionLine]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProductionLine>> delete(
    _i1.DatabaseSession session,
    List<ProductionLine> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProductionLine>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProductionLine].
  Future<ProductionLine> deleteRow(
    _i1.DatabaseSession session,
    ProductionLine row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductionLine>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProductionLine>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductionLineTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProductionLine>(
      where: where(ProductionLine.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductionLineTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProductionLine>(
      where: where?.call(ProductionLine.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductionLine] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductionLineTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductionLine>(
      where: where(ProductionLine.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
