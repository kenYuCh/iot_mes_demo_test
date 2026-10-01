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
import '../command/device_command_state.dart' as _i2;
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i3;

/// 下發至裝置的控制命令（冪等，一鍵一命令）。
abstract class DeviceCommand implements _i1.SerializableModel {
  DeviceCommand._({
    this.id,
    required this.companyId,
    required this.deviceId,
    required this.commandType,
    required this.payload,
    required this.state,
    required this.idempotencyKey,
    required this.issuedBy,
    this.errorMessage,
    required this.createdAt,
    this.sentAt,
    this.acknowledgedAt,
    this.completedAt,
  });

  factory DeviceCommand({
    int? id,
    required int companyId,
    required int deviceId,
    required String commandType,
    required Map<String, String> payload,
    required _i2.DeviceCommandState state,
    required String idempotencyKey,
    required String issuedBy,
    String? errorMessage,
    required DateTime createdAt,
    DateTime? sentAt,
    DateTime? acknowledgedAt,
    DateTime? completedAt,
  }) = _DeviceCommandImpl;

  factory DeviceCommand.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceCommand(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      commandType: jsonSerialization['commandType'] as String,
      payload: _i3.Protocol().deserialize<Map<String, String>>(
        jsonSerialization['payload'],
      ),
      state: _i2.DeviceCommandState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      idempotencyKey: jsonSerialization['idempotencyKey'] as String,
      issuedBy: jsonSerialization['issuedBy'] as String,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt'],
            ),
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

  int deviceId;

  /// 命令類型，例如 reboot、calibrate、setInterval。
  String commandType;

  /// 命令參數。
  Map<String, String> payload;

  _i2.DeviceCommandState state;

  /// 冪等鍵：同一鍵重複下發時回傳既有命令，不重複建立。
  String idempotencyKey;

  /// 下發者（authUserId）。
  String issuedBy;

  /// 失敗或逾時原因。
  String? errorMessage;

  DateTime createdAt;

  DateTime? sentAt;

  DateTime? acknowledgedAt;

  /// 進入終態（completed/failed/timedOut/cancelled）時間。
  DateTime? completedAt;

  /// Returns a shallow copy of this [DeviceCommand]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceCommand copyWith({
    int? id,
    int? companyId,
    int? deviceId,
    String? commandType,
    Map<String, String>? payload,
    _i2.DeviceCommandState? state,
    String? idempotencyKey,
    String? issuedBy,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? sentAt,
    DateTime? acknowledgedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceCommand',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'commandType': commandType,
      'payload': payload.toJson(),
      'state': state.toJson(),
      'idempotencyKey': idempotencyKey,
      'issuedBy': issuedBy,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'createdAt': createdAt.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceCommandImpl extends DeviceCommand {
  _DeviceCommandImpl({
    int? id,
    required int companyId,
    required int deviceId,
    required String commandType,
    required Map<String, String> payload,
    required _i2.DeviceCommandState state,
    required String idempotencyKey,
    required String issuedBy,
    String? errorMessage,
    required DateTime createdAt,
    DateTime? sentAt,
    DateTime? acknowledgedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         deviceId: deviceId,
         commandType: commandType,
         payload: payload,
         state: state,
         idempotencyKey: idempotencyKey,
         issuedBy: issuedBy,
         errorMessage: errorMessage,
         createdAt: createdAt,
         sentAt: sentAt,
         acknowledgedAt: acknowledgedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [DeviceCommand]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceCommand copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? deviceId,
    String? commandType,
    Map<String, String>? payload,
    _i2.DeviceCommandState? state,
    String? idempotencyKey,
    String? issuedBy,
    Object? errorMessage = _Undefined,
    DateTime? createdAt,
    Object? sentAt = _Undefined,
    Object? acknowledgedAt = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return DeviceCommand(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      deviceId: deviceId ?? this.deviceId,
      commandType: commandType ?? this.commandType,
      payload:
          payload ??
          this.payload.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      state: state ?? this.state,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      issuedBy: issuedBy ?? this.issuedBy,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      acknowledgedAt: acknowledgedAt is DateTime?
          ? acknowledgedAt
          : this.acknowledgedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}
