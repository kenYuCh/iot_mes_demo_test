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

/// 綁定請求回應（手冊 §7：claim_session_id + expires_in + status）。
abstract class ClaimSessionResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ClaimSessionResult._({
    required this.claimSessionId,
    required this.expiresInSeconds,
    required this.status,
    required this.serial,
  });

  factory ClaimSessionResult({
    required String claimSessionId,
    required int expiresInSeconds,
    required String status,
    required String serial,
  }) = _ClaimSessionResultImpl;

  factory ClaimSessionResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClaimSessionResult(
      claimSessionId: jsonSerialization['claimSessionId'] as String,
      expiresInSeconds: jsonSerialization['expiresInSeconds'] as int,
      status: jsonSerialization['status'] as String,
      serial: jsonSerialization['serial'] as String,
    );
  }

  String claimSessionId;

  int expiresInSeconds;

  String status;

  String serial;

  /// Returns a shallow copy of this [ClaimSessionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClaimSessionResult copyWith({
    String? claimSessionId,
    int? expiresInSeconds,
    String? status,
    String? serial,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClaimSessionResult',
      'claimSessionId': claimSessionId,
      'expiresInSeconds': expiresInSeconds,
      'status': status,
      'serial': serial,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClaimSessionResult',
      'claimSessionId': claimSessionId,
      'expiresInSeconds': expiresInSeconds,
      'status': status,
      'serial': serial,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ClaimSessionResultImpl extends ClaimSessionResult {
  _ClaimSessionResultImpl({
    required String claimSessionId,
    required int expiresInSeconds,
    required String status,
    required String serial,
  }) : super._(
         claimSessionId: claimSessionId,
         expiresInSeconds: expiresInSeconds,
         status: status,
         serial: serial,
       );

  /// Returns a shallow copy of this [ClaimSessionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClaimSessionResult copyWith({
    String? claimSessionId,
    int? expiresInSeconds,
    String? status,
    String? serial,
  }) {
    return ClaimSessionResult(
      claimSessionId: claimSessionId ?? this.claimSessionId,
      expiresInSeconds: expiresInSeconds ?? this.expiresInSeconds,
      status: status ?? this.status,
      serial: serial ?? this.serial,
    );
  }
}
