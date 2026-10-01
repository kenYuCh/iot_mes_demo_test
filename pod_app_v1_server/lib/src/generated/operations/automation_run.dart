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

abstract class AutomationRun
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AutomationRun._({
    this.id,
    required this.companyId,
    required this.ruleId,
    required this.state,
    required this.triggerValue,
    required this.repeatCount,
    required this.currentStep,
    this.message,
    required this.startedAt,
    this.finishedAt,
  });

  factory AutomationRun({
    int? id,
    required int companyId,
    required int ruleId,
    required String state,
    required double triggerValue,
    required int repeatCount,
    required String currentStep,
    String? message,
    required DateTime startedAt,
    DateTime? finishedAt,
  }) = _AutomationRunImpl;

  factory AutomationRun.fromJson(Map<String, dynamic> jsonSerialization) {
    return AutomationRun(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      ruleId: jsonSerialization['ruleId'] as int,
      state: jsonSerialization['state'] as String,
      triggerValue: (jsonSerialization['triggerValue'] as num).toDouble(),
      repeatCount: jsonSerialization['repeatCount'] as int,
      currentStep: jsonSerialization['currentStep'] as String,
      message: jsonSerialization['message'] as String?,
      startedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      finishedAt: jsonSerialization['finishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['finishedAt']),
    );
  }

  static final t = AutomationRunTable();

  static const db = AutomationRunRepository._();

  @override
  int? id;

  int companyId;

  int ruleId;

  String state;

  double triggerValue;

  int repeatCount;

  String currentStep;

  String? message;

  DateTime startedAt;

  DateTime? finishedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AutomationRun]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AutomationRun copyWith({
    int? id,
    int? companyId,
    int? ruleId,
    String? state,
    double? triggerValue,
    int? repeatCount,
    String? currentStep,
    String? message,
    DateTime? startedAt,
    DateTime? finishedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AutomationRun',
      if (id != null) 'id': id,
      'companyId': companyId,
      'ruleId': ruleId,
      'state': state,
      'triggerValue': triggerValue,
      'repeatCount': repeatCount,
      'currentStep': currentStep,
      if (message != null) 'message': message,
      'startedAt': startedAt.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AutomationRun',
      if (id != null) 'id': id,
      'companyId': companyId,
      'ruleId': ruleId,
      'state': state,
      'triggerValue': triggerValue,
      'repeatCount': repeatCount,
      'currentStep': currentStep,
      if (message != null) 'message': message,
      'startedAt': startedAt.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
    };
  }

  static AutomationRunInclude include() {
    return AutomationRunInclude._();
  }

  static AutomationRunIncludeList includeList({
    _i1.WhereExpressionBuilder<AutomationRunTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AutomationRunTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AutomationRunTable>? orderByList,
    AutomationRunInclude? include,
  }) {
    return AutomationRunIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AutomationRun.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AutomationRun.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AutomationRunImpl extends AutomationRun {
  _AutomationRunImpl({
    int? id,
    required int companyId,
    required int ruleId,
    required String state,
    required double triggerValue,
    required int repeatCount,
    required String currentStep,
    String? message,
    required DateTime startedAt,
    DateTime? finishedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         ruleId: ruleId,
         state: state,
         triggerValue: triggerValue,
         repeatCount: repeatCount,
         currentStep: currentStep,
         message: message,
         startedAt: startedAt,
         finishedAt: finishedAt,
       );

  /// Returns a shallow copy of this [AutomationRun]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AutomationRun copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? ruleId,
    String? state,
    double? triggerValue,
    int? repeatCount,
    String? currentStep,
    Object? message = _Undefined,
    DateTime? startedAt,
    Object? finishedAt = _Undefined,
  }) {
    return AutomationRun(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      ruleId: ruleId ?? this.ruleId,
      state: state ?? this.state,
      triggerValue: triggerValue ?? this.triggerValue,
      repeatCount: repeatCount ?? this.repeatCount,
      currentStep: currentStep ?? this.currentStep,
      message: message is String? ? message : this.message,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt is DateTime? ? finishedAt : this.finishedAt,
    );
  }
}

class AutomationRunUpdateTable extends _i1.UpdateTable<AutomationRunTable> {
  AutomationRunUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> ruleId(int value) => _i1.ColumnValue(
    table.ruleId,
    value,
  );

  _i1.ColumnValue<String, String> state(String value) => _i1.ColumnValue(
    table.state,
    value,
  );

  _i1.ColumnValue<double, double> triggerValue(double value) => _i1.ColumnValue(
    table.triggerValue,
    value,
  );

  _i1.ColumnValue<int, int> repeatCount(int value) => _i1.ColumnValue(
    table.repeatCount,
    value,
  );

  _i1.ColumnValue<String, String> currentStep(String value) => _i1.ColumnValue(
    table.currentStep,
    value,
  );

  _i1.ColumnValue<String, String> message(String? value) => _i1.ColumnValue(
    table.message,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> finishedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.finishedAt,
        value,
      );
}

class AutomationRunTable extends _i1.Table<int?> {
  AutomationRunTable({super.tableRelation})
    : super(tableName: 'automation_run') {
    updateTable = AutomationRunUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    ruleId = _i1.ColumnInt(
      'ruleId',
      this,
    );
    state = _i1.ColumnString(
      'state',
      this,
    );
    triggerValue = _i1.ColumnDouble(
      'triggerValue',
      this,
    );
    repeatCount = _i1.ColumnInt(
      'repeatCount',
      this,
    );
    currentStep = _i1.ColumnString(
      'currentStep',
      this,
    );
    message = _i1.ColumnString(
      'message',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    finishedAt = _i1.ColumnDateTime(
      'finishedAt',
      this,
    );
  }

  late final AutomationRunUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt ruleId;

  late final _i1.ColumnString state;

  late final _i1.ColumnDouble triggerValue;

  late final _i1.ColumnInt repeatCount;

  late final _i1.ColumnString currentStep;

  late final _i1.ColumnString message;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime finishedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    ruleId,
    state,
    triggerValue,
    repeatCount,
    currentStep,
    message,
    startedAt,
    finishedAt,
  ];
}

class AutomationRunInclude extends _i1.IncludeObject {
  AutomationRunInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AutomationRun.t;
}

class AutomationRunIncludeList extends _i1.IncludeList {
  AutomationRunIncludeList._({
    _i1.WhereExpressionBuilder<AutomationRunTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AutomationRun.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AutomationRun.t;
}

class AutomationRunRepository {
  const AutomationRunRepository._();

  /// Returns a list of [AutomationRun]s matching the given query parameters.
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
  Future<List<AutomationRun>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AutomationRunTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AutomationRunTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AutomationRunTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AutomationRun>(
      where: where?.call(AutomationRun.t),
      orderBy: orderBy?.call(AutomationRun.t),
      orderByList: orderByList?.call(AutomationRun.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AutomationRun] matching the given query parameters.
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
  Future<AutomationRun?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AutomationRunTable>? where,
    int? offset,
    _i1.OrderByBuilder<AutomationRunTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AutomationRunTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AutomationRun>(
      where: where?.call(AutomationRun.t),
      orderBy: orderBy?.call(AutomationRun.t),
      orderByList: orderByList?.call(AutomationRun.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AutomationRun] by its [id] or null if no such row exists.
  Future<AutomationRun?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AutomationRun>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AutomationRun]s in the list and returns the inserted rows.
  ///
  /// The returned [AutomationRun]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AutomationRun>> insert(
    _i1.DatabaseSession session,
    List<AutomationRun> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AutomationRun>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AutomationRun] and returns the inserted row.
  ///
  /// The returned [AutomationRun] will have its `id` field set.
  Future<AutomationRun> insertRow(
    _i1.DatabaseSession session,
    AutomationRun row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AutomationRun>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AutomationRun]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AutomationRun>> update(
    _i1.DatabaseSession session,
    List<AutomationRun> rows, {
    _i1.ColumnSelections<AutomationRunTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AutomationRun>(
      rows,
      columns: columns?.call(AutomationRun.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AutomationRun]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AutomationRun> updateRow(
    _i1.DatabaseSession session,
    AutomationRun row, {
    _i1.ColumnSelections<AutomationRunTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AutomationRun>(
      row,
      columns: columns?.call(AutomationRun.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AutomationRun] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AutomationRun?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AutomationRunUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AutomationRun>(
      id,
      columnValues: columnValues(AutomationRun.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AutomationRun]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AutomationRun>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AutomationRunUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AutomationRunTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AutomationRunTable>? orderBy,
    _i1.OrderByListBuilder<AutomationRunTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AutomationRun>(
      columnValues: columnValues(AutomationRun.t.updateTable),
      where: where(AutomationRun.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AutomationRun.t),
      orderByList: orderByList?.call(AutomationRun.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AutomationRun]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AutomationRun>> delete(
    _i1.DatabaseSession session,
    List<AutomationRun> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AutomationRun>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AutomationRun].
  Future<AutomationRun> deleteRow(
    _i1.DatabaseSession session,
    AutomationRun row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AutomationRun>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AutomationRun>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AutomationRunTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AutomationRun>(
      where: where(AutomationRun.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AutomationRunTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AutomationRun>(
      where: where?.call(AutomationRun.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AutomationRun] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AutomationRunTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AutomationRun>(
      where: where(AutomationRun.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
