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

enum ProcessEventType implements _i1.SerializableModel {
  arrived,
  started,
  completed,
  inspected,
  reworked,
  skipped,
  paused,
  scrapped,
  transferOut,
  transferIn;

  static ProcessEventType fromJson(String name) {
    switch (name) {
      case 'arrived':
        return ProcessEventType.arrived;
      case 'started':
        return ProcessEventType.started;
      case 'completed':
        return ProcessEventType.completed;
      case 'inspected':
        return ProcessEventType.inspected;
      case 'reworked':
        return ProcessEventType.reworked;
      case 'skipped':
        return ProcessEventType.skipped;
      case 'paused':
        return ProcessEventType.paused;
      case 'scrapped':
        return ProcessEventType.scrapped;
      case 'transferOut':
        return ProcessEventType.transferOut;
      case 'transferIn':
        return ProcessEventType.transferIn;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ProcessEventType"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
