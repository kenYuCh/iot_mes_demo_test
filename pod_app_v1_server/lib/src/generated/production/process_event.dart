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
import '../production/process_event_type.dart' as _i2;
import '../production/process_result.dart' as _i3;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i4;

/// Append-only 製程事件；禁止 update/delete，以保留稽核與產品追溯。
abstract class ProcessEvent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProcessEvent._({
    this.id,
    required this.companyId,
    required this.clientEventId,
    required this.productUnitId,
    required this.productionOrderId,
    required this.processNodeId,
    required this.stationCode,
    required this.eventType,
    required this.result,
    required this.operatorId,
    this.deviceId,
    this.materialLotIds,
    this.measurements,
    this.note,
    required this.occurredAt,
    required this.receivedAt,
  });

  factory ProcessEvent({
    int? id,
    required int companyId,
    required String clientEventId,
    required int productUnitId,
    required int productionOrderId,
    required int processNodeId,
    required String stationCode,
    required _i2.ProcessEventType eventType,
    required _i3.ProcessResult result,
    required String operatorId,
    int? deviceId,
    List<int>? materialLotIds,
    Map<String, double>? measurements,
    String? note,
    required DateTime occurredAt,
    required DateTime receivedAt,
  }) = _ProcessEventImpl;

  factory ProcessEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProcessEvent(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      clientEventId: jsonSerialization['clientEventId'] as String,
      productUnitId: jsonSerialization['productUnitId'] as int,
      productionOrderId: jsonSerialization['productionOrderId'] as int,
      processNodeId: jsonSerialization['processNodeId'] as int,
      stationCode: jsonSerialization['stationCode'] as String,
      eventType: _i2.ProcessEventType.fromJson(
        (jsonSerialization['eventType'] as String),
      ),
      result: _i3.ProcessResult.fromJson(
        (jsonSerialization['result'] as String),
      ),
      operatorId: jsonSerialization['operatorId'] as String,
      deviceId: jsonSerialization['deviceId'] as int?,
      materialLotIds: jsonSerialization['materialLotIds'] == null
          ? null
          : _i4.Protocol().deserialize<List<int>>(
              jsonSerialization['materialLotIds'],
            ),
      measurements: jsonSerialization['measurements'] == null
          ? null
          : _i4.Protocol().deserialize<Map<String, double>>(
              jsonSerialization['measurements'],
            ),
      note: jsonSerialization['note'] as String?,
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
      receivedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
    );
  }

  static final t = ProcessEventTable();

  static const db = ProcessEventRepository._();

  @override
  int? id;

  int companyId;

  String clientEventId;

  int productUnitId;

  int productionOrderId;

  int processNodeId;

  String stationCode;

  _i2.ProcessEventType eventType;

  _i3.ProcessResult result;

  String operatorId;

  int? deviceId;

  List<int>? materialLotIds;

  Map<String, double>? measurements;

  String? note;

  DateTime occurredAt;

  DateTime receivedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProcessEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProcessEvent copyWith({
    int? id,
    int? companyId,
    String? clientEventId,
    int? productUnitId,
    int? productionOrderId,
    int? processNodeId,
    String? stationCode,
    _i2.ProcessEventType? eventType,
    _i3.ProcessResult? result,
    String? operatorId,
    int? deviceId,
    List<int>? materialLotIds,
    Map<String, double>? measurements,
    String? note,
    DateTime? occurredAt,
    DateTime? receivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProcessEvent',
      if (id != null) 'id': id,
      'companyId': companyId,
      'clientEventId': clientEventId,
      'productUnitId': productUnitId,
      'productionOrderId': productionOrderId,
      'processNodeId': processNodeId,
      'stationCode': stationCode,
      'eventType': eventType.toJson(),
      'result': result.toJson(),
      'operatorId': operatorId,
      if (deviceId != null) 'deviceId': deviceId,
      if (materialLotIds != null) 'materialLotIds': materialLotIds?.toJson(),
      if (measurements != null) 'measurements': measurements?.toJson(),
      if (note != null) 'note': note,
      'occurredAt': occurredAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProcessEvent',
      if (id != null) 'id': id,
      'companyId': companyId,
      'clientEventId': clientEventId,
      'productUnitId': productUnitId,
      'productionOrderId': productionOrderId,
      'processNodeId': processNodeId,
      'stationCode': stationCode,
      'eventType': eventType.toJson(),
      'result': result.toJson(),
      'operatorId': operatorId,
      if (deviceId != null) 'deviceId': deviceId,
      if (materialLotIds != null) 'materialLotIds': materialLotIds?.toJson(),
      if (measurements != null) 'measurements': measurements?.toJson(),
      if (note != null) 'note': note,
      'occurredAt': occurredAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  static ProcessEventInclude include() {
    return ProcessEventInclude._();
  }

  static ProcessEventIncludeList includeList({
    _i1.WhereExpressionBuilder<ProcessEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProcessEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProcessEventTable>? orderByList,
    ProcessEventInclude? include,
  }) {
    return ProcessEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProcessEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProcessEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProcessEventImpl extends ProcessEvent {
  _ProcessEventImpl({
    int? id,
    required int companyId,
    required String clientEventId,
    required int productUnitId,
    required int productionOrderId,
    required int processNodeId,
    required String stationCode,
    required _i2.ProcessEventType eventType,
    required _i3.ProcessResult result,
    required String operatorId,
    int? deviceId,
    List<int>? materialLotIds,
    Map<String, double>? measurements,
    String? note,
    required DateTime occurredAt,
    required DateTime receivedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         clientEventId: clientEventId,
         productUnitId: productUnitId,
         productionOrderId: productionOrderId,
         processNodeId: processNodeId,
         stationCode: stationCode,
         eventType: eventType,
         result: result,
         operatorId: operatorId,
         deviceId: deviceId,
         materialLotIds: materialLotIds,
         measurements: measurements,
         note: note,
         occurredAt: occurredAt,
         receivedAt: receivedAt,
       );

  /// Returns a shallow copy of this [ProcessEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProcessEvent copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? clientEventId,
    int? productUnitId,
    int? productionOrderId,
    int? processNodeId,
    String? stationCode,
    _i2.ProcessEventType? eventType,
    _i3.ProcessResult? result,
    String? operatorId,
    Object? deviceId = _Undefined,
    Object? materialLotIds = _Undefined,
    Object? measurements = _Undefined,
    Object? note = _Undefined,
    DateTime? occurredAt,
    DateTime? receivedAt,
  }) {
    return ProcessEvent(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      clientEventId: clientEventId ?? this.clientEventId,
      productUnitId: productUnitId ?? this.productUnitId,
      productionOrderId: productionOrderId ?? this.productionOrderId,
      processNodeId: processNodeId ?? this.processNodeId,
      stationCode: stationCode ?? this.stationCode,
      eventType: eventType ?? this.eventType,
      result: result ?? this.result,
      operatorId: operatorId ?? this.operatorId,
      deviceId: deviceId is int? ? deviceId : this.deviceId,
      materialLotIds: materialLotIds is List<int>?
          ? materialLotIds
          : this.materialLotIds?.map((e0) => e0).toList(),
      measurements: measurements is Map<String, double>?
          ? measurements
          : this.measurements?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      note: note is String? ? note : this.note,
      occurredAt: occurredAt ?? this.occurredAt,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }
}

class ProcessEventUpdateTable extends _i1.UpdateTable<ProcessEventTable> {
  ProcessEventUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> clientEventId(String value) =>
      _i1.ColumnValue(
        table.clientEventId,
        value,
      );

  _i1.ColumnValue<int, int> productUnitId(int value) => _i1.ColumnValue(
    table.productUnitId,
    value,
  );

  _i1.ColumnValue<int, int> productionOrderId(int value) => _i1.ColumnValue(
    table.productionOrderId,
    value,
  );

  _i1.ColumnValue<int, int> processNodeId(int value) => _i1.ColumnValue(
    table.processNodeId,
    value,
  );

  _i1.ColumnValue<String, String> stationCode(String value) => _i1.ColumnValue(
    table.stationCode,
    value,
  );

  _i1.ColumnValue<_i2.ProcessEventType, _i2.ProcessEventType> eventType(
    _i2.ProcessEventType value,
  ) => _i1.ColumnValue(
    table.eventType,
    value,
  );

  _i1.ColumnValue<_i3.ProcessResult, _i3.ProcessResult> result(
    _i3.ProcessResult value,
  ) => _i1.ColumnValue(
    table.result,
    value,
  );

  _i1.ColumnValue<String, String> operatorId(String value) => _i1.ColumnValue(
    table.operatorId,
    value,
  );

  _i1.ColumnValue<int, int> deviceId(int? value) => _i1.ColumnValue(
    table.deviceId,
    value,
  );

  _i1.ColumnValue<List<int>, List<int>> materialLotIds(List<int>? value) =>
      _i1.ColumnValue(
        table.materialLotIds,
        value,
      );

  _i1.ColumnValue<Map<String, double>, Map<String, double>> measurements(
    Map<String, double>? value,
  ) => _i1.ColumnValue(
    table.measurements,
    value,
  );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> occurredAt(DateTime value) =>
      _i1.ColumnValue(
        table.occurredAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> receivedAt(DateTime value) =>
      _i1.ColumnValue(
        table.receivedAt,
        value,
      );
}

class ProcessEventTable extends _i1.Table<int?> {
  ProcessEventTable({super.tableRelation}) : super(tableName: 'process_event') {
    updateTable = ProcessEventUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    clientEventId = _i1.ColumnString(
      'clientEventId',
      this,
    );
    productUnitId = _i1.ColumnInt(
      'productUnitId',
      this,
    );
    productionOrderId = _i1.ColumnInt(
      'productionOrderId',
      this,
    );
    processNodeId = _i1.ColumnInt(
      'processNodeId',
      this,
    );
    stationCode = _i1.ColumnString(
      'stationCode',
      this,
    );
    eventType = _i1.ColumnEnum(
      'eventType',
      this,
      _i1.EnumSerialization.byName,
    );
    result = _i1.ColumnEnum(
      'result',
      this,
      _i1.EnumSerialization.byName,
    );
    operatorId = _i1.ColumnString(
      'operatorId',
      this,
    );
    deviceId = _i1.ColumnInt(
      'deviceId',
      this,
    );
    materialLotIds = _i1.ColumnSerializable<List<int>>(
      'materialLotIds',
      this,
    );
    measurements = _i1.ColumnSerializable<Map<String, double>>(
      'measurements',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    occurredAt = _i1.ColumnDateTime(
      'occurredAt',
      this,
    );
    receivedAt = _i1.ColumnDateTime(
      'receivedAt',
      this,
    );
  }

  late final ProcessEventUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnString clientEventId;

  late final _i1.ColumnInt productUnitId;

  late final _i1.ColumnInt productionOrderId;

  late final _i1.ColumnInt processNodeId;

  late final _i1.ColumnString stationCode;

  late final _i1.ColumnEnum<_i2.ProcessEventType> eventType;

  late final _i1.ColumnEnum<_i3.ProcessResult> result;

  late final _i1.ColumnString operatorId;

  late final _i1.ColumnInt deviceId;

  late final _i1.ColumnSerializable<List<int>> materialLotIds;

  late final _i1.ColumnSerializable<Map<String, double>> measurements;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime occurredAt;

  late final _i1.ColumnDateTime receivedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    clientEventId,
    productUnitId,
    productionOrderId,
    processNodeId,
    stationCode,
    eventType,
    result,
    operatorId,
    deviceId,
    materialLotIds,
    measurements,
    note,
    occurredAt,
    receivedAt,
  ];
}

class ProcessEventInclude extends _i1.IncludeObject {
  ProcessEventInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProcessEvent.t;
}

class ProcessEventIncludeList extends _i1.IncludeList {
  ProcessEventIncludeList._({
    _i1.WhereExpressionBuilder<ProcessEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProcessEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProcessEvent.t;
}

class ProcessEventRepository {
  const ProcessEventRepository._();

  /// Returns a list of [ProcessEvent]s matching the given query parameters.
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
  Future<List<ProcessEvent>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProcessEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProcessEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProcessEventTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProcessEvent>(
      where: where?.call(ProcessEvent.t),
      orderBy: orderBy?.call(ProcessEvent.t),
      orderByList: orderByList?.call(ProcessEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProcessEvent] matching the given query parameters.
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
  Future<ProcessEvent?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProcessEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProcessEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProcessEventTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProcessEvent>(
      where: where?.call(ProcessEvent.t),
      orderBy: orderBy?.call(ProcessEvent.t),
      orderByList: orderByList?.call(ProcessEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProcessEvent] by its [id] or null if no such row exists.
  Future<ProcessEvent?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProcessEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProcessEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [ProcessEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProcessEvent>> insert(
    _i1.DatabaseSession session,
    List<ProcessEvent> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProcessEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProcessEvent] and returns the inserted row.
  ///
  /// The returned [ProcessEvent] will have its `id` field set.
  Future<ProcessEvent> insertRow(
    _i1.DatabaseSession session,
    ProcessEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProcessEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProcessEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProcessEvent>> update(
    _i1.DatabaseSession session,
    List<ProcessEvent> rows, {
    _i1.ColumnSelections<ProcessEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProcessEvent>(
      rows,
      columns: columns?.call(ProcessEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProcessEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProcessEvent> updateRow(
    _i1.DatabaseSession session,
    ProcessEvent row, {
    _i1.ColumnSelections<ProcessEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProcessEvent>(
      row,
      columns: columns?.call(ProcessEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProcessEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProcessEvent?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProcessEventUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProcessEvent>(
      id,
      columnValues: columnValues(ProcessEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProcessEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProcessEvent>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProcessEventUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProcessEventTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProcessEventTable>? orderBy,
    _i1.OrderByListBuilder<ProcessEventTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProcessEvent>(
      columnValues: columnValues(ProcessEvent.t.updateTable),
      where: where(ProcessEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProcessEvent.t),
      orderByList: orderByList?.call(ProcessEvent.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProcessEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProcessEvent>> delete(
    _i1.DatabaseSession session,
    List<ProcessEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProcessEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProcessEvent].
  Future<ProcessEvent> deleteRow(
    _i1.DatabaseSession session,
    ProcessEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProcessEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProcessEvent>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProcessEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProcessEvent>(
      where: where(ProcessEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProcessEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProcessEvent>(
      where: where?.call(ProcessEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProcessEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProcessEventTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProcessEvent>(
      where: where(ProcessEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
