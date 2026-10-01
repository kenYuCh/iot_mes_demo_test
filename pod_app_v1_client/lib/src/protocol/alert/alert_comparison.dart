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

/// 告警規則的比較運算子。
enum AlertComparison implements _i1.SerializableModel {
  /// 量測值大於閾值時觸發。
  greaterThan,

  /// 量測值大於等於閾值時觸發。
  greaterOrEqual,

  /// 量測值小於閾值時觸發。
  lessThan,

  /// 量測值小於等於閾值時觸發。
  lessOrEqual;

  static AlertComparison fromJson(String name) {
    switch (name) {
      case 'greaterThan':
        return AlertComparison.greaterThan;
      case 'greaterOrEqual':
        return AlertComparison.greaterOrEqual;
      case 'lessThan':
        return AlertComparison.lessThan;
      case 'lessOrEqual':
        return AlertComparison.lessOrEqual;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "AlertComparison"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
