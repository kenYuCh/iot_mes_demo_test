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
import '../alert/alert_comparison.dart' as _i2;

/// 規則分支中的一個感測條件。
abstract class AutomationCondition implements _i1.SerializableModel {
  AutomationCondition._({
    required this.deviceId,
    required this.featureKey,
    required this.comparison,
    required this.value,
  });

  factory AutomationCondition({
    required int deviceId,
    required String featureKey,
    required _i2.AlertComparison comparison,
    required double value,
  }) = _AutomationConditionImpl;

  factory AutomationCondition.fromJson(Map<String, dynamic> jsonSerialization) {
    return AutomationCondition(
      deviceId: jsonSerialization['deviceId'] as int,
      featureKey: jsonSerialization['featureKey'] as String,
      comparison: _i2.AlertComparison.fromJson(
        (jsonSerialization['comparison'] as String),
      ),
      value: (jsonSerialization['value'] as num).toDouble(),
    );
  }

  int deviceId;

  String featureKey;

  _i2.AlertComparison comparison;

  double value;

  /// Returns a shallow copy of this [AutomationCondition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AutomationCondition copyWith({
    int? deviceId,
    String? featureKey,
    _i2.AlertComparison? comparison,
    double? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AutomationCondition',
      'deviceId': deviceId,
      'featureKey': featureKey,
      'comparison': comparison.toJson(),
      'value': value,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AutomationConditionImpl extends AutomationCondition {
  _AutomationConditionImpl({
    required int deviceId,
    required String featureKey,
    required _i2.AlertComparison comparison,
    required double value,
  }) : super._(
         deviceId: deviceId,
         featureKey: featureKey,
         comparison: comparison,
         value: value,
       );

  /// Returns a shallow copy of this [AutomationCondition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AutomationCondition copyWith({
    int? deviceId,
    String? featureKey,
    _i2.AlertComparison? comparison,
    double? value,
  }) {
    return AutomationCondition(
      deviceId: deviceId ?? this.deviceId,
      featureKey: featureKey ?? this.featureKey,
      comparison: comparison ?? this.comparison,
      value: value ?? this.value,
    );
  }
}
