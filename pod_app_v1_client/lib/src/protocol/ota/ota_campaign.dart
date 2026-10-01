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
import '../ota/ota_strategy.dart' as _i2;
import '../ota/ota_campaign_state.dart' as _i3;

/// 一次 OTA 發布活動；每台目標設備另有 OtaDeviceJob。
abstract class OtaCampaign implements _i1.SerializableModel {
  OtaCampaign._({
    this.id,
    required this.companyId,
    required this.firmwarePackageId,
    required this.name,
    required this.targetDeviceType,
    required this.strategy,
    required this.state,
    this.scheduledAt,
    required this.totalDevices,
    required this.succeededDevices,
    required this.failedDevices,
    required this.createdBy,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
  });

  factory OtaCampaign({
    int? id,
    required int companyId,
    required int firmwarePackageId,
    required String name,
    required String targetDeviceType,
    required _i2.OtaStrategy strategy,
    required _i3.OtaCampaignState state,
    DateTime? scheduledAt,
    required int totalDevices,
    required int succeededDevices,
    required int failedDevices,
    required String createdBy,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _OtaCampaignImpl;

  factory OtaCampaign.fromJson(Map<String, dynamic> jsonSerialization) {
    return OtaCampaign(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      firmwarePackageId: jsonSerialization['firmwarePackageId'] as int,
      name: jsonSerialization['name'] as String,
      targetDeviceType: jsonSerialization['targetDeviceType'] as String,
      strategy: _i2.OtaStrategy.fromJson(
        (jsonSerialization['strategy'] as String),
      ),
      state: _i3.OtaCampaignState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      scheduledAt: jsonSerialization['scheduledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scheduledAt'],
            ),
      totalDevices: jsonSerialization['totalDevices'] as int,
      succeededDevices: jsonSerialization['succeededDevices'] as int,
      failedDevices: jsonSerialization['failedDevices'] as int,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  int firmwarePackageId;

  String name;

  String targetDeviceType;

  _i2.OtaStrategy strategy;

  _i3.OtaCampaignState state;

  DateTime? scheduledAt;

  int totalDevices;

  int succeededDevices;

  int failedDevices;

  String createdBy;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? completedAt;

  /// Returns a shallow copy of this [OtaCampaign]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OtaCampaign copyWith({
    int? id,
    int? companyId,
    int? firmwarePackageId,
    String? name,
    String? targetDeviceType,
    _i2.OtaStrategy? strategy,
    _i3.OtaCampaignState? state,
    DateTime? scheduledAt,
    int? totalDevices,
    int? succeededDevices,
    int? failedDevices,
    String? createdBy,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OtaCampaign',
      if (id != null) 'id': id,
      'companyId': companyId,
      'firmwarePackageId': firmwarePackageId,
      'name': name,
      'targetDeviceType': targetDeviceType,
      'strategy': strategy.toJson(),
      'state': state.toJson(),
      if (scheduledAt != null) 'scheduledAt': scheduledAt?.toJson(),
      'totalDevices': totalDevices,
      'succeededDevices': succeededDevices,
      'failedDevices': failedDevices,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OtaCampaignImpl extends OtaCampaign {
  _OtaCampaignImpl({
    int? id,
    required int companyId,
    required int firmwarePackageId,
    required String name,
    required String targetDeviceType,
    required _i2.OtaStrategy strategy,
    required _i3.OtaCampaignState state,
    DateTime? scheduledAt,
    required int totalDevices,
    required int succeededDevices,
    required int failedDevices,
    required String createdBy,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         firmwarePackageId: firmwarePackageId,
         name: name,
         targetDeviceType: targetDeviceType,
         strategy: strategy,
         state: state,
         scheduledAt: scheduledAt,
         totalDevices: totalDevices,
         succeededDevices: succeededDevices,
         failedDevices: failedDevices,
         createdBy: createdBy,
         createdAt: createdAt,
         startedAt: startedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [OtaCampaign]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OtaCampaign copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? firmwarePackageId,
    String? name,
    String? targetDeviceType,
    _i2.OtaStrategy? strategy,
    _i3.OtaCampaignState? state,
    Object? scheduledAt = _Undefined,
    int? totalDevices,
    int? succeededDevices,
    int? failedDevices,
    String? createdBy,
    DateTime? createdAt,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return OtaCampaign(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      firmwarePackageId: firmwarePackageId ?? this.firmwarePackageId,
      name: name ?? this.name,
      targetDeviceType: targetDeviceType ?? this.targetDeviceType,
      strategy: strategy ?? this.strategy,
      state: state ?? this.state,
      scheduledAt: scheduledAt is DateTime? ? scheduledAt : this.scheduledAt,
      totalDevices: totalDevices ?? this.totalDevices,
      succeededDevices: succeededDevices ?? this.succeededDevices,
      failedDevices: failedDevices ?? this.failedDevices,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}
