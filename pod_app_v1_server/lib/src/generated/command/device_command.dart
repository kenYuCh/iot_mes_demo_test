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
import '../command/device_command_state.dart' as _i2;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i3;

/// 下發至裝置的控制命令（冪等，一鍵一命令）。
abstract class DeviceCommand
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DeviceCommand._({
    this.id,
    required this.companyId,
    required this.deviceId,
    required this.commandType,
    required this.payload,
    required this.state,
    required this.idempotencyKey,
    required this.issuedBy,
    this.errorMessage,
    required this.createdAt,
    this.sentAt,
    this.acknowledgedAt,
    this.completedAt,
  });

  factory DeviceCommand({
    int? id,
    required int companyId,
    required int deviceId,
    required String commandType,
    required Map<String, String> payload,
    required _i2.DeviceCommandState state,
    required String idempotencyKey,
    required String issuedBy,
    String? errorMessage,
    required DateTime createdAt,
    DateTime? sentAt,
    DateTime? acknowledgedAt,
    DateTime? completedAt,
  }) = _DeviceCommandImpl;

  factory DeviceCommand.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceCommand(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      commandType: jsonSerialization['commandType'] as String,
      payload: _i3.Protocol().deserialize<Map<String, String>>(
        jsonSerialization['payload'],
      ),
      state: _i2.DeviceCommandState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      idempotencyKey: jsonSerialization['idempotencyKey'] as String,
      issuedBy: jsonSerialization['issuedBy'] as String,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt'],
            ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  static final t = DeviceCommandTable();

  static const db = DeviceCommandRepository._();

  @override
  int? id;

  int companyId;

  int deviceId;

  /// 命令類型，例如 reboot、calibrate、setInterval。
  String commandType;

  /// 命令參數。
  Map<String, String> payload;

  _i2.DeviceCommandState state;

  /// 冪等鍵：同一鍵重複下發時回傳既有命令，不重複建立。
  String idempotencyKey;

  /// 下發者（authUserId）。
  String issuedBy;

  /// 失敗或逾時原因。
  String? errorMessage;

  DateTime createdAt;

  DateTime? sentAt;

  DateTime? acknowledgedAt;

  /// 進入終態（completed/failed/timedOut/cancelled）時間。
  DateTime? completedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DeviceCommand]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceCommand copyWith({
    int? id,
    int? companyId,
    int? deviceId,
    String? commandType,
    Map<String, String>? payload,
    _i2.DeviceCommandState? state,
    String? idempotencyKey,
    String? issuedBy,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? sentAt,
    DateTime? acknowledgedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceCommand',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'commandType': commandType,
      'payload': payload.toJson(),
      'state': state.toJson(),
      'idempotencyKey': idempotencyKey,
      'issuedBy': issuedBy,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'createdAt': createdAt.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceCommand',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'commandType': commandType,
      'payload': payload.toJson(),
      'state': state.toJson(),
      'idempotencyKey': idempotencyKey,
      'issuedBy': issuedBy,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'createdAt': createdAt.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  static DeviceCommandInclude include() {
    return DeviceCommandInclude._();
  }

  static DeviceCommandIncludeList includeList({
    _i1.WhereExpressionBuilder<DeviceCommandTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceCommandTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceCommandTable>? orderByList,
    DeviceCommandInclude? include,
  }) {
    return DeviceCommandIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceCommand.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DeviceCommand.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceCommandImpl extends DeviceCommand {
  _DeviceCommandImpl({
    int? id,
    required int companyId,
    required int deviceId,
    required String commandType,
    required Map<String, String> payload,
    required _i2.DeviceCommandState state,
    required String idempotencyKey,
    required String issuedBy,
    String? errorMessage,
    required DateTime createdAt,
    DateTime? sentAt,
    DateTime? acknowledgedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         deviceId: deviceId,
         commandType: commandType,
         payload: payload,
         state: state,
         idempotencyKey: idempotencyKey,
         issuedBy: issuedBy,
         errorMessage: errorMessage,
         createdAt: createdAt,
         sentAt: sentAt,
         acknowledgedAt: acknowledgedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [DeviceCommand]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceCommand copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? deviceId,
    String? commandType,
    Map<String, String>? payload,
    _i2.DeviceCommandState? state,
    String? idempotencyKey,
    String? issuedBy,
    Object? errorMessage = _Undefined,
    DateTime? createdAt,
    Object? sentAt = _Undefined,
    Object? acknowledgedAt = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return DeviceCommand(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      deviceId: deviceId ?? this.deviceId,
      commandType: commandType ?? this.commandType,
      payload:
          payload ??
          this.payload.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      state: state ?? this.state,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      issuedBy: issuedBy ?? this.issuedBy,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      acknowledgedAt: acknowledgedAt is DateTime?
          ? acknowledgedAt
          : this.acknowledgedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}

class DeviceCommandUpdateTable extends _i1.UpdateTable<DeviceCommandTable> {
  DeviceCommandUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> deviceId(int value) => _i1.ColumnValue(
    table.deviceId,
    value,
  );

  _i1.ColumnValue<String, String> commandType(String value) => _i1.ColumnValue(
    table.commandType,
    value,
  );

  _i1.ColumnValue<Map<String, String>, Map<String, String>> payload(
    Map<String, String> value,
  ) => _i1.ColumnValue(
    table.payload,
    value,
  );

  _i1.ColumnValue<_i2.DeviceCommandState, _i2.DeviceCommandState> state(
    _i2.DeviceCommandState value,
  ) => _i1.ColumnValue(
    table.state,
    value,
  );

  _i1.ColumnValue<String, String> idempotencyKey(String value) =>
      _i1.ColumnValue(
        table.idempotencyKey,
        value,
      );

  _i1.ColumnValue<String, String> issuedBy(String value) => _i1.ColumnValue(
    table.issuedBy,
    value,
  );

  _i1.ColumnValue<String, String> errorMessage(String? value) =>
      _i1.ColumnValue(
        table.errorMessage,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> sentAt(DateTime? value) =>
      _i1.ColumnValue(
        table.sentAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> acknowledgedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.acknowledgedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );
}

class DeviceCommandTable extends _i1.Table<int?> {
  DeviceCommandTable({super.tableRelation})
    : super(tableName: 'device_command') {
    updateTable = DeviceCommandUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    deviceId = _i1.ColumnInt(
      'deviceId',
      this,
    );
    commandType = _i1.ColumnString(
      'commandType',
      this,
    );
    payload = _i1.ColumnSerializable<Map<String, String>>(
      'payload',
      this,
    );
    state = _i1.ColumnEnum(
      'state',
      this,
      _i1.EnumSerialization.byName,
    );
    idempotencyKey = _i1.ColumnString(
      'idempotencyKey',
      this,
    );
    issuedBy = _i1.ColumnString(
      'issuedBy',
      this,
    );
    errorMessage = _i1.ColumnString(
      'errorMessage',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    sentAt = _i1.ColumnDateTime(
      'sentAt',
      this,
    );
    acknowledgedAt = _i1.ColumnDateTime(
      'acknowledgedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final DeviceCommandUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt deviceId;

  /// 命令類型，例如 reboot、calibrate、setInterval。
  late final _i1.ColumnString commandType;

  /// 命令參數。
  late final _i1.ColumnSerializable<Map<String, String>> payload;

  late final _i1.ColumnEnum<_i2.DeviceCommandState> state;

  /// 冪等鍵：同一鍵重複下發時回傳既有命令，不重複建立。
  late final _i1.ColumnString idempotencyKey;

  /// 下發者（authUserId）。
  late final _i1.ColumnString issuedBy;

  /// 失敗或逾時原因。
  late final _i1.ColumnString errorMessage;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime sentAt;

  late final _i1.ColumnDateTime acknowledgedAt;

  /// 進入終態（completed/failed/timedOut/cancelled）時間。
  late final _i1.ColumnDateTime completedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    deviceId,
    commandType,
    payload,
    state,
    idempotencyKey,
    issuedBy,
    errorMessage,
    createdAt,
    sentAt,
    acknowledgedAt,
    completedAt,
  ];
}

class DeviceCommandInclude extends _i1.IncludeObject {
  DeviceCommandInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DeviceCommand.t;
}

class DeviceCommandIncludeList extends _i1.IncludeList {
  DeviceCommandIncludeList._({
    _i1.WhereExpressionBuilder<DeviceCommandTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DeviceCommand.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DeviceCommand.t;
}

class DeviceCommandRepository {
  const DeviceCommandRepository._();

  /// Returns a list of [DeviceCommand]s matching the given query parameters.
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
  Future<List<DeviceCommand>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceCommandTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceCommandTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceCommandTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DeviceCommand>(
      where: where?.call(DeviceCommand.t),
      orderBy: orderBy?.call(DeviceCommand.t),
      orderByList: orderByList?.call(DeviceCommand.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DeviceCommand] matching the given query parameters.
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
  Future<DeviceCommand?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceCommandTable>? where,
    int? offset,
    _i1.OrderByBuilder<DeviceCommandTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceCommandTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DeviceCommand>(
      where: where?.call(DeviceCommand.t),
      orderBy: orderBy?.call(DeviceCommand.t),
      orderByList: orderByList?.call(DeviceCommand.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DeviceCommand] by its [id] or null if no such row exists.
  Future<DeviceCommand?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DeviceCommand>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DeviceCommand]s in the list and returns the inserted rows.
  ///
  /// The returned [DeviceCommand]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DeviceCommand>> insert(
    _i1.DatabaseSession session,
    List<DeviceCommand> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DeviceCommand>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DeviceCommand] and returns the inserted row.
  ///
  /// The returned [DeviceCommand] will have its `id` field set.
  Future<DeviceCommand> insertRow(
    _i1.DatabaseSession session,
    DeviceCommand row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DeviceCommand>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DeviceCommand]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DeviceCommand>> update(
    _i1.DatabaseSession session,
    List<DeviceCommand> rows, {
    _i1.ColumnSelections<DeviceCommandTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DeviceCommand>(
      rows,
      columns: columns?.call(DeviceCommand.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceCommand]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DeviceCommand> updateRow(
    _i1.DatabaseSession session,
    DeviceCommand row, {
    _i1.ColumnSelections<DeviceCommandTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DeviceCommand>(
      row,
      columns: columns?.call(DeviceCommand.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceCommand] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DeviceCommand?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DeviceCommandUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DeviceCommand>(
      id,
      columnValues: columnValues(DeviceCommand.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DeviceCommand]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DeviceCommand>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DeviceCommandUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DeviceCommandTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceCommandTable>? orderBy,
    _i1.OrderByListBuilder<DeviceCommandTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DeviceCommand>(
      columnValues: columnValues(DeviceCommand.t.updateTable),
      where: where(DeviceCommand.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceCommand.t),
      orderByList: orderByList?.call(DeviceCommand.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DeviceCommand]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DeviceCommand>> delete(
    _i1.DatabaseSession session,
    List<DeviceCommand> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DeviceCommand>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DeviceCommand].
  Future<DeviceCommand> deleteRow(
    _i1.DatabaseSession session,
    DeviceCommand row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DeviceCommand>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DeviceCommand>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceCommandTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DeviceCommand>(
      where: where(DeviceCommand.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceCommandTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DeviceCommand>(
      where: where?.call(DeviceCommand.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DeviceCommand] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceCommandTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DeviceCommand>(
      where: where(DeviceCommand.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
