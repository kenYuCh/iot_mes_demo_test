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
import '../ota/firmware_package_state.dart' as _i2;

/// 經簽章與雜湊驗證的 OTA 韌體套件 Metadata。
abstract class FirmwarePackage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FirmwarePackage._({
    this.id,
    required this.companyId,
    required this.name,
    required this.version,
    required this.targetDeviceType,
    this.productKey,
    this.chipFamily,
    this.updateProtocol,
    this.hardwareRevision,
    this.releaseNotes,
    required this.downloadUrl,
    this.fileName,
    this.storagePath,
    required this.sha256,
    required this.sizeBytes,
    required this.state,
    required this.createdBy,
    required this.createdAt,
    this.deletedAt,
    this.deletedBy,
  });

  factory FirmwarePackage({
    int? id,
    required int companyId,
    required String name,
    required String version,
    required String targetDeviceType,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? releaseNotes,
    required String downloadUrl,
    String? fileName,
    String? storagePath,
    required String sha256,
    required int sizeBytes,
    required _i2.FirmwarePackageState state,
    required String createdBy,
    required DateTime createdAt,
    DateTime? deletedAt,
    String? deletedBy,
  }) = _FirmwarePackageImpl;

  factory FirmwarePackage.fromJson(Map<String, dynamic> jsonSerialization) {
    return FirmwarePackage(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      name: jsonSerialization['name'] as String,
      version: jsonSerialization['version'] as String,
      targetDeviceType: jsonSerialization['targetDeviceType'] as String,
      productKey: jsonSerialization['productKey'] as String?,
      chipFamily: jsonSerialization['chipFamily'] as String?,
      updateProtocol: jsonSerialization['updateProtocol'] as String?,
      hardwareRevision: jsonSerialization['hardwareRevision'] as String?,
      releaseNotes: jsonSerialization['releaseNotes'] as String?,
      downloadUrl: jsonSerialization['downloadUrl'] as String,
      fileName: jsonSerialization['fileName'] as String?,
      storagePath: jsonSerialization['storagePath'] as String?,
      sha256: jsonSerialization['sha256'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      state: _i2.FirmwarePackageState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
      deletedBy: jsonSerialization['deletedBy'] as String?,
    );
  }

  static final t = FirmwarePackageTable();

  static const db = FirmwarePackageRepository._();

  @override
  int? id;

  int companyId;

  String name;

  String version;

  String targetDeviceType;

  /// 產品族、MCU 與更新協定，例如 gateway / nrf52840 / mcuboot。
  String? productKey;

  String? chipFamily;

  String? updateProtocol;

  String? hardwareRevision;

  String? releaseNotes;

  String downloadUrl;

  /// Server 韌體資產目錄內的原始 .bin 檔名與絕對路徑。
  String? fileName;

  String? storagePath;

  String sha256;

  int sizeBytes;

  _i2.FirmwarePackageState state;

  String createdBy;

  DateTime createdAt;

  DateTime? deletedAt;

  String? deletedBy;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FirmwarePackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FirmwarePackage copyWith({
    int? id,
    int? companyId,
    String? name,
    String? version,
    String? targetDeviceType,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? releaseNotes,
    String? downloadUrl,
    String? fileName,
    String? storagePath,
    String? sha256,
    int? sizeBytes,
    _i2.FirmwarePackageState? state,
    String? createdBy,
    DateTime? createdAt,
    DateTime? deletedAt,
    String? deletedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FirmwarePackage',
      if (id != null) 'id': id,
      'companyId': companyId,
      'name': name,
      'version': version,
      'targetDeviceType': targetDeviceType,
      if (productKey != null) 'productKey': productKey,
      if (chipFamily != null) 'chipFamily': chipFamily,
      if (updateProtocol != null) 'updateProtocol': updateProtocol,
      if (hardwareRevision != null) 'hardwareRevision': hardwareRevision,
      if (releaseNotes != null) 'releaseNotes': releaseNotes,
      'downloadUrl': downloadUrl,
      if (fileName != null) 'fileName': fileName,
      if (storagePath != null) 'storagePath': storagePath,
      'sha256': sha256,
      'sizeBytes': sizeBytes,
      'state': state.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      if (deletedBy != null) 'deletedBy': deletedBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FirmwarePackage',
      if (id != null) 'id': id,
      'companyId': companyId,
      'name': name,
      'version': version,
      'targetDeviceType': targetDeviceType,
      if (productKey != null) 'productKey': productKey,
      if (chipFamily != null) 'chipFamily': chipFamily,
      if (updateProtocol != null) 'updateProtocol': updateProtocol,
      if (hardwareRevision != null) 'hardwareRevision': hardwareRevision,
      if (releaseNotes != null) 'releaseNotes': releaseNotes,
      'downloadUrl': downloadUrl,
      if (fileName != null) 'fileName': fileName,
      if (storagePath != null) 'storagePath': storagePath,
      'sha256': sha256,
      'sizeBytes': sizeBytes,
      'state': state.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      if (deletedBy != null) 'deletedBy': deletedBy,
    };
  }

  static FirmwarePackageInclude include() {
    return FirmwarePackageInclude._();
  }

  static FirmwarePackageIncludeList includeList({
    _i1.WhereExpressionBuilder<FirmwarePackageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FirmwarePackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FirmwarePackageTable>? orderByList,
    FirmwarePackageInclude? include,
  }) {
    return FirmwarePackageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FirmwarePackage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FirmwarePackage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FirmwarePackageImpl extends FirmwarePackage {
  _FirmwarePackageImpl({
    int? id,
    required int companyId,
    required String name,
    required String version,
    required String targetDeviceType,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? releaseNotes,
    required String downloadUrl,
    String? fileName,
    String? storagePath,
    required String sha256,
    required int sizeBytes,
    required _i2.FirmwarePackageState state,
    required String createdBy,
    required DateTime createdAt,
    DateTime? deletedAt,
    String? deletedBy,
  }) : super._(
         id: id,
         companyId: companyId,
         name: name,
         version: version,
         targetDeviceType: targetDeviceType,
         productKey: productKey,
         chipFamily: chipFamily,
         updateProtocol: updateProtocol,
         hardwareRevision: hardwareRevision,
         releaseNotes: releaseNotes,
         downloadUrl: downloadUrl,
         fileName: fileName,
         storagePath: storagePath,
         sha256: sha256,
         sizeBytes: sizeBytes,
         state: state,
         createdBy: createdBy,
         createdAt: createdAt,
         deletedAt: deletedAt,
         deletedBy: deletedBy,
       );

  /// Returns a shallow copy of this [FirmwarePackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FirmwarePackage copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? name,
    String? version,
    String? targetDeviceType,
    Object? productKey = _Undefined,
    Object? chipFamily = _Undefined,
    Object? updateProtocol = _Undefined,
    Object? hardwareRevision = _Undefined,
    Object? releaseNotes = _Undefined,
    String? downloadUrl,
    Object? fileName = _Undefined,
    Object? storagePath = _Undefined,
    String? sha256,
    int? sizeBytes,
    _i2.FirmwarePackageState? state,
    String? createdBy,
    DateTime? createdAt,
    Object? deletedAt = _Undefined,
    Object? deletedBy = _Undefined,
  }) {
    return FirmwarePackage(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      version: version ?? this.version,
      targetDeviceType: targetDeviceType ?? this.targetDeviceType,
      productKey: productKey is String? ? productKey : this.productKey,
      chipFamily: chipFamily is String? ? chipFamily : this.chipFamily,
      updateProtocol: updateProtocol is String?
          ? updateProtocol
          : this.updateProtocol,
      hardwareRevision: hardwareRevision is String?
          ? hardwareRevision
          : this.hardwareRevision,
      releaseNotes: releaseNotes is String? ? releaseNotes : this.releaseNotes,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      fileName: fileName is String? ? fileName : this.fileName,
      storagePath: storagePath is String? ? storagePath : this.storagePath,
      sha256: sha256 ?? this.sha256,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      state: state ?? this.state,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
      deletedBy: deletedBy is String? ? deletedBy : this.deletedBy,
    );
  }
}

class FirmwarePackageUpdateTable extends _i1.UpdateTable<FirmwarePackageTable> {
  FirmwarePackageUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> version(String value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<String, String> targetDeviceType(String value) =>
      _i1.ColumnValue(
        table.targetDeviceType,
        value,
      );

  _i1.ColumnValue<String, String> productKey(String? value) => _i1.ColumnValue(
    table.productKey,
    value,
  );

  _i1.ColumnValue<String, String> chipFamily(String? value) => _i1.ColumnValue(
    table.chipFamily,
    value,
  );

  _i1.ColumnValue<String, String> updateProtocol(String? value) =>
      _i1.ColumnValue(
        table.updateProtocol,
        value,
      );

  _i1.ColumnValue<String, String> hardwareRevision(String? value) =>
      _i1.ColumnValue(
        table.hardwareRevision,
        value,
      );

  _i1.ColumnValue<String, String> releaseNotes(String? value) =>
      _i1.ColumnValue(
        table.releaseNotes,
        value,
      );

  _i1.ColumnValue<String, String> downloadUrl(String value) => _i1.ColumnValue(
    table.downloadUrl,
    value,
  );

  _i1.ColumnValue<String, String> fileName(String? value) => _i1.ColumnValue(
    table.fileName,
    value,
  );

  _i1.ColumnValue<String, String> storagePath(String? value) => _i1.ColumnValue(
    table.storagePath,
    value,
  );

  _i1.ColumnValue<String, String> sha256(String value) => _i1.ColumnValue(
    table.sha256,
    value,
  );

  _i1.ColumnValue<int, int> sizeBytes(int value) => _i1.ColumnValue(
    table.sizeBytes,
    value,
  );

  _i1.ColumnValue<_i2.FirmwarePackageState, _i2.FirmwarePackageState> state(
    _i2.FirmwarePackageState value,
  ) => _i1.ColumnValue(
    table.state,
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

  _i1.ColumnValue<DateTime, DateTime> deletedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.deletedAt,
        value,
      );

  _i1.ColumnValue<String, String> deletedBy(String? value) => _i1.ColumnValue(
    table.deletedBy,
    value,
  );
}

class FirmwarePackageTable extends _i1.Table<int?> {
  FirmwarePackageTable({super.tableRelation})
    : super(tableName: 'firmware_package') {
    updateTable = FirmwarePackageUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    version = _i1.ColumnString(
      'version',
      this,
    );
    targetDeviceType = _i1.ColumnString(
      'targetDeviceType',
      this,
    );
    productKey = _i1.ColumnString(
      'productKey',
      this,
    );
    chipFamily = _i1.ColumnString(
      'chipFamily',
      this,
    );
    updateProtocol = _i1.ColumnString(
      'updateProtocol',
      this,
    );
    hardwareRevision = _i1.ColumnString(
      'hardwareRevision',
      this,
    );
    releaseNotes = _i1.ColumnString(
      'releaseNotes',
      this,
    );
    downloadUrl = _i1.ColumnString(
      'downloadUrl',
      this,
    );
    fileName = _i1.ColumnString(
      'fileName',
      this,
    );
    storagePath = _i1.ColumnString(
      'storagePath',
      this,
    );
    sha256 = _i1.ColumnString(
      'sha256',
      this,
    );
    sizeBytes = _i1.ColumnInt(
      'sizeBytes',
      this,
    );
    state = _i1.ColumnEnum(
      'state',
      this,
      _i1.EnumSerialization.byName,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    deletedAt = _i1.ColumnDateTime(
      'deletedAt',
      this,
    );
    deletedBy = _i1.ColumnString(
      'deletedBy',
      this,
    );
  }

  late final FirmwarePackageUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString version;

  late final _i1.ColumnString targetDeviceType;

  /// 產品族、MCU 與更新協定，例如 gateway / nrf52840 / mcuboot。
  late final _i1.ColumnString productKey;

  late final _i1.ColumnString chipFamily;

  late final _i1.ColumnString updateProtocol;

  late final _i1.ColumnString hardwareRevision;

  late final _i1.ColumnString releaseNotes;

  late final _i1.ColumnString downloadUrl;

  /// Server 韌體資產目錄內的原始 .bin 檔名與絕對路徑。
  late final _i1.ColumnString fileName;

  late final _i1.ColumnString storagePath;

  late final _i1.ColumnString sha256;

  late final _i1.ColumnInt sizeBytes;

  late final _i1.ColumnEnum<_i2.FirmwarePackageState> state;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime deletedAt;

  late final _i1.ColumnString deletedBy;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    name,
    version,
    targetDeviceType,
    productKey,
    chipFamily,
    updateProtocol,
    hardwareRevision,
    releaseNotes,
    downloadUrl,
    fileName,
    storagePath,
    sha256,
    sizeBytes,
    state,
    createdBy,
    createdAt,
    deletedAt,
    deletedBy,
  ];
}

class FirmwarePackageInclude extends _i1.IncludeObject {
  FirmwarePackageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FirmwarePackage.t;
}

class FirmwarePackageIncludeList extends _i1.IncludeList {
  FirmwarePackageIncludeList._({
    _i1.WhereExpressionBuilder<FirmwarePackageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FirmwarePackage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FirmwarePackage.t;
}

class FirmwarePackageRepository {
  const FirmwarePackageRepository._();

  /// Returns a list of [FirmwarePackage]s matching the given query parameters.
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
  Future<List<FirmwarePackage>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FirmwarePackageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FirmwarePackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FirmwarePackageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FirmwarePackage>(
      where: where?.call(FirmwarePackage.t),
      orderBy: orderBy?.call(FirmwarePackage.t),
      orderByList: orderByList?.call(FirmwarePackage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FirmwarePackage] matching the given query parameters.
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
  Future<FirmwarePackage?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FirmwarePackageTable>? where,
    int? offset,
    _i1.OrderByBuilder<FirmwarePackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FirmwarePackageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FirmwarePackage>(
      where: where?.call(FirmwarePackage.t),
      orderBy: orderBy?.call(FirmwarePackage.t),
      orderByList: orderByList?.call(FirmwarePackage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FirmwarePackage] by its [id] or null if no such row exists.
  Future<FirmwarePackage?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FirmwarePackage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FirmwarePackage]s in the list and returns the inserted rows.
  ///
  /// The returned [FirmwarePackage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FirmwarePackage>> insert(
    _i1.DatabaseSession session,
    List<FirmwarePackage> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FirmwarePackage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FirmwarePackage] and returns the inserted row.
  ///
  /// The returned [FirmwarePackage] will have its `id` field set.
  Future<FirmwarePackage> insertRow(
    _i1.DatabaseSession session,
    FirmwarePackage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FirmwarePackage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FirmwarePackage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FirmwarePackage>> update(
    _i1.DatabaseSession session,
    List<FirmwarePackage> rows, {
    _i1.ColumnSelections<FirmwarePackageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FirmwarePackage>(
      rows,
      columns: columns?.call(FirmwarePackage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FirmwarePackage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FirmwarePackage> updateRow(
    _i1.DatabaseSession session,
    FirmwarePackage row, {
    _i1.ColumnSelections<FirmwarePackageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FirmwarePackage>(
      row,
      columns: columns?.call(FirmwarePackage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FirmwarePackage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FirmwarePackage?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FirmwarePackageUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FirmwarePackage>(
      id,
      columnValues: columnValues(FirmwarePackage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FirmwarePackage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FirmwarePackage>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FirmwarePackageUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<FirmwarePackageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FirmwarePackageTable>? orderBy,
    _i1.OrderByListBuilder<FirmwarePackageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FirmwarePackage>(
      columnValues: columnValues(FirmwarePackage.t.updateTable),
      where: where(FirmwarePackage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FirmwarePackage.t),
      orderByList: orderByList?.call(FirmwarePackage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FirmwarePackage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FirmwarePackage>> delete(
    _i1.DatabaseSession session,
    List<FirmwarePackage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FirmwarePackage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FirmwarePackage].
  Future<FirmwarePackage> deleteRow(
    _i1.DatabaseSession session,
    FirmwarePackage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FirmwarePackage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FirmwarePackage>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FirmwarePackageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FirmwarePackage>(
      where: where(FirmwarePackage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FirmwarePackageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FirmwarePackage>(
      where: where?.call(FirmwarePackage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FirmwarePackage] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FirmwarePackageTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FirmwarePackage>(
      where: where(FirmwarePackage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
