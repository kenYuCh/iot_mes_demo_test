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
import '../production/material_type.dart' as _i2;

abstract class MaterialItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MaterialItem._({
    this.id,
    required this.companyId,
    required this.code,
    required this.name,
    required this.type,
    this.specification,
    required this.unit,
    this.supplier,
    double? safetyStock,
    bool? active,
    required this.createdAt,
    required this.updatedAt,
  }) : safetyStock = safetyStock ?? 0.0,
       active = active ?? true;

  factory MaterialItem({
    int? id,
    required int companyId,
    required String code,
    required String name,
    required _i2.MaterialType type,
    String? specification,
    required String unit,
    String? supplier,
    double? safetyStock,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MaterialItemImpl;

  factory MaterialItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaterialItem(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      type: _i2.MaterialType.fromJson((jsonSerialization['type'] as String)),
      specification: jsonSerialization['specification'] as String?,
      unit: jsonSerialization['unit'] as String,
      supplier: jsonSerialization['supplier'] as String?,
      safetyStock: (jsonSerialization['safetyStock'] as num?)?.toDouble(),
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

  static final t = MaterialItemTable();

  static const db = MaterialItemRepository._();

  @override
  int? id;

  int companyId;

  String code;

  String name;

  _i2.MaterialType type;

  String? specification;

  String unit;

  String? supplier;

  double safetyStock;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MaterialItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MaterialItem copyWith({
    int? id,
    int? companyId,
    String? code,
    String? name,
    _i2.MaterialType? type,
    String? specification,
    String? unit,
    String? supplier,
    double? safetyStock,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaterialItem',
      if (id != null) 'id': id,
      'companyId': companyId,
      'code': code,
      'name': name,
      'type': type.toJson(),
      if (specification != null) 'specification': specification,
      'unit': unit,
      if (supplier != null) 'supplier': supplier,
      'safetyStock': safetyStock,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MaterialItem',
      if (id != null) 'id': id,
      'companyId': companyId,
      'code': code,
      'name': name,
      'type': type.toJson(),
      if (specification != null) 'specification': specification,
      'unit': unit,
      if (supplier != null) 'supplier': supplier,
      'safetyStock': safetyStock,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MaterialItemInclude include() {
    return MaterialItemInclude._();
  }

  static MaterialItemIncludeList includeList({
    _i1.WhereExpressionBuilder<MaterialItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialItemTable>? orderByList,
    MaterialItemInclude? include,
  }) {
    return MaterialItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaterialItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MaterialItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaterialItemImpl extends MaterialItem {
  _MaterialItemImpl({
    int? id,
    required int companyId,
    required String code,
    required String name,
    required _i2.MaterialType type,
    String? specification,
    required String unit,
    String? supplier,
    double? safetyStock,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         code: code,
         name: name,
         type: type,
         specification: specification,
         unit: unit,
         supplier: supplier,
         safetyStock: safetyStock,
         active: active,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MaterialItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MaterialItem copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? code,
    String? name,
    _i2.MaterialType? type,
    Object? specification = _Undefined,
    String? unit,
    Object? supplier = _Undefined,
    double? safetyStock,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MaterialItem(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      specification: specification is String?
          ? specification
          : this.specification,
      unit: unit ?? this.unit,
      supplier: supplier is String? ? supplier : this.supplier,
      safetyStock: safetyStock ?? this.safetyStock,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MaterialItemUpdateTable extends _i1.UpdateTable<MaterialItemTable> {
  MaterialItemUpdateTable(super.table);

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

  _i1.ColumnValue<_i2.MaterialType, _i2.MaterialType> type(
    _i2.MaterialType value,
  ) => _i1.ColumnValue(
    table.type,
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

  _i1.ColumnValue<String, String> supplier(String? value) => _i1.ColumnValue(
    table.supplier,
    value,
  );

  _i1.ColumnValue<double, double> safetyStock(double value) => _i1.ColumnValue(
    table.safetyStock,
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

class MaterialItemTable extends _i1.Table<int?> {
  MaterialItemTable({super.tableRelation}) : super(tableName: 'material') {
    updateTable = MaterialItemUpdateTable(this);
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
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    specification = _i1.ColumnString(
      'specification',
      this,
    );
    unit = _i1.ColumnString(
      'unit',
      this,
    );
    supplier = _i1.ColumnString(
      'supplier',
      this,
    );
    safetyStock = _i1.ColumnDouble(
      'safetyStock',
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

  late final MaterialItemUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnEnum<_i2.MaterialType> type;

  late final _i1.ColumnString specification;

  late final _i1.ColumnString unit;

  late final _i1.ColumnString supplier;

  late final _i1.ColumnDouble safetyStock;

  late final _i1.ColumnBool active;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    code,
    name,
    type,
    specification,
    unit,
    supplier,
    safetyStock,
    active,
    createdAt,
    updatedAt,
  ];
}

class MaterialItemInclude extends _i1.IncludeObject {
  MaterialItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MaterialItem.t;
}

class MaterialItemIncludeList extends _i1.IncludeList {
  MaterialItemIncludeList._({
    _i1.WhereExpressionBuilder<MaterialItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MaterialItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MaterialItem.t;
}

class MaterialItemRepository {
  const MaterialItemRepository._();

  /// Returns a list of [MaterialItem]s matching the given query parameters.
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
  Future<List<MaterialItem>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MaterialItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MaterialItem>(
      where: where?.call(MaterialItem.t),
      orderBy: orderBy?.call(MaterialItem.t),
      orderByList: orderByList?.call(MaterialItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MaterialItem] matching the given query parameters.
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
  Future<MaterialItem?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MaterialItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<MaterialItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MaterialItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MaterialItem>(
      where: where?.call(MaterialItem.t),
      orderBy: orderBy?.call(MaterialItem.t),
      orderByList: orderByList?.call(MaterialItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MaterialItem] by its [id] or null if no such row exists.
  Future<MaterialItem?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MaterialItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MaterialItem]s in the list and returns the inserted rows.
  ///
  /// The returned [MaterialItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MaterialItem>> insert(
    _i1.DatabaseSession session,
    List<MaterialItem> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MaterialItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MaterialItem] and returns the inserted row.
  ///
  /// The returned [MaterialItem] will have its `id` field set.
  Future<MaterialItem> insertRow(
    _i1.DatabaseSession session,
    MaterialItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MaterialItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MaterialItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MaterialItem>> update(
    _i1.DatabaseSession session,
    List<MaterialItem> rows, {
    _i1.ColumnSelections<MaterialItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MaterialItem>(
      rows,
      columns: columns?.call(MaterialItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MaterialItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MaterialItem> updateRow(
    _i1.DatabaseSession session,
    MaterialItem row, {
    _i1.ColumnSelections<MaterialItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MaterialItem>(
      row,
      columns: columns?.call(MaterialItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MaterialItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MaterialItem?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<MaterialItemUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MaterialItem>(
      id,
      columnValues: columnValues(MaterialItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MaterialItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MaterialItem>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MaterialItemUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MaterialItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MaterialItemTable>? orderBy,
    _i1.OrderByListBuilder<MaterialItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MaterialItem>(
      columnValues: columnValues(MaterialItem.t.updateTable),
      where: where(MaterialItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaterialItem.t),
      orderByList: orderByList?.call(MaterialItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MaterialItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MaterialItem>> delete(
    _i1.DatabaseSession session,
    List<MaterialItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MaterialItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MaterialItem].
  Future<MaterialItem> deleteRow(
    _i1.DatabaseSession session,
    MaterialItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MaterialItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MaterialItem>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MaterialItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MaterialItem>(
      where: where(MaterialItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MaterialItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MaterialItem>(
      where: where?.call(MaterialItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MaterialItem] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MaterialItemTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MaterialItem>(
      where: where(MaterialItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
