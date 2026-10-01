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
import '../device/device_feature.dart' as _i2;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i3;

/// 公司自訂設備型別檔。內建型別仍由程式提供，自訂型別持久化於此表。
abstract class CustomDeviceProfile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CustomDeviceProfile._({
    this.id,
    required this.companyId,
    required this.profileKey,
    required this.name,
    this.description,
    this.mcuFamily,
    this.category,
    required this.features,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomDeviceProfile({
    int? id,
    required int companyId,
    required String profileKey,
    required String name,
    String? description,
    String? mcuFamily,
    String? category,
    required List<_i2.DeviceFeature> features,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CustomDeviceProfileImpl;

  factory CustomDeviceProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomDeviceProfile(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      profileKey: jsonSerialization['profileKey'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      mcuFamily: jsonSerialization['mcuFamily'] as String?,
      category: jsonSerialization['category'] as String?,
      features: _i3.Protocol().deserialize<List<_i2.DeviceFeature>>(
        jsonSerialization['features'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = CustomDeviceProfileTable();

  static const db = CustomDeviceProfileRepository._();

  @override
  int? id;

  int companyId;

  String profileKey;

  String name;

  String? description;

  String? mcuFamily;

  String? category;

  List<_i2.DeviceFeature> features;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CustomDeviceProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CustomDeviceProfile copyWith({
    int? id,
    int? companyId,
    String? profileKey,
    String? name,
    String? description,
    String? mcuFamily,
    String? category,
    List<_i2.DeviceFeature>? features,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomDeviceProfile',
      if (id != null) 'id': id,
      'companyId': companyId,
      'profileKey': profileKey,
      'name': name,
      if (description != null) 'description': description,
      if (mcuFamily != null) 'mcuFamily': mcuFamily,
      if (category != null) 'category': category,
      'features': features.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomDeviceProfile',
      if (id != null) 'id': id,
      'companyId': companyId,
      'profileKey': profileKey,
      'name': name,
      if (description != null) 'description': description,
      if (mcuFamily != null) 'mcuFamily': mcuFamily,
      if (category != null) 'category': category,
      'features': features.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static CustomDeviceProfileInclude include() {
    return CustomDeviceProfileInclude._();
  }

  static CustomDeviceProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<CustomDeviceProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CustomDeviceProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CustomDeviceProfileTable>? orderByList,
    CustomDeviceProfileInclude? include,
  }) {
    return CustomDeviceProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CustomDeviceProfile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CustomDeviceProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomDeviceProfileImpl extends CustomDeviceProfile {
  _CustomDeviceProfileImpl({
    int? id,
    required int companyId,
    required String profileKey,
    required String name,
    String? description,
    String? mcuFamily,
    String? category,
    required List<_i2.DeviceFeature> features,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         profileKey: profileKey,
         name: name,
         description: description,
         mcuFamily: mcuFamily,
         category: category,
         features: features,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CustomDeviceProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CustomDeviceProfile copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? profileKey,
    String? name,
    Object? description = _Undefined,
    Object? mcuFamily = _Undefined,
    Object? category = _Undefined,
    List<_i2.DeviceFeature>? features,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomDeviceProfile(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      profileKey: profileKey ?? this.profileKey,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      mcuFamily: mcuFamily is String? ? mcuFamily : this.mcuFamily,
      category: category is String? ? category : this.category,
      features: features ?? this.features.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CustomDeviceProfileUpdateTable
    extends _i1.UpdateTable<CustomDeviceProfileTable> {
  CustomDeviceProfileUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<String, String> profileKey(String value) => _i1.ColumnValue(
    table.profileKey,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> mcuFamily(String? value) => _i1.ColumnValue(
    table.mcuFamily,
    value,
  );

  _i1.ColumnValue<String, String> category(String? value) => _i1.ColumnValue(
    table.category,
    value,
  );

  _i1.ColumnValue<List<_i2.DeviceFeature>, List<_i2.DeviceFeature>> features(
    List<_i2.DeviceFeature> value,
  ) => _i1.ColumnValue(
    table.features,
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

class CustomDeviceProfileTable extends _i1.Table<int?> {
  CustomDeviceProfileTable({super.tableRelation})
    : super(tableName: 'custom_device_profile') {
    updateTable = CustomDeviceProfileUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    profileKey = _i1.ColumnString(
      'profileKey',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    mcuFamily = _i1.ColumnString(
      'mcuFamily',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    features = _i1.ColumnSerializable<List<_i2.DeviceFeature>>(
      'features',
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

  late final CustomDeviceProfileUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnString profileKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString mcuFamily;

  late final _i1.ColumnString category;

  late final _i1.ColumnSerializable<List<_i2.DeviceFeature>> features;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    profileKey,
    name,
    description,
    mcuFamily,
    category,
    features,
    createdAt,
    updatedAt,
  ];
}

class CustomDeviceProfileInclude extends _i1.IncludeObject {
  CustomDeviceProfileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CustomDeviceProfile.t;
}

class CustomDeviceProfileIncludeList extends _i1.IncludeList {
  CustomDeviceProfileIncludeList._({
    _i1.WhereExpressionBuilder<CustomDeviceProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CustomDeviceProfile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CustomDeviceProfile.t;
}

class CustomDeviceProfileRepository {
  const CustomDeviceProfileRepository._();

  /// Returns a list of [CustomDeviceProfile]s matching the given query parameters.
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
  Future<List<CustomDeviceProfile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CustomDeviceProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CustomDeviceProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CustomDeviceProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CustomDeviceProfile>(
      where: where?.call(CustomDeviceProfile.t),
      orderBy: orderBy?.call(CustomDeviceProfile.t),
      orderByList: orderByList?.call(CustomDeviceProfile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CustomDeviceProfile] matching the given query parameters.
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
  Future<CustomDeviceProfile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CustomDeviceProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<CustomDeviceProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CustomDeviceProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CustomDeviceProfile>(
      where: where?.call(CustomDeviceProfile.t),
      orderBy: orderBy?.call(CustomDeviceProfile.t),
      orderByList: orderByList?.call(CustomDeviceProfile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CustomDeviceProfile] by its [id] or null if no such row exists.
  Future<CustomDeviceProfile?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CustomDeviceProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CustomDeviceProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [CustomDeviceProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CustomDeviceProfile>> insert(
    _i1.DatabaseSession session,
    List<CustomDeviceProfile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CustomDeviceProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CustomDeviceProfile] and returns the inserted row.
  ///
  /// The returned [CustomDeviceProfile] will have its `id` field set.
  Future<CustomDeviceProfile> insertRow(
    _i1.DatabaseSession session,
    CustomDeviceProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CustomDeviceProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CustomDeviceProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CustomDeviceProfile>> update(
    _i1.DatabaseSession session,
    List<CustomDeviceProfile> rows, {
    _i1.ColumnSelections<CustomDeviceProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CustomDeviceProfile>(
      rows,
      columns: columns?.call(CustomDeviceProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CustomDeviceProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CustomDeviceProfile> updateRow(
    _i1.DatabaseSession session,
    CustomDeviceProfile row, {
    _i1.ColumnSelections<CustomDeviceProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CustomDeviceProfile>(
      row,
      columns: columns?.call(CustomDeviceProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CustomDeviceProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CustomDeviceProfile?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CustomDeviceProfileUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CustomDeviceProfile>(
      id,
      columnValues: columnValues(CustomDeviceProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CustomDeviceProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CustomDeviceProfile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CustomDeviceProfileUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CustomDeviceProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CustomDeviceProfileTable>? orderBy,
    _i1.OrderByListBuilder<CustomDeviceProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CustomDeviceProfile>(
      columnValues: columnValues(CustomDeviceProfile.t.updateTable),
      where: where(CustomDeviceProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CustomDeviceProfile.t),
      orderByList: orderByList?.call(CustomDeviceProfile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CustomDeviceProfile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CustomDeviceProfile>> delete(
    _i1.DatabaseSession session,
    List<CustomDeviceProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CustomDeviceProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CustomDeviceProfile].
  Future<CustomDeviceProfile> deleteRow(
    _i1.DatabaseSession session,
    CustomDeviceProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CustomDeviceProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CustomDeviceProfile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CustomDeviceProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CustomDeviceProfile>(
      where: where(CustomDeviceProfile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CustomDeviceProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CustomDeviceProfile>(
      where: where?.call(CustomDeviceProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CustomDeviceProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CustomDeviceProfileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CustomDeviceProfile>(
      where: where(CustomDeviceProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
