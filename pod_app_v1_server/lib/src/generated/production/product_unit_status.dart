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

enum ProductUnitStatus implements _i1.SerializableModel {
  created,
  inProgress,
  waiting,
  awaitingTransfer,
  passed,
  failed,
  rework,
  scrapped,
  completed;

  static ProductUnitStatus fromJson(String name) {
    switch (name) {
      case 'created':
        return ProductUnitStatus.created;
      case 'inProgress':
        return ProductUnitStatus.inProgress;
      case 'waiting':
        return ProductUnitStatus.waiting;
      case 'awaitingTransfer':
        return ProductUnitStatus.awaitingTransfer;
      case 'passed':
        return ProductUnitStatus.passed;
      case 'failed':
        return ProductUnitStatus.failed;
      case 'rework':
        return ProductUnitStatus.rework;
      case 'scrapped':
        return ProductUnitStatus.scrapped;
      case 'completed':
        return ProductUnitStatus.completed;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ProductUnitStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
