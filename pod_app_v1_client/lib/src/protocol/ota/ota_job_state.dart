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

enum OtaJobState implements _i1.SerializableModel {
  pending,
  downloading,
  installing,
  verifying,
  succeeded,
  failed,
  cancelled,
  rolledBack;

  static OtaJobState fromJson(String name) {
    switch (name) {
      case 'pending':
        return OtaJobState.pending;
      case 'downloading':
        return OtaJobState.downloading;
      case 'installing':
        return OtaJobState.installing;
      case 'verifying':
        return OtaJobState.verifying;
      case 'succeeded':
        return OtaJobState.succeeded;
      case 'failed':
        return OtaJobState.failed;
      case 'cancelled':
        return OtaJobState.cancelled;
      case 'rolledBack':
        return OtaJobState.rolledBack;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "OtaJobState"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
