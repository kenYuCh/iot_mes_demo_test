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
import '../ota/ota_job_state.dart' as _i2;

/// 單台設備的 OTA 狀態，可獨立失敗、重試或回滾。
abstract class OtaDeviceJob implements _i1.SerializableModel {
  OtaDeviceJob._({
    this.id,
    required this.companyId,
    required this.campaignId,
    this.deviceId,
    this.gatewayId,
    required this.state,
    required this.progress,
    this.previousVersion,
    this.errorMessage,
    required this.updatedAt,
  });

  factory OtaDeviceJob({
    int? id,
    required int companyId,
    required int campaignId,
    int? deviceId,
    int? gatewayId,
    required _i2.OtaJobState state,
    required int progress,
    String? previousVersion,
    String? errorMessage,
    required DateTime updatedAt,
  }) = _OtaDeviceJobImpl;

  factory OtaDeviceJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return OtaDeviceJob(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      campaignId: jsonSerialization['campaignId'] as int,
      deviceId: jsonSerialization['deviceId'] as int?,
      gatewayId: jsonSerialization['gatewayId'] as int?,
      state: _i2.OtaJobState.fromJson((jsonSerialization['state'] as String)),
      progress: jsonSerialization['progress'] as int,
      previousVersion: jsonSerialization['previousVersion'] as String?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
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

  int campaignId;

  /// 一般感測／致動設備與 Gateway 二擇一。
  int? deviceId;

  int? gatewayId;

  _i2.OtaJobState state;

  int progress;

  String? previousVersion;

  String? errorMessage;

  DateTime updatedAt;

  /// Returns a shallow copy of this [OtaDeviceJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OtaDeviceJob copyWith({
    int? id,
    int? companyId,
    int? campaignId,
    int? deviceId,
    int? gatewayId,
    _i2.OtaJobState? state,
    int? progress,
    String? previousVersion,
    String? errorMessage,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OtaDeviceJob',
      if (id != null) 'id': id,
      'companyId': companyId,
      'campaignId': campaignId,
      if (deviceId != null) 'deviceId': deviceId,
      if (gatewayId != null) 'gatewayId': gatewayId,
      'state': state.toJson(),
      'progress': progress,
      if (previousVersion != null) 'previousVersion': previousVersion,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OtaDeviceJobImpl extends OtaDeviceJob {
  _OtaDeviceJobImpl({
    int? id,
    required int companyId,
    required int campaignId,
    int? deviceId,
    int? gatewayId,
    required _i2.OtaJobState state,
    required int progress,
    String? previousVersion,
    String? errorMessage,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         campaignId: campaignId,
         deviceId: deviceId,
         gatewayId: gatewayId,
         state: state,
         progress: progress,
         previousVersion: previousVersion,
         errorMessage: errorMessage,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [OtaDeviceJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OtaDeviceJob copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? campaignId,
    Object? deviceId = _Undefined,
    Object? gatewayId = _Undefined,
    _i2.OtaJobState? state,
    int? progress,
    Object? previousVersion = _Undefined,
    Object? errorMessage = _Undefined,
    DateTime? updatedAt,
  }) {
    return OtaDeviceJob(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      campaignId: campaignId ?? this.campaignId,
      deviceId: deviceId is int? ? deviceId : this.deviceId,
      gatewayId: gatewayId is int? ? gatewayId : this.gatewayId,
      state: state ?? this.state,
      progress: progress ?? this.progress,
      previousVersion: previousVersion is String?
          ? previousVersion
          : this.previousVersion,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
