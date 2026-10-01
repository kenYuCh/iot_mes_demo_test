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

/// 歷史量測資料（高頻寫入，批次插入，不逐筆交易）。
abstract class Measurement
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Measurement._({
    this.id,
    required this.companyId,
    required this.deviceId,
    required this.featureKey,
    required this.value,
    required this.measuredAt,
    required this.receivedAt,
  });

  factory Measurement({
    int? id,
    required int companyId,
    required int deviceId,
    required String featureKey,
    required double value,
    required DateTime measuredAt,
    required DateTime receivedAt,
  }) = _MeasurementImpl;

  factory Measurement.fromJson(Map<String, dynamic> jsonSerialization) {
    return Measurement(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      featureKey: jsonSerialization['featureKey'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      measuredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['measuredAt'],
      ),
      receivedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
    );
  }

  static final t = MeasurementTable();

  static const db = MeasurementRepository._();

  @override
  int? id;

  int companyId;

  int deviceId;

  String featureKey;

  double value;

  /// 設備量測時間（UTC）。
  DateTime measuredAt;

  /// 平台收到時間（UTC）。
  DateTime receivedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Measurement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Measurement copyWith({
    int? id,
    int? companyId,
    int? deviceId,
    String? featureKey,
    double? value,
    DateTime? measuredAt,
    DateTime? receivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Measurement',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'featureKey': featureKey,
      'value': value,
      'measuredAt': measuredAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Measurement',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'featureKey': featureKey,
      'value': value,
      'measuredAt': measuredAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  static MeasurementInclude include() {
    return MeasurementInclude._();
  }

  static MeasurementIncludeList includeList({
    _i1.WhereExpressionBuilder<MeasurementTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MeasurementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MeasurementTable>? orderByList,
    MeasurementInclude? include,
  }) {
    return MeasurementIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Measurement.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Measurement.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MeasurementImpl extends Measurement {
  _MeasurementImpl({
    int? id,
    required int companyId,
    required int deviceId,
    required String featureKey,
    required double value,
    required DateTime measuredAt,
    required DateTime receivedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         deviceId: deviceId,
         featureKey: featureKey,
         value: value,
         measuredAt: measuredAt,
         receivedAt: receivedAt,
       );

  /// Returns a shallow copy of this [Measurement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Measurement copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? deviceId,
    String? featureKey,
    double? value,
    DateTime? measuredAt,
    DateTime? receivedAt,
  }) {
    return Measurement(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      deviceId: deviceId ?? this.deviceId,
      featureKey: featureKey ?? this.featureKey,
      value: value ?? this.value,
      measuredAt: measuredAt ?? this.measuredAt,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }
}

class MeasurementUpdateTable extends _i1.UpdateTable<MeasurementTable> {
  MeasurementUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> deviceId(int value) => _i1.ColumnValue(
    table.deviceId,
    value,
  );

  _i1.ColumnValue<String, String> featureKey(String value) => _i1.ColumnValue(
    table.featureKey,
    value,
  );

  _i1.ColumnValue<double, double> value(double value) => _i1.ColumnValue(
    table.value,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> measuredAt(DateTime value) =>
      _i1.ColumnValue(
        table.measuredAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> receivedAt(DateTime value) =>
      _i1.ColumnValue(
        table.receivedAt,
        value,
      );
}

class MeasurementTable extends _i1.Table<int?> {
  MeasurementTable({super.tableRelation}) : super(tableName: 'measurement') {
    updateTable = MeasurementUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    deviceId = _i1.ColumnInt(
      'deviceId',
      this,
    );
    featureKey = _i1.ColumnString(
      'featureKey',
      this,
    );
    value = _i1.ColumnDouble(
      'value',
      this,
    );
    measuredAt = _i1.ColumnDateTime(
      'measuredAt',
      this,
    );
    receivedAt = _i1.ColumnDateTime(
      'receivedAt',
      this,
    );
  }

  late final MeasurementUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt deviceId;

  late final _i1.ColumnString featureKey;

  late final _i1.ColumnDouble value;

  /// 設備量測時間（UTC）。
  late final _i1.ColumnDateTime measuredAt;

  /// 平台收到時間（UTC）。
  late final _i1.ColumnDateTime receivedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    deviceId,
    featureKey,
    value,
    measuredAt,
    receivedAt,
  ];
}

class MeasurementInclude extends _i1.IncludeObject {
  MeasurementInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Measurement.t;
}

class MeasurementIncludeList extends _i1.IncludeList {
  MeasurementIncludeList._({
    _i1.WhereExpressionBuilder<MeasurementTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Measurement.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Measurement.t;
}

class MeasurementRepository {
  const MeasurementRepository._();

  /// Returns a list of [Measurement]s matching the given query parameters.
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
  Future<List<Measurement>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MeasurementTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MeasurementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MeasurementTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Measurement>(
      where: where?.call(Measurement.t),
      orderBy: orderBy?.call(Measurement.t),
      orderByList: orderByList?.call(Measurement.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Measurement] matching the given query parameters.
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
  Future<Measurement?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MeasurementTable>? where,
    int? offset,
    _i1.OrderByBuilder<MeasurementTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MeasurementTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Measurement>(
      where: where?.call(Measurement.t),
      orderBy: orderBy?.call(Measurement.t),
      orderByList: orderByList?.call(Measurement.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Measurement] by its [id] or null if no such row exists.
  Future<Measurement?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Measurement>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Measurement]s in the list and returns the inserted rows.
  ///
  /// The returned [Measurement]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Measurement>> insert(
    _i1.DatabaseSession session,
    List<Measurement> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Measurement>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Measurement] and returns the inserted row.
  ///
  /// The returned [Measurement] will have its `id` field set.
  Future<Measurement> insertRow(
    _i1.DatabaseSession session,
    Measurement row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Measurement>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Measurement]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Measurement>> update(
    _i1.DatabaseSession session,
    List<Measurement> rows, {
    _i1.ColumnSelections<MeasurementTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Measurement>(
      rows,
      columns: columns?.call(Measurement.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Measurement]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Measurement> updateRow(
    _i1.DatabaseSession session,
    Measurement row, {
    _i1.ColumnSelections<MeasurementTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Measurement>(
      row,
      columns: columns?.call(Measurement.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Measurement] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Measurement?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<MeasurementUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Measurement>(
      id,
      columnValues: columnValues(Measurement.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Measurement]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Measurement>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MeasurementUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MeasurementTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MeasurementTable>? orderBy,
    _i1.OrderByListBuilder<MeasurementTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Measurement>(
      columnValues: columnValues(Measurement.t.updateTable),
      where: where(Measurement.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Measurement.t),
      orderByList: orderByList?.call(Measurement.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Measurement]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Measurement>> delete(
    _i1.DatabaseSession session,
    List<Measurement> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Measurement>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Measurement].
  Future<Measurement> deleteRow(
    _i1.DatabaseSession session,
    Measurement row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Measurement>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Measurement>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MeasurementTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Measurement>(
      where: where(Measurement.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MeasurementTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Measurement>(
      where: where?.call(Measurement.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Measurement] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MeasurementTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Measurement>(
      where: where(Measurement.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
