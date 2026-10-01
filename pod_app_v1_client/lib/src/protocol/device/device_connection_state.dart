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

/// 全平台統一的設備連線狀態（見 docs/product/enterprise-iot-platform-spec.md 21.3）。
enum DeviceConnectionState implements _i1.SerializableModel {
  /// 連線正常且持續收到資料。
  online,

  /// Gateway 在線，但設備資料長時間未更新。
  stale,

  /// Gateway 或設備完全失聯。
  offline,

  /// 維護模式，暫停離線判斷與告警。
  maintenance,

  /// 已停用，不參與判斷。
  disabled,

  /// 尚未取得任何狀態。
  unknown;

  static DeviceConnectionState fromJson(String name) {
    switch (name) {
      case 'online':
        return DeviceConnectionState.online;
      case 'stale':
        return DeviceConnectionState.stale;
      case 'offline':
        return DeviceConnectionState.offline;
      case 'maintenance':
        return DeviceConnectionState.maintenance;
      case 'disabled':
        return DeviceConnectionState.disabled;
      case 'unknown':
        return DeviceConnectionState.unknown;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "DeviceConnectionState"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
