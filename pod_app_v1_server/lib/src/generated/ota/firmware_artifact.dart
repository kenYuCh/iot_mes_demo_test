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

/// 一個韌體 Release 內的實體產物；同版可含 HEX、BIN、DFU ZIP 與簽章。
abstract class FirmwareArtifact
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FirmwareArtifact._({
    this.id,
    required this.companyId,
    required this.firmwarePackageId,
    required this.fileName,
    required this.fileType,
    this.core,
    required this.storagePath,
    required this.sha256,
    required this.sizeBytes,
    required this.isPrimary,
    required this.createdAt,
    this.deletedAt,
  });

  factory FirmwareArtifact({
    int? id,
    required int companyId,
    required int firmwarePackageId,
    required String fileName,
    required String fileType,
    String? core,
    required String storagePath,
    required String sha256,
    required int sizeBytes,
    required bool isPrimary,
    required DateTime createdAt,
    DateTime? deletedAt,
  }) = _FirmwareArtifactImpl;

  factory FirmwareArtifact.fromJson(Map<String, dynamic> jsonSerialization) {
    return FirmwareArtifact(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      firmwarePackageId: jsonSerialization['firmwarePackageId'] as int,
      fileName: jsonSerialization['fileName'] as String,
      fileType: jsonSerialization['fileType'] as String,
      core: jsonSerialization['core'] as String?,
      storagePath: jsonSerialization['storagePath'] as String,
      sha256: jsonSerialization['sha256'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      isPrimary: _i1.BoolJsonExtension.fromJson(jsonSerialization['isPrimary']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  static final t = FirmwareArtifactTable();

  static const db = FirmwareArtifactRepository._();

  @override
  int? id;

  int companyId;

  int firmwarePackageId;

  String fileName;

  String fileType;

  String? core;

  String storagePath;

  String sha256;

  int sizeBytes;

  bool isPrimary;

  DateTime createdAt;

  DateTime? deletedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FirmwareArtifact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FirmwareArtifact copyWith({
    int? id,
    int? companyId,
    int? firmwarePackageId,
    String? fileName,
    String? fileType,
    String? core,
    String? storagePath,
    String? sha256,
    int? sizeBytes,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FirmwareArtifact',
      if (id != null) 'id': id,
      'companyId': companyId,
      'firmwarePackageId': firmwarePackageId,
      'fileName': fileName,
      'fileType': fileType,
      if (core != null) 'core': core,
      'storagePath': storagePath,
      'sha256': sha256,
      'sizeBytes': sizeBytes,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FirmwareArtifact',
      if (id != null) 'id': id,
      'companyId': companyId,
      'firmwarePackageId': firmwarePackageId,
      'fileName': fileName,
      'fileType': fileType,
      if (core != null) 'core': core,
      'storagePath': storagePath,
      'sha256': sha256,
      'sizeBytes': sizeBytes,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  static FirmwareArtifactInclude include() {
    return FirmwareArtifactInclude._();
  }

  static FirmwareArtifactIncludeList includeList({
    _i1.WhereExpressionBuilder<FirmwareArtifactTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FirmwareArtifactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FirmwareArtifactTable>? orderByList,
    FirmwareArtifactInclude? include,
  }) {
    return FirmwareArtifactIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FirmwareArtifact.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FirmwareArtifact.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FirmwareArtifactImpl extends FirmwareArtifact {
  _FirmwareArtifactImpl({
    int? id,
    required int companyId,
    required int firmwarePackageId,
    required String fileName,
    required String fileType,
    String? core,
    required String storagePath,
    required String sha256,
    required int sizeBytes,
    required bool isPrimary,
    required DateTime createdAt,
    DateTime? deletedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         firmwarePackageId: firmwarePackageId,
         fileName: fileName,
         fileType: fileType,
         core: core,
         storagePath: storagePath,
         sha256: sha256,
         sizeBytes: sizeBytes,
         isPrimary: isPrimary,
         createdAt: createdAt,
         deletedAt: deletedAt,
       );

  /// Returns a shallow copy of this [FirmwareArtifact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FirmwareArtifact copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? firmwarePackageId,
    String? fileName,
    String? fileType,
    Object? core = _Undefined,
    String? storagePath,
    String? sha256,
    int? sizeBytes,
    bool? isPrimary,
    DateTime? createdAt,
    Object? deletedAt = _Undefined,
  }) {
    return FirmwareArtifact(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      firmwarePackageId: firmwarePackageId ?? this.firmwarePackageId,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      core: core is String? ? core : this.core,
      storagePath: storagePath ?? this.storagePath,
      sha256: sha256 ?? this.sha256,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}

class FirmwareArtifactUpdateTable
    extends _i1.UpdateTable<FirmwareArtifactTable> {
  FirmwareArtifactUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> firmwarePackageId(int value) => _i1.ColumnValue(
    table.firmwarePackageId,
    value,
  );

  _i1.ColumnValue<String, String> fileName(String value) => _i1.ColumnValue(
    table.fileName,
    value,
  );

  _i1.ColumnValue<String, String> fileType(String value) => _i1.ColumnValue(
    table.fileType,
    value,
  );

  _i1.ColumnValue<String, String> core(String? value) => _i1.ColumnValue(
    table.core,
    value,
  );

  _i1.ColumnValue<String, String> storagePath(String value) => _i1.ColumnValue(
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

  _i1.ColumnValue<bool, bool> isPrimary(bool value) => _i1.ColumnValue(
    table.isPrimary,
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
}

class FirmwareArtifactTable extends _i1.Table<int?> {
  FirmwareArtifactTable({super.tableRelation})
    : super(tableName: 'firmware_artifact') {
    updateTable = FirmwareArtifactUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    firmwarePackageId = _i1.ColumnInt(
      'firmwarePackageId',
      this,
    );
    fileName = _i1.ColumnString(
      'fileName',
      this,
    );
    fileType = _i1.ColumnString(
      'fileType',
      this,
    );
    core = _i1.ColumnString(
      'core',
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
    isPrimary = _i1.ColumnBool(
      'isPrimary',
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
  }

  late final FirmwareArtifactUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt firmwarePackageId;

  late final _i1.ColumnString fileName;

  late final _i1.ColumnString fileType;

  late final _i1.ColumnString core;

  late final _i1.ColumnString storagePath;

  late final _i1.ColumnString sha256;

  late final _i1.ColumnInt sizeBytes;

  late final _i1.ColumnBool isPrimary;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime deletedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    firmwarePackageId,
    fileName,
    fileType,
    core,
    storagePath,
    sha256,
    sizeBytes,
    isPrimary,
    createdAt,
    deletedAt,
  ];
}

class FirmwareArtifactInclude extends _i1.IncludeObject {
  FirmwareArtifactInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FirmwareArtifact.t;
}

class FirmwareArtifactIncludeList extends _i1.IncludeList {
  FirmwareArtifactIncludeList._({
    _i1.WhereExpressionBuilder<FirmwareArtifactTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FirmwareArtifact.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FirmwareArtifact.t;
}

class FirmwareArtifactRepository {
  const FirmwareArtifactRepository._();

  /// Returns a list of [FirmwareArtifact]s matching the given query parameters.
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
  Future<List<FirmwareArtifact>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FirmwareArtifactTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FirmwareArtifactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FirmwareArtifactTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FirmwareArtifact>(
      where: where?.call(FirmwareArtifact.t),
      orderBy: orderBy?.call(FirmwareArtifact.t),
      orderByList: orderByList?.call(FirmwareArtifact.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FirmwareArtifact] matching the given query parameters.
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
  Future<FirmwareArtifact?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FirmwareArtifactTable>? where,
    int? offset,
    _i1.OrderByBuilder<FirmwareArtifactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FirmwareArtifactTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FirmwareArtifact>(
      where: where?.call(FirmwareArtifact.t),
      orderBy: orderBy?.call(FirmwareArtifact.t),
      orderByList: orderByList?.call(FirmwareArtifact.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FirmwareArtifact] by its [id] or null if no such row exists.
  Future<FirmwareArtifact?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FirmwareArtifact>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FirmwareArtifact]s in the list and returns the inserted rows.
  ///
  /// The returned [FirmwareArtifact]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FirmwareArtifact>> insert(
    _i1.DatabaseSession session,
    List<FirmwareArtifact> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FirmwareArtifact>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FirmwareArtifact] and returns the inserted row.
  ///
  /// The returned [FirmwareArtifact] will have its `id` field set.
  Future<FirmwareArtifact> insertRow(
    _i1.DatabaseSession session,
    FirmwareArtifact row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FirmwareArtifact>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FirmwareArtifact]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FirmwareArtifact>> update(
    _i1.DatabaseSession session,
    List<FirmwareArtifact> rows, {
    _i1.ColumnSelections<FirmwareArtifactTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FirmwareArtifact>(
      rows,
      columns: columns?.call(FirmwareArtifact.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FirmwareArtifact]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FirmwareArtifact> updateRow(
    _i1.DatabaseSession session,
    FirmwareArtifact row, {
    _i1.ColumnSelections<FirmwareArtifactTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FirmwareArtifact>(
      row,
      columns: columns?.call(FirmwareArtifact.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FirmwareArtifact] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FirmwareArtifact?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FirmwareArtifactUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FirmwareArtifact>(
      id,
      columnValues: columnValues(FirmwareArtifact.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FirmwareArtifact]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FirmwareArtifact>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FirmwareArtifactUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<FirmwareArtifactTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FirmwareArtifactTable>? orderBy,
    _i1.OrderByListBuilder<FirmwareArtifactTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FirmwareArtifact>(
      columnValues: columnValues(FirmwareArtifact.t.updateTable),
      where: where(FirmwareArtifact.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FirmwareArtifact.t),
      orderByList: orderByList?.call(FirmwareArtifact.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FirmwareArtifact]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FirmwareArtifact>> delete(
    _i1.DatabaseSession session,
    List<FirmwareArtifact> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FirmwareArtifact>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FirmwareArtifact].
  Future<FirmwareArtifact> deleteRow(
    _i1.DatabaseSession session,
    FirmwareArtifact row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FirmwareArtifact>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FirmwareArtifact>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FirmwareArtifactTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FirmwareArtifact>(
      where: where(FirmwareArtifact.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FirmwareArtifactTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FirmwareArtifact>(
      where: where?.call(FirmwareArtifact.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FirmwareArtifact] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FirmwareArtifactTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FirmwareArtifact>(
      where: where(FirmwareArtifact.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
