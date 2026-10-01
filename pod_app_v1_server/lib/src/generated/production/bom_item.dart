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

abstract class BomItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BomItem._({
    this.id,
    required this.companyId,
    required this.productDefinitionId,
    required this.materialId,
    required this.quantity,
    required this.unit,
    double? scrapRatePercent,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  }) : scrapRatePercent = scrapRatePercent ?? 0.0;

  factory BomItem({
    int? id,
    required int companyId,
    required int productDefinitionId,
    required int materialId,
    required double quantity,
    required String unit,
    double? scrapRatePercent,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BomItemImpl;

  factory BomItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return BomItem(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      productDefinitionId: jsonSerialization['productDefinitionId'] as int,
      materialId: jsonSerialization['materialId'] as int,
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      scrapRatePercent: (jsonSerialization['scrapRatePercent'] as num?)
          ?.toDouble(),
      note: jsonSerialization['note'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = BomItemTable();

  static const db = BomItemRepository._();

  @override
  int? id;

  int companyId;

  int productDefinitionId;

  int materialId;

  double quantity;

  String unit;

  double scrapRatePercent;

  String? note;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BomItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BomItem copyWith({
    int? id,
    int? companyId,
    int? productDefinitionId,
    int? materialId,
    double? quantity,
    String? unit,
    double? scrapRatePercent,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BomItem',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productDefinitionId': productDefinitionId,
      'materialId': materialId,
      'quantity': quantity,
      'unit': unit,
      'scrapRatePercent': scrapRatePercent,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BomItem',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productDefinitionId': productDefinitionId,
      'materialId': materialId,
      'quantity': quantity,
      'unit': unit,
      'scrapRatePercent': scrapRatePercent,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static BomItemInclude include() {
    return BomItemInclude._();
  }

  static BomItemIncludeList includeList({
    _i1.WhereExpressionBuilder<BomItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BomItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BomItemTable>? orderByList,
    BomItemInclude? include,
  }) {
    return BomItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BomItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BomItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BomItemImpl extends BomItem {
  _BomItemImpl({
    int? id,
    required int companyId,
    required int productDefinitionId,
    required int materialId,
    required double quantity,
    required String unit,
    double? scrapRatePercent,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         productDefinitionId: productDefinitionId,
         materialId: materialId,
         quantity: quantity,
         unit: unit,
         scrapRatePercent: scrapRatePercent,
         note: note,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BomItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BomItem copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? productDefinitionId,
    int? materialId,
    double? quantity,
    String? unit,
    double? scrapRatePercent,
    Object? note = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BomItem(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      productDefinitionId: productDefinitionId ?? this.productDefinitionId,
      materialId: materialId ?? this.materialId,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      scrapRatePercent: scrapRatePercent ?? this.scrapRatePercent,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BomItemUpdateTable extends _i1.UpdateTable<BomItemTable> {
  BomItemUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> productDefinitionId(int value) => _i1.ColumnValue(
    table.productDefinitionId,
    value,
  );

  _i1.ColumnValue<int, int> materialId(int value) => _i1.ColumnValue(
    table.materialId,
    value,
  );

  _i1.ColumnValue<double, double> quantity(double value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<String, String> unit(String value) => _i1.ColumnValue(
    table.unit,
    value,
  );

  _i1.ColumnValue<double, double> scrapRatePercent(double value) =>
      _i1.ColumnValue(
        table.scrapRatePercent,
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

class BomItemTable extends _i1.Table<int?> {
  BomItemTable({super.tableRelation}) : super(tableName: 'bom_item') {
    updateTable = BomItemUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    productDefinitionId = _i1.ColumnInt(
      'productDefinitionId',
      this,
    );
    materialId = _i1.ColumnInt(
      'materialId',
      this,
    );
    quantity = _i1.ColumnDouble(
      'quantity',
      this,
    );
    unit = _i1.ColumnString(
      'unit',
      this,
    );
    scrapRatePercent = _i1.ColumnDouble(
      'scrapRatePercent',
      this,
      hasDefault: true,
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

  late final BomItemUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt productDefinitionId;

  late final _i1.ColumnInt materialId;

  late final _i1.ColumnDouble quantity;

  late final _i1.ColumnString unit;

  late final _i1.ColumnDouble scrapRatePercent;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    productDefinitionId,
    materialId,
    quantity,
    unit,
    scrapRatePercent,
    note,
    createdAt,
    updatedAt,
  ];
}

class BomItemInclude extends _i1.IncludeObject {
  BomItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BomItem.t;
}

class BomItemIncludeList extends _i1.IncludeList {
  BomItemIncludeList._({
    _i1.WhereExpressionBuilder<BomItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BomItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BomItem.t;
}

class BomItemRepository {
  const BomItemRepository._();

  /// Returns a list of [BomItem]s matching the given query parameters.
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
  Future<List<BomItem>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BomItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BomItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BomItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BomItem>(
      where: where?.call(BomItem.t),
      orderBy: orderBy?.call(BomItem.t),
      orderByList: orderByList?.call(BomItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BomItem] matching the given query parameters.
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
  Future<BomItem?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BomItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<BomItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BomItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BomItem>(
      where: where?.call(BomItem.t),
      orderBy: orderBy?.call(BomItem.t),
      orderByList: orderByList?.call(BomItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BomItem] by its [id] or null if no such row exists.
  Future<BomItem?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BomItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BomItem]s in the list and returns the inserted rows.
  ///
  /// The returned [BomItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BomItem>> insert(
    _i1.DatabaseSession session,
    List<BomItem> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BomItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BomItem] and returns the inserted row.
  ///
  /// The returned [BomItem] will have its `id` field set.
  Future<BomItem> insertRow(
    _i1.DatabaseSession session,
    BomItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BomItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BomItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BomItem>> update(
    _i1.DatabaseSession session,
    List<BomItem> rows, {
    _i1.ColumnSelections<BomItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BomItem>(
      rows,
      columns: columns?.call(BomItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BomItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BomItem> updateRow(
    _i1.DatabaseSession session,
    BomItem row, {
    _i1.ColumnSelections<BomItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BomItem>(
      row,
      columns: columns?.call(BomItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BomItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BomItem?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BomItemUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BomItem>(
      id,
      columnValues: columnValues(BomItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BomItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BomItem>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BomItemUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BomItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BomItemTable>? orderBy,
    _i1.OrderByListBuilder<BomItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BomItem>(
      columnValues: columnValues(BomItem.t.updateTable),
      where: where(BomItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BomItem.t),
      orderByList: orderByList?.call(BomItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BomItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BomItem>> delete(
    _i1.DatabaseSession session,
    List<BomItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BomItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BomItem].
  Future<BomItem> deleteRow(
    _i1.DatabaseSession session,
    BomItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BomItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BomItem>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BomItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BomItem>(
      where: where(BomItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BomItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BomItem>(
      where: where?.call(BomItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BomItem] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BomItemTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BomItem>(
      where: where(BomItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
