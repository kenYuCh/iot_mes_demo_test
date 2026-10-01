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

/// 告警狀態。
enum AlertState implements _i1.SerializableModel {
  /// 觸發中，數值仍超出閾值。
  active,

  /// 使用者已確認，但條件尚未恢復。
  acknowledged,

  /// 數值已恢復正常。
  resolved;

  static AlertState fromJson(String name) {
    switch (name) {
      case 'active':
        return AlertState.active;
      case 'acknowledged':
        return AlertState.acknowledged;
      case 'resolved':
        return AlertState.resolved;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "AlertState"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
