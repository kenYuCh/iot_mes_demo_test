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

/// 控制命令生命週期（見 docs/backend/api-rules.md 命令狀態機）。
enum DeviceCommandState implements _i1.SerializableModel {
  /// 已建立，尚未送往裝置。
  created,

  /// 已送往裝置（MQTT downlink / 模擬器）。
  sent,

  /// 裝置已回覆收到命令。
  acknowledged,

  /// 裝置執行完成。
  completed,

  /// 裝置回報執行失敗。
  failed,

  /// 逾時未收到裝置回覆。
  timedOut,

  /// 使用者在送達前取消。
  cancelled;

  static DeviceCommandState fromJson(String name) {
    switch (name) {
      case 'created':
        return DeviceCommandState.created;
      case 'sent':
        return DeviceCommandState.sent;
      case 'acknowledged':
        return DeviceCommandState.acknowledged;
      case 'completed':
        return DeviceCommandState.completed;
      case 'failed':
        return DeviceCommandState.failed;
      case 'timedOut':
        return DeviceCommandState.timedOut;
      case 'cancelled':
        return DeviceCommandState.cancelled;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "DeviceCommandState"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
