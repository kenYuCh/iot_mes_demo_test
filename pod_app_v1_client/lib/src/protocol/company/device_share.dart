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

/// 將單一設備分享給公司成員，讀寫權限分離。
abstract class DeviceShare implements _i1.SerializableModel {
  DeviceShare._({
    this.id,
    required this.companyId,
    required this.deviceId,
    required this.membershipId,
    bool? canRead,
    bool? canWrite,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  }) : canRead = canRead ?? true,
       canWrite = canWrite ?? false;

  factory DeviceShare({
    int? id,
    required int companyId,
    required int deviceId,
    required int membershipId,
    bool? canRead,
    bool? canWrite,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DeviceShareImpl;

  factory DeviceShare.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceShare(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      membershipId: jsonSerialization['membershipId'] as int,
      canRead: jsonSerialization['canRead'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['canRead']),
      canWrite: jsonSerialization['canWrite'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['canWrite']),
      createdBy: jsonSerialization['createdBy'] as String,
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

  int deviceId;

  int membershipId;

  bool canRead;

  bool canWrite;

  String createdBy;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DeviceShare]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceShare copyWith({
    int? id,
    int? companyId,
    int? deviceId,
    int? membershipId,
    bool? canRead,
    bool? canWrite,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceShare',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'membershipId': membershipId,
      'canRead': canRead,
      'canWrite': canWrite,
      'createdBy': createdBy,
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

class _DeviceShareImpl extends DeviceShare {
  _DeviceShareImpl({
    int? id,
    required int companyId,
    required int deviceId,
    required int membershipId,
    bool? canRead,
    bool? canWrite,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         deviceId: deviceId,
         membershipId: membershipId,
         canRead: canRead,
         canWrite: canWrite,
         createdBy: createdBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DeviceShare]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceShare copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? deviceId,
    int? membershipId,
    bool? canRead,
    bool? canWrite,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DeviceShare(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      deviceId: deviceId ?? this.deviceId,
      membershipId: membershipId ?? this.membershipId,
      canRead: canRead ?? this.canRead,
      canWrite: canWrite ?? this.canWrite,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
