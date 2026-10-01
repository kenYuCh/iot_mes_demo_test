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

/// 分支命中後送出的單一控制動作。
abstract class AutomationAction implements _i1.SerializableModel {
  AutomationAction._({
    required this.deviceId,
    required this.featureKey,
    required this.value,
    required this.durationSeconds,
    required this.delaySeconds,
  });

  factory AutomationAction({
    required int deviceId,
    required String featureKey,
    required double value,
    required int durationSeconds,
    required int delaySeconds,
  }) = _AutomationActionImpl;

  factory AutomationAction.fromJson(Map<String, dynamic> jsonSerialization) {
    return AutomationAction(
      deviceId: jsonSerialization['deviceId'] as int,
      featureKey: jsonSerialization['featureKey'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      durationSeconds: jsonSerialization['durationSeconds'] as int,
      delaySeconds: jsonSerialization['delaySeconds'] as int,
    );
  }

  int deviceId;

  String featureKey;

  double value;

  int durationSeconds;

  int delaySeconds;

  /// Returns a shallow copy of this [AutomationAction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AutomationAction copyWith({
    int? deviceId,
    String? featureKey,
    double? value,
    int? durationSeconds,
    int? delaySeconds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AutomationAction',
      'deviceId': deviceId,
      'featureKey': featureKey,
      'value': value,
      'durationSeconds': durationSeconds,
      'delaySeconds': delaySeconds,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AutomationActionImpl extends AutomationAction {
  _AutomationActionImpl({
    required int deviceId,
    required String featureKey,
    required double value,
    required int durationSeconds,
    required int delaySeconds,
  }) : super._(
         deviceId: deviceId,
         featureKey: featureKey,
         value: value,
         durationSeconds: durationSeconds,
         delaySeconds: delaySeconds,
       );

  /// Returns a shallow copy of this [AutomationAction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AutomationAction copyWith({
    int? deviceId,
    String? featureKey,
    double? value,
    int? durationSeconds,
    int? delaySeconds,
  }) {
    return AutomationAction(
      deviceId: deviceId ?? this.deviceId,
      featureKey: featureKey ?? this.featureKey,
      value: value ?? this.value,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      delaySeconds: delaySeconds ?? this.delaySeconds,
    );
  }
}
