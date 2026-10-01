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

/// 權限管理頁使用的安全 DTO。
abstract class MemberAccessSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  MemberAccessSummary._({
    required this.membershipId,
    required this.email,
    this.displayName,
    required this.role,
    required this.permissions,
    required this.isActive,
    required this.sharedDeviceIds,
    required this.writableDeviceIds,
    required this.isCurrentUser,
  });

  factory MemberAccessSummary({
    required int membershipId,
    required String email,
    String? displayName,
    required _i2.CompanyRole role,
    required List<_i3.PlatformPermission> permissions,
    required bool isActive,
    required List<int> sharedDeviceIds,
    required List<int> writableDeviceIds,
    required bool isCurrentUser,
  }) = _MemberAccessSummaryImpl;

  factory MemberAccessSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemberAccessSummary(
      membershipId: jsonSerialization['membershipId'] as int,
      email: jsonSerialization['email'] as String,
      displayName: jsonSerialization['displayName'] as String?,
      role: _i2.CompanyRole.fromJson((jsonSerialization['role'] as String)),
      permissions: _i4.Protocol().deserialize<List<_i3.PlatformPermission>>(
        jsonSerialization['permissions'],
      ),
      isActive: _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      sharedDeviceIds: _i4.Protocol().deserialize<List<int>>(
        jsonSerialization['sharedDeviceIds'],
      ),
      writableDeviceIds: _i4.Protocol().deserialize<List<int>>(
        jsonSerialization['writableDeviceIds'],
      ),
      isCurrentUser: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isCurrentUser'],
      ),
    );
  }

  int membershipId;

  String email;

  String? displayName;

  _i2.CompanyRole role;

  List<_i3.PlatformPermission> permissions;

  bool isActive;

  List<int> sharedDeviceIds;

  List<int> writableDeviceIds;

  bool isCurrentUser;

  /// Returns a shallow copy of this [MemberAccessSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MemberAccessSummary copyWith({
    int? membershipId,
    String? email,
    String? displayName,
    _i2.CompanyRole? role,
    List<_i3.PlatformPermission>? permissions,
    bool? isActive,
    List<int>? sharedDeviceIds,
    List<int>? writableDeviceIds,
    bool? isCurrentUser,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemberAccessSummary',
      'membershipId': membershipId,
      'email': email,
      if (displayName != null) 'displayName': displayName,
      'role': role.toJson(),
      'permissions': permissions.toJson(valueToJson: (v) => v.toJson()),
      'isActive': isActive,
      'sharedDeviceIds': sharedDeviceIds.toJson(),
      'writableDeviceIds': writableDeviceIds.toJson(),
      'isCurrentUser': isCurrentUser,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemberAccessSummary',
      'membershipId': membershipId,
      'email': email,
      if (displayName != null) 'displayName': displayName,
      'role': role.toJson(),
      'permissions': permissions.toJson(valueToJson: (v) => v.toJson()),
      'isActive': isActive,
      'sharedDeviceIds': sharedDeviceIds.toJson(),
      'writableDeviceIds': writableDeviceIds.toJson(),
      'isCurrentUser': isCurrentUser,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemberAccessSummaryImpl extends MemberAccessSummary {
  _MemberAccessSummaryImpl({
    required int membershipId,
    required String email,
    String? displayName,
    required _i2.CompanyRole role,
    required List<_i3.PlatformPermission> permissions,
    required bool isActive,
    required List<int> sharedDeviceIds,
    required List<int> writableDeviceIds,
    required bool isCurrentUser,
  }) : super._(
         membershipId: membershipId,
         email: email,
         displayName: displayName,
         role: role,
         permissions: permissions,
         isActive: isActive,
         sharedDeviceIds: sharedDeviceIds,
         writableDeviceIds: writableDeviceIds,
         isCurrentUser: isCurrentUser,
       );

  /// Returns a shallow copy of this [MemberAccessSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MemberAccessSummary copyWith({
    int? membershipId,
    String? email,
    Object? displayName = _Undefined,
    _i2.CompanyRole? role,
    List<_i3.PlatformPermission>? permissions,
    bool? isActive,
    List<int>? sharedDeviceIds,
    List<int>? writableDeviceIds,
    bool? isCurrentUser,
  }) {
    return MemberAccessSummary(
      membershipId: membershipId ?? this.membershipId,
      email: email ?? this.email,
      displayName: displayName is String? ? displayName : this.displayName,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions.map((e0) => e0).toList(),
      isActive: isActive ?? this.isActive,
      sharedDeviceIds:
          sharedDeviceIds ?? this.sharedDeviceIds.map((e0) => e0).toList(),
      writableDeviceIds:
          writableDeviceIds ?? this.writableDeviceIds.map((e0) => e0).toList(),
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }
}
