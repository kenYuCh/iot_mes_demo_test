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
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i3;

/// 設備即時狀態（與 Device 主表分離）。正式環境最新值以 Redis 為主，本表為持久化快照。
abstract class DeviceStatus implements _i1.SerializableModel {
  DeviceStatus._({
    this.id,
    required this.companyId,
    required this.deviceId,
    required this.connectionState,
    required this.latestValues,
    this.lastUpdatedAt,
  });

  factory DeviceStatus({
    int? id,
    required int companyId,
    required int deviceId,
    required _i2.DeviceConnectionState connectionState,
    required Map<String, double> latestValues,
    DateTime? lastUpdatedAt,
  }) = _DeviceStatusImpl;

  factory DeviceStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceStatus(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      connectionState: _i2.DeviceConnectionState.fromJson(
        (jsonSerialization['connectionState'] as String),
      ),
      latestValues: _i3.Protocol().deserialize<Map<String, double>>(
        jsonSerialization['latestValues'],
      ),
      lastUpdatedAt: jsonSerialization['lastUpdatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastUpdatedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  int deviceId;

  _i2.DeviceConnectionState connectionState;

  /// 各 feature 最新值，key 為 featureKey。
  Map<String, double> latestValues;

  DateTime? lastUpdatedAt;

  /// Returns a shallow copy of this [DeviceStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceStatus copyWith({
    int? id,
    int? companyId,
    int? deviceId,
    _i2.DeviceConnectionState? connectionState,
    Map<String, double>? latestValues,
    DateTime? lastUpdatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceStatus',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'connectionState': connectionState.toJson(),
      'latestValues': latestValues.toJson(),
      if (lastUpdatedAt != null) 'lastUpdatedAt': lastUpdatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceStatusImpl extends DeviceStatus {
  _DeviceStatusImpl({
    int? id,
    required int companyId,
    required int deviceId,
    required _i2.DeviceConnectionState connectionState,
    required Map<String, double> latestValues,
    DateTime? lastUpdatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         deviceId: deviceId,
         connectionState: connectionState,
         latestValues: latestValues,
         lastUpdatedAt: lastUpdatedAt,
       );

  /// Returns a shallow copy of this [DeviceStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceStatus copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? deviceId,
    _i2.DeviceConnectionState? connectionState,
    Map<String, double>? latestValues,
    Object? lastUpdatedAt = _Undefined,
  }) {
    return DeviceStatus(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      deviceId: deviceId ?? this.deviceId,
      connectionState: connectionState ?? this.connectionState,
      latestValues:
          latestValues ??
          this.latestValues.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      lastUpdatedAt: lastUpdatedAt is DateTime?
          ? lastUpdatedAt
          : this.lastUpdatedAt,
    );
  }
}
