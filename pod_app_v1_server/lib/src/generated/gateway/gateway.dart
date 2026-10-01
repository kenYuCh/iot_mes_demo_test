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

/// 閘道器。負責聚合底下設備資料上行至平台。
abstract class Gateway
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Gateway._({
    this.id,
    required this.companyId,
    required this.siteId,
    required this.serialNumber,
    required this.name,
    this.model,
    this.productKey,
    this.chipFamily,
    this.updateProtocol,
    this.hardwareRevision,
    this.firmwareVersion,
    required this.connectionState,
    this.lastSeenAt,
    required this.createdAt,
  });

  factory Gateway({
    int? id,
    required int companyId,
    required int siteId,
    required String serialNumber,
    required String name,
    String? model,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? firmwareVersion,
    required _i2.DeviceConnectionState connectionState,
    DateTime? lastSeenAt,
    required DateTime createdAt,
  }) = _GatewayImpl;

  factory Gateway.fromJson(Map<String, dynamic> jsonSerialization) {
    return Gateway(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      siteId: jsonSerialization['siteId'] as int,
      serialNumber: jsonSerialization['serialNumber'] as String,
      name: jsonSerialization['name'] as String,
      model: jsonSerialization['model'] as String?,
      productKey: jsonSerialization['productKey'] as String?,
      chipFamily: jsonSerialization['chipFamily'] as String?,
      updateProtocol: jsonSerialization['updateProtocol'] as String?,
      hardwareRevision: jsonSerialization['hardwareRevision'] as String?,
      firmwareVersion: jsonSerialization['firmwareVersion'] as String?,
      connectionState: _i2.DeviceConnectionState.fromJson(
        (jsonSerialization['connectionState'] as String),
      ),
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastSeenAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = GatewayTable();

  static const db = GatewayRepository._();

  @override
  int? id;

  int companyId;

  int siteId;

  String serialNumber;

  String name;

  /// 出廠型號與 OTA 相容性識別。
  String? model;

  String? productKey;

  String? chipFamily;

  String? updateProtocol;

  String? hardwareRevision;

  String? firmwareVersion;

  _i2.DeviceConnectionState connectionState;

  DateTime? lastSeenAt;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Gateway]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Gateway copyWith({
    int? id,
    int? companyId,
    int? siteId,
    String? serialNumber,
    String? name,
    String? model,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? firmwareVersion,
    _i2.DeviceConnectionState? connectionState,
    DateTime? lastSeenAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Gateway',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      'serialNumber': serialNumber,
      'name': name,
      if (model != null) 'model': model,
      if (productKey != null) 'productKey': productKey,
      if (chipFamily != null) 'chipFamily': chipFamily,
      if (updateProtocol != null) 'updateProtocol': updateProtocol,
      if (hardwareRevision != null) 'hardwareRevision': hardwareRevision,
      if (firmwareVersion != null) 'firmwareVersion': firmwareVersion,
      'connectionState': connectionState.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Gateway',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      'serialNumber': serialNumber,
      'name': name,
      if (model != null) 'model': model,
      if (productKey != null) 'productKey': productKey,
      if (chipFamily != null) 'chipFamily': chipFamily,
      if (updateProtocol != null) 'updateProtocol': updateProtocol,
      if (hardwareRevision != null) 'hardwareRevision': hardwareRevision,
      if (firmwareVersion != null) 'firmwareVersion': firmwareVersion,
      'connectionState': connectionState.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static GatewayInclude include() {
    return GatewayInclude._();
  }

  static GatewayIncludeList includeList({
    _i1.WhereExpressionBuilder<GatewayTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GatewayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GatewayTable>? orderByList,
    GatewayInclude? include,
  }) {
    return GatewayIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Gateway.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Gateway.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GatewayImpl extends Gateway {
  _GatewayImpl({
    int? id,
    required int companyId,
    required int siteId,
    required String serialNumber,
    required String name,
    String? model,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? firmwareVersion,
    required _i2.DeviceConnectionState connectionState,
    DateTime? lastSeenAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         siteId: siteId,
         serialNumber: serialNumber,
         name: name,
         model: model,
         productKey: productKey,
         chipFamily: chipFamily,
         updateProtocol: updateProtocol,
         hardwareRevision: hardwareRevision,
         firmwareVersion: firmwareVersion,
         connectionState: connectionState,
         lastSeenAt: lastSeenAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Gateway]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Gateway copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? siteId,
    String? serialNumber,
    String? name,
    Object? model = _Undefined,
    Object? productKey = _Undefined,
    Object? chipFamily = _Undefined,
    Object? updateProtocol = _Undefined,
    Object? hardwareRevision = _Undefined,
    Object? firmwareVersion = _Undefined,
    _i2.DeviceConnectionState? connectionState,
    Object? lastSeenAt = _Undefined,
    DateTime? createdAt,
  }) {
    return Gateway(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      siteId: siteId ?? this.siteId,
      serialNumber: serialNumber ?? this.serialNumber,
      name: name ?? this.name,
      model: model is String? ? model : this.model,
      productKey: productKey is String? ? productKey : this.productKey,
      chipFamily: chipFamily is String? ? chipFamily : this.chipFamily,
      updateProtocol: updateProtocol is String?
          ? updateProtocol
          : this.updateProtocol,
      hardwareRevision: hardwareRevision is String?
          ? hardwareRevision
          : this.hardwareRevision,
      firmwareVersion: firmwareVersion is String?
          ? firmwareVersion
          : this.firmwareVersion,
      connectionState: connectionState ?? this.connectionState,
      lastSeenAt: lastSeenAt is DateTime? ? lastSeenAt : this.lastSeenAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class GatewayUpdateTable extends _i1.UpdateTable<GatewayTable> {
  GatewayUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> siteId(int value) => _i1.ColumnValue(
    table.siteId,
    value,
  );

  _i1.ColumnValue<String, String> serialNumber(String value) => _i1.ColumnValue(
    table.serialNumber,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> model(String? value) => _i1.ColumnValue(
    table.model,
    value,
  );

  _i1.ColumnValue<String, String> productKey(String? value) => _i1.ColumnValue(
    table.productKey,
    value,
  );

  _i1.ColumnValue<String, String> chipFamily(String? value) => _i1.ColumnValue(
    table.chipFamily,
    value,
  );

  _i1.ColumnValue<String, String> updateProtocol(String? value) =>
      _i1.ColumnValue(
        table.updateProtocol,
        value,
      );

  _i1.ColumnValue<String, String> hardwareRevision(String? value) =>
      _i1.ColumnValue(
        table.hardwareRevision,
        value,
      );

  _i1.ColumnValue<String, String> firmwareVersion(String? value) =>
      _i1.ColumnValue(
        table.firmwareVersion,
        value,
      );

  _i1.ColumnValue<_i2.DeviceConnectionState, _i2.DeviceConnectionState>
  connectionState(_i2.DeviceConnectionState value) => _i1.ColumnValue(
    table.connectionState,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastSeenAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class GatewayTable extends _i1.Table<int?> {
  GatewayTable({super.tableRelation}) : super(tableName: 'gateway') {
    updateTable = GatewayUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    siteId = _i1.ColumnInt(
      'siteId',
      this,
    );
    serialNumber = _i1.ColumnString(
      'serialNumber',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    model = _i1.ColumnString(
      'model',
      this,
    );
    productKey = _i1.ColumnString(
      'productKey',
      this,
    );
    chipFamily = _i1.ColumnString(
      'chipFamily',
      this,
    );
    updateProtocol = _i1.ColumnString(
      'updateProtocol',
      this,
    );
    hardwareRevision = _i1.ColumnString(
      'hardwareRevision',
      this,
    );
    firmwareVersion = _i1.ColumnString(
      'firmwareVersion',
      this,
    );
    connectionState = _i1.ColumnEnum(
      'connectionState',
      this,
      _i1.EnumSerialization.byName,
    );
    lastSeenAt = _i1.ColumnDateTime(
      'lastSeenAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final GatewayUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt siteId;

  late final _i1.ColumnString serialNumber;

  late final _i1.ColumnString name;

  /// 出廠型號與 OTA 相容性識別。
  late final _i1.ColumnString model;

  late final _i1.ColumnString productKey;

  late final _i1.ColumnString chipFamily;

  late final _i1.ColumnString updateProtocol;

  late final _i1.ColumnString hardwareRevision;

  late final _i1.ColumnString firmwareVersion;

  late final _i1.ColumnEnum<_i2.DeviceConnectionState> connectionState;

  late final _i1.ColumnDateTime lastSeenAt;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    siteId,
    serialNumber,
    name,
    model,
    productKey,
    chipFamily,
    updateProtocol,
    hardwareRevision,
    firmwareVersion,
    connectionState,
    lastSeenAt,
    createdAt,
  ];
}

class GatewayInclude extends _i1.IncludeObject {
  GatewayInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Gateway.t;
}

class GatewayIncludeList extends _i1.IncludeList {
  GatewayIncludeList._({
    _i1.WhereExpressionBuilder<GatewayTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Gateway.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Gateway.t;
}

class GatewayRepository {
  const GatewayRepository._();

  /// Returns a list of [Gateway]s matching the given query parameters.
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
  Future<List<Gateway>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GatewayTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GatewayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GatewayTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Gateway>(
      where: where?.call(Gateway.t),
      orderBy: orderBy?.call(Gateway.t),
      orderByList: orderByList?.call(Gateway.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Gateway] matching the given query parameters.
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
  Future<Gateway?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GatewayTable>? where,
    int? offset,
    _i1.OrderByBuilder<GatewayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GatewayTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Gateway>(
      where: where?.call(Gateway.t),
      orderBy: orderBy?.call(Gateway.t),
      orderByList: orderByList?.call(Gateway.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Gateway] by its [id] or null if no such row exists.
  Future<Gateway?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Gateway>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Gateway]s in the list and returns the inserted rows.
  ///
  /// The returned [Gateway]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Gateway>> insert(
    _i1.DatabaseSession session,
    List<Gateway> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Gateway>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Gateway] and returns the inserted row.
  ///
  /// The returned [Gateway] will have its `id` field set.
  Future<Gateway> insertRow(
    _i1.DatabaseSession session,
    Gateway row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Gateway>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Gateway]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Gateway>> update(
    _i1.DatabaseSession session,
    List<Gateway> rows, {
    _i1.ColumnSelections<GatewayTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Gateway>(
      rows,
      columns: columns?.call(Gateway.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Gateway]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Gateway> updateRow(
    _i1.DatabaseSession session,
    Gateway row, {
    _i1.ColumnSelections<GatewayTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Gateway>(
      row,
      columns: columns?.call(Gateway.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Gateway] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Gateway?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<GatewayUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Gateway>(
      id,
      columnValues: columnValues(Gateway.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Gateway]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Gateway>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<GatewayUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<GatewayTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GatewayTable>? orderBy,
    _i1.OrderByListBuilder<GatewayTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Gateway>(
      columnValues: columnValues(Gateway.t.updateTable),
      where: where(Gateway.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Gateway.t),
      orderByList: orderByList?.call(Gateway.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Gateway]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Gateway>> delete(
    _i1.DatabaseSession session,
    List<Gateway> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Gateway>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Gateway].
  Future<Gateway> deleteRow(
    _i1.DatabaseSession session,
    Gateway row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Gateway>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Gateway>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<GatewayTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Gateway>(
      where: where(Gateway.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GatewayTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Gateway>(
      where: where?.call(Gateway.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Gateway] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<GatewayTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Gateway>(
      where: where(Gateway.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
