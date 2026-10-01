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

/// 將單一設備分享給公司成員，讀寫權限分離。
abstract class DeviceShare
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DeviceShare._({
    this.id,
    required this.companyId,
    required this.deviceId,
    required this.membershipId,
    bool? canRead,
    bool? canWrite,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  }) : canRead = canRead ?? true,
       canWrite = canWrite ?? false;

  factory DeviceShare({
    int? id,
    required int companyId,
    required int deviceId,
    required int membershipId,
    bool? canRead,
    bool? canWrite,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DeviceShareImpl;

  factory DeviceShare.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceShare(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      membershipId: jsonSerialization['membershipId'] as int,
      canRead: jsonSerialization['canRead'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['canRead']),
      canWrite: jsonSerialization['canWrite'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['canWrite']),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = DeviceShareTable();

  static const db = DeviceShareRepository._();

  @override
  int? id;

  int companyId;

  int deviceId;

  int membershipId;

  bool canRead;

  bool canWrite;

  String createdBy;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DeviceShare]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceShare copyWith({
    int? id,
    int? companyId,
    int? deviceId,
    int? membershipId,
    bool? canRead,
    bool? canWrite,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceShare',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'membershipId': membershipId,
      'canRead': canRead,
      'canWrite': canWrite,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceShare',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'membershipId': membershipId,
      'canRead': canRead,
      'canWrite': canWrite,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DeviceShareInclude include() {
    return DeviceShareInclude._();
  }

  static DeviceShareIncludeList includeList({
    _i1.WhereExpressionBuilder<DeviceShareTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceShareTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceShareTable>? orderByList,
    DeviceShareInclude? include,
  }) {
    return DeviceShareIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceShare.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DeviceShare.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceShareImpl extends DeviceShare {
  _DeviceShareImpl({
    int? id,
    required int companyId,
    required int deviceId,
    required int membershipId,
    bool? canRead,
    bool? canWrite,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         deviceId: deviceId,
         membershipId: membershipId,
         canRead: canRead,
         canWrite: canWrite,
         createdBy: createdBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DeviceShare]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceShare copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? deviceId,
    int? membershipId,
    bool? canRead,
    bool? canWrite,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DeviceShare(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      deviceId: deviceId ?? this.deviceId,
      membershipId: membershipId ?? this.membershipId,
      canRead: canRead ?? this.canRead,
      canWrite: canWrite ?? this.canWrite,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DeviceShareUpdateTable extends _i1.UpdateTable<DeviceShareTable> {
  DeviceShareUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> deviceId(int value) => _i1.ColumnValue(
    table.deviceId,
    value,
  );

  _i1.ColumnValue<int, int> membershipId(int value) => _i1.ColumnValue(
    table.membershipId,
    value,
  );

  _i1.ColumnValue<bool, bool> canRead(bool value) => _i1.ColumnValue(
    table.canRead,
    value,
  );

  _i1.ColumnValue<bool, bool> canWrite(bool value) => _i1.ColumnValue(
    table.canWrite,
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

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class DeviceShareTable extends _i1.Table<int?> {
  DeviceShareTable({super.tableRelation}) : super(tableName: 'device_share') {
    updateTable = DeviceShareUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    deviceId = _i1.ColumnInt(
      'deviceId',
      this,
    );
    membershipId = _i1.ColumnInt(
      'membershipId',
      this,
    );
    canRead = _i1.ColumnBool(
      'canRead',
      this,
      hasDefault: true,
    );
    canWrite = _i1.ColumnBool(
      'canWrite',
      this,
      hasDefault: true,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
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

  late final DeviceShareUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt deviceId;

  late final _i1.ColumnInt membershipId;

  late final _i1.ColumnBool canRead;

  late final _i1.ColumnBool canWrite;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    deviceId,
    membershipId,
    canRead,
    canWrite,
    createdBy,
    createdAt,
    updatedAt,
  ];
}

class DeviceShareInclude extends _i1.IncludeObject {
  DeviceShareInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DeviceShare.t;
}

class DeviceShareIncludeList extends _i1.IncludeList {
  DeviceShareIncludeList._({
    _i1.WhereExpressionBuilder<DeviceShareTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DeviceShare.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DeviceShare.t;
}

class DeviceShareRepository {
  const DeviceShareRepository._();

  /// Returns a list of [DeviceShare]s matching the given query parameters.
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
  Future<List<DeviceShare>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceShareTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceShareTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceShareTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DeviceShare>(
      where: where?.call(DeviceShare.t),
      orderBy: orderBy?.call(DeviceShare.t),
      orderByList: orderByList?.call(DeviceShare.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DeviceShare] matching the given query parameters.
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
  Future<DeviceShare?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceShareTable>? where,
    int? offset,
    _i1.OrderByBuilder<DeviceShareTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceShareTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DeviceShare>(
      where: where?.call(DeviceShare.t),
      orderBy: orderBy?.call(DeviceShare.t),
      orderByList: orderByList?.call(DeviceShare.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DeviceShare] by its [id] or null if no such row exists.
  Future<DeviceShare?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DeviceShare>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DeviceShare]s in the list and returns the inserted rows.
  ///
  /// The returned [DeviceShare]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DeviceShare>> insert(
    _i1.DatabaseSession session,
    List<DeviceShare> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DeviceShare>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DeviceShare] and returns the inserted row.
  ///
  /// The returned [DeviceShare] will have its `id` field set.
  Future<DeviceShare> insertRow(
    _i1.DatabaseSession session,
    DeviceShare row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DeviceShare>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DeviceShare]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DeviceShare>> update(
    _i1.DatabaseSession session,
    List<DeviceShare> rows, {
    _i1.ColumnSelections<DeviceShareTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DeviceShare>(
      rows,
      columns: columns?.call(DeviceShare.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceShare]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DeviceShare> updateRow(
    _i1.DatabaseSession session,
    DeviceShare row, {
    _i1.ColumnSelections<DeviceShareTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DeviceShare>(
      row,
      columns: columns?.call(DeviceShare.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceShare] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DeviceShare?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DeviceShareUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DeviceShare>(
      id,
      columnValues: columnValues(DeviceShare.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DeviceShare]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DeviceShare>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DeviceShareUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DeviceShareTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceShareTable>? orderBy,
    _i1.OrderByListBuilder<DeviceShareTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DeviceShare>(
      columnValues: columnValues(DeviceShare.t.updateTable),
      where: where(DeviceShare.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceShare.t),
      orderByList: orderByList?.call(DeviceShare.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DeviceShare]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DeviceShare>> delete(
    _i1.DatabaseSession session,
    List<DeviceShare> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DeviceShare>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DeviceShare].
  Future<DeviceShare> deleteRow(
    _i1.DatabaseSession session,
    DeviceShare row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DeviceShare>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DeviceShare>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceShareTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DeviceShare>(
      where: where(DeviceShare.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceShareTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DeviceShare>(
      where: where?.call(DeviceShare.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DeviceShare] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceShareTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DeviceShare>(
      where: where(DeviceShare.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
