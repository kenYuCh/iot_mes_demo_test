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

/// 致動器在行動端的建議操作元件。
enum ControlPresentation implements _i1.SerializableModel {
  slider,
  stepper,
  toggle,
  segmented,
  momentary;

  static ControlPresentation fromJson(String name) {
    switch (name) {
      case 'slider':
        return ControlPresentation.slider;
      case 'stepper':
        return ControlPresentation.stepper;
      case 'toggle':
        return ControlPresentation.toggle;
      case 'segmented':
        return ControlPresentation.segmented;
      case 'momentary':
        return ControlPresentation.momentary;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ControlPresentation"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
