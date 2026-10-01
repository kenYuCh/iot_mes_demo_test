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
import '../operations/automation_branch.dart' as _i3;
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i4;

abstract class AutomationRule implements _i1.SerializableModel {
  AutomationRule._({
    this.id,
    required this.companyId,
    required this.name,
    required this.triggerDeviceId,
    required this.triggerFeatureKey,
    required this.comparison,
    required this.threshold,
    required this.recoveryThreshold,
    required this.actionDeviceId,
    required this.actionFeatureKey,
    required this.actionValue,
    required this.pulseOnSeconds,
    required this.intervalSeconds,
    required this.maxRepeats,
    required this.mixingDelaySeconds,
    this.branches,
    int? sensorTimeoutSeconds,
    int? cooldownSeconds,
    required this.enabled,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  }) : sensorTimeoutSeconds = sensorTimeoutSeconds ?? 60,
       cooldownSeconds = cooldownSeconds ?? 10;

  factory AutomationRule({
    int? id,
    required int companyId,
    required String name,
    required int triggerDeviceId,
    required String triggerFeatureKey,
    required _i2.AlertComparison comparison,
    required double threshold,
    required double recoveryThreshold,
    required int actionDeviceId,
    required String actionFeatureKey,
    required double actionValue,
    required int pulseOnSeconds,
    required int intervalSeconds,
    required int maxRepeats,
    required int mixingDelaySeconds,
    List<_i3.AutomationBranch>? branches,
    int? sensorTimeoutSeconds,
    int? cooldownSeconds,
    required bool enabled,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AutomationRuleImpl;

  factory AutomationRule.fromJson(Map<String, dynamic> jsonSerialization) {
    return AutomationRule(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      name: jsonSerialization['name'] as String,
      triggerDeviceId: jsonSerialization['triggerDeviceId'] as int,
      triggerFeatureKey: jsonSerialization['triggerFeatureKey'] as String,
      comparison: _i2.AlertComparison.fromJson(
        (jsonSerialization['comparison'] as String),
      ),
      threshold: (jsonSerialization['threshold'] as num).toDouble(),
      recoveryThreshold: (jsonSerialization['recoveryThreshold'] as num)
          .toDouble(),
      actionDeviceId: jsonSerialization['actionDeviceId'] as int,
      actionFeatureKey: jsonSerialization['actionFeatureKey'] as String,
      actionValue: (jsonSerialization['actionValue'] as num).toDouble(),
      pulseOnSeconds: jsonSerialization['pulseOnSeconds'] as int,
      intervalSeconds: jsonSerialization['intervalSeconds'] as int,
      maxRepeats: jsonSerialization['maxRepeats'] as int,
      mixingDelaySeconds: jsonSerialization['mixingDelaySeconds'] as int,
      branches: jsonSerialization['branches'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.AutomationBranch>>(
              jsonSerialization['branches'],
            ),
      sensorTimeoutSeconds: jsonSerialization['sensorTimeoutSeconds'] as int?,
      cooldownSeconds: jsonSerialization['cooldownSeconds'] as int?,
      enabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  String name;

  int triggerDeviceId;

  String triggerFeatureKey;

  _i2.AlertComparison comparison;

  double threshold;

  double recoveryThreshold;

  int actionDeviceId;

  String actionFeatureKey;

  double actionValue;

  int pulseOnSeconds;

  int intervalSeconds;

  int maxRepeats;

  int mixingDelaySeconds;

  List<_i3.AutomationBranch>? branches;

  int? sensorTimeoutSeconds;

  int? cooldownSeconds;

  bool enabled;

  String createdBy;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AutomationRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AutomationRule copyWith({
    int? id,
    int? companyId,
    String? name,
    int? triggerDeviceId,
    String? triggerFeatureKey,
    _i2.AlertComparison? comparison,
    double? threshold,
    double? recoveryThreshold,
    int? actionDeviceId,
    String? actionFeatureKey,
    double? actionValue,
    int? pulseOnSeconds,
    int? intervalSeconds,
    int? maxRepeats,
    int? mixingDelaySeconds,
    List<_i3.AutomationBranch>? branches,
    int? sensorTimeoutSeconds,
    int? cooldownSeconds,
    bool? enabled,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AutomationRule',
      if (id != null) 'id': id,
      'companyId': companyId,
      'name': name,
      'triggerDeviceId': triggerDeviceId,
      'triggerFeatureKey': triggerFeatureKey,
      'comparison': comparison.toJson(),
      'threshold': threshold,
      'recoveryThreshold': recoveryThreshold,
      'actionDeviceId': actionDeviceId,
      'actionFeatureKey': actionFeatureKey,
      'actionValue': actionValue,
      'pulseOnSeconds': pulseOnSeconds,
      'intervalSeconds': intervalSeconds,
      'maxRepeats': maxRepeats,
      'mixingDelaySeconds': mixingDelaySeconds,
      if (branches != null)
        'branches': branches?.toJson(valueToJson: (v) => v.toJson()),
      if (sensorTimeoutSeconds != null)
        'sensorTimeoutSeconds': sensorTimeoutSeconds,
      if (cooldownSeconds != null) 'cooldownSeconds': cooldownSeconds,
      'enabled': enabled,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AutomationRuleImpl extends AutomationRule {
  _AutomationRuleImpl({
    int? id,
    required int companyId,
    required String name,
    required int triggerDeviceId,
    required String triggerFeatureKey,
    required _i2.AlertComparison comparison,
    required double threshold,
    required double recoveryThreshold,
    required int actionDeviceId,
    required String actionFeatureKey,
    required double actionValue,
    required int pulseOnSeconds,
    required int intervalSeconds,
    required int maxRepeats,
    required int mixingDelaySeconds,
    List<_i3.AutomationBranch>? branches,
    int? sensorTimeoutSeconds,
    int? cooldownSeconds,
    required bool enabled,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         name: name,
         triggerDeviceId: triggerDeviceId,
         triggerFeatureKey: triggerFeatureKey,
         comparison: comparison,
         threshold: threshold,
         recoveryThreshold: recoveryThreshold,
         actionDeviceId: actionDeviceId,
         actionFeatureKey: actionFeatureKey,
         actionValue: actionValue,
         pulseOnSeconds: pulseOnSeconds,
         intervalSeconds: intervalSeconds,
         maxRepeats: maxRepeats,
         mixingDelaySeconds: mixingDelaySeconds,
         branches: branches,
         sensorTimeoutSeconds: sensorTimeoutSeconds,
         cooldownSeconds: cooldownSeconds,
         enabled: enabled,
         createdBy: createdBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AutomationRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AutomationRule copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? name,
    int? triggerDeviceId,
    String? triggerFeatureKey,
    _i2.AlertComparison? comparison,
    double? threshold,
    double? recoveryThreshold,
    int? actionDeviceId,
    String? actionFeatureKey,
    double? actionValue,
    int? pulseOnSeconds,
    int? intervalSeconds,
    int? maxRepeats,
    int? mixingDelaySeconds,
    Object? branches = _Undefined,
    Object? sensorTimeoutSeconds = _Undefined,
    Object? cooldownSeconds = _Undefined,
    bool? enabled,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AutomationRule(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      triggerDeviceId: triggerDeviceId ?? this.triggerDeviceId,
      triggerFeatureKey: triggerFeatureKey ?? this.triggerFeatureKey,
      comparison: comparison ?? this.comparison,
      threshold: threshold ?? this.threshold,
      recoveryThreshold: recoveryThreshold ?? this.recoveryThreshold,
      actionDeviceId: actionDeviceId ?? this.actionDeviceId,
      actionFeatureKey: actionFeatureKey ?? this.actionFeatureKey,
      actionValue: actionValue ?? this.actionValue,
      pulseOnSeconds: pulseOnSeconds ?? this.pulseOnSeconds,
      intervalSeconds: intervalSeconds ?? this.intervalSeconds,
      maxRepeats: maxRepeats ?? this.maxRepeats,
      mixingDelaySeconds: mixingDelaySeconds ?? this.mixingDelaySeconds,
      branches: branches is List<_i3.AutomationBranch>?
          ? branches
          : this.branches?.map((e0) => e0.copyWith()).toList(),
      sensorTimeoutSeconds: sensorTimeoutSeconds is int?
          ? sensorTimeoutSeconds
          : this.sensorTimeoutSeconds,
      cooldownSeconds: cooldownSeconds is int?
          ? cooldownSeconds
          : this.cooldownSeconds,
      enabled: enabled ?? this.enabled,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
