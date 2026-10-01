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
import '../company/company_role.dart' as _i2;
import '../company/platform_permission.dart' as _i3;
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i4;

/// 使用者與公司的隸屬關係。垂直切片先支援單一公司；完整 RBAC 於第二階段擴充。
abstract class CompanyMembership implements _i1.SerializableModel {
  CompanyMembership._({
    this.id,
    required this.companyId,
    required this.authUserId,
    this.role,
    this.permissions,
    this.email,
    this.displayName,
    bool? isActive,
    required this.createdAt,
  }) : isActive = isActive ?? true;

  factory CompanyMembership({
    int? id,
    required int companyId,
    required String authUserId,
    _i2.CompanyRole? role,
    List<_i3.PlatformPermission>? permissions,
    String? email,
    String? displayName,
    bool? isActive,
    required DateTime createdAt,
  }) = _CompanyMembershipImpl;

  factory CompanyMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompanyMembership(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      authUserId: jsonSerialization['authUserId'] as String,
      role: jsonSerialization['role'] == null
          ? null
          : _i2.CompanyRole.fromJson((jsonSerialization['role'] as String)),
      permissions: jsonSerialization['permissions'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.PlatformPermission>>(
              jsonSerialization['permissions'],
            ),
      email: jsonSerialization['email'] as String?,
      displayName: jsonSerialization['displayName'] as String?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
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

  /// Serverpod auth 的使用者識別字串。
  String authUserId;

  /// 舊資料為 null 時視為開發環境 admin；新加入者預設 viewer。
  _i2.CompanyRole? role;

  /// 額外模組權限；null 依角色套用預設權限，便於舊資料相容。
  List<_i3.PlatformPermission>? permissions;

  /// 帳戶顯示資訊快照，避免將 auth 內部資料直接暴露給 Client。
  String? email;

  String? displayName;

  bool isActive;

  DateTime createdAt;

  /// Returns a shallow copy of this [CompanyMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CompanyMembership copyWith({
    int? id,
    int? companyId,
    String? authUserId,
    _i2.CompanyRole? role,
    List<_i3.PlatformPermission>? permissions,
    String? email,
    String? displayName,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CompanyMembership',
      if (id != null) 'id': id,
      'companyId': companyId,
      'authUserId': authUserId,
      if (role != null) 'role': role?.toJson(),
      if (permissions != null)
        'permissions': permissions?.toJson(valueToJson: (v) => v.toJson()),
      if (email != null) 'email': email,
      if (displayName != null) 'displayName': displayName,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanyMembershipImpl extends CompanyMembership {
  _CompanyMembershipImpl({
    int? id,
    required int companyId,
    required String authUserId,
    _i2.CompanyRole? role,
    List<_i3.PlatformPermission>? permissions,
    String? email,
    String? displayName,
    bool? isActive,
    required DateTime createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         authUserId: authUserId,
         role: role,
         permissions: permissions,
         email: email,
         displayName: displayName,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CompanyMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CompanyMembership copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? authUserId,
    Object? role = _Undefined,
    Object? permissions = _Undefined,
    Object? email = _Undefined,
    Object? displayName = _Undefined,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return CompanyMembership(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      authUserId: authUserId ?? this.authUserId,
      role: role is _i2.CompanyRole? ? role : this.role,
      permissions: permissions is List<_i3.PlatformPermission>?
          ? permissions
          : this.permissions?.map((e0) => e0).toList(),
      email: email is String? ? email : this.email,
      displayName: displayName is String? ? displayName : this.displayName,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
