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

/// 設備型別檔（profile）：定義某類設備的量測通道與控制參數組合。
/// 目錄由伺服器維護（device_profiles.dart），建立設備時套用。
abstract class DeviceProfile
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DeviceProfile._({
    required this.id,
    required this.name,
    this.description,
    this.mcuFamily,
    this.category,
    required this.features,
  });

  factory DeviceProfile({
    required String id,
    required String name,
    String? description,
    String? mcuFamily,
    String? category,
    required List<_i2.DeviceFeature> features,
  }) = _DeviceProfileImpl;

  factory DeviceProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceProfile(
      id: jsonSerialization['id'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      mcuFamily: jsonSerialization['mcuFamily'] as String?,
      category: jsonSerialization['category'] as String?,
      features: _i3.Protocol().deserialize<List<_i2.DeviceFeature>>(
        jsonSerialization['features'],
      ),
    );
  }

  /// 型別檔 id，存於 Device.deviceType。
  String id;

  String name;

  String? description;

  /// MCU / SoC 家族，例如 ESP32、nRF52840、nRF5340。
  String? mcuFamily;

  /// sensor / controller / mixed，供分類與搜尋。
  String? category;

  List<_i2.DeviceFeature> features;

  /// Returns a shallow copy of this [DeviceProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceProfile copyWith({
    String? id,
    String? name,
    String? description,
    String? mcuFamily,
    String? category,
    List<_i2.DeviceFeature>? features,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceProfile',
      'id': id,
      'name': name,
      if (description != null) 'description': description,
      if (mcuFamily != null) 'mcuFamily': mcuFamily,
      if (category != null) 'category': category,
      'features': features.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceProfile',
      'id': id,
      'name': name,
      if (description != null) 'description': description,
      if (mcuFamily != null) 'mcuFamily': mcuFamily,
      if (category != null) 'category': category,
      'features': features.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceProfileImpl extends DeviceProfile {
  _DeviceProfileImpl({
    required String id,
    required String name,
    String? description,
    String? mcuFamily,
    String? category,
    required List<_i2.DeviceFeature> features,
  }) : super._(
         id: id,
         name: name,
         description: description,
         mcuFamily: mcuFamily,
         category: category,
         features: features,
       );

  /// Returns a shallow copy of this [DeviceProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceProfile copyWith({
    String? id,
    String? name,
    Object? description = _Undefined,
    Object? mcuFamily = _Undefined,
    Object? category = _Undefined,
    List<_i2.DeviceFeature>? features,
  }) {
    return DeviceProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      mcuFamily: mcuFamily is String? ? mcuFamily : this.mcuFamily,
      category: category is String? ? category : this.category,
      features: features ?? this.features.map((e0) => e0.copyWith()).toList(),
    );
  }
}
