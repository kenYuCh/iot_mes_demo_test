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
import '../provisioning/provisioning_state.dart' as _i2;

/// 出廠設備登錄（Device Registry，手冊 §13）。
/// 公司出廠設備登錄。配對資格以公司 CA 簽發的 Factory Certificate 為準。
abstract class ProvisionedDevice
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProvisionedDevice._({
    this.id,
    required this.serial,
    required this.model,
    required this.claimCodeHash,
    this.manufacturerVerified,
    this.factoryCertificateFingerprint,
    this.manufacturerVerifiedAt,
    required this.state,
    this.companyId,
    this.claimedBy,
    this.claimedAt,
    this.linkedGatewayId,
    this.linkedDeviceId,
    required this.createdAt,
  });

  factory ProvisionedDevice({
    int? id,
    required String serial,
    required String model,
    required String claimCodeHash,
    bool? manufacturerVerified,
    String? factoryCertificateFingerprint,
    DateTime? manufacturerVerifiedAt,
    required _i2.ProvisioningState state,
    int? companyId,
    String? claimedBy,
    DateTime? claimedAt,
    int? linkedGatewayId,
    int? linkedDeviceId,
    required DateTime createdAt,
  }) = _ProvisionedDeviceImpl;

  factory ProvisionedDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProvisionedDevice(
      id: jsonSerialization['id'] as int?,
      serial: jsonSerialization['serial'] as String,
      model: jsonSerialization['model'] as String,
      claimCodeHash: jsonSerialization['claimCodeHash'] as String,
      manufacturerVerified: jsonSerialization['manufacturerVerified'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['manufacturerVerified'],
            ),
      factoryCertificateFingerprint:
          jsonSerialization['factoryCertificateFingerprint'] as String?,
      manufacturerVerifiedAt:
          jsonSerialization['manufacturerVerifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['manufacturerVerifiedAt'],
            ),
      state: _i2.ProvisioningState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      companyId: jsonSerialization['companyId'] as int?,
      claimedBy: jsonSerialization['claimedBy'] as String?,
      claimedAt: jsonSerialization['claimedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['claimedAt']),
      linkedGatewayId: jsonSerialization['linkedGatewayId'] as int?,
      linkedDeviceId: jsonSerialization['linkedDeviceId'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ProvisionedDeviceTable();

  static const db = ProvisionedDeviceRepository._();

  @override
  int? id;

  /// 設備序號（QR Code 內容之一），全域唯一。
  String serial;

  String model;

  /// 舊版 Claim Code 雜湊；新配對流程不再使用，保留以相容既有資料。
  String claimCodeHash;

  /// 是否已通過公司 Factory CA 憑證鏈與 CN 驗證。
  bool? manufacturerVerified;

  /// Factory Certificate SHA-256 指紋，用於稽核與防止憑證替換。
  String? factoryCertificateFingerprint;

  DateTime? manufacturerVerifiedAt;

  _i2.ProvisioningState state;

  /// 綁定後所屬公司。
  int? companyId;

  /// 完成綁定的使用者。
  String? claimedBy;

  DateTime? claimedAt;

  /// 加入設備庫後的平台關聯（GW 型號 → Gateway；感測器 → Device）。
  int? linkedGatewayId;

  int? linkedDeviceId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProvisionedDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProvisionedDevice copyWith({
    int? id,
    String? serial,
    String? model,
    String? claimCodeHash,
    bool? manufacturerVerified,
    String? factoryCertificateFingerprint,
    DateTime? manufacturerVerifiedAt,
    _i2.ProvisioningState? state,
    int? companyId,
    String? claimedBy,
    DateTime? claimedAt,
    int? linkedGatewayId,
    int? linkedDeviceId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProvisionedDevice',
      if (id != null) 'id': id,
      'serial': serial,
      'model': model,
      'claimCodeHash': claimCodeHash,
      if (manufacturerVerified != null)
        'manufacturerVerified': manufacturerVerified,
      if (factoryCertificateFingerprint != null)
        'factoryCertificateFingerprint': factoryCertificateFingerprint,
      if (manufacturerVerifiedAt != null)
        'manufacturerVerifiedAt': manufacturerVerifiedAt?.toJson(),
      'state': state.toJson(),
      if (companyId != null) 'companyId': companyId,
      if (claimedBy != null) 'claimedBy': claimedBy,
      if (claimedAt != null) 'claimedAt': claimedAt?.toJson(),
      if (linkedGatewayId != null) 'linkedGatewayId': linkedGatewayId,
      if (linkedDeviceId != null) 'linkedDeviceId': linkedDeviceId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProvisionedDevice',
      if (id != null) 'id': id,
      'serial': serial,
      'model': model,
      'claimCodeHash': claimCodeHash,
      if (manufacturerVerified != null)
        'manufacturerVerified': manufacturerVerified,
      if (factoryCertificateFingerprint != null)
        'factoryCertificateFingerprint': factoryCertificateFingerprint,
      if (manufacturerVerifiedAt != null)
        'manufacturerVerifiedAt': manufacturerVerifiedAt?.toJson(),
      'state': state.toJson(),
      if (companyId != null) 'companyId': companyId,
      if (claimedBy != null) 'claimedBy': claimedBy,
      if (claimedAt != null) 'claimedAt': claimedAt?.toJson(),
      if (linkedGatewayId != null) 'linkedGatewayId': linkedGatewayId,
      if (linkedDeviceId != null) 'linkedDeviceId': linkedDeviceId,
      'createdAt': createdAt.toJson(),
    };
  }

  static ProvisionedDeviceInclude include() {
    return ProvisionedDeviceInclude._();
  }

  static ProvisionedDeviceIncludeList includeList({
    _i1.WhereExpressionBuilder<ProvisionedDeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProvisionedDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProvisionedDeviceTable>? orderByList,
    ProvisionedDeviceInclude? include,
  }) {
    return ProvisionedDeviceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProvisionedDevice.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProvisionedDevice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProvisionedDeviceImpl extends ProvisionedDevice {
  _ProvisionedDeviceImpl({
    int? id,
    required String serial,
    required String model,
    required String claimCodeHash,
    bool? manufacturerVerified,
    String? factoryCertificateFingerprint,
    DateTime? manufacturerVerifiedAt,
    required _i2.ProvisioningState state,
    int? companyId,
    String? claimedBy,
    DateTime? claimedAt,
    int? linkedGatewayId,
    int? linkedDeviceId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         serial: serial,
         model: model,
         claimCodeHash: claimCodeHash,
         manufacturerVerified: manufacturerVerified,
         factoryCertificateFingerprint: factoryCertificateFingerprint,
         manufacturerVerifiedAt: manufacturerVerifiedAt,
         state: state,
         companyId: companyId,
         claimedBy: claimedBy,
         claimedAt: claimedAt,
         linkedGatewayId: linkedGatewayId,
         linkedDeviceId: linkedDeviceId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ProvisionedDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProvisionedDevice copyWith({
    Object? id = _Undefined,
    String? serial,
    String? model,
    String? claimCodeHash,
    Object? manufacturerVerified = _Undefined,
    Object? factoryCertificateFingerprint = _Undefined,
    Object? manufacturerVerifiedAt = _Undefined,
    _i2.ProvisioningState? state,
    Object? companyId = _Undefined,
    Object? claimedBy = _Undefined,
    Object? claimedAt = _Undefined,
    Object? linkedGatewayId = _Undefined,
    Object? linkedDeviceId = _Undefined,
    DateTime? createdAt,
  }) {
    return ProvisionedDevice(
      id: id is int? ? id : this.id,
      serial: serial ?? this.serial,
      model: model ?? this.model,
      claimCodeHash: claimCodeHash ?? this.claimCodeHash,
      manufacturerVerified: manufacturerVerified is bool?
          ? manufacturerVerified
          : this.manufacturerVerified,
      factoryCertificateFingerprint: factoryCertificateFingerprint is String?
          ? factoryCertificateFingerprint
          : this.factoryCertificateFingerprint,
      manufacturerVerifiedAt: manufacturerVerifiedAt is DateTime?
          ? manufacturerVerifiedAt
          : this.manufacturerVerifiedAt,
      state: state ?? this.state,
      companyId: companyId is int? ? companyId : this.companyId,
      claimedBy: claimedBy is String? ? claimedBy : this.claimedBy,
      claimedAt: claimedAt is DateTime? ? claimedAt : this.claimedAt,
      linkedGatewayId: linkedGatewayId is int?
          ? linkedGatewayId
          : this.linkedGatewayId,
      linkedDeviceId: linkedDeviceId is int?
          ? linkedDeviceId
          : this.linkedDeviceId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ProvisionedDeviceUpdateTable
    extends _i1.UpdateTable<ProvisionedDeviceTable> {
  ProvisionedDeviceUpdateTable(super.table);

  _i1.ColumnValue<String, String> serial(String value) => _i1.ColumnValue(
    table.serial,
    value,
  );

  _i1.ColumnValue<String, String> model(String value) => _i1.ColumnValue(
    table.model,
    value,
  );

  _i1.ColumnValue<String, String> claimCodeHash(String value) =>
      _i1.ColumnValue(
        table.claimCodeHash,
        value,
      );

  _i1.ColumnValue<bool, bool> manufacturerVerified(bool? value) =>
      _i1.ColumnValue(
        table.manufacturerVerified,
        value,
      );

  _i1.ColumnValue<String, String> factoryCertificateFingerprint(
    String? value,
  ) => _i1.ColumnValue(
    table.factoryCertificateFingerprint,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> manufacturerVerifiedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.manufacturerVerifiedAt,
        value,
      );

  _i1.ColumnValue<_i2.ProvisioningState, _i2.ProvisioningState> state(
    _i2.ProvisioningState value,
  ) => _i1.ColumnValue(
    table.state,
    value,
  );

  _i1.ColumnValue<int, int> companyId(int? value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> claimedBy(String? value) => _i1.ColumnValue(
    table.claimedBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> claimedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.claimedAt,
        value,
      );

  _i1.ColumnValue<int, int> linkedGatewayId(int? value) => _i1.ColumnValue(
    table.linkedGatewayId,
    value,
  );

  _i1.ColumnValue<int, int> linkedDeviceId(int? value) => _i1.ColumnValue(
    table.linkedDeviceId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ProvisionedDeviceTable extends _i1.Table<int?> {
  ProvisionedDeviceTable({super.tableRelation})
    : super(tableName: 'provisioned_device') {
    updateTable = ProvisionedDeviceUpdateTable(this);
    serial = _i1.ColumnString(
      'serial',
      this,
    );
    model = _i1.ColumnString(
      'model',
      this,
    );
    claimCodeHash = _i1.ColumnString(
      'claimCodeHash',
      this,
    );
    manufacturerVerified = _i1.ColumnBool(
      'manufacturerVerified',
      this,
    );
    factoryCertificateFingerprint = _i1.ColumnString(
      'factoryCertificateFingerprint',
      this,
    );
    manufacturerVerifiedAt = _i1.ColumnDateTime(
      'manufacturerVerifiedAt',
      this,
    );
    state = _i1.ColumnEnum(
      'state',
      this,
      _i1.EnumSerialization.byName,
    );
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    claimedBy = _i1.ColumnString(
      'claimedBy',
      this,
    );
    claimedAt = _i1.ColumnDateTime(
      'claimedAt',
      this,
    );
    linkedGatewayId = _i1.ColumnInt(
      'linkedGatewayId',
      this,
    );
    linkedDeviceId = _i1.ColumnInt(
      'linkedDeviceId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ProvisionedDeviceUpdateTable updateTable;

  /// 設備序號（QR Code 內容之一），全域唯一。
  late final _i1.ColumnString serial;

  late final _i1.ColumnString model;

  /// 舊版 Claim Code 雜湊；新配對流程不再使用，保留以相容既有資料。
  late final _i1.ColumnString claimCodeHash;

  /// 是否已通過公司 Factory CA 憑證鏈與 CN 驗證。
  late final _i1.ColumnBool manufacturerVerified;

  /// Factory Certificate SHA-256 指紋，用於稽核與防止憑證替換。
  late final _i1.ColumnString factoryCertificateFingerprint;

  late final _i1.ColumnDateTime manufacturerVerifiedAt;

  late final _i1.ColumnEnum<_i2.ProvisioningState> state;

  /// 綁定後所屬公司。
  late final _i1.ColumnInt companyId;

  /// 完成綁定的使用者。
  late final _i1.ColumnString claimedBy;

  late final _i1.ColumnDateTime claimedAt;

  /// 加入設備庫後的平台關聯（GW 型號 → Gateway；感測器 → Device）。
  late final _i1.ColumnInt linkedGatewayId;

  late final _i1.ColumnInt linkedDeviceId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    serial,
    model,
    claimCodeHash,
    manufacturerVerified,
    factoryCertificateFingerprint,
    manufacturerVerifiedAt,
    state,
    companyId,
    claimedBy,
    claimedAt,
    linkedGatewayId,
    linkedDeviceId,
    createdAt,
  ];
}

class ProvisionedDeviceInclude extends _i1.IncludeObject {
  ProvisionedDeviceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProvisionedDevice.t;
}

class ProvisionedDeviceIncludeList extends _i1.IncludeList {
  ProvisionedDeviceIncludeList._({
    _i1.WhereExpressionBuilder<ProvisionedDeviceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProvisionedDevice.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProvisionedDevice.t;
}

class ProvisionedDeviceRepository {
  const ProvisionedDeviceRepository._();

  /// Returns a list of [ProvisionedDevice]s matching the given query parameters.
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
  Future<List<ProvisionedDevice>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProvisionedDeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProvisionedDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProvisionedDeviceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProvisionedDevice>(
      where: where?.call(ProvisionedDevice.t),
      orderBy: orderBy?.call(ProvisionedDevice.t),
      orderByList: orderByList?.call(ProvisionedDevice.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProvisionedDevice] matching the given query parameters.
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
  Future<ProvisionedDevice?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProvisionedDeviceTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProvisionedDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProvisionedDeviceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProvisionedDevice>(
      where: where?.call(ProvisionedDevice.t),
      orderBy: orderBy?.call(ProvisionedDevice.t),
      orderByList: orderByList?.call(ProvisionedDevice.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProvisionedDevice] by its [id] or null if no such row exists.
  Future<ProvisionedDevice?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProvisionedDevice>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProvisionedDevice]s in the list and returns the inserted rows.
  ///
  /// The returned [ProvisionedDevice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProvisionedDevice>> insert(
    _i1.DatabaseSession session,
    List<ProvisionedDevice> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProvisionedDevice>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProvisionedDevice] and returns the inserted row.
  ///
  /// The returned [ProvisionedDevice] will have its `id` field set.
  Future<ProvisionedDevice> insertRow(
    _i1.DatabaseSession session,
    ProvisionedDevice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProvisionedDevice>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProvisionedDevice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProvisionedDevice>> update(
    _i1.DatabaseSession session,
    List<ProvisionedDevice> rows, {
    _i1.ColumnSelections<ProvisionedDeviceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProvisionedDevice>(
      rows,
      columns: columns?.call(ProvisionedDevice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProvisionedDevice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProvisionedDevice> updateRow(
    _i1.DatabaseSession session,
    ProvisionedDevice row, {
    _i1.ColumnSelections<ProvisionedDeviceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProvisionedDevice>(
      row,
      columns: columns?.call(ProvisionedDevice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProvisionedDevice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProvisionedDevice?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProvisionedDeviceUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProvisionedDevice>(
      id,
      columnValues: columnValues(ProvisionedDevice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProvisionedDevice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProvisionedDevice>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProvisionedDeviceUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ProvisionedDeviceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProvisionedDeviceTable>? orderBy,
    _i1.OrderByListBuilder<ProvisionedDeviceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProvisionedDevice>(
      columnValues: columnValues(ProvisionedDevice.t.updateTable),
      where: where(ProvisionedDevice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProvisionedDevice.t),
      orderByList: orderByList?.call(ProvisionedDevice.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProvisionedDevice]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProvisionedDevice>> delete(
    _i1.DatabaseSession session,
    List<ProvisionedDevice> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProvisionedDevice>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProvisionedDevice].
  Future<ProvisionedDevice> deleteRow(
    _i1.DatabaseSession session,
    ProvisionedDevice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProvisionedDevice>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProvisionedDevice>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProvisionedDeviceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProvisionedDevice>(
      where: where(ProvisionedDevice.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProvisionedDeviceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProvisionedDevice>(
      where: where?.call(ProvisionedDevice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProvisionedDevice] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProvisionedDeviceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProvisionedDevice>(
      where: where(ProvisionedDevice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
