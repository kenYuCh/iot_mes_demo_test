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

/// 憑證簽發回應（手冊 §8）。私鑰不在其中——由設備自持。
abstract class CertificateIssueResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CertificateIssueResult._({
    required this.deviceCertificate,
    required this.intermediateCa,
    required this.rootCa,
    required this.mqttHost,
    required this.mqttPort,
    required this.mqttClientId,
    required this.certificateVersion,
    required this.expiresAt,
  });

  factory CertificateIssueResult({
    required String deviceCertificate,
    required String intermediateCa,
    required String rootCa,
    required String mqttHost,
    required int mqttPort,
    required String mqttClientId,
    required int certificateVersion,
    required DateTime expiresAt,
  }) = _CertificateIssueResultImpl;

  factory CertificateIssueResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CertificateIssueResult(
      deviceCertificate: jsonSerialization['deviceCertificate'] as String,
      intermediateCa: jsonSerialization['intermediateCa'] as String,
      rootCa: jsonSerialization['rootCa'] as String,
      mqttHost: jsonSerialization['mqttHost'] as String,
      mqttPort: jsonSerialization['mqttPort'] as int,
      mqttClientId: jsonSerialization['mqttClientId'] as String,
      certificateVersion: jsonSerialization['certificateVersion'] as int,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  /// 設備憑證 PEM。
  String deviceCertificate;

  /// 中介 CA PEM（設備需保存完整信任鏈）。
  String intermediateCa;

  /// Root CA PEM（設備用於驗證伺服器）。
  String rootCa;

  String mqttHost;

  int mqttPort;

  String mqttClientId;

  int certificateVersion;

  DateTime expiresAt;

  /// Returns a shallow copy of this [CertificateIssueResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CertificateIssueResult copyWith({
    String? deviceCertificate,
    String? intermediateCa,
    String? rootCa,
    String? mqttHost,
    int? mqttPort,
    String? mqttClientId,
    int? certificateVersion,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CertificateIssueResult',
      'deviceCertificate': deviceCertificate,
      'intermediateCa': intermediateCa,
      'rootCa': rootCa,
      'mqttHost': mqttHost,
      'mqttPort': mqttPort,
      'mqttClientId': mqttClientId,
      'certificateVersion': certificateVersion,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CertificateIssueResult',
      'deviceCertificate': deviceCertificate,
      'intermediateCa': intermediateCa,
      'rootCa': rootCa,
      'mqttHost': mqttHost,
      'mqttPort': mqttPort,
      'mqttClientId': mqttClientId,
      'certificateVersion': certificateVersion,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CertificateIssueResultImpl extends CertificateIssueResult {
  _CertificateIssueResultImpl({
    required String deviceCertificate,
    required String intermediateCa,
    required String rootCa,
    required String mqttHost,
    required int mqttPort,
    required String mqttClientId,
    required int certificateVersion,
    required DateTime expiresAt,
  }) : super._(
         deviceCertificate: deviceCertificate,
         intermediateCa: intermediateCa,
         rootCa: rootCa,
         mqttHost: mqttHost,
         mqttPort: mqttPort,
         mqttClientId: mqttClientId,
         certificateVersion: certificateVersion,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [CertificateIssueResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CertificateIssueResult copyWith({
    String? deviceCertificate,
    String? intermediateCa,
    String? rootCa,
    String? mqttHost,
    int? mqttPort,
    String? mqttClientId,
    int? certificateVersion,
    DateTime? expiresAt,
  }) {
    return CertificateIssueResult(
      deviceCertificate: deviceCertificate ?? this.deviceCertificate,
      intermediateCa: intermediateCa ?? this.intermediateCa,
      rootCa: rootCa ?? this.rootCa,
      mqttHost: mqttHost ?? this.mqttHost,
      mqttPort: mqttPort ?? this.mqttPort,
      mqttClientId: mqttClientId ?? this.mqttClientId,
      certificateVersion: certificateVersion ?? this.certificateVersion,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
