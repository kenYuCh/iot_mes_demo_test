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

/// 設備固定資料（Metadata）。高頻即時狀態存於 DeviceStatus，不得寫入本表。
abstract class Device implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Device._({
    this.id,
    required this.companyId,
    required this.siteId,
    this.gatewayId,
    this.serialNumber,
    required this.name,
    required this.model,
    this.hardwareRevision,
    this.firmwareVersion,
    required this.deviceType,
    this.features,
    required this.expectedIntervalSeconds,
    this.mapX,
    this.mapY,
    required this.createdAt,
  });

  factory Device({
    int? id,
    required int companyId,
    required int siteId,
    int? gatewayId,
    String? serialNumber,
    required String name,
    required String model,
    String? hardwareRevision,
    String? firmwareVersion,
    required String deviceType,
    List<_i2.DeviceFeature>? features,
    required int expectedIntervalSeconds,
    double? mapX,
    double? mapY,
    required DateTime createdAt,
  }) = _DeviceImpl;

  factory Device.fromJson(Map<String, dynamic> jsonSerialization) {
    return Device(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      siteId: jsonSerialization['siteId'] as int,
      gatewayId: jsonSerialization['gatewayId'] as int?,
      serialNumber: jsonSerialization['serialNumber'] as String?,
      name: jsonSerialization['name'] as String,
      model: jsonSerialization['model'] as String,
      hardwareRevision: jsonSerialization['hardwareRevision'] as String?,
      firmwareVersion: jsonSerialization['firmwareVersion'] as String?,
      deviceType: jsonSerialization['deviceType'] as String,
      features: jsonSerialization['features'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.DeviceFeature>>(
              jsonSerialization['features'],
            ),
      expectedIntervalSeconds:
          jsonSerialization['expectedIntervalSeconds'] as int,
      mapX: (jsonSerialization['mapX'] as num?)?.toDouble(),
      mapY: (jsonSerialization['mapY'] as num?)?.toDouble(),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = DeviceTable();

  static const db = DeviceRepository._();

  @override
  int? id;

  int companyId;

  int siteId;

  /// null 表示設備以 Wi-Fi / Ethernet 直接連線 Server/MQTT；非 null 表示經閘道器。
  int? gatewayId;

  /// 實體設備序號；邏輯設備可為 null。用於 MQTT、OTA 與配對關聯。
  String? serialNumber;

  String name;

  String model;

  /// 硬體版次，用於 OTA 相容性檢查。
  String? hardwareRevision;

  /// 裝置目前回報的韌體版本。
  String? firmwareVersion;

  /// 型別檔 id（DeviceProfile.id），例如 temperature / env_multi / motor_drive。
  String deviceType;

  /// 特徵清單（量測通道＋控制參數）。null 時依 deviceType 從型別檔目錄補齊。
  List<_i2.DeviceFeature>? features;

  /// 預期上報間隔（秒），用於 STALE / OFFLINE 判斷。
  int expectedIntervalSeconds;

  /// 2D 廠房地圖座標（0..1 正規化；null 表示尚未擺放）。
  double? mapX;

  double? mapY;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Device]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Device copyWith({
    int? id,
    int? companyId,
    int? siteId,
    int? gatewayId,
    String? serialNumber,
    String? name,
    String? model,
    String? hardwareRevision,
    String? firmwareVersion,
    String? deviceType,
    List<_i2.DeviceFeature>? features,
    int? expectedIntervalSeconds,
    double? mapX,
    double? mapY,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Device',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      if (gatewayId != null) 'gatewayId': gatewayId,
      if (serialNumber != null) 'serialNumber': serialNumber,
      'name': name,
      'model': model,
      if (hardwareRevision != null) 'hardwareRevision': hardwareRevision,
      if (firmwareVersion != null) 'firmwareVersion': firmwareVersion,
      'deviceType': deviceType,
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJson()),
      'expectedIntervalSeconds': expectedIntervalSeconds,
      if (mapX != null) 'mapX': mapX,
      if (mapY != null) 'mapY': mapY,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Device',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      if (gatewayId != null) 'gatewayId': gatewayId,
      if (serialNumber != null) 'serialNumber': serialNumber,
      'name': name,
      'model': model,
      if (hardwareRevision != null) 'hardwareRevision': hardwareRevision,
      if (firmwareVersion != null) 'firmwareVersion': firmwareVersion,
      'deviceType': deviceType,
      if (features != null)
        'features': features?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'expectedIntervalSeconds': expectedIntervalSeconds,
      if (mapX != null) 'mapX': mapX,
      if (mapY != null) 'mapY': mapY,
      'createdAt': createdAt.toJson(),
    };
  }

  static DeviceInclude include() {
    return DeviceInclude._();
  }

  static DeviceIncludeList includeList({
    _i1.WhereExpressionBuilder<DeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceTable>? orderByList,
    DeviceInclude? include,
  }) {
    return DeviceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Device.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Device.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceImpl extends Device {
  _DeviceImpl({
    int? id,
    required int companyId,
    required int siteId,
    int? gatewayId,
    String? serialNumber,
    required String name,
    required String model,
    String? hardwareRevision,
    String? firmwareVersion,
    required String deviceType,
    List<_i2.DeviceFeature>? features,
    required int expectedIntervalSeconds,
    double? mapX,
    double? mapY,
    required DateTime createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         siteId: siteId,
         gatewayId: gatewayId,
         serialNumber: serialNumber,
         name: name,
         model: model,
         hardwareRevision: hardwareRevision,
         firmwareVersion: firmwareVersion,
         deviceType: deviceType,
         features: features,
         expectedIntervalSeconds: expectedIntervalSeconds,
         mapX: mapX,
         mapY: mapY,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Device]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Device copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? siteId,
    Object? gatewayId = _Undefined,
    Object? serialNumber = _Undefined,
    String? name,
    String? model,
    Object? hardwareRevision = _Undefined,
    Object? firmwareVersion = _Undefined,
    String? deviceType,
    Object? features = _Undefined,
    int? expectedIntervalSeconds,
    Object? mapX = _Undefined,
    Object? mapY = _Undefined,
    DateTime? createdAt,
  }) {
    return Device(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      siteId: siteId ?? this.siteId,
      gatewayId: gatewayId is int? ? gatewayId : this.gatewayId,
      serialNumber: serialNumber is String? ? serialNumber : this.serialNumber,
      name: name ?? this.name,
      model: model ?? this.model,
      hardwareRevision: hardwareRevision is String?
          ? hardwareRevision
          : this.hardwareRevision,
      firmwareVersion: firmwareVersion is String?
          ? firmwareVersion
          : this.firmwareVersion,
      deviceType: deviceType ?? this.deviceType,
      features: features is List<_i2.DeviceFeature>?
          ? features
          : this.features?.map((e0) => e0.copyWith()).toList(),
      expectedIntervalSeconds:
          expectedIntervalSeconds ?? this.expectedIntervalSeconds,
      mapX: mapX is double? ? mapX : this.mapX,
      mapY: mapY is double? ? mapY : this.mapY,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class DeviceUpdateTable extends _i1.UpdateTable<DeviceTable> {
  DeviceUpdateTable(super.table);

  _i1.ColumnValue<int, int> companyId(int value) => _i1.ColumnValue(
    table.companyId,
    value,
  );

  _i1.ColumnValue<int, int> siteId(int value) => _i1.ColumnValue(
    table.siteId,
    value,
  );

  _i1.ColumnValue<int, int> gatewayId(int? value) => _i1.ColumnValue(
    table.gatewayId,
    value,
  );

  _i1.ColumnValue<String, String> serialNumber(String? value) =>
      _i1.ColumnValue(
        table.serialNumber,
        value,
      );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> model(String value) => _i1.ColumnValue(
    table.model,
    value,
  );

  _i1.ColumnValue<String, String> hardwareRevision(String? value) =>
      _i1.ColumnValue(
        table.hardwareRevision,
        value,
      );

  _i1.ColumnValue<String, String> firmwareVersion(String? value) =>
      _i1.ColumnValue(
        table.firmwareVersion,
        value,
      );

  _i1.ColumnValue<String, String> deviceType(String value) => _i1.ColumnValue(
    table.deviceType,
    value,
  );

  _i1.ColumnValue<List<_i2.DeviceFeature>, List<_i2.DeviceFeature>> features(
    List<_i2.DeviceFeature>? value,
  ) => _i1.ColumnValue(
    table.features,
    value,
  );

  _i1.ColumnValue<int, int> expectedIntervalSeconds(int value) =>
      _i1.ColumnValue(
        table.expectedIntervalSeconds,
        value,
      );

  _i1.ColumnValue<double, double> mapX(double? value) => _i1.ColumnValue(
    table.mapX,
    value,
  );

  _i1.ColumnValue<double, double> mapY(double? value) => _i1.ColumnValue(
    table.mapY,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class DeviceTable extends _i1.Table<int?> {
  DeviceTable({super.tableRelation}) : super(tableName: 'device') {
    updateTable = DeviceUpdateTable(this);
    companyId = _i1.ColumnInt(
      'companyId',
      this,
    );
    siteId = _i1.ColumnInt(
      'siteId',
      this,
    );
    gatewayId = _i1.ColumnInt(
      'gatewayId',
      this,
    );
    serialNumber = _i1.ColumnString(
      'serialNumber',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    model = _i1.ColumnString(
      'model',
      this,
    );
    hardwareRevision = _i1.ColumnString(
      'hardwareRevision',
      this,
    );
    firmwareVersion = _i1.ColumnString(
      'firmwareVersion',
      this,
    );
    deviceType = _i1.ColumnString(
      'deviceType',
      this,
    );
    features = _i1.ColumnSerializable<List<_i2.DeviceFeature>>(
      'features',
      this,
    );
    expectedIntervalSeconds = _i1.ColumnInt(
      'expectedIntervalSeconds',
      this,
    );
    mapX = _i1.ColumnDouble(
      'mapX',
      this,
    );
    mapY = _i1.ColumnDouble(
      'mapY',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final DeviceUpdateTable updateTable;

  late final _i1.ColumnInt companyId;

  late final _i1.ColumnInt siteId;

  /// null 表示設備以 Wi-Fi / Ethernet 直接連線 Server/MQTT；非 null 表示經閘道器。
  late final _i1.ColumnInt gatewayId;

  /// 實體設備序號；邏輯設備可為 null。用於 MQTT、OTA 與配對關聯。
  late final _i1.ColumnString serialNumber;

  late final _i1.ColumnString name;

  late final _i1.ColumnString model;

  /// 硬體版次，用於 OTA 相容性檢查。
  late final _i1.ColumnString hardwareRevision;

  /// 裝置目前回報的韌體版本。
  late final _i1.ColumnString firmwareVersion;

  /// 型別檔 id（DeviceProfile.id），例如 temperature / env_multi / motor_drive。
  late final _i1.ColumnString deviceType;

  /// 特徵清單（量測通道＋控制參數）。null 時依 deviceType 從型別檔目錄補齊。
  late final _i1.ColumnSerializable<List<_i2.DeviceFeature>> features;

  /// 預期上報間隔（秒），用於 STALE / OFFLINE 判斷。
  late final _i1.ColumnInt expectedIntervalSeconds;

  /// 2D 廠房地圖座標（0..1 正規化；null 表示尚未擺放）。
  late final _i1.ColumnDouble mapX;

  late final _i1.ColumnDouble mapY;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    companyId,
    siteId,
    gatewayId,
    serialNumber,
    name,
    model,
    hardwareRevision,
    firmwareVersion,
    deviceType,
    features,
    expectedIntervalSeconds,
    mapX,
    mapY,
    createdAt,
  ];
}

class DeviceInclude extends _i1.IncludeObject {
  DeviceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Device.t;
}

class DeviceIncludeList extends _i1.IncludeList {
  DeviceIncludeList._({
    _i1.WhereExpressionBuilder<DeviceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Device.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Device.t;
}

class DeviceRepository {
  const DeviceRepository._();

  /// Returns a list of [Device]s matching the given query parameters.
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
  Future<List<Device>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Device>(
      where: where?.call(Device.t),
      orderBy: orderBy?.call(Device.t),
      orderByList: orderByList?.call(Device.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Device] matching the given query parameters.
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
  Future<Device?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceTable>? where,
    int? offset,
    _i1.OrderByBuilder<DeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Device>(
      where: where?.call(Device.t),
      orderBy: orderBy?.call(Device.t),
      orderByList: orderByList?.call(Device.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Device] by its [id] or null if no such row exists.
  Future<Device?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Device>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Device]s in the list and returns the inserted rows.
  ///
  /// The returned [Device]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Device>> insert(
    _i1.DatabaseSession session,
    List<Device> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Device>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Device] and returns the inserted row.
  ///
  /// The returned [Device] will have its `id` field set.
  Future<Device> insertRow(
    _i1.DatabaseSession session,
    Device row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Device>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Device]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Device>> update(
    _i1.DatabaseSession session,
    List<Device> rows, {
    _i1.ColumnSelections<DeviceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Device>(
      rows,
      columns: columns?.call(Device.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Device]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Device> updateRow(
    _i1.DatabaseSession session,
    Device row, {
    _i1.ColumnSelections<DeviceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Device>(
      row,
      columns: columns?.call(Device.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Device] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Device?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DeviceUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Device>(
      id,
      columnValues: columnValues(Device.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Device]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Device>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DeviceUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DeviceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceTable>? orderBy,
    _i1.OrderByListBuilder<DeviceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Device>(
      columnValues: columnValues(Device.t.updateTable),
      where: where(Device.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Device.t),
      orderByList: orderByList?.call(Device.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Device]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Device>> delete(
    _i1.DatabaseSession session,
    List<Device> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Device>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Device].
  Future<Device> deleteRow(
    _i1.DatabaseSession session,
    Device row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Device>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Device>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Device>(
      where: where(Device.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Device>(
      where: where?.call(Device.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Device] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Device>(
      where: where(Device.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
