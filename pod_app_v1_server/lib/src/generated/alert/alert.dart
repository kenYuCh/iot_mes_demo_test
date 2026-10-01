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
import '../alert/alert_comparison.dart' as _i2;
import '../alert/alert_severity.dart' as _i3;
import '../alert/alert_state.dart' as _i4;

/// 告警事件：規則被觸發後產生，恢復正常時自動 resolved。
abstract class Alert implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Alert._({
    this.id,
    required this.companyId,
    required this.siteId,
    required this.deviceId,
    required this.ruleId,
    required this.featureKey,
    required this.triggeredValue,
    required this.threshold,
    required this.comparison,
    required this.severity,
    bool? mobileNotificationEnabled,
    required this.state,
    required this.message,
    required this.triggeredAt,
    this.acknowledgedAt,
    this.resolvedAt,
  }) : mobileNotificationEnabled = mobileNotificationEnabled ?? false;

  factory Alert({
    int? id,
    required int companyId,
    required int siteId,
    required int deviceId,
    required int ruleId,
    required String featureKey,
    required double triggeredValue,
    required double threshold,
    required _i2.AlertComparison comparison,
    required _i3.AlertSeverity severity,
    bool? mobileNotificationEnabled,
    required _i4.AlertState state,
    required String message,
    required DateTime triggeredAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  }) = _AlertImpl;

  factory Alert.fromJson(Map<String, dynamic> jsonSerialization) {
    return Alert(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      siteId: jsonSerialization['siteId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      ruleId: jsonSerialization['ruleId'] as int,
      featureKey: jsonSerialization['featureKey'] as String,
      triggeredValue: (jsonSerialization['triggeredValue'] as num).toDouble(),
      threshold: (jsonSerialization['threshold'] as num).toDouble(),
      comparison: _i2.AlertComparison.fromJson(
        (jsonSerialization['comparison'] as String),
      ),
      severity: _i3.AlertSeverity.fromJson(
        (jsonSerialization['severity'] as String),
      ),
      mobileNotificationEnabled:
          jsonSerialization['mobileNotificationEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['mobileNotificationEnabled'],
            ),
      state: _i4.AlertState.fromJson((jsonSerialization['state'] as String)),
      message: jsonSerialization['message'] as String,
      triggeredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['triggeredAt'],
      ),
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt'],
            ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = AlertTable();

  static const db = AlertRepository._();

  @override
  int? id;

  int companyId;

  int siteId;

  int deviceId;

  int ruleId;

  String featureKey;

  /// 觸發當下的量測值。
  double triggeredValue;

  double threshold;

  _i2.AlertComparison comparison;

  _i3.AlertSeverity severity;

  /// 觸發當下規則的手機通知決策；保存在事件上供即時客戶端判斷。
  bool mobileNotificationEnabled;

  _i4.AlertState state;

  String message;

  DateTime triggeredAt;

  DateTime? acknowledgedAt;

  DateTime? resolvedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Alert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Alert copyWith({
    int? id,
    int? companyId,
    int? siteId,
    int? deviceId,
    int? ruleId,
    String? featureKey,
    double? triggeredValue,
    double? threshold,
    _i2.AlertComparison? comparison,
    _i3.AlertSeverity? severity,
    bool? mobileNotificationEnabled,
    _i4.AlertState? state,
    String? message,
    DateTime? triggeredAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Alert',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      'deviceId': deviceId,
      'ruleId': ruleId,
      'featureKey': featureKey,
      'triggeredValue': triggeredValue,
      'threshold': threshold,
      'comparison': comparison.toJson(),
      'severity': severity.toJson(),
      'mobileNotificationEnabled': mobileNotificationEnabled,
      'state': state.toJson(),
      'message': message,
      'triggeredAt': triggeredAt.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Alert',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      'deviceId': deviceId,
      'ruleId': ruleId,
      'featureKey': featureKey,
      'triggeredValue': triggeredValue,
      'threshold': threshold,
      'comparison': comparison.toJson(),
      'severity': severity.toJson(),
      'mobileNotificationEnabled': mobileNotificationEnabled,
      'state': state.toJson(),
      'message': message,
      'triggeredAt': triggeredAt.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  static AlertInclude include() {
    return AlertInclude._();
  }

  static AlertIncludeList includeList({
    _i1.WhereExpressionBuilder<AlertTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AlertTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AlertTable>? orderByList,
    AlertInclude? include,
  }) {
    return AlertIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Alert.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Alert.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AlertImpl extends Alert {
  _AlertImpl({
    int? id,
    required int companyId,
    required int siteId,
    required int deviceId,
    required int ruleId,
    required String featureKey,
    required double triggeredValue,
    required double threshold,
    required _i2.AlertComparison comparison,
    required _i3.AlertSeverity severity,
    bool? mobileNotificationEnabled,
    required _i4.AlertState state,
    required String message,
    required DateTime triggeredAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         siteId: siteId,
         deviceId: deviceId,
         ruleId: ruleId,
         featureKey: featureKey,
         triggeredValue: triggeredValue,
         threshold: threshold,
         comparison: comparison,
         severity: severity,
         mobileNotificationEnabled: mobileNotificationEnabled,
         state: state,
         message: message,
         triggeredAt: triggeredAt,
         acknowledgedAt: acknowledgedAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [Alert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Alert copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? siteId,
    int? deviceId,
    int? ruleId,
    String? featureKey,
    double? triggeredValue,
    double? threshold,
    _i2.AlertComparison? comparison,
    _i3.AlertSeverity? severity,
    bool? mobileNotificationEnabled,
    _i4.AlertState? state,
    String? message,
    DateTime? triggeredAt,
    Object? acknowledgedAt = _Undefined,
    Object? resolvedAt = _Undefined,
  }) {
    return Alert(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      siteId: siteId ?? this.siteId,
      deviceId: deviceId ?? this.deviceId,
      ruleId: ruleId ?? this.ruleId,
      featureKey: featureKey ?? this.featureKey,
      triggeredValue: triggeredValue ?? this.triggeredValue,
      threshold: threshold ?? this.threshold,
      comparison: comparison ?? this.comparison,
      severity: severity ?? this.severity,
      mobileNotificationEnabled:
          mobileNotificationEnabled ?? this.mobileNotificationEnabled,
      state: state ?? this.state,
      message: message ?? this.message,
      triggeredAt: triggeredAt ?? this.triggeredAt,
      acknowledgedAt: acknowledgedAt is DateTime?
          ? acknowledgedAt
          : this.acknowledgedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}

class AlertUpdateTable extends _i1.UpdateTable<AlertTable> {
  AlertUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> siteId(int value) => _i1.ColumnValue(
    table.siteId,
    value,
  );

  _i1.ColumnValue<int, int> deviceId(int value) => _i1.ColumnValue(
    table.deviceId,
    value,
  );

  _i1.ColumnValue<int, int> ruleId(int value) => _i1.ColumnValue(
    table.ruleId,
    value,
  );

  _i1.ColumnValue<String, String> featureKey(String value) => _i1.ColumnValue(
    table.featureKey,
    value,
  );

  _i1.ColumnValue<double, double> triggeredValue(double value) =>
      _i1.ColumnValue(
        table.triggeredValue,
        value,
      );

  _i1.ColumnValue<double, double> threshold(double value) => _i1.ColumnValue(
    table.threshold,
    value,
  );

  _i1.ColumnValue<_i2.AlertComparison, _i2.AlertComparison> comparison(
    _i2.AlertComparison value,
  ) => _i1.ColumnValue(
    table.comparison,
    value,
  );

  _i1.ColumnValue<_i3.AlertSeverity, _i3.AlertSeverity> severity(
    _i3.AlertSeverity value,
  ) => _i1.ColumnValue(
    table.severity,
    value,
  );

  _i1.ColumnValue<bool, bool> mobileNotificationEnabled(bool value) =>
      _i1.ColumnValue(
        table.mobileNotificationEnabled,
        value,
      );

  _i1.ColumnValue<_i4.AlertState, _i4.AlertState> state(_i4.AlertState value) =>
      _i1.ColumnValue(
        table.state,
        value,
      );

  _i1.ColumnValue<String, String> message(String value) => _i1.ColumnValue(
    table.message,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> triggeredAt(DateTime value) =>
      _i1.ColumnValue(
        table.triggeredAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> acknowledgedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.acknowledgedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.resolvedAt,
        value,
      );
}

class AlertTable extends _i1.Table<int?> {
  AlertTable({super.tableRelation}) : super(tableName: 'alert') {
    updateTable = AlertUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    siteId = _i1.ColumnInt(
      'siteId',
      this,
    );
    deviceId = _i1.ColumnInt(
      'deviceId',
      this,
    );
    ruleId = _i1.ColumnInt(
      'ruleId',
      this,
    );
    featureKey = _i1.ColumnString(
      'featureKey',
      this,
    );
    triggeredValue = _i1.ColumnDouble(
      'triggeredValue',
      this,
    );
    threshold = _i1.ColumnDouble(
      'threshold',
      this,
    );
    comparison = _i1.ColumnEnum(
      'comparison',
      this,
      _i1.EnumSerialization.byName,
    );
    severity = _i1.ColumnEnum(
      'severity',
      this,
      _i1.EnumSerialization.byName,
    );
    mobileNotificationEnabled = _i1.ColumnBool(
      'mobileNotificationEnabled',
      this,
      hasDefault: true,
    );
    state = _i1.ColumnEnum(
      'state',
      this,
      _i1.EnumSerialization.byName,
    );
    message = _i1.ColumnString(
      'message',
      this,
    );
    triggeredAt = _i1.ColumnDateTime(
      'triggeredAt',
      this,
    );
    acknowledgedAt = _i1.ColumnDateTime(
      'acknowledgedAt',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
  }

  late final AlertUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt siteId;

  late final _i1.ColumnInt deviceId;

  late final _i1.ColumnInt ruleId;

  late final _i1.ColumnString featureKey;

  /// 觸發當下的量測值。
  late final _i1.ColumnDouble triggeredValue;

  late final _i1.ColumnDouble threshold;

  late final _i1.ColumnEnum<_i2.AlertComparison> comparison;

  late final _i1.ColumnEnum<_i3.AlertSeverity> severity;

  /// 觸發當下規則的手機通知決策；保存在事件上供即時客戶端判斷。
  late final _i1.ColumnBool mobileNotificationEnabled;

  late final _i1.ColumnEnum<_i4.AlertState> state;

  late final _i1.ColumnString message;

  late final _i1.ColumnDateTime triggeredAt;

  late final _i1.ColumnDateTime acknowledgedAt;

  late final _i1.ColumnDateTime resolvedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    siteId,
    deviceId,
    ruleId,
    featureKey,
    triggeredValue,
    threshold,
    comparison,
    severity,
    mobileNotificationEnabled,
    state,
    message,
    triggeredAt,
    acknowledgedAt,
    resolvedAt,
  ];
}

class AlertInclude extends _i1.IncludeObject {
  AlertInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Alert.t;
}

class AlertIncludeList extends _i1.IncludeList {
  AlertIncludeList._({
    _i1.WhereExpressionBuilder<AlertTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Alert.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Alert.t;
}

class AlertRepository {
  const AlertRepository._();

  /// Returns a list of [Alert]s matching the given query parameters.
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
  Future<List<Alert>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AlertTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AlertTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AlertTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Alert>(
      where: where?.call(Alert.t),
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Alert] matching the given query parameters.
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
  Future<Alert?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AlertTable>? where,
    int? offset,
    _i1.OrderByBuilder<AlertTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AlertTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Alert>(
      where: where?.call(Alert.t),
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Alert] by its [id] or null if no such row exists.
  Future<Alert?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Alert>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Alert]s in the list and returns the inserted rows.
  ///
  /// The returned [Alert]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Alert>> insert(
    _i1.DatabaseSession session,
    List<Alert> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Alert>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Alert] and returns the inserted row.
  ///
  /// The returned [Alert] will have its `id` field set.
  Future<Alert> insertRow(
    _i1.DatabaseSession session,
    Alert row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Alert>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Alert]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Alert>> update(
    _i1.DatabaseSession session,
    List<Alert> rows, {
    _i1.ColumnSelections<AlertTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Alert>(
      rows,
      columns: columns?.call(Alert.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Alert]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Alert> updateRow(
    _i1.DatabaseSession session,
    Alert row, {
    _i1.ColumnSelections<AlertTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Alert>(
      row,
      columns: columns?.call(Alert.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Alert] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Alert?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AlertUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Alert>(
      id,
      columnValues: columnValues(Alert.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Alert]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Alert>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AlertUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AlertTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AlertTable>? orderBy,
    _i1.OrderByListBuilder<AlertTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Alert>(
      columnValues: columnValues(Alert.t.updateTable),
      where: where(Alert.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Alert]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Alert>> delete(
    _i1.DatabaseSession session,
    List<Alert> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Alert>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Alert].
  Future<Alert> deleteRow(
    _i1.DatabaseSession session,
    Alert row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Alert>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Alert>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AlertTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Alert>(
      where: where(Alert.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AlertTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Alert>(
      where: where?.call(Alert.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Alert] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AlertTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Alert>(
      where: where(Alert.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
