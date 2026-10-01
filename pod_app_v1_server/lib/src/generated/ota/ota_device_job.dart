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
import '../ota/ota_job_state.dart' as _i2;

/// 單台設備的 OTA 狀態，可獨立失敗、重試或回滾。
abstract class OtaDeviceJob
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OtaDeviceJob._({
    this.id,
    required this.companyId,
    required this.campaignId,
    this.deviceId,
    this.gatewayId,
    required this.state,
    required this.progress,
    this.previousVersion,
    this.errorMessage,
    required this.updatedAt,
  });

  factory OtaDeviceJob({
    int? id,
    required int companyId,
    required int campaignId,
    int? deviceId,
    int? gatewayId,
    required _i2.OtaJobState state,
    required int progress,
    String? previousVersion,
    String? errorMessage,
    required DateTime updatedAt,
  }) = _OtaDeviceJobImpl;

  factory OtaDeviceJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return OtaDeviceJob(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      campaignId: jsonSerialization['campaignId'] as int,
      deviceId: jsonSerialization['deviceId'] as int?,
      gatewayId: jsonSerialization['gatewayId'] as int?,
      state: _i2.OtaJobState.fromJson((jsonSerialization['state'] as String)),
      progress: jsonSerialization['progress'] as int,
      previousVersion: jsonSerialization['previousVersion'] as String?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = OtaDeviceJobTable();

  static const db = OtaDeviceJobRepository._();

  @override
  int? id;

  int companyId;

  int campaignId;

  /// 一般感測／致動設備與 Gateway 二擇一。
  int? deviceId;

  int? gatewayId;

  _i2.OtaJobState state;

  int progress;

  String? previousVersion;

  String? errorMessage;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OtaDeviceJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OtaDeviceJob copyWith({
    int? id,
    int? companyId,
    int? campaignId,
    int? deviceId,
    int? gatewayId,
    _i2.OtaJobState? state,
    int? progress,
    String? previousVersion,
    String? errorMessage,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OtaDeviceJob',
      if (id != null) 'id': id,
      'companyId': companyId,
      'campaignId': campaignId,
      if (deviceId != null) 'deviceId': deviceId,
      if (gatewayId != null) 'gatewayId': gatewayId,
      'state': state.toJson(),
      'progress': progress,
      if (previousVersion != null) 'previousVersion': previousVersion,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OtaDeviceJob',
      if (id != null) 'id': id,
      'companyId': companyId,
      'campaignId': campaignId,
      if (deviceId != null) 'deviceId': deviceId,
      if (gatewayId != null) 'gatewayId': gatewayId,
      'state': state.toJson(),
      'progress': progress,
      if (previousVersion != null) 'previousVersion': previousVersion,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static OtaDeviceJobInclude include() {
    return OtaDeviceJobInclude._();
  }

  static OtaDeviceJobIncludeList includeList({
    _i1.WhereExpressionBuilder<OtaDeviceJobTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OtaDeviceJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OtaDeviceJobTable>? orderByList,
    OtaDeviceJobInclude? include,
  }) {
    return OtaDeviceJobIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OtaDeviceJob.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OtaDeviceJob.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OtaDeviceJobImpl extends OtaDeviceJob {
  _OtaDeviceJobImpl({
    int? id,
    required int companyId,
    required int campaignId,
    int? deviceId,
    int? gatewayId,
    required _i2.OtaJobState state,
    required int progress,
    String? previousVersion,
    String? errorMessage,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         campaignId: campaignId,
         deviceId: deviceId,
         gatewayId: gatewayId,
         state: state,
         progress: progress,
         previousVersion: previousVersion,
         errorMessage: errorMessage,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [OtaDeviceJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OtaDeviceJob copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? campaignId,
    Object? deviceId = _Undefined,
    Object? gatewayId = _Undefined,
    _i2.OtaJobState? state,
    int? progress,
    Object? previousVersion = _Undefined,
    Object? errorMessage = _Undefined,
    DateTime? updatedAt,
  }) {
    return OtaDeviceJob(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      campaignId: campaignId ?? this.campaignId,
      deviceId: deviceId is int? ? deviceId : this.deviceId,
      gatewayId: gatewayId is int? ? gatewayId : this.gatewayId,
      state: state ?? this.state,
      progress: progress ?? this.progress,
      previousVersion: previousVersion is String?
          ? previousVersion
          : this.previousVersion,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OtaDeviceJobUpdateTable extends _i1.UpdateTable<OtaDeviceJobTable> {
  OtaDeviceJobUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> campaignId(int value) => _i1.ColumnValue(
    table.campaignId,
    value,
  );

  _i1.ColumnValue<int, int> deviceId(int? value) => _i1.ColumnValue(
    table.deviceId,
    value,
  );

  _i1.ColumnValue<int, int> gatewayId(int? value) => _i1.ColumnValue(
    table.gatewayId,
    value,
  );

  _i1.ColumnValue<_i2.OtaJobState, _i2.OtaJobState> state(
    _i2.OtaJobState value,
  ) => _i1.ColumnValue(
    table.state,
    value,
  );

  _i1.ColumnValue<int, int> progress(int value) => _i1.ColumnValue(
    table.progress,
    value,
  );

  _i1.ColumnValue<String, String> previousVersion(String? value) =>
      _i1.ColumnValue(
        table.previousVersion,
        value,
      );

  _i1.ColumnValue<String, String> errorMessage(String? value) =>
      _i1.ColumnValue(
        table.errorMessage,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class OtaDeviceJobTable extends _i1.Table<int?> {
  OtaDeviceJobTable({super.tableRelation})
    : super(tableName: 'ota_device_job') {
    updateTable = OtaDeviceJobUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    campaignId = _i1.ColumnInt(
      'campaignId',
      this,
    );
    deviceId = _i1.ColumnInt(
      'deviceId',
      this,
    );
    gatewayId = _i1.ColumnInt(
      'gatewayId',
      this,
    );
    state = _i1.ColumnEnum(
      'state',
      this,
      _i1.EnumSerialization.byName,
    );
    progress = _i1.ColumnInt(
      'progress',
      this,
    );
    previousVersion = _i1.ColumnString(
      'previousVersion',
      this,
    );
    errorMessage = _i1.ColumnString(
      'errorMessage',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final OtaDeviceJobUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt campaignId;

  /// 一般感測／致動設備與 Gateway 二擇一。
  late final _i1.ColumnInt deviceId;

  late final _i1.ColumnInt gatewayId;

  late final _i1.ColumnEnum<_i2.OtaJobState> state;

  late final _i1.ColumnInt progress;

  late final _i1.ColumnString previousVersion;

  late final _i1.ColumnString errorMessage;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    campaignId,
    deviceId,
    gatewayId,
    state,
    progress,
    previousVersion,
    errorMessage,
    updatedAt,
  ];
}

class OtaDeviceJobInclude extends _i1.IncludeObject {
  OtaDeviceJobInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OtaDeviceJob.t;
}

class OtaDeviceJobIncludeList extends _i1.IncludeList {
  OtaDeviceJobIncludeList._({
    _i1.WhereExpressionBuilder<OtaDeviceJobTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OtaDeviceJob.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OtaDeviceJob.t;
}

class OtaDeviceJobRepository {
  const OtaDeviceJobRepository._();

  /// Returns a list of [OtaDeviceJob]s matching the given query parameters.
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
  Future<List<OtaDeviceJob>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OtaDeviceJobTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OtaDeviceJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OtaDeviceJobTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OtaDeviceJob>(
      where: where?.call(OtaDeviceJob.t),
      orderBy: orderBy?.call(OtaDeviceJob.t),
      orderByList: orderByList?.call(OtaDeviceJob.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OtaDeviceJob] matching the given query parameters.
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
  Future<OtaDeviceJob?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OtaDeviceJobTable>? where,
    int? offset,
    _i1.OrderByBuilder<OtaDeviceJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OtaDeviceJobTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OtaDeviceJob>(
      where: where?.call(OtaDeviceJob.t),
      orderBy: orderBy?.call(OtaDeviceJob.t),
      orderByList: orderByList?.call(OtaDeviceJob.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OtaDeviceJob] by its [id] or null if no such row exists.
  Future<OtaDeviceJob?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OtaDeviceJob>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OtaDeviceJob]s in the list and returns the inserted rows.
  ///
  /// The returned [OtaDeviceJob]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OtaDeviceJob>> insert(
    _i1.DatabaseSession session,
    List<OtaDeviceJob> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OtaDeviceJob>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OtaDeviceJob] and returns the inserted row.
  ///
  /// The returned [OtaDeviceJob] will have its `id` field set.
  Future<OtaDeviceJob> insertRow(
    _i1.DatabaseSession session,
    OtaDeviceJob row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OtaDeviceJob>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OtaDeviceJob]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OtaDeviceJob>> update(
    _i1.DatabaseSession session,
    List<OtaDeviceJob> rows, {
    _i1.ColumnSelections<OtaDeviceJobTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OtaDeviceJob>(
      rows,
      columns: columns?.call(OtaDeviceJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OtaDeviceJob]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OtaDeviceJob> updateRow(
    _i1.DatabaseSession session,
    OtaDeviceJob row, {
    _i1.ColumnSelections<OtaDeviceJobTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OtaDeviceJob>(
      row,
      columns: columns?.call(OtaDeviceJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OtaDeviceJob] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OtaDeviceJob?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OtaDeviceJobUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OtaDeviceJob>(
      id,
      columnValues: columnValues(OtaDeviceJob.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OtaDeviceJob]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OtaDeviceJob>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OtaDeviceJobUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OtaDeviceJobTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OtaDeviceJobTable>? orderBy,
    _i1.OrderByListBuilder<OtaDeviceJobTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OtaDeviceJob>(
      columnValues: columnValues(OtaDeviceJob.t.updateTable),
      where: where(OtaDeviceJob.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OtaDeviceJob.t),
      orderByList: orderByList?.call(OtaDeviceJob.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OtaDeviceJob]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OtaDeviceJob>> delete(
    _i1.DatabaseSession session,
    List<OtaDeviceJob> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OtaDeviceJob>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OtaDeviceJob].
  Future<OtaDeviceJob> deleteRow(
    _i1.DatabaseSession session,
    OtaDeviceJob row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OtaDeviceJob>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OtaDeviceJob>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OtaDeviceJobTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OtaDeviceJob>(
      where: where(OtaDeviceJob.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OtaDeviceJobTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OtaDeviceJob>(
      where: where?.call(OtaDeviceJob.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OtaDeviceJob] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OtaDeviceJobTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OtaDeviceJob>(
      where: where(OtaDeviceJob.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
