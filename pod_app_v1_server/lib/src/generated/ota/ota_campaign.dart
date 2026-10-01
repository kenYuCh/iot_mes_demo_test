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
import '../ota/ota_strategy.dart' as _i2;
import '../ota/ota_campaign_state.dart' as _i3;

/// 一次 OTA 發布活動；每台目標設備另有 OtaDeviceJob。
abstract class OtaCampaign
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OtaCampaign._({
    this.id,
    required this.companyId,
    required this.firmwarePackageId,
    required this.name,
    required this.targetDeviceType,
    required this.strategy,
    required this.state,
    this.scheduledAt,
    required this.totalDevices,
    required this.succeededDevices,
    required this.failedDevices,
    required this.createdBy,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
  });

  factory OtaCampaign({
    int? id,
    required int companyId,
    required int firmwarePackageId,
    required String name,
    required String targetDeviceType,
    required _i2.OtaStrategy strategy,
    required _i3.OtaCampaignState state,
    DateTime? scheduledAt,
    required int totalDevices,
    required int succeededDevices,
    required int failedDevices,
    required String createdBy,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _OtaCampaignImpl;

  factory OtaCampaign.fromJson(Map<String, dynamic> jsonSerialization) {
    return OtaCampaign(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      firmwarePackageId: jsonSerialization['firmwarePackageId'] as int,
      name: jsonSerialization['name'] as String,
      targetDeviceType: jsonSerialization['targetDeviceType'] as String,
      strategy: _i2.OtaStrategy.fromJson(
        (jsonSerialization['strategy'] as String),
      ),
      state: _i3.OtaCampaignState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      scheduledAt: jsonSerialization['scheduledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scheduledAt'],
            ),
      totalDevices: jsonSerialization['totalDevices'] as int,
      succeededDevices: jsonSerialization['succeededDevices'] as int,
      failedDevices: jsonSerialization['failedDevices'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  static final t = OtaCampaignTable();

  static const db = OtaCampaignRepository._();

  @override
  int? id;

  int companyId;

  int firmwarePackageId;

  String name;

  String targetDeviceType;

  _i2.OtaStrategy strategy;

  _i3.OtaCampaignState state;

  DateTime? scheduledAt;

  int totalDevices;

  int succeededDevices;

  int failedDevices;

  String createdBy;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? completedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OtaCampaign]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OtaCampaign copyWith({
    int? id,
    int? companyId,
    int? firmwarePackageId,
    String? name,
    String? targetDeviceType,
    _i2.OtaStrategy? strategy,
    _i3.OtaCampaignState? state,
    DateTime? scheduledAt,
    int? totalDevices,
    int? succeededDevices,
    int? failedDevices,
    String? createdBy,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OtaCampaign',
      if (id != null) 'id': id,
      'companyId': companyId,
      'firmwarePackageId': firmwarePackageId,
      'name': name,
      'targetDeviceType': targetDeviceType,
      'strategy': strategy.toJson(),
      'state': state.toJson(),
      if (scheduledAt != null) 'scheduledAt': scheduledAt?.toJson(),
      'totalDevices': totalDevices,
      'succeededDevices': succeededDevices,
      'failedDevices': failedDevices,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OtaCampaign',
      if (id != null) 'id': id,
      'companyId': companyId,
      'firmwarePackageId': firmwarePackageId,
      'name': name,
      'targetDeviceType': targetDeviceType,
      'strategy': strategy.toJson(),
      'state': state.toJson(),
      if (scheduledAt != null) 'scheduledAt': scheduledAt?.toJson(),
      'totalDevices': totalDevices,
      'succeededDevices': succeededDevices,
      'failedDevices': failedDevices,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  static OtaCampaignInclude include() {
    return OtaCampaignInclude._();
  }

  static OtaCampaignIncludeList includeList({
    _i1.WhereExpressionBuilder<OtaCampaignTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OtaCampaignTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OtaCampaignTable>? orderByList,
    OtaCampaignInclude? include,
  }) {
    return OtaCampaignIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OtaCampaign.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OtaCampaign.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OtaCampaignImpl extends OtaCampaign {
  _OtaCampaignImpl({
    int? id,
    required int companyId,
    required int firmwarePackageId,
    required String name,
    required String targetDeviceType,
    required _i2.OtaStrategy strategy,
    required _i3.OtaCampaignState state,
    DateTime? scheduledAt,
    required int totalDevices,
    required int succeededDevices,
    required int failedDevices,
    required String createdBy,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         firmwarePackageId: firmwarePackageId,
         name: name,
         targetDeviceType: targetDeviceType,
         strategy: strategy,
         state: state,
         scheduledAt: scheduledAt,
         totalDevices: totalDevices,
         succeededDevices: succeededDevices,
         failedDevices: failedDevices,
         createdBy: createdBy,
         createdAt: createdAt,
         startedAt: startedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [OtaCampaign]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OtaCampaign copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? firmwarePackageId,
    String? name,
    String? targetDeviceType,
    _i2.OtaStrategy? strategy,
    _i3.OtaCampaignState? state,
    Object? scheduledAt = _Undefined,
    int? totalDevices,
    int? succeededDevices,
    int? failedDevices,
    String? createdBy,
    DateTime? createdAt,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return OtaCampaign(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      firmwarePackageId: firmwarePackageId ?? this.firmwarePackageId,
      name: name ?? this.name,
      targetDeviceType: targetDeviceType ?? this.targetDeviceType,
      strategy: strategy ?? this.strategy,
      state: state ?? this.state,
      scheduledAt: scheduledAt is DateTime? ? scheduledAt : this.scheduledAt,
      totalDevices: totalDevices ?? this.totalDevices,
      succeededDevices: succeededDevices ?? this.succeededDevices,
      failedDevices: failedDevices ?? this.failedDevices,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}

class OtaCampaignUpdateTable extends _i1.UpdateTable<OtaCampaignTable> {
  OtaCampaignUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> firmwarePackageId(int value) => _i1.ColumnValue(
    table.firmwarePackageId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> targetDeviceType(String value) =>
      _i1.ColumnValue(
        table.targetDeviceType,
        value,
      );

  _i1.ColumnValue<_i2.OtaStrategy, _i2.OtaStrategy> strategy(
    _i2.OtaStrategy value,
  ) => _i1.ColumnValue(
    table.strategy,
    value,
  );

  _i1.ColumnValue<_i3.OtaCampaignState, _i3.OtaCampaignState> state(
    _i3.OtaCampaignState value,
  ) => _i1.ColumnValue(
    table.state,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> scheduledAt(DateTime? value) =>
      _i1.ColumnValue(
        table.scheduledAt,
        value,
      );

  _i1.ColumnValue<int, int> totalDevices(int value) => _i1.ColumnValue(
    table.totalDevices,
    value,
  );

  _i1.ColumnValue<int, int> succeededDevices(int value) => _i1.ColumnValue(
    table.succeededDevices,
    value,
  );

  _i1.ColumnValue<int, int> failedDevices(int value) => _i1.ColumnValue(
    table.failedDevices,
    value,
  );

  _i1.ColumnValue<String, String> createdBy(String value) => _i1.ColumnValue(
    table.createdBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );
}

class OtaCampaignTable extends _i1.Table<int?> {
  OtaCampaignTable({super.tableRelation}) : super(tableName: 'ota_campaign') {
    updateTable = OtaCampaignUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    firmwarePackageId = _i1.ColumnInt(
      'firmwarePackageId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    targetDeviceType = _i1.ColumnString(
      'targetDeviceType',
      this,
    );
    strategy = _i1.ColumnEnum(
      'strategy',
      this,
      _i1.EnumSerialization.byName,
    );
    state = _i1.ColumnEnum(
      'state',
      this,
      _i1.EnumSerialization.byName,
    );
    scheduledAt = _i1.ColumnDateTime(
      'scheduledAt',
      this,
    );
    totalDevices = _i1.ColumnInt(
      'totalDevices',
      this,
    );
    succeededDevices = _i1.ColumnInt(
      'succeededDevices',
      this,
    );
    failedDevices = _i1.ColumnInt(
      'failedDevices',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final OtaCampaignUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt firmwarePackageId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString targetDeviceType;

  late final _i1.ColumnEnum<_i2.OtaStrategy> strategy;

  late final _i1.ColumnEnum<_i3.OtaCampaignState> state;

  late final _i1.ColumnDateTime scheduledAt;

  late final _i1.ColumnInt totalDevices;

  late final _i1.ColumnInt succeededDevices;

  late final _i1.ColumnInt failedDevices;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime completedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    firmwarePackageId,
    name,
    targetDeviceType,
    strategy,
    state,
    scheduledAt,
    totalDevices,
    succeededDevices,
    failedDevices,
    createdBy,
    createdAt,
    startedAt,
    completedAt,
  ];
}

class OtaCampaignInclude extends _i1.IncludeObject {
  OtaCampaignInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OtaCampaign.t;
}

class OtaCampaignIncludeList extends _i1.IncludeList {
  OtaCampaignIncludeList._({
    _i1.WhereExpressionBuilder<OtaCampaignTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OtaCampaign.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OtaCampaign.t;
}

class OtaCampaignRepository {
  const OtaCampaignRepository._();

  /// Returns a list of [OtaCampaign]s matching the given query parameters.
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
  Future<List<OtaCampaign>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OtaCampaignTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OtaCampaignTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OtaCampaignTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OtaCampaign>(
      where: where?.call(OtaCampaign.t),
      orderBy: orderBy?.call(OtaCampaign.t),
      orderByList: orderByList?.call(OtaCampaign.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OtaCampaign] matching the given query parameters.
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
  Future<OtaCampaign?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OtaCampaignTable>? where,
    int? offset,
    _i1.OrderByBuilder<OtaCampaignTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OtaCampaignTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OtaCampaign>(
      where: where?.call(OtaCampaign.t),
      orderBy: orderBy?.call(OtaCampaign.t),
      orderByList: orderByList?.call(OtaCampaign.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OtaCampaign] by its [id] or null if no such row exists.
  Future<OtaCampaign?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OtaCampaign>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OtaCampaign]s in the list and returns the inserted rows.
  ///
  /// The returned [OtaCampaign]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OtaCampaign>> insert(
    _i1.DatabaseSession session,
    List<OtaCampaign> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OtaCampaign>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OtaCampaign] and returns the inserted row.
  ///
  /// The returned [OtaCampaign] will have its `id` field set.
  Future<OtaCampaign> insertRow(
    _i1.DatabaseSession session,
    OtaCampaign row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OtaCampaign>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OtaCampaign]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OtaCampaign>> update(
    _i1.DatabaseSession session,
    List<OtaCampaign> rows, {
    _i1.ColumnSelections<OtaCampaignTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OtaCampaign>(
      rows,
      columns: columns?.call(OtaCampaign.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OtaCampaign]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OtaCampaign> updateRow(
    _i1.DatabaseSession session,
    OtaCampaign row, {
    _i1.ColumnSelections<OtaCampaignTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OtaCampaign>(
      row,
      columns: columns?.call(OtaCampaign.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OtaCampaign] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OtaCampaign?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OtaCampaignUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OtaCampaign>(
      id,
      columnValues: columnValues(OtaCampaign.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OtaCampaign]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OtaCampaign>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OtaCampaignUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OtaCampaignTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OtaCampaignTable>? orderBy,
    _i1.OrderByListBuilder<OtaCampaignTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OtaCampaign>(
      columnValues: columnValues(OtaCampaign.t.updateTable),
      where: where(OtaCampaign.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OtaCampaign.t),
      orderByList: orderByList?.call(OtaCampaign.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OtaCampaign]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OtaCampaign>> delete(
    _i1.DatabaseSession session,
    List<OtaCampaign> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OtaCampaign>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OtaCampaign].
  Future<OtaCampaign> deleteRow(
    _i1.DatabaseSession session,
    OtaCampaign row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OtaCampaign>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OtaCampaign>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OtaCampaignTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OtaCampaign>(
      where: where(OtaCampaign.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OtaCampaignTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OtaCampaign>(
      where: where?.call(OtaCampaign.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OtaCampaign] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OtaCampaignTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OtaCampaign>(
      where: where(OtaCampaign.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
