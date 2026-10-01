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

/// 工單狀態機：open → inProgress → done / cancelled。
enum WorkOrderStatus implements _i1.SerializableModel {
  /// 已開立，待指派處理。
  open,

  /// 處理中。
  inProgress,

  /// 已完成。
  done,

  /// 已取消。
  cancelled;

  static WorkOrderStatus fromJson(String name) {
    switch (name) {
      case 'open':
        return WorkOrderStatus.open;
      case 'inProgress':
        return WorkOrderStatus.inProgress;
      case 'done':
        return WorkOrderStatus.done;
      case 'cancelled':
        return WorkOrderStatus.cancelled;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "WorkOrderStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
