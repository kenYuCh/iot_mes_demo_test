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
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i2;

abstract class AuditLog implements _i1.SerializableModel {
  AuditLog._({
    this.id,
    required this.companyId,
    required this.userIdentifier,
    required this.source,
    required this.action,
    required this.resourceType,
    this.resourceId,
    this.deviceId,
    required this.summary,
    this.details,
    required this.success,
    required this.createdAt,
  });

  factory AuditLog({
    int? id,
    required int companyId,
    required String userIdentifier,
    required String source,
    required String action,
    required String resourceType,
    int? resourceId,
    int? deviceId,
    required String summary,
    Map<String, String>? details,
    required bool success,
    required DateTime createdAt,
  }) = _AuditLogImpl;

  factory AuditLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditLog(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      userIdentifier: jsonSerialization['userIdentifier'] as String,
      source: jsonSerialization['source'] as String,
      action: jsonSerialization['action'] as String,
      resourceType: jsonSerialization['resourceType'] as String,
      resourceId: jsonSerialization['resourceId'] as int?,
      deviceId: jsonSerialization['deviceId'] as int?,
      summary: jsonSerialization['summary'] as String,
      details: jsonSerialization['details'] == null
          ? null
          : _i2.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['details'],
            ),
      success: _i1.BoolJsonExtension.fromJson(jsonSerialization['success']),
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

  String userIdentifier;

  String source;

  String action;

  String resourceType;

  int? resourceId;

  int? deviceId;

  String summary;

  Map<String, String>? details;

  bool success;

  DateTime createdAt;

  /// Returns a shallow copy of this [AuditLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditLog copyWith({
    int? id,
    int? companyId,
    String? userIdentifier,
    String? source,
    String? action,
    String? resourceType,
    int? resourceId,
    int? deviceId,
    String? summary,
    Map<String, String>? details,
    bool? success,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditLog',
      if (id != null) 'id': id,
      'companyId': companyId,
      'userIdentifier': userIdentifier,
      'source': source,
      'action': action,
      'resourceType': resourceType,
      if (resourceId != null) 'resourceId': resourceId,
      if (deviceId != null) 'deviceId': deviceId,
      'summary': summary,
      if (details != null) 'details': details?.toJson(),
      'success': success,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditLogImpl extends AuditLog {
  _AuditLogImpl({
    int? id,
    required int companyId,
    required String userIdentifier,
    required String source,
    required String action,
    required String resourceType,
    int? resourceId,
    int? deviceId,
    required String summary,
    Map<String, String>? details,
    required bool success,
    required DateTime createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         userIdentifier: userIdentifier,
         source: source,
         action: action,
         resourceType: resourceType,
         resourceId: resourceId,
         deviceId: deviceId,
         summary: summary,
         details: details,
         success: success,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AuditLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditLog copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? userIdentifier,
    String? source,
    String? action,
    String? resourceType,
    Object? resourceId = _Undefined,
    Object? deviceId = _Undefined,
    String? summary,
    Object? details = _Undefined,
    bool? success,
    DateTime? createdAt,
  }) {
    return AuditLog(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      source: source ?? this.source,
      action: action ?? this.action,
      resourceType: resourceType ?? this.resourceType,
      resourceId: resourceId is int? ? resourceId : this.resourceId,
      deviceId: deviceId is int? ? deviceId : this.deviceId,
      summary: summary ?? this.summary,
      details: details is Map<String, String>?
          ? details
          : this.details?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      success: success ?? this.success,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
