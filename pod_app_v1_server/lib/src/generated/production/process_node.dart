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
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i2;

abstract class ProcessNode
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProcessNode._({
    this.id,
    required this.companyId,
    required this.routeId,
    required this.sequence,
    required this.code,
    required this.name,
    required this.stationCode,
    required this.standardSeconds,
    String? scanMode,
    bool? allowSkip,
    bool? allowRework,
    this.measurementRequirements,
    required this.createdAt,
    required this.updatedAt,
  }) : scanMode = scanMode ?? 'startComplete',
       allowSkip = allowSkip ?? false,
       allowRework = allowRework ?? true;

  factory ProcessNode({
    int? id,
    required int companyId,
    required int routeId,
    required int sequence,
    required String code,
    required String name,
    required String stationCode,
    required int standardSeconds,
    String? scanMode,
    bool? allowSkip,
    bool? allowRework,
    Map<String, String>? measurementRequirements,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProcessNodeImpl;

  factory ProcessNode.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProcessNode(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      routeId: jsonSerialization['routeId'] as int,
      sequence: jsonSerialization['sequence'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      stationCode: jsonSerialization['stationCode'] as String,
      standardSeconds: jsonSerialization['standardSeconds'] as int,
      scanMode: jsonSerialization['scanMode'] as String?,
      allowSkip: jsonSerialization['allowSkip'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['allowSkip']),
      allowRework: jsonSerialization['allowRework'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['allowRework']),
      measurementRequirements:
          jsonSerialization['measurementRequirements'] == null
          ? null
          : _i2.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['measurementRequirements'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ProcessNodeTable();

  static const db = ProcessNodeRepository._();

  @override
  int? id;

  int companyId;

  int routeId;

  int sequence;

  String code;

  String name;

  String stationCode;

  int standardSeconds;

  String scanMode;

  bool allowSkip;

  bool allowRework;

  Map<String, String>? measurementRequirements;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProcessNode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProcessNode copyWith({
    int? id,
    int? companyId,
    int? routeId,
    int? sequence,
    String? code,
    String? name,
    String? stationCode,
    int? standardSeconds,
    String? scanMode,
    bool? allowSkip,
    bool? allowRework,
    Map<String, String>? measurementRequirements,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProcessNode',
      if (id != null) 'id': id,
      'companyId': companyId,
      'routeId': routeId,
      'sequence': sequence,
      'code': code,
      'name': name,
      'stationCode': stationCode,
      'standardSeconds': standardSeconds,
      'scanMode': scanMode,
      'allowSkip': allowSkip,
      'allowRework': allowRework,
      if (measurementRequirements != null)
        'measurementRequirements': measurementRequirements?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProcessNode',
      if (id != null) 'id': id,
      'companyId': companyId,
      'routeId': routeId,
      'sequence': sequence,
      'code': code,
      'name': name,
      'stationCode': stationCode,
      'standardSeconds': standardSeconds,
      'scanMode': scanMode,
      'allowSkip': allowSkip,
      'allowRework': allowRework,
      if (measurementRequirements != null)
        'measurementRequirements': measurementRequirements?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProcessNodeInclude include() {
    return ProcessNodeInclude._();
  }

  static ProcessNodeIncludeList includeList({
    _i1.WhereExpressionBuilder<ProcessNodeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProcessNodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProcessNodeTable>? orderByList,
    ProcessNodeInclude? include,
  }) {
    return ProcessNodeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProcessNode.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProcessNode.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProcessNodeImpl extends ProcessNode {
  _ProcessNodeImpl({
    int? id,
    required int companyId,
    required int routeId,
    required int sequence,
    required String code,
    required String name,
    required String stationCode,
    required int standardSeconds,
    String? scanMode,
    bool? allowSkip,
    bool? allowRework,
    Map<String, String>? measurementRequirements,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         routeId: routeId,
         sequence: sequence,
         code: code,
         name: name,
         stationCode: stationCode,
         standardSeconds: standardSeconds,
         scanMode: scanMode,
         allowSkip: allowSkip,
         allowRework: allowRework,
         measurementRequirements: measurementRequirements,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProcessNode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProcessNode copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? routeId,
    int? sequence,
    String? code,
    String? name,
    String? stationCode,
    int? standardSeconds,
    String? scanMode,
    bool? allowSkip,
    bool? allowRework,
    Object? measurementRequirements = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProcessNode(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      routeId: routeId ?? this.routeId,
      sequence: sequence ?? this.sequence,
      code: code ?? this.code,
      name: name ?? this.name,
      stationCode: stationCode ?? this.stationCode,
      standardSeconds: standardSeconds ?? this.standardSeconds,
      scanMode: scanMode ?? this.scanMode,
      allowSkip: allowSkip ?? this.allowSkip,
      allowRework: allowRework ?? this.allowRework,
      measurementRequirements: measurementRequirements is Map<String, String>?
          ? measurementRequirements
          : this.measurementRequirements?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProcessNodeUpdateTable extends _i1.UpdateTable<ProcessNodeTable> {
  ProcessNodeUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> routeId(int value) => _i1.ColumnValue(
    table.routeId,
    value,
  );

  _i1.ColumnValue<int, int> sequence(int value) => _i1.ColumnValue(
    table.sequence,
    value,
  );

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> stationCode(String value) => _i1.ColumnValue(
    table.stationCode,
    value,
  );

  _i1.ColumnValue<int, int> standardSeconds(int value) => _i1.ColumnValue(
    table.standardSeconds,
    value,
  );

  _i1.ColumnValue<String, String> scanMode(String value) => _i1.ColumnValue(
    table.scanMode,
    value,
  );

  _i1.ColumnValue<bool, bool> allowSkip(bool value) => _i1.ColumnValue(
    table.allowSkip,
    value,
  );

  _i1.ColumnValue<bool, bool> allowRework(bool value) => _i1.ColumnValue(
    table.allowRework,
    value,
  );

  _i1.ColumnValue<Map<String, String>, Map<String, String>>
  measurementRequirements(Map<String, String>? value) => _i1.ColumnValue(
    table.measurementRequirements,
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

class ProcessNodeTable extends _i1.Table<int?> {
  ProcessNodeTable({super.tableRelation}) : super(tableName: 'process_node') {
    updateTable = ProcessNodeUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    routeId = _i1.ColumnInt(
      'routeId',
      this,
    );
    sequence = _i1.ColumnInt(
      'sequence',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    stationCode = _i1.ColumnString(
      'stationCode',
      this,
    );
    standardSeconds = _i1.ColumnInt(
      'standardSeconds',
      this,
    );
    scanMode = _i1.ColumnString(
      'scanMode',
      this,
      hasDefault: true,
    );
    allowSkip = _i1.ColumnBool(
      'allowSkip',
      this,
      hasDefault: true,
    );
    allowRework = _i1.ColumnBool(
      'allowRework',
      this,
      hasDefault: true,
    );
    measurementRequirements = _i1.ColumnSerializable<Map<String, String>>(
      'measurementRequirements',
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

  late final ProcessNodeUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt routeId;

  late final _i1.ColumnInt sequence;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnString stationCode;

  late final _i1.ColumnInt standardSeconds;

  late final _i1.ColumnString scanMode;

  late final _i1.ColumnBool allowSkip;

  late final _i1.ColumnBool allowRework;

  late final _i1.ColumnSerializable<Map<String, String>>
  measurementRequirements;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    routeId,
    sequence,
    code,
    name,
    stationCode,
    standardSeconds,
    scanMode,
    allowSkip,
    allowRework,
    measurementRequirements,
    createdAt,
    updatedAt,
  ];
}

class ProcessNodeInclude extends _i1.IncludeObject {
  ProcessNodeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProcessNode.t;
}

class ProcessNodeIncludeList extends _i1.IncludeList {
  ProcessNodeIncludeList._({
    _i1.WhereExpressionBuilder<ProcessNodeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProcessNode.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProcessNode.t;
}

class ProcessNodeRepository {
  const ProcessNodeRepository._();

  /// Returns a list of [ProcessNode]s matching the given query parameters.
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
  Future<List<ProcessNode>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProcessNodeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProcessNodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProcessNodeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProcessNode>(
      where: where?.call(ProcessNode.t),
      orderBy: orderBy?.call(ProcessNode.t),
      orderByList: orderByList?.call(ProcessNode.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProcessNode] matching the given query parameters.
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
  Future<ProcessNode?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProcessNodeTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProcessNodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProcessNodeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProcessNode>(
      where: where?.call(ProcessNode.t),
      orderBy: orderBy?.call(ProcessNode.t),
      orderByList: orderByList?.call(ProcessNode.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProcessNode] by its [id] or null if no such row exists.
  Future<ProcessNode?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProcessNode>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProcessNode]s in the list and returns the inserted rows.
  ///
  /// The returned [ProcessNode]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProcessNode>> insert(
    _i1.DatabaseSession session,
    List<ProcessNode> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProcessNode>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProcessNode] and returns the inserted row.
  ///
  /// The returned [ProcessNode] will have its `id` field set.
  Future<ProcessNode> insertRow(
    _i1.DatabaseSession session,
    ProcessNode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProcessNode>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProcessNode]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProcessNode>> update(
    _i1.DatabaseSession session,
    List<ProcessNode> rows, {
    _i1.ColumnSelections<ProcessNodeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProcessNode>(
      rows,
      columns: columns?.call(ProcessNode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProcessNode]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProcessNode> updateRow(
    _i1.DatabaseSession session,
    ProcessNode row, {
    _i1.ColumnSelections<ProcessNodeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProcessNode>(
      row,
      columns: columns?.call(ProcessNode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProcessNode] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProcessNode?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProcessNodeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProcessNode>(
      id,
      columnValues: columnValues(ProcessNode.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProcessNode]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProcessNode>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProcessNodeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProcessNodeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProcessNodeTable>? orderBy,
    _i1.OrderByListBuilder<ProcessNodeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProcessNode>(
      columnValues: columnValues(ProcessNode.t.updateTable),
      where: where(ProcessNode.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProcessNode.t),
      orderByList: orderByList?.call(ProcessNode.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProcessNode]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProcessNode>> delete(
    _i1.DatabaseSession session,
    List<ProcessNode> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProcessNode>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProcessNode].
  Future<ProcessNode> deleteRow(
    _i1.DatabaseSession session,
    ProcessNode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProcessNode>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProcessNode>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProcessNodeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProcessNode>(
      where: where(ProcessNode.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProcessNodeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProcessNode>(
      where: where?.call(ProcessNode.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProcessNode] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProcessNodeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProcessNode>(
      where: where(ProcessNode.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
