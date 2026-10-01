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

/// 告警規則：針對設備單一 featureKey 的閾值判斷。
abstract class AlertRule
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AlertRule._({
    this.id,
    required this.companyId,
    required this.deviceId,
    required this.featureKey,
    required this.name,
    required this.comparison,
    required this.threshold,
    required this.severity,
    bool? mobileNotificationEnabled,
    required this.enabled,
    required this.createdAt,
  }) : mobileNotificationEnabled = mobileNotificationEnabled ?? false;

  factory AlertRule({
    int? id,
    required int companyId,
    required int deviceId,
    required String featureKey,
    required String name,
    required _i2.AlertComparison comparison,
    required double threshold,
    required _i3.AlertSeverity severity,
    bool? mobileNotificationEnabled,
    required bool enabled,
    required DateTime createdAt,
  }) = _AlertRuleImpl;

  factory AlertRule.fromJson(Map<String, dynamic> jsonSerialization) {
    return AlertRule(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      featureKey: jsonSerialization['featureKey'] as String,
      name: jsonSerialization['name'] as String,
      comparison: _i2.AlertComparison.fromJson(
        (jsonSerialization['comparison'] as String),
      ),
      threshold: (jsonSerialization['threshold'] as num).toDouble(),
      severity: _i3.AlertSeverity.fromJson(
        (jsonSerialization['severity'] as String),
      ),
      mobileNotificationEnabled:
          jsonSerialization['mobileNotificationEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['mobileNotificationEnabled'],
            ),
      enabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = AlertRuleTable();

  static const db = AlertRuleRepository._();

  @override
  int? id;

  int companyId;

  int deviceId;

  String featureKey;

  String name;

  _i2.AlertComparison comparison;

  double threshold;

  /// 觸發時產生的告警等級。
  _i3.AlertSeverity severity;

  /// 規則觸發時是否要求行動 App 顯示通知。
  bool mobileNotificationEnabled;

  bool enabled;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AlertRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AlertRule copyWith({
    int? id,
    int? companyId,
    int? deviceId,
    String? featureKey,
    String? name,
    _i2.AlertComparison? comparison,
    double? threshold,
    _i3.AlertSeverity? severity,
    bool? mobileNotificationEnabled,
    bool? enabled,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AlertRule',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'featureKey': featureKey,
      'name': name,
      'comparison': comparison.toJson(),
      'threshold': threshold,
      'severity': severity.toJson(),
      'mobileNotificationEnabled': mobileNotificationEnabled,
      'enabled': enabled,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AlertRule',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'featureKey': featureKey,
      'name': name,
      'comparison': comparison.toJson(),
      'threshold': threshold,
      'severity': severity.toJson(),
      'mobileNotificationEnabled': mobileNotificationEnabled,
      'enabled': enabled,
      'createdAt': createdAt.toJson(),
    };
  }

  static AlertRuleInclude include() {
    return AlertRuleInclude._();
  }

  static AlertRuleIncludeList includeList({
    _i1.WhereExpressionBuilder<AlertRuleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AlertRuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AlertRuleTable>? orderByList,
    AlertRuleInclude? include,
  }) {
    return AlertRuleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AlertRule.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AlertRule.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AlertRuleImpl extends AlertRule {
  _AlertRuleImpl({
    int? id,
    required int companyId,
    required int deviceId,
    required String featureKey,
    required String name,
    required _i2.AlertComparison comparison,
    required double threshold,
    required _i3.AlertSeverity severity,
    bool? mobileNotificationEnabled,
    required bool enabled,
    required DateTime createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         deviceId: deviceId,
         featureKey: featureKey,
         name: name,
         comparison: comparison,
         threshold: threshold,
         severity: severity,
         mobileNotificationEnabled: mobileNotificationEnabled,
         enabled: enabled,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AlertRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AlertRule copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? deviceId,
    String? featureKey,
    String? name,
    _i2.AlertComparison? comparison,
    double? threshold,
    _i3.AlertSeverity? severity,
    bool? mobileNotificationEnabled,
    bool? enabled,
    DateTime? createdAt,
  }) {
    return AlertRule(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      deviceId: deviceId ?? this.deviceId,
      featureKey: featureKey ?? this.featureKey,
      name: name ?? this.name,
      comparison: comparison ?? this.comparison,
      threshold: threshold ?? this.threshold,
      severity: severity ?? this.severity,
      mobileNotificationEnabled:
          mobileNotificationEnabled ?? this.mobileNotificationEnabled,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AlertRuleUpdateTable extends _i1.UpdateTable<AlertRuleTable> {
  AlertRuleUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> deviceId(int value) => _i1.ColumnValue(
    table.deviceId,
    value,
  );

  _i1.ColumnValue<String, String> featureKey(String value) => _i1.ColumnValue(
    table.featureKey,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<_i2.AlertComparison, _i2.AlertComparison> comparison(
    _i2.AlertComparison value,
  ) => _i1.ColumnValue(
    table.comparison,
    value,
  );

  _i1.ColumnValue<double, double> threshold(double value) => _i1.ColumnValue(
    table.threshold,
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

  _i1.ColumnValue<bool, bool> enabled(bool value) => _i1.ColumnValue(
    table.enabled,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class AlertRuleTable extends _i1.Table<int?> {
  AlertRuleTable({super.tableRelation}) : super(tableName: 'alert_rule') {
    updateTable = AlertRuleUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    deviceId = _i1.ColumnInt(
      'deviceId',
      this,
    );
    featureKey = _i1.ColumnString(
      'featureKey',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    comparison = _i1.ColumnEnum(
      'comparison',
      this,
      _i1.EnumSerialization.byName,
    );
    threshold = _i1.ColumnDouble(
      'threshold',
      this,
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
    enabled = _i1.ColumnBool(
      'enabled',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final AlertRuleUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt deviceId;

  late final _i1.ColumnString featureKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnEnum<_i2.AlertComparison> comparison;

  late final _i1.ColumnDouble threshold;

  /// 觸發時產生的告警等級。
  late final _i1.ColumnEnum<_i3.AlertSeverity> severity;

  /// 規則觸發時是否要求行動 App 顯示通知。
  late final _i1.ColumnBool mobileNotificationEnabled;

  late final _i1.ColumnBool enabled;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    deviceId,
    featureKey,
    name,
    comparison,
    threshold,
    severity,
    mobileNotificationEnabled,
    enabled,
    createdAt,
  ];
}

class AlertRuleInclude extends _i1.IncludeObject {
  AlertRuleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AlertRule.t;
}

class AlertRuleIncludeList extends _i1.IncludeList {
  AlertRuleIncludeList._({
    _i1.WhereExpressionBuilder<AlertRuleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AlertRule.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AlertRule.t;
}

class AlertRuleRepository {
  const AlertRuleRepository._();

  /// Returns a list of [AlertRule]s matching the given query parameters.
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
  Future<List<AlertRule>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AlertRuleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AlertRuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AlertRuleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AlertRule>(
      where: where?.call(AlertRule.t),
      orderBy: orderBy?.call(AlertRule.t),
      orderByList: orderByList?.call(AlertRule.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AlertRule] matching the given query parameters.
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
  Future<AlertRule?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AlertRuleTable>? where,
    int? offset,
    _i1.OrderByBuilder<AlertRuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AlertRuleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AlertRule>(
      where: where?.call(AlertRule.t),
      orderBy: orderBy?.call(AlertRule.t),
      orderByList: orderByList?.call(AlertRule.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AlertRule] by its [id] or null if no such row exists.
  Future<AlertRule?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AlertRule>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AlertRule]s in the list and returns the inserted rows.
  ///
  /// The returned [AlertRule]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AlertRule>> insert(
    _i1.DatabaseSession session,
    List<AlertRule> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AlertRule>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AlertRule] and returns the inserted row.
  ///
  /// The returned [AlertRule] will have its `id` field set.
  Future<AlertRule> insertRow(
    _i1.DatabaseSession session,
    AlertRule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AlertRule>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AlertRule]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AlertRule>> update(
    _i1.DatabaseSession session,
    List<AlertRule> rows, {
    _i1.ColumnSelections<AlertRuleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AlertRule>(
      rows,
      columns: columns?.call(AlertRule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AlertRule]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AlertRule> updateRow(
    _i1.DatabaseSession session,
    AlertRule row, {
    _i1.ColumnSelections<AlertRuleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AlertRule>(
      row,
      columns: columns?.call(AlertRule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AlertRule] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AlertRule?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AlertRuleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AlertRule>(
      id,
      columnValues: columnValues(AlertRule.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AlertRule]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AlertRule>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AlertRuleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AlertRuleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AlertRuleTable>? orderBy,
    _i1.OrderByListBuilder<AlertRuleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AlertRule>(
      columnValues: columnValues(AlertRule.t.updateTable),
      where: where(AlertRule.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AlertRule.t),
      orderByList: orderByList?.call(AlertRule.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AlertRule]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AlertRule>> delete(
    _i1.DatabaseSession session,
    List<AlertRule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AlertRule>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AlertRule].
  Future<AlertRule> deleteRow(
    _i1.DatabaseSession session,
    AlertRule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AlertRule>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AlertRule>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AlertRuleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AlertRule>(
      where: where(AlertRule.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AlertRuleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AlertRule>(
      where: where?.call(AlertRule.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AlertRule] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AlertRuleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AlertRule>(
      where: where(AlertRule.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
