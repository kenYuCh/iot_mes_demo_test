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

/// 已簽發的設備憑證（手冊 §13）。憑證為公開資訊可入庫；
/// 私鑰永不落地（由設備自持，手冊 §2）。
abstract class DeviceCertificate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DeviceCertificate._({
    this.id,
    required this.serial,
    required this.certSerialNumber,
    required this.subjectCn,
    required this.certificatePem,
    required this.version,
    required this.issuedAt,
    required this.expiresAt,
    required this.revoked,
    this.revokedAt,
  });

  factory DeviceCertificate({
    int? id,
    required String serial,
    required String certSerialNumber,
    required String subjectCn,
    required String certificatePem,
    required int version,
    required DateTime issuedAt,
    required DateTime expiresAt,
    required bool revoked,
    DateTime? revokedAt,
  }) = _DeviceCertificateImpl;

  factory DeviceCertificate.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceCertificate(
      id: jsonSerialization['id'] as int?,
      serial: jsonSerialization['serial'] as String,
      certSerialNumber: jsonSerialization['certSerialNumber'] as String,
      subjectCn: jsonSerialization['subjectCn'] as String,
      certificatePem: jsonSerialization['certificatePem'] as String,
      version: jsonSerialization['version'] as int,
      issuedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['issuedAt'],
      ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      revoked: _i1.BoolJsonExtension.fromJson(jsonSerialization['revoked']),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
    );
  }

  static final t = DeviceCertificateTable();

  static const db = DeviceCertificateRepository._();

  @override
  int? id;

  String serial;

  /// 憑證序號（OpenSSL 簽發時的 serial number，hex）。
  String certSerialNumber;

  String subjectCn;

  /// 憑證 PEM（公開）。
  String certificatePem;

  int version;

  DateTime issuedAt;

  DateTime expiresAt;

  bool revoked;

  DateTime? revokedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DeviceCertificate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceCertificate copyWith({
    int? id,
    String? serial,
    String? certSerialNumber,
    String? subjectCn,
    String? certificatePem,
    int? version,
    DateTime? issuedAt,
    DateTime? expiresAt,
    bool? revoked,
    DateTime? revokedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceCertificate',
      if (id != null) 'id': id,
      'serial': serial,
      'certSerialNumber': certSerialNumber,
      'subjectCn': subjectCn,
      'certificatePem': certificatePem,
      'version': version,
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      'revoked': revoked,
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceCertificate',
      if (id != null) 'id': id,
      'serial': serial,
      'certSerialNumber': certSerialNumber,
      'subjectCn': subjectCn,
      'certificatePem': certificatePem,
      'version': version,
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      'revoked': revoked,
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
    };
  }

  static DeviceCertificateInclude include() {
    return DeviceCertificateInclude._();
  }

  static DeviceCertificateIncludeList includeList({
    _i1.WhereExpressionBuilder<DeviceCertificateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceCertificateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceCertificateTable>? orderByList,
    DeviceCertificateInclude? include,
  }) {
    return DeviceCertificateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceCertificate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DeviceCertificate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceCertificateImpl extends DeviceCertificate {
  _DeviceCertificateImpl({
    int? id,
    required String serial,
    required String certSerialNumber,
    required String subjectCn,
    required String certificatePem,
    required int version,
    required DateTime issuedAt,
    required DateTime expiresAt,
    required bool revoked,
    DateTime? revokedAt,
  }) : super._(
         id: id,
         serial: serial,
         certSerialNumber: certSerialNumber,
         subjectCn: subjectCn,
         certificatePem: certificatePem,
         version: version,
         issuedAt: issuedAt,
         expiresAt: expiresAt,
         revoked: revoked,
         revokedAt: revokedAt,
       );

  /// Returns a shallow copy of this [DeviceCertificate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceCertificate copyWith({
    Object? id = _Undefined,
    String? serial,
    String? certSerialNumber,
    String? subjectCn,
    String? certificatePem,
    int? version,
    DateTime? issuedAt,
    DateTime? expiresAt,
    bool? revoked,
    Object? revokedAt = _Undefined,
  }) {
    return DeviceCertificate(
      id: id is int? ? id : this.id,
      serial: serial ?? this.serial,
      certSerialNumber: certSerialNumber ?? this.certSerialNumber,
      subjectCn: subjectCn ?? this.subjectCn,
      certificatePem: certificatePem ?? this.certificatePem,
      version: version ?? this.version,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      revoked: revoked ?? this.revoked,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
    );
  }
}

class DeviceCertificateUpdateTable
    extends _i1.UpdateTable<DeviceCertificateTable> {
  DeviceCertificateUpdateTable(super.table);

  _i1.ColumnValue<String, String> serial(String value) => _i1.ColumnValue(
    table.serial,
    value,
  );

  _i1.ColumnValue<String, String> certSerialNumber(String value) =>
      _i1.ColumnValue(
        table.certSerialNumber,
        value,
      );

  _i1.ColumnValue<String, String> subjectCn(String value) => _i1.ColumnValue(
    table.subjectCn,
    value,
  );

  _i1.ColumnValue<String, String> certificatePem(String value) =>
      _i1.ColumnValue(
        table.certificatePem,
        value,
      );

  _i1.ColumnValue<int, int> version(int value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> issuedAt(DateTime value) =>
      _i1.ColumnValue(
        table.issuedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<bool, bool> revoked(bool value) => _i1.ColumnValue(
    table.revoked,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> revokedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.revokedAt,
        value,
      );
}

class DeviceCertificateTable extends _i1.Table<int?> {
  DeviceCertificateTable({super.tableRelation})
    : super(tableName: 'device_certificate') {
    updateTable = DeviceCertificateUpdateTable(this);
    serial = _i1.ColumnString(
      'serial',
      this,
    );
    certSerialNumber = _i1.ColumnString(
      'certSerialNumber',
      this,
    );
    subjectCn = _i1.ColumnString(
      'subjectCn',
      this,
    );
    certificatePem = _i1.ColumnString(
      'certificatePem',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    issuedAt = _i1.ColumnDateTime(
      'issuedAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    revoked = _i1.ColumnBool(
      'revoked',
      this,
    );
    revokedAt = _i1.ColumnDateTime(
      'revokedAt',
      this,
    );
  }

  late final DeviceCertificateUpdateTable updateTable;

  late final _i1.ColumnString serial;

  /// 憑證序號（OpenSSL 簽發時的 serial number，hex）。
  late final _i1.ColumnString certSerialNumber;

  late final _i1.ColumnString subjectCn;

  /// 憑證 PEM（公開）。
  late final _i1.ColumnString certificatePem;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime issuedAt;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnBool revoked;

  late final _i1.ColumnDateTime revokedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    serial,
    certSerialNumber,
    subjectCn,
    certificatePem,
    version,
    issuedAt,
    expiresAt,
    revoked,
    revokedAt,
  ];
}

class DeviceCertificateInclude extends _i1.IncludeObject {
  DeviceCertificateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DeviceCertificate.t;
}

class DeviceCertificateIncludeList extends _i1.IncludeList {
  DeviceCertificateIncludeList._({
    _i1.WhereExpressionBuilder<DeviceCertificateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DeviceCertificate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DeviceCertificate.t;
}

class DeviceCertificateRepository {
  const DeviceCertificateRepository._();

  /// Returns a list of [DeviceCertificate]s matching the given query parameters.
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
  Future<List<DeviceCertificate>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceCertificateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceCertificateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceCertificateTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DeviceCertificate>(
      where: where?.call(DeviceCertificate.t),
      orderBy: orderBy?.call(DeviceCertificate.t),
      orderByList: orderByList?.call(DeviceCertificate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DeviceCertificate] matching the given query parameters.
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
  Future<DeviceCertificate?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceCertificateTable>? where,
    int? offset,
    _i1.OrderByBuilder<DeviceCertificateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceCertificateTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DeviceCertificate>(
      where: where?.call(DeviceCertificate.t),
      orderBy: orderBy?.call(DeviceCertificate.t),
      orderByList: orderByList?.call(DeviceCertificate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DeviceCertificate] by its [id] or null if no such row exists.
  Future<DeviceCertificate?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DeviceCertificate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DeviceCertificate]s in the list and returns the inserted rows.
  ///
  /// The returned [DeviceCertificate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DeviceCertificate>> insert(
    _i1.DatabaseSession session,
    List<DeviceCertificate> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DeviceCertificate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DeviceCertificate] and returns the inserted row.
  ///
  /// The returned [DeviceCertificate] will have its `id` field set.
  Future<DeviceCertificate> insertRow(
    _i1.DatabaseSession session,
    DeviceCertificate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DeviceCertificate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DeviceCertificate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DeviceCertificate>> update(
    _i1.DatabaseSession session,
    List<DeviceCertificate> rows, {
    _i1.ColumnSelections<DeviceCertificateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DeviceCertificate>(
      rows,
      columns: columns?.call(DeviceCertificate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceCertificate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DeviceCertificate> updateRow(
    _i1.DatabaseSession session,
    DeviceCertificate row, {
    _i1.ColumnSelections<DeviceCertificateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DeviceCertificate>(
      row,
      columns: columns?.call(DeviceCertificate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceCertificate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DeviceCertificate?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DeviceCertificateUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DeviceCertificate>(
      id,
      columnValues: columnValues(DeviceCertificate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DeviceCertificate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DeviceCertificate>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DeviceCertificateUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DeviceCertificateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceCertificateTable>? orderBy,
    _i1.OrderByListBuilder<DeviceCertificateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DeviceCertificate>(
      columnValues: columnValues(DeviceCertificate.t.updateTable),
      where: where(DeviceCertificate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceCertificate.t),
      orderByList: orderByList?.call(DeviceCertificate.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DeviceCertificate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DeviceCertificate>> delete(
    _i1.DatabaseSession session,
    List<DeviceCertificate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DeviceCertificate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DeviceCertificate].
  Future<DeviceCertificate> deleteRow(
    _i1.DatabaseSession session,
    DeviceCertificate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DeviceCertificate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DeviceCertificate>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceCertificateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DeviceCertificate>(
      where: where(DeviceCertificate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceCertificateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DeviceCertificate>(
      where: where?.call(DeviceCertificate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DeviceCertificate] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceCertificateTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DeviceCertificate>(
      where: where(DeviceCertificate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
