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

/// Claim Session（手冊 §7）：使用者掃碼後建立，效期 5 分鐘，
/// 等待設備以 Bootstrap 身分回應 claim-confirm。
abstract class DeviceClaim
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DeviceClaim._({
    this.id,
    required this.sessionId,
    required this.serial,
    required this.userIdentifier,
    required this.companyId,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
    this.confirmedAt,
  });

  factory DeviceClaim({
    int? id,
    required String sessionId,
    required String serial,
    required String userIdentifier,
    required int companyId,
    required String status,
    required DateTime expiresAt,
    required DateTime createdAt,
    DateTime? confirmedAt,
  }) = _DeviceClaimImpl;

  factory DeviceClaim.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceClaim(
      id: jsonSerialization['id'] as int?,
      sessionId: jsonSerialization['sessionId'] as String,
      serial: jsonSerialization['serial'] as String,
      userIdentifier: jsonSerialization['userIdentifier'] as String,
      companyId: jsonSerialization['companyId'] as int,
      status: jsonSerialization['status'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      confirmedAt: jsonSerialization['confirmedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['confirmedAt'],
            ),
    );
  }

  static final t = DeviceClaimTable();

  static const db = DeviceClaimRepository._();

  @override
  int? id;

  /// 對外的 claim_session_id。
  String sessionId;

  String serial;

  /// 發起綁定的使用者。
  String userIdentifier;

  int companyId;

  /// waiting_for_device / confirmed / expired。
  String status;

  DateTime expiresAt;

  DateTime createdAt;

  DateTime? confirmedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DeviceClaim]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceClaim copyWith({
    int? id,
    String? sessionId,
    String? serial,
    String? userIdentifier,
    int? companyId,
    String? status,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? confirmedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceClaim',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'serial': serial,
      'userIdentifier': userIdentifier,
      'companyId': companyId,
      'status': status,
      'expiresAt': expiresAt.toJson(),
      'createdAt': createdAt.toJson(),
      if (confirmedAt != null) 'confirmedAt': confirmedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceClaim',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'serial': serial,
      'userIdentifier': userIdentifier,
      'companyId': companyId,
      'status': status,
      'expiresAt': expiresAt.toJson(),
      'createdAt': createdAt.toJson(),
      if (confirmedAt != null) 'confirmedAt': confirmedAt?.toJson(),
    };
  }

  static DeviceClaimInclude include() {
    return DeviceClaimInclude._();
  }

  static DeviceClaimIncludeList includeList({
    _i1.WhereExpressionBuilder<DeviceClaimTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceClaimTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceClaimTable>? orderByList,
    DeviceClaimInclude? include,
  }) {
    return DeviceClaimIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceClaim.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DeviceClaim.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceClaimImpl extends DeviceClaim {
  _DeviceClaimImpl({
    int? id,
    required String sessionId,
    required String serial,
    required String userIdentifier,
    required int companyId,
    required String status,
    required DateTime expiresAt,
    required DateTime createdAt,
    DateTime? confirmedAt,
  }) : super._(
         id: id,
         sessionId: sessionId,
         serial: serial,
         userIdentifier: userIdentifier,
         companyId: companyId,
         status: status,
         expiresAt: expiresAt,
         createdAt: createdAt,
         confirmedAt: confirmedAt,
       );

  /// Returns a shallow copy of this [DeviceClaim]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceClaim copyWith({
    Object? id = _Undefined,
    String? sessionId,
    String? serial,
    String? userIdentifier,
    int? companyId,
    String? status,
    DateTime? expiresAt,
    DateTime? createdAt,
    Object? confirmedAt = _Undefined,
  }) {
    return DeviceClaim(
      id: id is int? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      serial: serial ?? this.serial,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      companyId: companyId ?? this.companyId,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      confirmedAt: confirmedAt is DateTime? ? confirmedAt : this.confirmedAt,
    );
  }
}

class DeviceClaimUpdateTable extends _i1.UpdateTable<DeviceClaimTable> {
  DeviceClaimUpdateTable(super.table);

  _i1.ColumnValue<String, String> sessionId(String value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );

  _i1.ColumnValue<String, String> serial(String value) => _i1.ColumnValue(
    table.serial,
    value,
  );

  _i1.ColumnValue<String, String> userIdentifier(String value) =>
      _i1.ColumnValue(
        table.userIdentifier,
        value,
      );

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> confirmedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.confirmedAt,
        value,
      );
}

class DeviceClaimTable extends _i1.Table<int?> {
  DeviceClaimTable({super.tableRelation}) : super(tableName: 'device_claim') {
    updateTable = DeviceClaimUpdateTable(this);
    sessionId = _i1.ColumnString(
      'sessionId',
      this,
    );
    serial = _i1.ColumnString(
      'serial',
      this,
    );
    userIdentifier = _i1.ColumnString(
      'userIdentifier',
      this,
    );
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    confirmedAt = _i1.ColumnDateTime(
      'confirmedAt',
      this,
    );
  }

  late final DeviceClaimUpdateTable updateTable;

  /// 對外的 claim_session_id。
  late final _i1.ColumnString sessionId;

  late final _i1.ColumnString serial;

  /// 發起綁定的使用者。
  late final _i1.ColumnString userIdentifier;

  late final _i1.ColumnInt companyId;

  /// waiting_for_device / confirmed / expired。
  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime confirmedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    sessionId,
    serial,
    userIdentifier,
    companyId,
    status,
    expiresAt,
    createdAt,
    confirmedAt,
  ];
}

class DeviceClaimInclude extends _i1.IncludeObject {
  DeviceClaimInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DeviceClaim.t;
}

class DeviceClaimIncludeList extends _i1.IncludeList {
  DeviceClaimIncludeList._({
    _i1.WhereExpressionBuilder<DeviceClaimTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DeviceClaim.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DeviceClaim.t;
}

class DeviceClaimRepository {
  const DeviceClaimRepository._();

  /// Returns a list of [DeviceClaim]s matching the given query parameters.
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
  Future<List<DeviceClaim>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceClaimTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceClaimTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceClaimTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DeviceClaim>(
      where: where?.call(DeviceClaim.t),
      orderBy: orderBy?.call(DeviceClaim.t),
      orderByList: orderByList?.call(DeviceClaim.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DeviceClaim] matching the given query parameters.
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
  Future<DeviceClaim?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceClaimTable>? where,
    int? offset,
    _i1.OrderByBuilder<DeviceClaimTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceClaimTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DeviceClaim>(
      where: where?.call(DeviceClaim.t),
      orderBy: orderBy?.call(DeviceClaim.t),
      orderByList: orderByList?.call(DeviceClaim.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DeviceClaim] by its [id] or null if no such row exists.
  Future<DeviceClaim?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DeviceClaim>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DeviceClaim]s in the list and returns the inserted rows.
  ///
  /// The returned [DeviceClaim]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DeviceClaim>> insert(
    _i1.DatabaseSession session,
    List<DeviceClaim> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DeviceClaim>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DeviceClaim] and returns the inserted row.
  ///
  /// The returned [DeviceClaim] will have its `id` field set.
  Future<DeviceClaim> insertRow(
    _i1.DatabaseSession session,
    DeviceClaim row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DeviceClaim>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DeviceClaim]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DeviceClaim>> update(
    _i1.DatabaseSession session,
    List<DeviceClaim> rows, {
    _i1.ColumnSelections<DeviceClaimTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DeviceClaim>(
      rows,
      columns: columns?.call(DeviceClaim.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceClaim]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DeviceClaim> updateRow(
    _i1.DatabaseSession session,
    DeviceClaim row, {
    _i1.ColumnSelections<DeviceClaimTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DeviceClaim>(
      row,
      columns: columns?.call(DeviceClaim.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceClaim] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DeviceClaim?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DeviceClaimUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DeviceClaim>(
      id,
      columnValues: columnValues(DeviceClaim.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DeviceClaim]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DeviceClaim>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DeviceClaimUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DeviceClaimTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceClaimTable>? orderBy,
    _i1.OrderByListBuilder<DeviceClaimTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DeviceClaim>(
      columnValues: columnValues(DeviceClaim.t.updateTable),
      where: where(DeviceClaim.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceClaim.t),
      orderByList: orderByList?.call(DeviceClaim.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DeviceClaim]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DeviceClaim>> delete(
    _i1.DatabaseSession session,
    List<DeviceClaim> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DeviceClaim>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DeviceClaim].
  Future<DeviceClaim> deleteRow(
    _i1.DatabaseSession session,
    DeviceClaim row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DeviceClaim>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DeviceClaim>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceClaimTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DeviceClaim>(
      where: where(DeviceClaim.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceClaimTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DeviceClaim>(
      where: where?.call(DeviceClaim.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DeviceClaim] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceClaimTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DeviceClaim>(
      where: where(DeviceClaim.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
