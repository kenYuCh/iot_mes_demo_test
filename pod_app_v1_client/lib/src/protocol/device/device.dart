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
import '../device/device_feature.dart' as _i2;
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i3;

/// 設備固定資料（Metadata）。高頻即時狀態存於 DeviceStatus，不得寫入本表。
abstract class Device implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
