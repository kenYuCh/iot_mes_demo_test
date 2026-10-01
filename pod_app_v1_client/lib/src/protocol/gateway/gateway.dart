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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../device/device_connection_state.dart' as _i2;

/// 閘道器。負責聚合底下設備資料上行至平台。
abstract class Gateway implements _i1.SerializableModel {
  Gateway._({
    this.id,
    required this.companyId,
    required this.siteId,
    required this.serialNumber,
    required this.name,
    this.model,
    this.productKey,
    this.chipFamily,
    this.updateProtocol,
    this.hardwareRevision,
    this.firmwareVersion,
    required this.connectionState,
    this.lastSeenAt,
    required this.createdAt,
  });

  factory Gateway({
    int? id,
    required int companyId,
    required int siteId,
    required String serialNumber,
    required String name,
    String? model,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? firmwareVersion,
    required _i2.DeviceConnectionState connectionState,
    DateTime? lastSeenAt,
    required DateTime createdAt,
  }) = _GatewayImpl;

  factory Gateway.fromJson(Map<String, dynamic> jsonSerialization) {
    return Gateway(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      siteId: jsonSerialization['siteId'] as int,
      serialNumber: jsonSerialization['serialNumber'] as String,
      name: jsonSerialization['name'] as String,
      model: jsonSerialization['model'] as String?,
      productKey: jsonSerialization['productKey'] as String?,
      chipFamily: jsonSerialization['chipFamily'] as String?,
      updateProtocol: jsonSerialization['updateProtocol'] as String?,
      hardwareRevision: jsonSerialization['hardwareRevision'] as String?,
      firmwareVersion: jsonSerialization['firmwareVersion'] as String?,
      connectionState: _i2.DeviceConnectionState.fromJson(
        (jsonSerialization['connectionState'] as String),
      ),
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastSeenAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  int siteId;

  String serialNumber;

  String name;

  /// 出廠型號與 OTA 相容性識別。
  String? model;

  String? productKey;

  String? chipFamily;

  String? updateProtocol;

  String? hardwareRevision;

  String? firmwareVersion;

  _i2.DeviceConnectionState connectionState;

  DateTime? lastSeenAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [Gateway]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Gateway copyWith({
    int? id,
    int? companyId,
    int? siteId,
    String? serialNumber,
    String? name,
    String? model,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? firmwareVersion,
    _i2.DeviceConnectionState? connectionState,
    DateTime? lastSeenAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Gateway',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      'serialNumber': serialNumber,
      'name': name,
      if (model != null) 'model': model,
      if (productKey != null) 'productKey': productKey,
      if (chipFamily != null) 'chipFamily': chipFamily,
      if (updateProtocol != null) 'updateProtocol': updateProtocol,
      if (hardwareRevision != null) 'hardwareRevision': hardwareRevision,
      if (firmwareVersion != null) 'firmwareVersion': firmwareVersion,
      'connectionState': connectionState.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GatewayImpl extends Gateway {
  _GatewayImpl({
    int? id,
    required int companyId,
    required int siteId,
    required String serialNumber,
    required String name,
    String? model,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? firmwareVersion,
    required _i2.DeviceConnectionState connectionState,
    DateTime? lastSeenAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         siteId: siteId,
         serialNumber: serialNumber,
         name: name,
         model: model,
         productKey: productKey,
         chipFamily: chipFamily,
         updateProtocol: updateProtocol,
         hardwareRevision: hardwareRevision,
         firmwareVersion: firmwareVersion,
         connectionState: connectionState,
         lastSeenAt: lastSeenAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Gateway]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Gateway copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? siteId,
    String? serialNumber,
    String? name,
    Object? model = _Undefined,
    Object? productKey = _Undefined,
    Object? chipFamily = _Undefined,
    Object? updateProtocol = _Undefined,
    Object? hardwareRevision = _Undefined,
    Object? firmwareVersion = _Undefined,
    _i2.DeviceConnectionState? connectionState,
    Object? lastSeenAt = _Undefined,
    DateTime? createdAt,
  }) {
    return Gateway(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      siteId: siteId ?? this.siteId,
      serialNumber: serialNumber ?? this.serialNumber,
      name: name ?? this.name,
      model: model is String? ? model : this.model,
      productKey: productKey is String? ? productKey : this.productKey,
      chipFamily: chipFamily is String? ? chipFamily : this.chipFamily,
      updateProtocol: updateProtocol is String?
          ? updateProtocol
          : this.updateProtocol,
      hardwareRevision: hardwareRevision is String?
          ? hardwareRevision
          : this.hardwareRevision,
      firmwareVersion: firmwareVersion is String?
          ? firmwareVersion
          : this.firmwareVersion,
      connectionState: connectionState ?? this.connectionState,
      lastSeenAt: lastSeenAt is DateTime? ? lastSeenAt : this.lastSeenAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
