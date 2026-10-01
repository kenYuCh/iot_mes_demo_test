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

enum PlatformPermission implements _i1.SerializableModel {
  settingsRead,
  settingsWrite,
  deviceRead,
  deviceControl,
  deviceManage,
  otaManage,
  automationManage,
  auditRead;

  static PlatformPermission fromJson(String name) {
    switch (name) {
      case 'settingsRead':
        return PlatformPermission.settingsRead;
      case 'settingsWrite':
        return PlatformPermission.settingsWrite;
      case 'deviceRead':
        return PlatformPermission.deviceRead;
      case 'deviceControl':
        return PlatformPermission.deviceControl;
      case 'deviceManage':
        return PlatformPermission.deviceManage;
      case 'otaManage':
        return PlatformPermission.otaManage;
      case 'automationManage':
        return PlatformPermission.automationManage;
      case 'auditRead':
        return PlatformPermission.auditRead;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "PlatformPermission"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
