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

/// 設備功能值的資料語意；傳輸層統一使用 double 以維持即時資料效能。
enum FeatureDataType implements _i1.SerializableModel {
  number,
  boolean,
  enumeration;

  static FeatureDataType fromJson(String name) {
    switch (name) {
      case 'number':
        return FeatureDataType.number;
      case 'boolean':
        return FeatureDataType.boolean;
      case 'enumeration':
        return FeatureDataType.enumeration;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "FeatureDataType"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
