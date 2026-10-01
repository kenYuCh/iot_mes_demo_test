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
import '../device/device_connection_state.dart' as _i2;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i3;

/// 設備即時狀態（與 Device 主表分離）。正式環境最新值以 Redis 為主，本表為持久化快照。
abstract class DeviceStatus
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DeviceStatus._({
    this.id,
    required this.companyId,
    required this.deviceId,
    required this.connectionState,
    required this.latestValues,
    this.lastUpdatedAt,
  });

  factory DeviceStatus({
    int? id,
    required int companyId,
    required int deviceId,
    required _i2.DeviceConnectionState connectionState,
    required Map<String, double> latestValues,
    DateTime? lastUpdatedAt,
  }) = _DeviceStatusImpl;

  factory DeviceStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceStatus(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      connectionState: _i2.DeviceConnectionState.fromJson(
        (jsonSerialization['connectionState'] as String),
      ),
      latestValues: _i3.Protocol().deserialize<Map<String, double>>(
        jsonSerialization['latestValues'],
      ),
      lastUpdatedAt: jsonSerialization['lastUpdatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastUpdatedAt'],
            ),
    );
  }

  static final t = DeviceStatusTable();

  static const db = DeviceStatusRepository._();

  @override
  int? id;

  int companyId;

  int deviceId;

  _i2.DeviceConnectionState connectionState;

  /// 各 feature 最新值，key 為 featureKey。
  Map<String, double> latestValues;

  DateTime? lastUpdatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DeviceStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceStatus copyWith({
    int? id,
    int? companyId,
    int? deviceId,
    _i2.DeviceConnectionState? connectionState,
    Map<String, double>? latestValues,
    DateTime? lastUpdatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceStatus',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'connectionState': connectionState.toJson(),
      'latestValues': latestValues.toJson(),
      if (lastUpdatedAt != null) 'lastUpdatedAt': lastUpdatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceStatus',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'connectionState': connectionState.toJson(),
      'latestValues': latestValues.toJson(),
      if (lastUpdatedAt != null) 'lastUpdatedAt': lastUpdatedAt?.toJson(),
    };
  }

  static DeviceStatusInclude include() {
    return DeviceStatusInclude._();
  }

  static DeviceStatusIncludeList includeList({
    _i1.WhereExpressionBuilder<DeviceStatusTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceStatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceStatusTable>? orderByList,
    DeviceStatusInclude? include,
  }) {
    return DeviceStatusIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceStatus.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DeviceStatus.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceStatusImpl extends DeviceStatus {
  _DeviceStatusImpl({
    int? id,
    required int companyId,
    required int deviceId,
    required _i2.DeviceConnectionState connectionState,
    required Map<String, double> latestValues,
    DateTime? lastUpdatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         deviceId: deviceId,
         connectionState: connectionState,
         latestValues: latestValues,
         lastUpdatedAt: lastUpdatedAt,
       );

  /// Returns a shallow copy of this [DeviceStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceStatus copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? deviceId,
    _i2.DeviceConnectionState? connectionState,
    Map<String, double>? latestValues,
    Object? lastUpdatedAt = _Undefined,
  }) {
    return DeviceStatus(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      deviceId: deviceId ?? this.deviceId,
      connectionState: connectionState ?? this.connectionState,
      latestValues:
          latestValues ??
          this.latestValues.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      lastUpdatedAt: lastUpdatedAt is DateTime?
          ? lastUpdatedAt
          : this.lastUpdatedAt,
    );
  }
}

class DeviceStatusUpdateTable extends _i1.UpdateTable<DeviceStatusTable> {
  DeviceStatusUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> deviceId(int value) => _i1.ColumnValue(
    table.deviceId,
    value,
  );

  _i1.ColumnValue<_i2.DeviceConnectionState, _i2.DeviceConnectionState>
  connectionState(_i2.DeviceConnectionState value) => _i1.ColumnValue(
    table.connectionState,
    value,
  );

  _i1.ColumnValue<Map<String, double>, Map<String, double>> latestValues(
    Map<String, double> value,
  ) => _i1.ColumnValue(
    table.latestValues,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastUpdatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastUpdatedAt,
        value,
      );
}

class DeviceStatusTable extends _i1.Table<int?> {
  DeviceStatusTable({super.tableRelation}) : super(tableName: 'device_status') {
    updateTable = DeviceStatusUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    deviceId = _i1.ColumnInt(
      'deviceId',
      this,
    );
    connectionState = _i1.ColumnEnum(
      'connectionState',
      this,
      _i1.EnumSerialization.byName,
    );
    latestValues = _i1.ColumnSerializable<Map<String, double>>(
      'latestValues',
      this,
    );
    lastUpdatedAt = _i1.ColumnDateTime(
      'lastUpdatedAt',
      this,
    );
  }

  late final DeviceStatusUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt deviceId;

  late final _i1.ColumnEnum<_i2.DeviceConnectionState> connectionState;

  /// 各 feature 最新值，key 為 featureKey。
  late final _i1.ColumnSerializable<Map<String, double>> latestValues;

  late final _i1.ColumnDateTime lastUpdatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    deviceId,
    connectionState,
    latestValues,
    lastUpdatedAt,
  ];
}

class DeviceStatusInclude extends _i1.IncludeObject {
  DeviceStatusInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DeviceStatus.t;
}

class DeviceStatusIncludeList extends _i1.IncludeList {
  DeviceStatusIncludeList._({
    _i1.WhereExpressionBuilder<DeviceStatusTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DeviceStatus.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DeviceStatus.t;
}

class DeviceStatusRepository {
  const DeviceStatusRepository._();

  /// Returns a list of [DeviceStatus]s matching the given query parameters.
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
  Future<List<DeviceStatus>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceStatusTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceStatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceStatusTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DeviceStatus>(
      where: where?.call(DeviceStatus.t),
      orderBy: orderBy?.call(DeviceStatus.t),
      orderByList: orderByList?.call(DeviceStatus.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DeviceStatus] matching the given query parameters.
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
  Future<DeviceStatus?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceStatusTable>? where,
    int? offset,
    _i1.OrderByBuilder<DeviceStatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceStatusTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DeviceStatus>(
      where: where?.call(DeviceStatus.t),
      orderBy: orderBy?.call(DeviceStatus.t),
      orderByList: orderByList?.call(DeviceStatus.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DeviceStatus] by its [id] or null if no such row exists.
  Future<DeviceStatus?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DeviceStatus>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DeviceStatus]s in the list and returns the inserted rows.
  ///
  /// The returned [DeviceStatus]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DeviceStatus>> insert(
    _i1.DatabaseSession session,
    List<DeviceStatus> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DeviceStatus>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DeviceStatus] and returns the inserted row.
  ///
  /// The returned [DeviceStatus] will have its `id` field set.
  Future<DeviceStatus> insertRow(
    _i1.DatabaseSession session,
    DeviceStatus row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DeviceStatus>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DeviceStatus]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DeviceStatus>> update(
    _i1.DatabaseSession session,
    List<DeviceStatus> rows, {
    _i1.ColumnSelections<DeviceStatusTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DeviceStatus>(
      rows,
      columns: columns?.call(DeviceStatus.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceStatus]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DeviceStatus> updateRow(
    _i1.DatabaseSession session,
    DeviceStatus row, {
    _i1.ColumnSelections<DeviceStatusTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DeviceStatus>(
      row,
      columns: columns?.call(DeviceStatus.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceStatus] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DeviceStatus?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DeviceStatusUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DeviceStatus>(
      id,
      columnValues: columnValues(DeviceStatus.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DeviceStatus]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DeviceStatus>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DeviceStatusUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DeviceStatusTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceStatusTable>? orderBy,
    _i1.OrderByListBuilder<DeviceStatusTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DeviceStatus>(
      columnValues: columnValues(DeviceStatus.t.updateTable),
      where: where(DeviceStatus.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceStatus.t),
      orderByList: orderByList?.call(DeviceStatus.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DeviceStatus]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DeviceStatus>> delete(
    _i1.DatabaseSession session,
    List<DeviceStatus> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DeviceStatus>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DeviceStatus].
  Future<DeviceStatus> deleteRow(
    _i1.DatabaseSession session,
    DeviceStatus row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DeviceStatus>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DeviceStatus>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceStatusTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DeviceStatus>(
      where: where(DeviceStatus.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceStatusTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DeviceStatus>(
      where: where?.call(DeviceStatus.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DeviceStatus] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceStatusTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DeviceStatus>(
      where: where(DeviceStatus.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
