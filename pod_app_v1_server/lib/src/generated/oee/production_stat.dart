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

/// 產線小時統計（OEE 計算來源）。開發環境由模擬器產生，
/// 正式環境由產線 PLC / MES 匯入。
abstract class ProductionStat
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProductionStat._({
    this.id,
    required this.companyId,
    required this.siteId,
    required this.windowStart,
    required this.plannedMinutes,
    required this.runMinutes,
    required this.idealCount,
    required this.actualCount,
    required this.goodCount,
  });

  factory ProductionStat({
    int? id,
    required int companyId,
    required int siteId,
    required DateTime windowStart,
    required double plannedMinutes,
    required double runMinutes,
    required int idealCount,
    required int actualCount,
    required int goodCount,
  }) = _ProductionStatImpl;

  factory ProductionStat.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductionStat(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      siteId: jsonSerialization['siteId'] as int,
      windowStart: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['windowStart'],
      ),
      plannedMinutes: (jsonSerialization['plannedMinutes'] as num).toDouble(),
      runMinutes: (jsonSerialization['runMinutes'] as num).toDouble(),
      idealCount: jsonSerialization['idealCount'] as int,
      actualCount: jsonSerialization['actualCount'] as int,
      goodCount: jsonSerialization['goodCount'] as int,
    );
  }

  static final t = ProductionStatTable();

  static const db = ProductionStatRepository._();

  @override
  int? id;

  int companyId;

  int siteId;

  /// 統計視窗起點（整點，UTC）。
  DateTime windowStart;

  /// 計畫生產時間（分鐘）。
  double plannedMinutes;

  /// 實際運轉時間（分鐘）。
  double runMinutes;

  /// 理想產量（依理想節拍計算）。
  int idealCount;

  /// 實際產量。
  int actualCount;

  /// 良品數。
  int goodCount;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProductionStat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductionStat copyWith({
    int? id,
    int? companyId,
    int? siteId,
    DateTime? windowStart,
    double? plannedMinutes,
    double? runMinutes,
    int? idealCount,
    int? actualCount,
    int? goodCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductionStat',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      'windowStart': windowStart.toJson(),
      'plannedMinutes': plannedMinutes,
      'runMinutes': runMinutes,
      'idealCount': idealCount,
      'actualCount': actualCount,
      'goodCount': goodCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProductionStat',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      'windowStart': windowStart.toJson(),
      'plannedMinutes': plannedMinutes,
      'runMinutes': runMinutes,
      'idealCount': idealCount,
      'actualCount': actualCount,
      'goodCount': goodCount,
    };
  }

  static ProductionStatInclude include() {
    return ProductionStatInclude._();
  }

  static ProductionStatIncludeList includeList({
    _i1.WhereExpressionBuilder<ProductionStatTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductionStatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductionStatTable>? orderByList,
    ProductionStatInclude? include,
  }) {
    return ProductionStatIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductionStat.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProductionStat.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductionStatImpl extends ProductionStat {
  _ProductionStatImpl({
    int? id,
    required int companyId,
    required int siteId,
    required DateTime windowStart,
    required double plannedMinutes,
    required double runMinutes,
    required int idealCount,
    required int actualCount,
    required int goodCount,
  }) : super._(
         id: id,
         companyId: companyId,
         siteId: siteId,
         windowStart: windowStart,
         plannedMinutes: plannedMinutes,
         runMinutes: runMinutes,
         idealCount: idealCount,
         actualCount: actualCount,
         goodCount: goodCount,
       );

  /// Returns a shallow copy of this [ProductionStat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductionStat copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? siteId,
    DateTime? windowStart,
    double? plannedMinutes,
    double? runMinutes,
    int? idealCount,
    int? actualCount,
    int? goodCount,
  }) {
    return ProductionStat(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      siteId: siteId ?? this.siteId,
      windowStart: windowStart ?? this.windowStart,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      runMinutes: runMinutes ?? this.runMinutes,
      idealCount: idealCount ?? this.idealCount,
      actualCount: actualCount ?? this.actualCount,
      goodCount: goodCount ?? this.goodCount,
    );
  }
}

class ProductionStatUpdateTable extends _i1.UpdateTable<ProductionStatTable> {
  ProductionStatUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> siteId(int value) => _i1.ColumnValue(
    table.siteId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> windowStart(DateTime value) =>
      _i1.ColumnValue(
        table.windowStart,
        value,
      );

  _i1.ColumnValue<double, double> plannedMinutes(double value) =>
      _i1.ColumnValue(
        table.plannedMinutes,
        value,
      );

  _i1.ColumnValue<double, double> runMinutes(double value) => _i1.ColumnValue(
    table.runMinutes,
    value,
  );

  _i1.ColumnValue<int, int> idealCount(int value) => _i1.ColumnValue(
    table.idealCount,
    value,
  );

  _i1.ColumnValue<int, int> actualCount(int value) => _i1.ColumnValue(
    table.actualCount,
    value,
  );

  _i1.ColumnValue<int, int> goodCount(int value) => _i1.ColumnValue(
    table.goodCount,
    value,
  );
}

class ProductionStatTable extends _i1.Table<int?> {
  ProductionStatTable({super.tableRelation})
    : super(tableName: 'production_stat') {
    updateTable = ProductionStatUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    siteId = _i1.ColumnInt(
      'siteId',
      this,
    );
    windowStart = _i1.ColumnDateTime(
      'windowStart',
      this,
    );
    plannedMinutes = _i1.ColumnDouble(
      'plannedMinutes',
      this,
    );
    runMinutes = _i1.ColumnDouble(
      'runMinutes',
      this,
    );
    idealCount = _i1.ColumnInt(
      'idealCount',
      this,
    );
    actualCount = _i1.ColumnInt(
      'actualCount',
      this,
    );
    goodCount = _i1.ColumnInt(
      'goodCount',
      this,
    );
  }

  late final ProductionStatUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt siteId;

  /// 統計視窗起點（整點，UTC）。
  late final _i1.ColumnDateTime windowStart;

  /// 計畫生產時間（分鐘）。
  late final _i1.ColumnDouble plannedMinutes;

  /// 實際運轉時間（分鐘）。
  late final _i1.ColumnDouble runMinutes;

  /// 理想產量（依理想節拍計算）。
  late final _i1.ColumnInt idealCount;

  /// 實際產量。
  late final _i1.ColumnInt actualCount;

  /// 良品數。
  late final _i1.ColumnInt goodCount;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    siteId,
    windowStart,
    plannedMinutes,
    runMinutes,
    idealCount,
    actualCount,
    goodCount,
  ];
}

class ProductionStatInclude extends _i1.IncludeObject {
  ProductionStatInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProductionStat.t;
}

class ProductionStatIncludeList extends _i1.IncludeList {
  ProductionStatIncludeList._({
    _i1.WhereExpressionBuilder<ProductionStatTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductionStat.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProductionStat.t;
}

class ProductionStatRepository {
  const ProductionStatRepository._();

  /// Returns a list of [ProductionStat]s matching the given query parameters.
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
  Future<List<ProductionStat>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductionStatTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductionStatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductionStatTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductionStat>(
      where: where?.call(ProductionStat.t),
      orderBy: orderBy?.call(ProductionStat.t),
      orderByList: orderByList?.call(ProductionStat.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProductionStat] matching the given query parameters.
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
  Future<ProductionStat?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductionStatTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProductionStatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductionStatTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductionStat>(
      where: where?.call(ProductionStat.t),
      orderBy: orderBy?.call(ProductionStat.t),
      orderByList: orderByList?.call(ProductionStat.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductionStat] by its [id] or null if no such row exists.
  Future<ProductionStat?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProductionStat>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProductionStat]s in the list and returns the inserted rows.
  ///
  /// The returned [ProductionStat]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProductionStat>> insert(
    _i1.DatabaseSession session,
    List<ProductionStat> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProductionStat>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProductionStat] and returns the inserted row.
  ///
  /// The returned [ProductionStat] will have its `id` field set.
  Future<ProductionStat> insertRow(
    _i1.DatabaseSession session,
    ProductionStat row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductionStat>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProductionStat]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProductionStat>> update(
    _i1.DatabaseSession session,
    List<ProductionStat> rows, {
    _i1.ColumnSelections<ProductionStatTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProductionStat>(
      rows,
      columns: columns?.call(ProductionStat.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductionStat]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductionStat> updateRow(
    _i1.DatabaseSession session,
    ProductionStat row, {
    _i1.ColumnSelections<ProductionStatTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProductionStat>(
      row,
      columns: columns?.call(ProductionStat.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductionStat] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProductionStat?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProductionStatUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductionStat>(
      id,
      columnValues: columnValues(ProductionStat.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductionStat]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProductionStat>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProductionStatUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProductionStatTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductionStatTable>? orderBy,
    _i1.OrderByListBuilder<ProductionStatTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProductionStat>(
      columnValues: columnValues(ProductionStat.t.updateTable),
      where: where(ProductionStat.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductionStat.t),
      orderByList: orderByList?.call(ProductionStat.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProductionStat]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProductionStat>> delete(
    _i1.DatabaseSession session,
    List<ProductionStat> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProductionStat>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProductionStat].
  Future<ProductionStat> deleteRow(
    _i1.DatabaseSession session,
    ProductionStat row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductionStat>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProductionStat>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductionStatTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProductionStat>(
      where: where(ProductionStat.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductionStatTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProductionStat>(
      where: where?.call(ProductionStat.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductionStat] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductionStatTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductionStat>(
      where: where(ProductionStat.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
