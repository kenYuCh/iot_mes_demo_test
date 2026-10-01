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
import '../provisioning/provisioning_state.dart' as _i2;

/// 出廠設備登錄（Device Registry，手冊 §13）。
/// 公司出廠設備登錄。配對資格以公司 CA 簽發的 Factory Certificate 為準。
abstract class ProvisionedDevice implements _i1.SerializableModel {
  ProvisionedDevice._({
    this.id,
    required this.serial,
    required this.model,
    required this.claimCodeHash,
    this.manufacturerVerified,
    this.factoryCertificateFingerprint,
    this.manufacturerVerifiedAt,
    required this.state,
    this.companyId,
    this.claimedBy,
    this.claimedAt,
    this.linkedGatewayId,
    this.linkedDeviceId,
    required this.createdAt,
  });

  factory ProvisionedDevice({
    int? id,
    required String serial,
    required String model,
    required String claimCodeHash,
    bool? manufacturerVerified,
    String? factoryCertificateFingerprint,
    DateTime? manufacturerVerifiedAt,
    required _i2.ProvisioningState state,
    int? companyId,
    String? claimedBy,
    DateTime? claimedAt,
    int? linkedGatewayId,
    int? linkedDeviceId,
    required DateTime createdAt,
  }) = _ProvisionedDeviceImpl;

  factory ProvisionedDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProvisionedDevice(
      id: jsonSerialization['id'] as int?,
      serial: jsonSerialization['serial'] as String,
      model: jsonSerialization['model'] as String,
      claimCodeHash: jsonSerialization['claimCodeHash'] as String,
      manufacturerVerified: jsonSerialization['manufacturerVerified'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['manufacturerVerified'],
            ),
      factoryCertificateFingerprint:
          jsonSerialization['factoryCertificateFingerprint'] as String?,
      manufacturerVerifiedAt:
          jsonSerialization['manufacturerVerifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['manufacturerVerifiedAt'],
            ),
      state: _i2.ProvisioningState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      companyId: jsonSerialization['companyId'] as int?,
      claimedBy: jsonSerialization['claimedBy'] as String?,
      claimedAt: jsonSerialization['claimedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['claimedAt']),
      linkedGatewayId: jsonSerialization['linkedGatewayId'] as int?,
      linkedDeviceId: jsonSerialization['linkedDeviceId'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 設備序號（QR Code 內容之一），全域唯一。
  String serial;

  String model;

  /// 舊版 Claim Code 雜湊；新配對流程不再使用，保留以相容既有資料。
  String claimCodeHash;

  /// 是否已通過公司 Factory CA 憑證鏈與 CN 驗證。
  bool? manufacturerVerified;

  /// Factory Certificate SHA-256 指紋，用於稽核與防止憑證替換。
  String? factoryCertificateFingerprint;

  DateTime? manufacturerVerifiedAt;

  _i2.ProvisioningState state;

  /// 綁定後所屬公司。
  int? companyId;

  /// 完成綁定的使用者。
  String? claimedBy;

  DateTime? claimedAt;

  /// 加入設備庫後的平台關聯（GW 型號 → Gateway；感測器 → Device）。
  int? linkedGatewayId;

  int? linkedDeviceId;

  DateTime createdAt;

  /// Returns a shallow copy of this [ProvisionedDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProvisionedDevice copyWith({
    int? id,
    String? serial,
    String? model,
    String? claimCodeHash,
    bool? manufacturerVerified,
    String? factoryCertificateFingerprint,
    DateTime? manufacturerVerifiedAt,
    _i2.ProvisioningState? state,
    int? companyId,
    String? claimedBy,
    DateTime? claimedAt,
    int? linkedGatewayId,
    int? linkedDeviceId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProvisionedDevice',
      if (id != null) 'id': id,
      'serial': serial,
      'model': model,
      'claimCodeHash': claimCodeHash,
      if (manufacturerVerified != null)
        'manufacturerVerified': manufacturerVerified,
      if (factoryCertificateFingerprint != null)
        'factoryCertificateFingerprint': factoryCertificateFingerprint,
      if (manufacturerVerifiedAt != null)
        'manufacturerVerifiedAt': manufacturerVerifiedAt?.toJson(),
      'state': state.toJson(),
      if (companyId != null) 'companyId': companyId,
      if (claimedBy != null) 'claimedBy': claimedBy,
      if (claimedAt != null) 'claimedAt': claimedAt?.toJson(),
      if (linkedGatewayId != null) 'linkedGatewayId': linkedGatewayId,
      if (linkedDeviceId != null) 'linkedDeviceId': linkedDeviceId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProvisionedDeviceImpl extends ProvisionedDevice {
  _ProvisionedDeviceImpl({
    int? id,
    required String serial,
    required String model,
    required String claimCodeHash,
    bool? manufacturerVerified,
    String? factoryCertificateFingerprint,
    DateTime? manufacturerVerifiedAt,
    required _i2.ProvisioningState state,
    int? companyId,
    String? claimedBy,
    DateTime? claimedAt,
    int? linkedGatewayId,
    int? linkedDeviceId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         serial: serial,
         model: model,
         claimCodeHash: claimCodeHash,
         manufacturerVerified: manufacturerVerified,
         factoryCertificateFingerprint: factoryCertificateFingerprint,
         manufacturerVerifiedAt: manufacturerVerifiedAt,
         state: state,
         companyId: companyId,
         claimedBy: claimedBy,
         claimedAt: claimedAt,
         linkedGatewayId: linkedGatewayId,
         linkedDeviceId: linkedDeviceId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ProvisionedDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProvisionedDevice copyWith({
    Object? id = _Undefined,
    String? serial,
    String? model,
    String? claimCodeHash,
    Object? manufacturerVerified = _Undefined,
    Object? factoryCertificateFingerprint = _Undefined,
    Object? manufacturerVerifiedAt = _Undefined,
    _i2.ProvisioningState? state,
    Object? companyId = _Undefined,
    Object? claimedBy = _Undefined,
    Object? claimedAt = _Undefined,
    Object? linkedGatewayId = _Undefined,
    Object? linkedDeviceId = _Undefined,
    DateTime? createdAt,
  }) {
    return ProvisionedDevice(
      id: id is int? ? id : this.id,
      serial: serial ?? this.serial,
      model: model ?? this.model,
      claimCodeHash: claimCodeHash ?? this.claimCodeHash,
      manufacturerVerified: manufacturerVerified is bool?
          ? manufacturerVerified
          : this.manufacturerVerified,
      factoryCertificateFingerprint: factoryCertificateFingerprint is String?
          ? factoryCertificateFingerprint
          : this.factoryCertificateFingerprint,
      manufacturerVerifiedAt: manufacturerVerifiedAt is DateTime?
          ? manufacturerVerifiedAt
          : this.manufacturerVerifiedAt,
      state: state ?? this.state,
      companyId: companyId is int? ? companyId : this.companyId,
      claimedBy: claimedBy is String? ? claimedBy : this.claimedBy,
      claimedAt: claimedAt is DateTime? ? claimedAt : this.claimedAt,
      linkedGatewayId: linkedGatewayId is int?
          ? linkedGatewayId
          : this.linkedGatewayId,
      linkedDeviceId: linkedDeviceId is int?
          ? linkedDeviceId
          : this.linkedDeviceId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
