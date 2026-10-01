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

abstract class ProductDefinition
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProductDefinition._({
    this.id,
    required this.companyId,
    required this.code,
    required this.name,
    this.specification,
    required this.unit,
    bool? active,
    required this.createdAt,
    required this.updatedAt,
  }) : active = active ?? true;

  factory ProductDefinition({
    int? id,
    required int companyId,
    required String code,
    required String name,
    String? specification,
    required String unit,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProductDefinitionImpl;

  factory ProductDefinition.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductDefinition(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      specification: jsonSerialization['specification'] as String?,
      unit: jsonSerialization['unit'] as String,
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

  static final t = ProductDefinitionTable();

  static const db = ProductDefinitionRepository._();

  @override
  int? id;

  int companyId;

  String code;

  String name;

  String? specification;

  String unit;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProductDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductDefinition copyWith({
    int? id,
    int? companyId,
    String? code,
    String? name,
    String? specification,
    String? unit,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductDefinition',
      if (id != null) 'id': id,
      'companyId': companyId,
      'code': code,
      'name': name,
      if (specification != null) 'specification': specification,
      'unit': unit,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProductDefinition',
      if (id != null) 'id': id,
      'companyId': companyId,
      'code': code,
      'name': name,
      if (specification != null) 'specification': specification,
      'unit': unit,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProductDefinitionInclude include() {
    return ProductDefinitionInclude._();
  }

  static ProductDefinitionIncludeList includeList({
    _i1.WhereExpressionBuilder<ProductDefinitionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductDefinitionTable>? orderByList,
    ProductDefinitionInclude? include,
  }) {
    return ProductDefinitionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductDefinition.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProductDefinition.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductDefinitionImpl extends ProductDefinition {
  _ProductDefinitionImpl({
    int? id,
    required int companyId,
    required String code,
    required String name,
    String? specification,
    required String unit,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         code: code,
         name: name,
         specification: specification,
         unit: unit,
         active: active,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProductDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductDefinition copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? code,
    String? name,
    Object? specification = _Undefined,
    String? unit,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductDefinition(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      code: code ?? this.code,
      name: name ?? this.name,
      specification: specification is String?
          ? specification
          : this.specification,
      unit: unit ?? this.unit,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProductDefinitionUpdateTable
    extends _i1.UpdateTable<ProductDefinitionTable> {
  ProductDefinitionUpdateTable(super.table);

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

  _i1.ColumnValue<String, String> specification(String? value) =>
      _i1.ColumnValue(
        table.specification,
        value,
      );

  _i1.ColumnValue<String, String> unit(String value) => _i1.ColumnValue(
    table.unit,
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

class ProductDefinitionTable extends _i1.Table<int?> {
  ProductDefinitionTable({super.tableRelation})
    : super(tableName: 'product_definition') {
    updateTable = ProductDefinitionUpdateTable(this);
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
    specification = _i1.ColumnString(
      'specification',
      this,
    );
    unit = _i1.ColumnString(
      'unit',
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

  late final ProductDefinitionUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnString specification;

  late final _i1.ColumnString unit;

  late final _i1.ColumnBool active;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    code,
    name,
    specification,
    unit,
    active,
    createdAt,
    updatedAt,
  ];
}

class ProductDefinitionInclude extends _i1.IncludeObject {
  ProductDefinitionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProductDefinition.t;
}

class ProductDefinitionIncludeList extends _i1.IncludeList {
  ProductDefinitionIncludeList._({
    _i1.WhereExpressionBuilder<ProductDefinitionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductDefinition.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProductDefinition.t;
}

class ProductDefinitionRepository {
  const ProductDefinitionRepository._();

  /// Returns a list of [ProductDefinition]s matching the given query parameters.
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
  Future<List<ProductDefinition>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductDefinitionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductDefinitionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductDefinition>(
      where: where?.call(ProductDefinition.t),
      orderBy: orderBy?.call(ProductDefinition.t),
      orderByList: orderByList?.call(ProductDefinition.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProductDefinition] matching the given query parameters.
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
  Future<ProductDefinition?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductDefinitionTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProductDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductDefinitionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductDefinition>(
      where: where?.call(ProductDefinition.t),
      orderBy: orderBy?.call(ProductDefinition.t),
      orderByList: orderByList?.call(ProductDefinition.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductDefinition] by its [id] or null if no such row exists.
  Future<ProductDefinition?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProductDefinition>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProductDefinition]s in the list and returns the inserted rows.
  ///
  /// The returned [ProductDefinition]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProductDefinition>> insert(
    _i1.DatabaseSession session,
    List<ProductDefinition> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProductDefinition>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProductDefinition] and returns the inserted row.
  ///
  /// The returned [ProductDefinition] will have its `id` field set.
  Future<ProductDefinition> insertRow(
    _i1.DatabaseSession session,
    ProductDefinition row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductDefinition>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProductDefinition]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProductDefinition>> update(
    _i1.DatabaseSession session,
    List<ProductDefinition> rows, {
    _i1.ColumnSelections<ProductDefinitionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProductDefinition>(
      rows,
      columns: columns?.call(ProductDefinition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductDefinition]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductDefinition> updateRow(
    _i1.DatabaseSession session,
    ProductDefinition row, {
    _i1.ColumnSelections<ProductDefinitionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProductDefinition>(
      row,
      columns: columns?.call(ProductDefinition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductDefinition] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProductDefinition?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProductDefinitionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductDefinition>(
      id,
      columnValues: columnValues(ProductDefinition.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductDefinition]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProductDefinition>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProductDefinitionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ProductDefinitionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductDefinitionTable>? orderBy,
    _i1.OrderByListBuilder<ProductDefinitionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProductDefinition>(
      columnValues: columnValues(ProductDefinition.t.updateTable),
      where: where(ProductDefinition.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductDefinition.t),
      orderByList: orderByList?.call(ProductDefinition.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProductDefinition]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProductDefinition>> delete(
    _i1.DatabaseSession session,
    List<ProductDefinition> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProductDefinition>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProductDefinition].
  Future<ProductDefinition> deleteRow(
    _i1.DatabaseSession session,
    ProductDefinition row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductDefinition>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProductDefinition>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductDefinitionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProductDefinition>(
      where: where(ProductDefinition.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductDefinitionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProductDefinition>(
      where: where?.call(ProductDefinition.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductDefinition] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductDefinitionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductDefinition>(
      where: where(ProductDefinition.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
