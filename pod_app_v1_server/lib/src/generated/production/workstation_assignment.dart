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

abstract class WorkstationAssignment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WorkstationAssignment._({
    this.id,
    required this.companyId,
    required this.workstationId,
    required this.membershipId,
    bool? active,
    required this.assignedBy,
    required this.createdAt,
    required this.updatedAt,
  }) : active = active ?? true;

  factory WorkstationAssignment({
    int? id,
    required int companyId,
    required int workstationId,
    required int membershipId,
    bool? active,
    required String assignedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WorkstationAssignmentImpl;

  factory WorkstationAssignment.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return WorkstationAssignment(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      workstationId: jsonSerialization['workstationId'] as int,
      membershipId: jsonSerialization['membershipId'] as int,
      active: jsonSerialization['active'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['active']),
      assignedBy: jsonSerialization['assignedBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = WorkstationAssignmentTable();

  static const db = WorkstationAssignmentRepository._();

  @override
  int? id;

  int companyId;

  int workstationId;

  int membershipId;

  bool active;

  String assignedBy;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WorkstationAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkstationAssignment copyWith({
    int? id,
    int? companyId,
    int? workstationId,
    int? membershipId,
    bool? active,
    String? assignedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkstationAssignment',
      if (id != null) 'id': id,
      'companyId': companyId,
      'workstationId': workstationId,
      'membershipId': membershipId,
      'active': active,
      'assignedBy': assignedBy,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkstationAssignment',
      if (id != null) 'id': id,
      'companyId': companyId,
      'workstationId': workstationId,
      'membershipId': membershipId,
      'active': active,
      'assignedBy': assignedBy,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static WorkstationAssignmentInclude include() {
    return WorkstationAssignmentInclude._();
  }

  static WorkstationAssignmentIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkstationAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkstationAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkstationAssignmentTable>? orderByList,
    WorkstationAssignmentInclude? include,
  }) {
    return WorkstationAssignmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkstationAssignment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WorkstationAssignment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkstationAssignmentImpl extends WorkstationAssignment {
  _WorkstationAssignmentImpl({
    int? id,
    required int companyId,
    required int workstationId,
    required int membershipId,
    bool? active,
    required String assignedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         workstationId: workstationId,
         membershipId: membershipId,
         active: active,
         assignedBy: assignedBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WorkstationAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkstationAssignment copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? workstationId,
    int? membershipId,
    bool? active,
    String? assignedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkstationAssignment(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      workstationId: workstationId ?? this.workstationId,
      membershipId: membershipId ?? this.membershipId,
      active: active ?? this.active,
      assignedBy: assignedBy ?? this.assignedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WorkstationAssignmentUpdateTable
    extends _i1.UpdateTable<WorkstationAssignmentTable> {
  WorkstationAssignmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> workstationId(int value) => _i1.ColumnValue(
    table.workstationId,
    value,
  );

  _i1.ColumnValue<int, int> membershipId(int value) => _i1.ColumnValue(
    table.membershipId,
    value,
  );

  _i1.ColumnValue<bool, bool> active(bool value) => _i1.ColumnValue(
    table.active,
    value,
  );

  _i1.ColumnValue<String, String> assignedBy(String value) => _i1.ColumnValue(
    table.assignedBy,
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

class WorkstationAssignmentTable extends _i1.Table<int?> {
  WorkstationAssignmentTable({super.tableRelation})
    : super(tableName: 'workstation_assignment') {
    updateTable = WorkstationAssignmentUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    workstationId = _i1.ColumnInt(
      'workstationId',
      this,
    );
    membershipId = _i1.ColumnInt(
      'membershipId',
      this,
    );
    active = _i1.ColumnBool(
      'active',
      this,
      hasDefault: true,
    );
    assignedBy = _i1.ColumnString(
      'assignedBy',
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

  late final WorkstationAssignmentUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt workstationId;

  late final _i1.ColumnInt membershipId;

  late final _i1.ColumnBool active;

  late final _i1.ColumnString assignedBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    workstationId,
    membershipId,
    active,
    assignedBy,
    createdAt,
    updatedAt,
  ];
}

class WorkstationAssignmentInclude extends _i1.IncludeObject {
  WorkstationAssignmentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WorkstationAssignment.t;
}

class WorkstationAssignmentIncludeList extends _i1.IncludeList {
  WorkstationAssignmentIncludeList._({
    _i1.WhereExpressionBuilder<WorkstationAssignmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WorkstationAssignment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WorkstationAssignment.t;
}

class WorkstationAssignmentRepository {
  const WorkstationAssignmentRepository._();

  /// Returns a list of [WorkstationAssignment]s matching the given query parameters.
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
  Future<List<WorkstationAssignment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkstationAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkstationAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkstationAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WorkstationAssignment>(
      where: where?.call(WorkstationAssignment.t),
      orderBy: orderBy?.call(WorkstationAssignment.t),
      orderByList: orderByList?.call(WorkstationAssignment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WorkstationAssignment] matching the given query parameters.
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
  Future<WorkstationAssignment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkstationAssignmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkstationAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkstationAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WorkstationAssignment>(
      where: where?.call(WorkstationAssignment.t),
      orderBy: orderBy?.call(WorkstationAssignment.t),
      orderByList: orderByList?.call(WorkstationAssignment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WorkstationAssignment] by its [id] or null if no such row exists.
  Future<WorkstationAssignment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WorkstationAssignment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WorkstationAssignment]s in the list and returns the inserted rows.
  ///
  /// The returned [WorkstationAssignment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WorkstationAssignment>> insert(
    _i1.DatabaseSession session,
    List<WorkstationAssignment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WorkstationAssignment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WorkstationAssignment] and returns the inserted row.
  ///
  /// The returned [WorkstationAssignment] will have its `id` field set.
  Future<WorkstationAssignment> insertRow(
    _i1.DatabaseSession session,
    WorkstationAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WorkstationAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WorkstationAssignment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WorkstationAssignment>> update(
    _i1.DatabaseSession session,
    List<WorkstationAssignment> rows, {
    _i1.ColumnSelections<WorkstationAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WorkstationAssignment>(
      rows,
      columns: columns?.call(WorkstationAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkstationAssignment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WorkstationAssignment> updateRow(
    _i1.DatabaseSession session,
    WorkstationAssignment row, {
    _i1.ColumnSelections<WorkstationAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WorkstationAssignment>(
      row,
      columns: columns?.call(WorkstationAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WorkstationAssignment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WorkstationAssignment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WorkstationAssignmentUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WorkstationAssignment>(
      id,
      columnValues: columnValues(WorkstationAssignment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WorkstationAssignment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WorkstationAssignment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WorkstationAssignmentUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<WorkstationAssignmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkstationAssignmentTable>? orderBy,
    _i1.OrderByListBuilder<WorkstationAssignmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WorkstationAssignment>(
      columnValues: columnValues(WorkstationAssignment.t.updateTable),
      where: where(WorkstationAssignment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WorkstationAssignment.t),
      orderByList: orderByList?.call(WorkstationAssignment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WorkstationAssignment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WorkstationAssignment>> delete(
    _i1.DatabaseSession session,
    List<WorkstationAssignment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WorkstationAssignment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WorkstationAssignment].
  Future<WorkstationAssignment> deleteRow(
    _i1.DatabaseSession session,
    WorkstationAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WorkstationAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WorkstationAssignment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkstationAssignmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WorkstationAssignment>(
      where: where(WorkstationAssignment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WorkstationAssignmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WorkstationAssignment>(
      where: where?.call(WorkstationAssignment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WorkstationAssignment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WorkstationAssignmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WorkstationAssignment>(
      where: where(WorkstationAssignment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
