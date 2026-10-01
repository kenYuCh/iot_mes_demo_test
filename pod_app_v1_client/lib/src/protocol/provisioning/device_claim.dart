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

/// Claim Session（手冊 §7）：使用者掃碼後建立，效期 5 分鐘，
/// 等待設備以 Bootstrap 身分回應 claim-confirm。
abstract class DeviceClaim implements _i1.SerializableModel {
  DeviceClaim._({
    this.id,
    required this.sessionId,
    required this.serial,
    required this.userIdentifier,
    required this.companyId,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
    this.confirmedAt,
  });

  factory DeviceClaim({
    int? id,
    required String sessionId,
    required String serial,
    required String userIdentifier,
    required int companyId,
    required String status,
    required DateTime expiresAt,
    required DateTime createdAt,
    DateTime? confirmedAt,
  }) = _DeviceClaimImpl;

  factory DeviceClaim.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceClaim(
      id: jsonSerialization['id'] as int?,
      sessionId: jsonSerialization['sessionId'] as String,
      serial: jsonSerialization['serial'] as String,
      userIdentifier: jsonSerialization['userIdentifier'] as String,
      companyId: jsonSerialization['companyId'] as int,
      status: jsonSerialization['status'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      confirmedAt: jsonSerialization['confirmedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['confirmedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 對外的 claim_session_id。
  String sessionId;

  String serial;

  /// 發起綁定的使用者。
  String userIdentifier;

  int companyId;

  /// waiting_for_device / confirmed / expired。
  String status;

  DateTime expiresAt;

  DateTime createdAt;

  DateTime? confirmedAt;

  /// Returns a shallow copy of this [DeviceClaim]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceClaim copyWith({
    int? id,
    String? sessionId,
    String? serial,
    String? userIdentifier,
    int? companyId,
    String? status,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? confirmedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceClaim',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'serial': serial,
      'userIdentifier': userIdentifier,
      'companyId': companyId,
      'status': status,
      'expiresAt': expiresAt.toJson(),
      'createdAt': createdAt.toJson(),
      if (confirmedAt != null) 'confirmedAt': confirmedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceClaimImpl extends DeviceClaim {
  _DeviceClaimImpl({
    int? id,
    required String sessionId,
    required String serial,
    required String userIdentifier,
    required int companyId,
    required String status,
    required DateTime expiresAt,
    required DateTime createdAt,
    DateTime? confirmedAt,
  }) : super._(
         id: id,
         sessionId: sessionId,
         serial: serial,
         userIdentifier: userIdentifier,
         companyId: companyId,
         status: status,
         expiresAt: expiresAt,
         createdAt: createdAt,
         confirmedAt: confirmedAt,
       );

  /// Returns a shallow copy of this [DeviceClaim]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceClaim copyWith({
    Object? id = _Undefined,
    String? sessionId,
    String? serial,
    String? userIdentifier,
    int? companyId,
    String? status,
    DateTime? expiresAt,
    DateTime? createdAt,
    Object? confirmedAt = _Undefined,
  }) {
    return DeviceClaim(
      id: id is int? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      serial: serial ?? this.serial,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      companyId: companyId ?? this.companyId,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      confirmedAt: confirmedAt is DateTime? ? confirmedAt : this.confirmedAt,
    );
  }
}
