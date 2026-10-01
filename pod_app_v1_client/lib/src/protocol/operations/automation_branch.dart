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
import '../operations/automation_condition.dart' as _i2;
import '../operations/automation_action.dart' as _i3;
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i4;

/// IF / ELSE IF / ELSE 分支；conditions 為空代表 ELSE。
abstract class AutomationBranch implements _i1.SerializableModel {
  AutomationBranch._({
    required this.label,
    required this.matchAll,
    required this.conditions,
    required this.actions,
  });

  factory AutomationBranch({
    required String label,
    required bool matchAll,
    required List<_i2.AutomationCondition> conditions,
    required List<_i3.AutomationAction> actions,
  }) = _AutomationBranchImpl;

  factory AutomationBranch.fromJson(Map<String, dynamic> jsonSerialization) {
    return AutomationBranch(
      label: jsonSerialization['label'] as String,
      matchAll: _i1.BoolJsonExtension.fromJson(jsonSerialization['matchAll']),
      conditions: _i4.Protocol().deserialize<List<_i2.AutomationCondition>>(
        jsonSerialization['conditions'],
      ),
      actions: _i4.Protocol().deserialize<List<_i3.AutomationAction>>(
        jsonSerialization['actions'],
      ),
    );
  }

  String label;

  bool matchAll;

  List<_i2.AutomationCondition> conditions;

  List<_i3.AutomationAction> actions;

  /// Returns a shallow copy of this [AutomationBranch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AutomationBranch copyWith({
    String? label,
    bool? matchAll,
    List<_i2.AutomationCondition>? conditions,
    List<_i3.AutomationAction>? actions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AutomationBranch',
      'label': label,
      'matchAll': matchAll,
      'conditions': conditions.toJson(valueToJson: (v) => v.toJson()),
      'actions': actions.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AutomationBranchImpl extends AutomationBranch {
  _AutomationBranchImpl({
    required String label,
    required bool matchAll,
    required List<_i2.AutomationCondition> conditions,
    required List<_i3.AutomationAction> actions,
  }) : super._(
         label: label,
         matchAll: matchAll,
         conditions: conditions,
         actions: actions,
       );

  /// Returns a shallow copy of this [AutomationBranch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AutomationBranch copyWith({
    String? label,
    bool? matchAll,
    List<_i2.AutomationCondition>? conditions,
    List<_i3.AutomationAction>? actions,
  }) {
    return AutomationBranch(
      label: label ?? this.label,
      matchAll: matchAll ?? this.matchAll,
      conditions:
          conditions ?? this.conditions.map((e0) => e0.copyWith()).toList(),
      actions: actions ?? this.actions.map((e0) => e0.copyWith()).toList(),
    );
  }
}
