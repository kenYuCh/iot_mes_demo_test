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

/// 公司自訂設備型別檔。內建型別仍由程式提供，自訂型別持久化於此表。
abstract class CustomDeviceProfile implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
