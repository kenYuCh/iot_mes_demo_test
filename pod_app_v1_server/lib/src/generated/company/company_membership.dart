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
import '../company/company_role.dart' as _i2;
import '../company/platform_permission.dart' as _i3;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i4;

/// 使用者與公司的隸屬關係。垂直切片先支援單一公司；完整 RBAC 於第二階段擴充。
abstract class CompanyMembership
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CompanyMembership._({
    this.id,
    required this.companyId,
    required this.authUserId,
    this.role,
    this.permissions,
    this.email,
    this.displayName,
    bool? isActive,
    required this.createdAt,
  }) : isActive = isActive ?? true;

  factory CompanyMembership({
    int? id,
    required int companyId,
    required String authUserId,
    _i2.CompanyRole? role,
    List<_i3.PlatformPermission>? permissions,
    String? email,
    String? displayName,
    bool? isActive,
    required DateTime createdAt,
  }) = _CompanyMembershipImpl;

  factory CompanyMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompanyMembership(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      authUserId: jsonSerialization['authUserId'] as String,
      role: jsonSerialization['role'] == null
          ? null
          : _i2.CompanyRole.fromJson((jsonSerialization['role'] as String)),
      permissions: jsonSerialization['permissions'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.PlatformPermission>>(
              jsonSerialization['permissions'],
            ),
      email: jsonSerialization['email'] as String?,
      displayName: jsonSerialization['displayName'] as String?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = CompanyMembershipTable();

  static const db = CompanyMembershipRepository._();

  @override
  int? id;

  int companyId;

  /// Serverpod auth 的使用者識別字串。
  String authUserId;

  /// 舊資料為 null 時視為開發環境 admin；新加入者預設 viewer。
  _i2.CompanyRole? role;

  /// 額外模組權限；null 依角色套用預設權限，便於舊資料相容。
  List<_i3.PlatformPermission>? permissions;

  /// 帳戶顯示資訊快照，避免將 auth 內部資料直接暴露給 Client。
  String? email;

  String? displayName;

  bool isActive;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CompanyMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompanyMembership copyWith({
    int? id,
    int? companyId,
    String? authUserId,
    _i2.CompanyRole? role,
    List<_i3.PlatformPermission>? permissions,
    String? email,
    String? displayName,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CompanyMembership',
      if (id != null) 'id': id,
      'companyId': companyId,
      'authUserId': authUserId,
      if (role != null) 'role': role?.toJson(),
      if (permissions != null)
        'permissions': permissions?.toJson(valueToJson: (v) => v.toJson()),
      if (email != null) 'email': email,
      if (displayName != null) 'displayName': displayName,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CompanyMembership',
      if (id != null) 'id': id,
      'companyId': companyId,
      'authUserId': authUserId,
      if (role != null) 'role': role?.toJson(),
      if (permissions != null)
        'permissions': permissions?.toJson(valueToJson: (v) => v.toJson()),
      if (email != null) 'email': email,
      if (displayName != null) 'displayName': displayName,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  static CompanyMembershipInclude include() {
    return CompanyMembershipInclude._();
  }

  static CompanyMembershipIncludeList includeList({
    _i1.WhereExpressionBuilder<CompanyMembershipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompanyMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompanyMembershipTable>? orderByList,
    CompanyMembershipInclude? include,
  }) {
    return CompanyMembershipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompanyMembership.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CompanyMembership.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanyMembershipImpl extends CompanyMembership {
  _CompanyMembershipImpl({
    int? id,
    required int companyId,
    required String authUserId,
    _i2.CompanyRole? role,
    List<_i3.PlatformPermission>? permissions,
    String? email,
    String? displayName,
    bool? isActive,
    required DateTime createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         authUserId: authUserId,
         role: role,
         permissions: permissions,
         email: email,
         displayName: displayName,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CompanyMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompanyMembership copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? authUserId,
    Object? role = _Undefined,
    Object? permissions = _Undefined,
    Object? email = _Undefined,
    Object? displayName = _Undefined,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return CompanyMembership(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      authUserId: authUserId ?? this.authUserId,
      role: role is _i2.CompanyRole? ? role : this.role,
      permissions: permissions is List<_i3.PlatformPermission>?
          ? permissions
          : this.permissions?.map((e0) => e0).toList(),
      email: email is String? ? email : this.email,
      displayName: displayName is String? ? displayName : this.displayName,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CompanyMembershipUpdateTable
    extends _i1.UpdateTable<CompanyMembershipTable> {
  CompanyMembershipUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> authUserId(String value) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<_i2.CompanyRole, _i2.CompanyRole> role(
    _i2.CompanyRole? value,
  ) => _i1.ColumnValue(
    table.role,
    value,
  );

  _i1.ColumnValue<List<_i3.PlatformPermission>, List<_i3.PlatformPermission>>
  permissions(List<_i3.PlatformPermission>? value) => _i1.ColumnValue(
    table.permissions,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> displayName(String? value) => _i1.ColumnValue(
    table.displayName,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CompanyMembershipTable extends _i1.Table<int?> {
  CompanyMembershipTable({super.tableRelation})
    : super(tableName: 'company_membership') {
    updateTable = CompanyMembershipUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    authUserId = _i1.ColumnString(
      'authUserId',
      this,
    );
    role = _i1.ColumnEnum(
      'role',
      this,
      _i1.EnumSerialization.byName,
    );
    permissions = _i1.ColumnSerializable<List<_i3.PlatformPermission>>(
      'permissions',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    displayName = _i1.ColumnString(
      'displayName',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CompanyMembershipUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  /// Serverpod auth 的使用者識別字串。
  late final _i1.ColumnString authUserId;

  /// 舊資料為 null 時視為開發環境 admin；新加入者預設 viewer。
  late final _i1.ColumnEnum<_i2.CompanyRole> role;

  /// 額外模組權限；null 依角色套用預設權限，便於舊資料相容。
  late final _i1.ColumnSerializable<List<_i3.PlatformPermission>> permissions;

  /// 帳戶顯示資訊快照，避免將 auth 內部資料直接暴露給 Client。
  late final _i1.ColumnString email;

  late final _i1.ColumnString displayName;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    authUserId,
    role,
    permissions,
    email,
    displayName,
    isActive,
    createdAt,
  ];
}

class CompanyMembershipInclude extends _i1.IncludeObject {
  CompanyMembershipInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CompanyMembership.t;
}

class CompanyMembershipIncludeList extends _i1.IncludeList {
  CompanyMembershipIncludeList._({
    _i1.WhereExpressionBuilder<CompanyMembershipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CompanyMembership.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CompanyMembership.t;
}

class CompanyMembershipRepository {
  const CompanyMembershipRepository._();

  /// Returns a list of [CompanyMembership]s matching the given query parameters.
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
  Future<List<CompanyMembership>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CompanyMembershipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompanyMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompanyMembershipTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CompanyMembership>(
      where: where?.call(CompanyMembership.t),
      orderBy: orderBy?.call(CompanyMembership.t),
      orderByList: orderByList?.call(CompanyMembership.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CompanyMembership] matching the given query parameters.
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
  Future<CompanyMembership?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CompanyMembershipTable>? where,
    int? offset,
    _i1.OrderByBuilder<CompanyMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CompanyMembershipTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CompanyMembership>(
      where: where?.call(CompanyMembership.t),
      orderBy: orderBy?.call(CompanyMembership.t),
      orderByList: orderByList?.call(CompanyMembership.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CompanyMembership] by its [id] or null if no such row exists.
  Future<CompanyMembership?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CompanyMembership>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CompanyMembership]s in the list and returns the inserted rows.
  ///
  /// The returned [CompanyMembership]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CompanyMembership>> insert(
    _i1.DatabaseSession session,
    List<CompanyMembership> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CompanyMembership>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CompanyMembership] and returns the inserted row.
  ///
  /// The returned [CompanyMembership] will have its `id` field set.
  Future<CompanyMembership> insertRow(
    _i1.DatabaseSession session,
    CompanyMembership row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CompanyMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CompanyMembership]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CompanyMembership>> update(
    _i1.DatabaseSession session,
    List<CompanyMembership> rows, {
    _i1.ColumnSelections<CompanyMembershipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CompanyMembership>(
      rows,
      columns: columns?.call(CompanyMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompanyMembership]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CompanyMembership> updateRow(
    _i1.DatabaseSession session,
    CompanyMembership row, {
    _i1.ColumnSelections<CompanyMembershipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CompanyMembership>(
      row,
      columns: columns?.call(CompanyMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompanyMembership] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CompanyMembership?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CompanyMembershipUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CompanyMembership>(
      id,
      columnValues: columnValues(CompanyMembership.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CompanyMembership]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CompanyMembership>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CompanyMembershipUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CompanyMembershipTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CompanyMembershipTable>? orderBy,
    _i1.OrderByListBuilder<CompanyMembershipTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CompanyMembership>(
      columnValues: columnValues(CompanyMembership.t.updateTable),
      where: where(CompanyMembership.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompanyMembership.t),
      orderByList: orderByList?.call(CompanyMembership.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CompanyMembership]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CompanyMembership>> delete(
    _i1.DatabaseSession session,
    List<CompanyMembership> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CompanyMembership>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CompanyMembership].
  Future<CompanyMembership> deleteRow(
    _i1.DatabaseSession session,
    CompanyMembership row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CompanyMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CompanyMembership>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CompanyMembershipTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CompanyMembership>(
      where: where(CompanyMembership.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CompanyMembershipTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CompanyMembership>(
      where: where?.call(CompanyMembership.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CompanyMembership] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CompanyMembershipTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CompanyMembership>(
      where: where(CompanyMembership.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
