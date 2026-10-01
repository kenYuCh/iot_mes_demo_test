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
import '../device/feature_kind.dart' as _i2;
import '../device/feature_data_type.dart' as _i3;
import '../device/control_presentation.dart' as _i4;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i5;

/// 公司級可重用特徵定義。設備型別選用時複製為快照，避免已部署協定被目錄修改連動。
abstract class FeatureDefinition
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FeatureDefinition._({
    this.id,
    required this.companyId,
    required this.featureKey,
    required this.label,
    required this.unit,
    required this.kind,
    this.dataType,
    this.controlPresentation,
    this.enumOptions,
    this.precision,
    this.description,
    required this.minValue,
    required this.maxValue,
    this.defaultValue,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FeatureDefinition({
    int? id,
    required int companyId,
    required String featureKey,
    required String label,
    required String unit,
    required _i2.FeatureKind kind,
    _i3.FeatureDataType? dataType,
    _i4.ControlPresentation? controlPresentation,
    List<String>? enumOptions,
    int? precision,
    String? description,
    required double minValue,
    required double maxValue,
    double? defaultValue,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FeatureDefinitionImpl;

  factory FeatureDefinition.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureDefinition(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      featureKey: jsonSerialization['featureKey'] as String,
      label: jsonSerialization['label'] as String,
      unit: jsonSerialization['unit'] as String,
      kind: _i2.FeatureKind.fromJson((jsonSerialization['kind'] as String)),
      dataType: jsonSerialization['dataType'] == null
          ? null
          : _i3.FeatureDataType.fromJson(
              (jsonSerialization['dataType'] as String),
            ),
      controlPresentation: jsonSerialization['controlPresentation'] == null
          ? null
          : _i4.ControlPresentation.fromJson(
              (jsonSerialization['controlPresentation'] as String),
            ),
      enumOptions: jsonSerialization['enumOptions'] == null
          ? null
          : _i5.Protocol().deserialize<List<String>>(
              jsonSerialization['enumOptions'],
            ),
      precision: jsonSerialization['precision'] as int?,
      description: jsonSerialization['description'] as String?,
      minValue: (jsonSerialization['minValue'] as num).toDouble(),
      maxValue: (jsonSerialization['maxValue'] as num).toDouble(),
      defaultValue: (jsonSerialization['defaultValue'] as num?)?.toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = FeatureDefinitionTable();

  static const db = FeatureDefinitionRepository._();

  @override
  int? id;

  int companyId;

  String featureKey;

  String label;

  String unit;

  _i2.FeatureKind kind;

  _i3.FeatureDataType? dataType;

  _i4.ControlPresentation? controlPresentation;

  List<String>? enumOptions;

  int? precision;

  String? description;

  double minValue;

  double maxValue;

  double? defaultValue;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureDefinition copyWith({
    int? id,
    int? companyId,
    String? featureKey,
    String? label,
    String? unit,
    _i2.FeatureKind? kind,
    _i3.FeatureDataType? dataType,
    _i4.ControlPresentation? controlPresentation,
    List<String>? enumOptions,
    int? precision,
    String? description,
    double? minValue,
    double? maxValue,
    double? defaultValue,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureDefinition',
      if (id != null) 'id': id,
      'companyId': companyId,
      'featureKey': featureKey,
      'label': label,
      'unit': unit,
      'kind': kind.toJson(),
      if (dataType != null) 'dataType': dataType?.toJson(),
      if (controlPresentation != null)
        'controlPresentation': controlPresentation?.toJson(),
      if (enumOptions != null) 'enumOptions': enumOptions?.toJson(),
      if (precision != null) 'precision': precision,
      if (description != null) 'description': description,
      'minValue': minValue,
      'maxValue': maxValue,
      if (defaultValue != null) 'defaultValue': defaultValue,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureDefinition',
      if (id != null) 'id': id,
      'companyId': companyId,
      'featureKey': featureKey,
      'label': label,
      'unit': unit,
      'kind': kind.toJson(),
      if (dataType != null) 'dataType': dataType?.toJson(),
      if (controlPresentation != null)
        'controlPresentation': controlPresentation?.toJson(),
      if (enumOptions != null) 'enumOptions': enumOptions?.toJson(),
      if (precision != null) 'precision': precision,
      if (description != null) 'description': description,
      'minValue': minValue,
      'maxValue': maxValue,
      if (defaultValue != null) 'defaultValue': defaultValue,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FeatureDefinitionInclude include() {
    return FeatureDefinitionInclude._();
  }

  static FeatureDefinitionIncludeList includeList({
    _i1.WhereExpressionBuilder<FeatureDefinitionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureDefinitionTable>? orderByList,
    FeatureDefinitionInclude? include,
  }) {
    return FeatureDefinitionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureDefinition.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FeatureDefinition.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureDefinitionImpl extends FeatureDefinition {
  _FeatureDefinitionImpl({
    int? id,
    required int companyId,
    required String featureKey,
    required String label,
    required String unit,
    required _i2.FeatureKind kind,
    _i3.FeatureDataType? dataType,
    _i4.ControlPresentation? controlPresentation,
    List<String>? enumOptions,
    int? precision,
    String? description,
    required double minValue,
    required double maxValue,
    double? defaultValue,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         featureKey: featureKey,
         label: label,
         unit: unit,
         kind: kind,
         dataType: dataType,
         controlPresentation: controlPresentation,
         enumOptions: enumOptions,
         precision: precision,
         description: description,
         minValue: minValue,
         maxValue: maxValue,
         defaultValue: defaultValue,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FeatureDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureDefinition copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? featureKey,
    String? label,
    String? unit,
    _i2.FeatureKind? kind,
    Object? dataType = _Undefined,
    Object? controlPresentation = _Undefined,
    Object? enumOptions = _Undefined,
    Object? precision = _Undefined,
    Object? description = _Undefined,
    double? minValue,
    double? maxValue,
    Object? defaultValue = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FeatureDefinition(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      featureKey: featureKey ?? this.featureKey,
      label: label ?? this.label,
      unit: unit ?? this.unit,
      kind: kind ?? this.kind,
      dataType: dataType is _i3.FeatureDataType? ? dataType : this.dataType,
      controlPresentation: controlPresentation is _i4.ControlPresentation?
          ? controlPresentation
          : this.controlPresentation,
      enumOptions: enumOptions is List<String>?
          ? enumOptions
          : this.enumOptions?.map((e0) => e0).toList(),
      precision: precision is int? ? precision : this.precision,
      description: description is String? ? description : this.description,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      defaultValue: defaultValue is double? ? defaultValue : this.defaultValue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FeatureDefinitionUpdateTable
    extends _i1.UpdateTable<FeatureDefinitionTable> {
  FeatureDefinitionUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> featureKey(String value) => _i1.ColumnValue(
    table.featureKey,
    value,
  );

  _i1.ColumnValue<String, String> label(String value) => _i1.ColumnValue(
    table.label,
    value,
  );

  _i1.ColumnValue<String, String> unit(String value) => _i1.ColumnValue(
    table.unit,
    value,
  );

  _i1.ColumnValue<_i2.FeatureKind, _i2.FeatureKind> kind(
    _i2.FeatureKind value,
  ) => _i1.ColumnValue(
    table.kind,
    value,
  );

  _i1.ColumnValue<_i3.FeatureDataType, _i3.FeatureDataType> dataType(
    _i3.FeatureDataType? value,
  ) => _i1.ColumnValue(
    table.dataType,
    value,
  );

  _i1.ColumnValue<_i4.ControlPresentation, _i4.ControlPresentation>
  controlPresentation(_i4.ControlPresentation? value) => _i1.ColumnValue(
    table.controlPresentation,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> enumOptions(
    List<String>? value,
  ) => _i1.ColumnValue(
    table.enumOptions,
    value,
  );

  _i1.ColumnValue<int, int> precision(int? value) => _i1.ColumnValue(
    table.precision,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<double, double> minValue(double value) => _i1.ColumnValue(
    table.minValue,
    value,
  );

  _i1.ColumnValue<double, double> maxValue(double value) => _i1.ColumnValue(
    table.maxValue,
    value,
  );

  _i1.ColumnValue<double, double> defaultValue(double? value) =>
      _i1.ColumnValue(
        table.defaultValue,
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

class FeatureDefinitionTable extends _i1.Table<int?> {
  FeatureDefinitionTable({super.tableRelation})
    : super(tableName: 'feature_definition') {
    updateTable = FeatureDefinitionUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    featureKey = _i1.ColumnString(
      'featureKey',
      this,
    );
    label = _i1.ColumnString(
      'label',
      this,
    );
    unit = _i1.ColumnString(
      'unit',
      this,
    );
    kind = _i1.ColumnEnum(
      'kind',
      this,
      _i1.EnumSerialization.byName,
    );
    dataType = _i1.ColumnEnum(
      'dataType',
      this,
      _i1.EnumSerialization.byName,
    );
    controlPresentation = _i1.ColumnEnum(
      'controlPresentation',
      this,
      _i1.EnumSerialization.byName,
    );
    enumOptions = _i1.ColumnSerializable<List<String>>(
      'enumOptions',
      this,
    );
    precision = _i1.ColumnInt(
      'precision',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    minValue = _i1.ColumnDouble(
      'minValue',
      this,
    );
    maxValue = _i1.ColumnDouble(
      'maxValue',
      this,
    );
    defaultValue = _i1.ColumnDouble(
      'defaultValue',
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

  late final FeatureDefinitionUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnString featureKey;

  late final _i1.ColumnString label;

  late final _i1.ColumnString unit;

  late final _i1.ColumnEnum<_i2.FeatureKind> kind;

  late final _i1.ColumnEnum<_i3.FeatureDataType> dataType;

  late final _i1.ColumnEnum<_i4.ControlPresentation> controlPresentation;

  late final _i1.ColumnSerializable<List<String>> enumOptions;

  late final _i1.ColumnInt precision;

  late final _i1.ColumnString description;

  late final _i1.ColumnDouble minValue;

  late final _i1.ColumnDouble maxValue;

  late final _i1.ColumnDouble defaultValue;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    featureKey,
    label,
    unit,
    kind,
    dataType,
    controlPresentation,
    enumOptions,
    precision,
    description,
    minValue,
    maxValue,
    defaultValue,
    createdAt,
    updatedAt,
  ];
}

class FeatureDefinitionInclude extends _i1.IncludeObject {
  FeatureDefinitionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FeatureDefinition.t;
}

class FeatureDefinitionIncludeList extends _i1.IncludeList {
  FeatureDefinitionIncludeList._({
    _i1.WhereExpressionBuilder<FeatureDefinitionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureDefinition.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FeatureDefinition.t;
}

class FeatureDefinitionRepository {
  const FeatureDefinitionRepository._();

  /// Returns a list of [FeatureDefinition]s matching the given query parameters.
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
  Future<List<FeatureDefinition>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FeatureDefinitionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureDefinitionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeatureDefinition>(
      where: where?.call(FeatureDefinition.t),
      orderBy: orderBy?.call(FeatureDefinition.t),
      orderByList: orderByList?.call(FeatureDefinition.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeatureDefinition] matching the given query parameters.
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
  Future<FeatureDefinition?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FeatureDefinitionTable>? where,
    int? offset,
    _i1.OrderByBuilder<FeatureDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureDefinitionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeatureDefinition>(
      where: where?.call(FeatureDefinition.t),
      orderBy: orderBy?.call(FeatureDefinition.t),
      orderByList: orderByList?.call(FeatureDefinition.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeatureDefinition] by its [id] or null if no such row exists.
  Future<FeatureDefinition?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeatureDefinition>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeatureDefinition]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureDefinition]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FeatureDefinition>> insert(
    _i1.DatabaseSession session,
    List<FeatureDefinition> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FeatureDefinition>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FeatureDefinition] and returns the inserted row.
  ///
  /// The returned [FeatureDefinition] will have its `id` field set.
  Future<FeatureDefinition> insertRow(
    _i1.DatabaseSession session,
    FeatureDefinition row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureDefinition>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FeatureDefinition]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FeatureDefinition>> update(
    _i1.DatabaseSession session,
    List<FeatureDefinition> rows, {
    _i1.ColumnSelections<FeatureDefinitionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FeatureDefinition>(
      rows,
      columns: columns?.call(FeatureDefinition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureDefinition]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureDefinition> updateRow(
    _i1.DatabaseSession session,
    FeatureDefinition row, {
    _i1.ColumnSelections<FeatureDefinitionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureDefinition>(
      row,
      columns: columns?.call(FeatureDefinition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureDefinition] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeatureDefinition?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FeatureDefinitionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FeatureDefinition>(
      id,
      columnValues: columnValues(FeatureDefinition.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureDefinition]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FeatureDefinition>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FeatureDefinitionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<FeatureDefinitionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureDefinitionTable>? orderBy,
    _i1.OrderByListBuilder<FeatureDefinitionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FeatureDefinition>(
      columnValues: columnValues(FeatureDefinition.t.updateTable),
      where: where(FeatureDefinition.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureDefinition.t),
      orderByList: orderByList?.call(FeatureDefinition.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FeatureDefinition]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FeatureDefinition>> delete(
    _i1.DatabaseSession session,
    List<FeatureDefinition> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FeatureDefinition>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FeatureDefinition].
  Future<FeatureDefinition> deleteRow(
    _i1.DatabaseSession session,
    FeatureDefinition row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureDefinition>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FeatureDefinition>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FeatureDefinitionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FeatureDefinition>(
      where: where(FeatureDefinition.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FeatureDefinitionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FeatureDefinition>(
      where: where?.call(FeatureDefinition.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeatureDefinition] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FeatureDefinitionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeatureDefinition>(
      where: where(FeatureDefinition.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
