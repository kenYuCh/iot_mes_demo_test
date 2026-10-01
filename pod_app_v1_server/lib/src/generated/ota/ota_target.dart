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
import '../device/device_connection_state.dart' as _i2;

/// 可被 OTA 任務選取的統一目標；targetKey 格式為 device:ID 或 gateway:ID。
abstract class OtaTarget
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  OtaTarget._({
    required this.targetKey,
    required this.targetKind,
    required this.targetId,
    this.serialNumber,
    required this.name,
    required this.model,
    required this.productKey,
    this.chipFamily,
    this.updateProtocol,
    this.hardwareRevision,
    this.firmwareVersion,
    required this.connectionState,
  });

  factory OtaTarget({
    required String targetKey,
    required String targetKind,
    required int targetId,
    String? serialNumber,
    required String name,
    required String model,
    required String productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? firmwareVersion,
    required _i2.DeviceConnectionState connectionState,
  }) = _OtaTargetImpl;

  factory OtaTarget.fromJson(Map<String, dynamic> jsonSerialization) {
    return OtaTarget(
      targetKey: jsonSerialization['targetKey'] as String,
      targetKind: jsonSerialization['targetKind'] as String,
      targetId: jsonSerialization['targetId'] as int,
      serialNumber: jsonSerialization['serialNumber'] as String?,
      name: jsonSerialization['name'] as String,
      model: jsonSerialization['model'] as String,
      productKey: jsonSerialization['productKey'] as String,
      chipFamily: jsonSerialization['chipFamily'] as String?,
      updateProtocol: jsonSerialization['updateProtocol'] as String?,
      hardwareRevision: jsonSerialization['hardwareRevision'] as String?,
      firmwareVersion: jsonSerialization['firmwareVersion'] as String?,
      connectionState: _i2.DeviceConnectionState.fromJson(
        (jsonSerialization['connectionState'] as String),
      ),
    );
  }

  String targetKey;

  String targetKind;

  int targetId;

  String? serialNumber;

  String name;

  String model;

  String productKey;

  String? chipFamily;

  String? updateProtocol;

  String? hardwareRevision;

  String? firmwareVersion;

  _i2.DeviceConnectionState connectionState;

  /// Returns a shallow copy of this [OtaTarget]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OtaTarget copyWith({
    String? targetKey,
    String? targetKind,
    int? targetId,
    String? serialNumber,
    String? name,
    String? model,
    String? productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? firmwareVersion,
    _i2.DeviceConnectionState? connectionState,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OtaTarget',
      'targetKey': targetKey,
      'targetKind': targetKind,
      'targetId': targetId,
      if (serialNumber != null) 'serialNumber': serialNumber,
      'name': name,
      'model': model,
      'productKey': productKey,
      if (chipFamily != null) 'chipFamily': chipFamily,
      if (updateProtocol != null) 'updateProtocol': updateProtocol,
      if (hardwareRevision != null) 'hardwareRevision': hardwareRevision,
      if (firmwareVersion != null) 'firmwareVersion': firmwareVersion,
      'connectionState': connectionState.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OtaTarget',
      'targetKey': targetKey,
      'targetKind': targetKind,
      'targetId': targetId,
      if (serialNumber != null) 'serialNumber': serialNumber,
      'name': name,
      'model': model,
      'productKey': productKey,
      if (chipFamily != null) 'chipFamily': chipFamily,
      if (updateProtocol != null) 'updateProtocol': updateProtocol,
      if (hardwareRevision != null) 'hardwareRevision': hardwareRevision,
      if (firmwareVersion != null) 'firmwareVersion': firmwareVersion,
      'connectionState': connectionState.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OtaTargetImpl extends OtaTarget {
  _OtaTargetImpl({
    required String targetKey,
    required String targetKind,
    required int targetId,
    String? serialNumber,
    required String name,
    required String model,
    required String productKey,
    String? chipFamily,
    String? updateProtocol,
    String? hardwareRevision,
    String? firmwareVersion,
    required _i2.DeviceConnectionState connectionState,
  }) : super._(
         targetKey: targetKey,
         targetKind: targetKind,
         targetId: targetId,
         serialNumber: serialNumber,
         name: name,
         model: model,
         productKey: productKey,
         chipFamily: chipFamily,
         updateProtocol: updateProtocol,
         hardwareRevision: hardwareRevision,
         firmwareVersion: firmwareVersion,
         connectionState: connectionState,
       );

  /// Returns a shallow copy of this [OtaTarget]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OtaTarget copyWith({
    String? targetKey,
    String? targetKind,
    int? targetId,
    Object? serialNumber = _Undefined,
    String? name,
    String? model,
    String? productKey,
    Object? chipFamily = _Undefined,
    Object? updateProtocol = _Undefined,
    Object? hardwareRevision = _Undefined,
    Object? firmwareVersion = _Undefined,
    _i2.DeviceConnectionState? connectionState,
  }) {
    return OtaTarget(
      targetKey: targetKey ?? this.targetKey,
      targetKind: targetKind ?? this.targetKind,
      targetId: targetId ?? this.targetId,
      serialNumber: serialNumber is String? ? serialNumber : this.serialNumber,
      name: name ?? this.name,
      model: model ?? this.model,
      productKey: productKey ?? this.productKey,
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
    );
  }
}
