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

/// 已簽發的設備憑證（手冊 §13）。憑證為公開資訊可入庫；
/// 私鑰永不落地（由設備自持，手冊 §2）。
abstract class DeviceCertificate implements _i1.SerializableModel {
  DeviceCertificate._({
    this.id,
    required this.serial,
    required this.certSerialNumber,
    required this.subjectCn,
    required this.certificatePem,
    required this.version,
    required this.issuedAt,
    required this.expiresAt,
    required this.revoked,
    this.revokedAt,
  });

  factory DeviceCertificate({
    int? id,
    required String serial,
    required String certSerialNumber,
    required String subjectCn,
    required String certificatePem,
    required int version,
    required DateTime issuedAt,
    required DateTime expiresAt,
    required bool revoked,
    DateTime? revokedAt,
  }) = _DeviceCertificateImpl;

  factory DeviceCertificate.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceCertificate(
      id: jsonSerialization['id'] as int?,
      serial: jsonSerialization['serial'] as String,
      certSerialNumber: jsonSerialization['certSerialNumber'] as String,
      subjectCn: jsonSerialization['subjectCn'] as String,
      certificatePem: jsonSerialization['certificatePem'] as String,
      version: jsonSerialization['version'] as int,
      issuedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['issuedAt'],
      ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      revoked: _i1.BoolJsonExtension.fromJson(jsonSerialization['revoked']),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String serial;

  /// 憑證序號（OpenSSL 簽發時的 serial number，hex）。
  String certSerialNumber;

  String subjectCn;

  /// 憑證 PEM（公開）。
  String certificatePem;

  int version;

  DateTime issuedAt;

  DateTime expiresAt;

  bool revoked;

  DateTime? revokedAt;

  /// Returns a shallow copy of this [DeviceCertificate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceCertificate copyWith({
    int? id,
    String? serial,
    String? certSerialNumber,
    String? subjectCn,
    String? certificatePem,
    int? version,
    DateTime? issuedAt,
    DateTime? expiresAt,
    bool? revoked,
    DateTime? revokedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceCertificate',
      if (id != null) 'id': id,
      'serial': serial,
      'certSerialNumber': certSerialNumber,
      'subjectCn': subjectCn,
      'certificatePem': certificatePem,
      'version': version,
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      'revoked': revoked,
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceCertificateImpl extends DeviceCertificate {
  _DeviceCertificateImpl({
    int? id,
    required String serial,
    required String certSerialNumber,
    required String subjectCn,
    required String certificatePem,
    required int version,
    required DateTime issuedAt,
    required DateTime expiresAt,
    required bool revoked,
    DateTime? revokedAt,
  }) : super._(
         id: id,
         serial: serial,
         certSerialNumber: certSerialNumber,
         subjectCn: subjectCn,
         certificatePem: certificatePem,
         version: version,
         issuedAt: issuedAt,
         expiresAt: expiresAt,
         revoked: revoked,
         revokedAt: revokedAt,
       );

  /// Returns a shallow copy of this [DeviceCertificate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceCertificate copyWith({
    Object? id = _Undefined,
    String? serial,
    String? certSerialNumber,
    String? subjectCn,
    String? certificatePem,
    int? version,
    DateTime? issuedAt,
    DateTime? expiresAt,
    bool? revoked,
    Object? revokedAt = _Undefined,
  }) {
    return DeviceCertificate(
      id: id is int? ? id : this.id,
      serial: serial ?? this.serial,
      certSerialNumber: certSerialNumber ?? this.certSerialNumber,
      subjectCn: subjectCn ?? this.subjectCn,
      certificatePem: certificatePem ?? this.certificatePem,
      version: version ?? this.version,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      revoked: revoked ?? this.revoked,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
    );
  }
}
