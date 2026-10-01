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
import '../operations/automation_branch.dart' as _i3;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i4;

abstract class AutomationRule
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AutomationRule._({
    this.id,
    required this.companyId,
    required this.name,
    required this.triggerDeviceId,
    required this.triggerFeatureKey,
    required this.comparison,
    required this.threshold,
    required this.recoveryThreshold,
    required this.actionDeviceId,
    required this.actionFeatureKey,
    required this.actionValue,
    required this.pulseOnSeconds,
    required this.intervalSeconds,
    required this.maxRepeats,
    required this.mixingDelaySeconds,
    this.branches,
    int? sensorTimeoutSeconds,
    int? cooldownSeconds,
    required this.enabled,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  }) : sensorTimeoutSeconds = sensorTimeoutSeconds ?? 60,
       cooldownSeconds = cooldownSeconds ?? 10;

  factory AutomationRule({
    int? id,
    required int companyId,
    required String name,
    required int triggerDeviceId,
    required String triggerFeatureKey,
    required _i2.AlertComparison comparison,
    required double threshold,
    required double recoveryThreshold,
    required int actionDeviceId,
    required String actionFeatureKey,
    required double actionValue,
    required int pulseOnSeconds,
    required int intervalSeconds,
    required int maxRepeats,
    required int mixingDelaySeconds,
    List<_i3.AutomationBranch>? branches,
    int? sensorTimeoutSeconds,
    int? cooldownSeconds,
    required bool enabled,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AutomationRuleImpl;

  factory AutomationRule.fromJson(Map<String, dynamic> jsonSerialization) {
    return AutomationRule(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      name: jsonSerialization['name'] as String,
      triggerDeviceId: jsonSerialization['triggerDeviceId'] as int,
      triggerFeatureKey: jsonSerialization['triggerFeatureKey'] as String,
      comparison: _i2.AlertComparison.fromJson(
        (jsonSerialization['comparison'] as String),
      ),
      threshold: (jsonSerialization['threshold'] as num).toDouble(),
      recoveryThreshold: (jsonSerialization['recoveryThreshold'] as num)
          .toDouble(),
      actionDeviceId: jsonSerialization['actionDeviceId'] as int,
      actionFeatureKey: jsonSerialization['actionFeatureKey'] as String,
      actionValue: (jsonSerialization['actionValue'] as num).toDouble(),
      pulseOnSeconds: jsonSerialization['pulseOnSeconds'] as int,
      intervalSeconds: jsonSerialization['intervalSeconds'] as int,
      maxRepeats: jsonSerialization['maxRepeats'] as int,
      mixingDelaySeconds: jsonSerialization['mixingDelaySeconds'] as int,
      branches: jsonSerialization['branches'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.AutomationBranch>>(
              jsonSerialization['branches'],
            ),
      sensorTimeoutSeconds: jsonSerialization['sensorTimeoutSeconds'] as int?,
      cooldownSeconds: jsonSerialization['cooldownSeconds'] as int?,
      enabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = AutomationRuleTable();

  static const db = AutomationRuleRepository._();

  @override
  int? id;

  int companyId;

  String name;

  int triggerDeviceId;

  String triggerFeatureKey;

  _i2.AlertComparison comparison;

  double threshold;

  double recoveryThreshold;

  int actionDeviceId;

  String actionFeatureKey;

  double actionValue;

  int pulseOnSeconds;

  int intervalSeconds;

  int maxRepeats;

  int mixingDelaySeconds;

  List<_i3.AutomationBranch>? branches;

  int? sensorTimeoutSeconds;

  int? cooldownSeconds;

  bool enabled;

  String createdBy;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AutomationRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AutomationRule copyWith({
    int? id,
    int? companyId,
    String? name,
    int? triggerDeviceId,
    String? triggerFeatureKey,
    _i2.AlertComparison? comparison,
    double? threshold,
    double? recoveryThreshold,
    int? actionDeviceId,
    String? actionFeatureKey,
    double? actionValue,
    int? pulseOnSeconds,
    int? intervalSeconds,
    int? maxRepeats,
    int? mixingDelaySeconds,
    List<_i3.AutomationBranch>? branches,
    int? sensorTimeoutSeconds,
    int? cooldownSeconds,
    bool? enabled,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AutomationRule',
      if (id != null) 'id': id,
      'companyId': companyId,
      'name': name,
      'triggerDeviceId': triggerDeviceId,
      'triggerFeatureKey': triggerFeatureKey,
      'comparison': comparison.toJson(),
      'threshold': threshold,
      'recoveryThreshold': recoveryThreshold,
      'actionDeviceId': actionDeviceId,
      'actionFeatureKey': actionFeatureKey,
      'actionValue': actionValue,
      'pulseOnSeconds': pulseOnSeconds,
      'intervalSeconds': intervalSeconds,
      'maxRepeats': maxRepeats,
      'mixingDelaySeconds': mixingDelaySeconds,
      if (branches != null)
        'branches': branches?.toJson(valueToJson: (v) => v.toJson()),
      if (sensorTimeoutSeconds != null)
        'sensorTimeoutSeconds': sensorTimeoutSeconds,
      if (cooldownSeconds != null) 'cooldownSeconds': cooldownSeconds,
      'enabled': enabled,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AutomationRule',
      if (id != null) 'id': id,
      'companyId': companyId,
      'name': name,
      'triggerDeviceId': triggerDeviceId,
      'triggerFeatureKey': triggerFeatureKey,
      'comparison': comparison.toJson(),
      'threshold': threshold,
      'recoveryThreshold': recoveryThreshold,
      'actionDeviceId': actionDeviceId,
      'actionFeatureKey': actionFeatureKey,
      'actionValue': actionValue,
      'pulseOnSeconds': pulseOnSeconds,
      'intervalSeconds': intervalSeconds,
      'maxRepeats': maxRepeats,
      'mixingDelaySeconds': mixingDelaySeconds,
      if (branches != null)
        'branches': branches?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (sensorTimeoutSeconds != null)
        'sensorTimeoutSeconds': sensorTimeoutSeconds,
      if (cooldownSeconds != null) 'cooldownSeconds': cooldownSeconds,
      'enabled': enabled,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AutomationRuleInclude include() {
    return AutomationRuleInclude._();
  }

  static AutomationRuleIncludeList includeList({
    _i1.WhereExpressionBuilder<AutomationRuleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AutomationRuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AutomationRuleTable>? orderByList,
    AutomationRuleInclude? include,
  }) {
    return AutomationRuleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AutomationRule.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AutomationRule.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AutomationRuleImpl extends AutomationRule {
  _AutomationRuleImpl({
    int? id,
    required int companyId,
    required String name,
    required int triggerDeviceId,
    required String triggerFeatureKey,
    required _i2.AlertComparison comparison,
    required double threshold,
    required double recoveryThreshold,
    required int actionDeviceId,
    required String actionFeatureKey,
    required double actionValue,
    required int pulseOnSeconds,
    required int intervalSeconds,
    required int maxRepeats,
    required int mixingDelaySeconds,
    List<_i3.AutomationBranch>? branches,
    int? sensorTimeoutSeconds,
    int? cooldownSeconds,
    required bool enabled,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         name: name,
         triggerDeviceId: triggerDeviceId,
         triggerFeatureKey: triggerFeatureKey,
         comparison: comparison,
         threshold: threshold,
         recoveryThreshold: recoveryThreshold,
         actionDeviceId: actionDeviceId,
         actionFeatureKey: actionFeatureKey,
         actionValue: actionValue,
         pulseOnSeconds: pulseOnSeconds,
         intervalSeconds: intervalSeconds,
         maxRepeats: maxRepeats,
         mixingDelaySeconds: mixingDelaySeconds,
         branches: branches,
         sensorTimeoutSeconds: sensorTimeoutSeconds,
         cooldownSeconds: cooldownSeconds,
         enabled: enabled,
         createdBy: createdBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AutomationRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AutomationRule copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? name,
    int? triggerDeviceId,
    String? triggerFeatureKey,
    _i2.AlertComparison? comparison,
    double? threshold,
    double? recoveryThreshold,
    int? actionDeviceId,
    String? actionFeatureKey,
    double? actionValue,
    int? pulseOnSeconds,
    int? intervalSeconds,
    int? maxRepeats,
    int? mixingDelaySeconds,
    Object? branches = _Undefined,
    Object? sensorTimeoutSeconds = _Undefined,
    Object? cooldownSeconds = _Undefined,
    bool? enabled,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AutomationRule(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      triggerDeviceId: triggerDeviceId ?? this.triggerDeviceId,
      triggerFeatureKey: triggerFeatureKey ?? this.triggerFeatureKey,
      comparison: comparison ?? this.comparison,
      threshold: threshold ?? this.threshold,
      recoveryThreshold: recoveryThreshold ?? this.recoveryThreshold,
      actionDeviceId: actionDeviceId ?? this.actionDeviceId,
      actionFeatureKey: actionFeatureKey ?? this.actionFeatureKey,
      actionValue: actionValue ?? this.actionValue,
      pulseOnSeconds: pulseOnSeconds ?? this.pulseOnSeconds,
      intervalSeconds: intervalSeconds ?? this.intervalSeconds,
      maxRepeats: maxRepeats ?? this.maxRepeats,
      mixingDelaySeconds: mixingDelaySeconds ?? this.mixingDelaySeconds,
      branches: branches is List<_i3.AutomationBranch>?
          ? branches
          : this.branches?.map((e0) => e0.copyWith()).toList(),
      sensorTimeoutSeconds: sensorTimeoutSeconds is int?
          ? sensorTimeoutSeconds
          : this.sensorTimeoutSeconds,
      cooldownSeconds: cooldownSeconds is int?
          ? cooldownSeconds
          : this.cooldownSeconds,
      enabled: enabled ?? this.enabled,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AutomationRuleUpdateTable extends _i1.UpdateTable<AutomationRuleTable> {
  AutomationRuleUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<int, int> triggerDeviceId(int value) => _i1.ColumnValue(
    table.triggerDeviceId,
    value,
  );

  _i1.ColumnValue<String, String> triggerFeatureKey(String value) =>
      _i1.ColumnValue(
        table.triggerFeatureKey,
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

  _i1.ColumnValue<double, double> recoveryThreshold(double value) =>
      _i1.ColumnValue(
        table.recoveryThreshold,
        value,
      );

  _i1.ColumnValue<int, int> actionDeviceId(int value) => _i1.ColumnValue(
    table.actionDeviceId,
    value,
  );

  _i1.ColumnValue<String, String> actionFeatureKey(String value) =>
      _i1.ColumnValue(
        table.actionFeatureKey,
        value,
      );

  _i1.ColumnValue<double, double> actionValue(double value) => _i1.ColumnValue(
    table.actionValue,
    value,
  );

  _i1.ColumnValue<int, int> pulseOnSeconds(int value) => _i1.ColumnValue(
    table.pulseOnSeconds,
    value,
  );

  _i1.ColumnValue<int, int> intervalSeconds(int value) => _i1.ColumnValue(
    table.intervalSeconds,
    value,
  );

  _i1.ColumnValue<int, int> maxRepeats(int value) => _i1.ColumnValue(
    table.maxRepeats,
    value,
  );

  _i1.ColumnValue<int, int> mixingDelaySeconds(int value) => _i1.ColumnValue(
    table.mixingDelaySeconds,
    value,
  );

  _i1.ColumnValue<List<_i3.AutomationBranch>, List<_i3.AutomationBranch>>
  branches(List<_i3.AutomationBranch>? value) => _i1.ColumnValue(
    table.branches,
    value,
  );

  _i1.ColumnValue<int, int> sensorTimeoutSeconds(int? value) => _i1.ColumnValue(
    table.sensorTimeoutSeconds,
    value,
  );

  _i1.ColumnValue<int, int> cooldownSeconds(int? value) => _i1.ColumnValue(
    table.cooldownSeconds,
    value,
  );

  _i1.ColumnValue<bool, bool> enabled(bool value) => _i1.ColumnValue(
    table.enabled,
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

class AutomationRuleTable extends _i1.Table<int?> {
  AutomationRuleTable({super.tableRelation})
    : super(tableName: 'automation_rule') {
    updateTable = AutomationRuleUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    triggerDeviceId = _i1.ColumnInt(
      'triggerDeviceId',
      this,
    );
    triggerFeatureKey = _i1.ColumnString(
      'triggerFeatureKey',
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
    recoveryThreshold = _i1.ColumnDouble(
      'recoveryThreshold',
      this,
    );
    actionDeviceId = _i1.ColumnInt(
      'actionDeviceId',
      this,
    );
    actionFeatureKey = _i1.ColumnString(
      'actionFeatureKey',
      this,
    );
    actionValue = _i1.ColumnDouble(
      'actionValue',
      this,
    );
    pulseOnSeconds = _i1.ColumnInt(
      'pulseOnSeconds',
      this,
    );
    intervalSeconds = _i1.ColumnInt(
      'intervalSeconds',
      this,
    );
    maxRepeats = _i1.ColumnInt(
      'maxRepeats',
      this,
    );
    mixingDelaySeconds = _i1.ColumnInt(
      'mixingDelaySeconds',
      this,
    );
    branches = _i1.ColumnSerializable<List<_i3.AutomationBranch>>(
      'branches',
      this,
    );
    sensorTimeoutSeconds = _i1.ColumnInt(
      'sensorTimeoutSeconds',
      this,
      hasDefault: true,
    );
    cooldownSeconds = _i1.ColumnInt(
      'cooldownSeconds',
      this,
      hasDefault: true,
    );
    enabled = _i1.ColumnBool(
      'enabled',
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
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final AutomationRuleUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnString name;

  late final _i1.ColumnInt triggerDeviceId;

  late final _i1.ColumnString triggerFeatureKey;

  late final _i1.ColumnEnum<_i2.AlertComparison> comparison;

  late final _i1.ColumnDouble threshold;

  late final _i1.ColumnDouble recoveryThreshold;

  late final _i1.ColumnInt actionDeviceId;

  late final _i1.ColumnString actionFeatureKey;

  late final _i1.ColumnDouble actionValue;

  late final _i1.ColumnInt pulseOnSeconds;

  late final _i1.ColumnInt intervalSeconds;

  late final _i1.ColumnInt maxRepeats;

  late final _i1.ColumnInt mixingDelaySeconds;

  late final _i1.ColumnSerializable<List<_i3.AutomationBranch>> branches;

  late final _i1.ColumnInt sensorTimeoutSeconds;

  late final _i1.ColumnInt cooldownSeconds;

  late final _i1.ColumnBool enabled;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    name,
    triggerDeviceId,
    triggerFeatureKey,
    comparison,
    threshold,
    recoveryThreshold,
    actionDeviceId,
    actionFeatureKey,
    actionValue,
    pulseOnSeconds,
    intervalSeconds,
    maxRepeats,
    mixingDelaySeconds,
    branches,
    sensorTimeoutSeconds,
    cooldownSeconds,
    enabled,
    createdBy,
    createdAt,
    updatedAt,
  ];
}

class AutomationRuleInclude extends _i1.IncludeObject {
  AutomationRuleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AutomationRule.t;
}

class AutomationRuleIncludeList extends _i1.IncludeList {
  AutomationRuleIncludeList._({
    _i1.WhereExpressionBuilder<AutomationRuleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AutomationRule.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AutomationRule.t;
}

class AutomationRuleRepository {
  const AutomationRuleRepository._();

  /// Returns a list of [AutomationRule]s matching the given query parameters.
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
  Future<List<AutomationRule>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AutomationRuleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AutomationRuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AutomationRuleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AutomationRule>(
      where: where?.call(AutomationRule.t),
      orderBy: orderBy?.call(AutomationRule.t),
      orderByList: orderByList?.call(AutomationRule.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AutomationRule] matching the given query parameters.
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
  Future<AutomationRule?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AutomationRuleTable>? where,
    int? offset,
    _i1.OrderByBuilder<AutomationRuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AutomationRuleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AutomationRule>(
      where: where?.call(AutomationRule.t),
      orderBy: orderBy?.call(AutomationRule.t),
      orderByList: orderByList?.call(AutomationRule.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AutomationRule] by its [id] or null if no such row exists.
  Future<AutomationRule?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AutomationRule>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AutomationRule]s in the list and returns the inserted rows.
  ///
  /// The returned [AutomationRule]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AutomationRule>> insert(
    _i1.DatabaseSession session,
    List<AutomationRule> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AutomationRule>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AutomationRule] and returns the inserted row.
  ///
  /// The returned [AutomationRule] will have its `id` field set.
  Future<AutomationRule> insertRow(
    _i1.DatabaseSession session,
    AutomationRule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AutomationRule>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AutomationRule]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AutomationRule>> update(
    _i1.DatabaseSession session,
    List<AutomationRule> rows, {
    _i1.ColumnSelections<AutomationRuleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AutomationRule>(
      rows,
      columns: columns?.call(AutomationRule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AutomationRule]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AutomationRule> updateRow(
    _i1.DatabaseSession session,
    AutomationRule row, {
    _i1.ColumnSelections<AutomationRuleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AutomationRule>(
      row,
      columns: columns?.call(AutomationRule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AutomationRule] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AutomationRule?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AutomationRuleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AutomationRule>(
      id,
      columnValues: columnValues(AutomationRule.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AutomationRule]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AutomationRule>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AutomationRuleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AutomationRuleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AutomationRuleTable>? orderBy,
    _i1.OrderByListBuilder<AutomationRuleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AutomationRule>(
      columnValues: columnValues(AutomationRule.t.updateTable),
      where: where(AutomationRule.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AutomationRule.t),
      orderByList: orderByList?.call(AutomationRule.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AutomationRule]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AutomationRule>> delete(
    _i1.DatabaseSession session,
    List<AutomationRule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AutomationRule>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AutomationRule].
  Future<AutomationRule> deleteRow(
    _i1.DatabaseSession session,
    AutomationRule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AutomationRule>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AutomationRule>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AutomationRuleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AutomationRule>(
      where: where(AutomationRule.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AutomationRuleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AutomationRule>(
      where: where?.call(AutomationRule.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AutomationRule] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AutomationRuleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AutomationRule>(
      where: where(AutomationRule.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
