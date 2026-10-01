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
import '../alert/alert_severity.dart' as _i3;

/// 告警規則：針對設備單一 featureKey 的閾值判斷。
abstract class AlertRule implements _i1.SerializableModel {
  AlertRule._({
    this.id,
    required this.companyId,
    required this.deviceId,
    required this.featureKey,
    required this.name,
    required this.comparison,
    required this.threshold,
    required this.severity,
    bool? mobileNotificationEnabled,
    required this.enabled,
    required this.createdAt,
  }) : mobileNotificationEnabled = mobileNotificationEnabled ?? false;

  factory AlertRule({
    int? id,
    required int companyId,
    required int deviceId,
    required String featureKey,
    required String name,
    required _i2.AlertComparison comparison,
    required double threshold,
    required _i3.AlertSeverity severity,
    bool? mobileNotificationEnabled,
    required bool enabled,
    required DateTime createdAt,
  }) = _AlertRuleImpl;

  factory AlertRule.fromJson(Map<String, dynamic> jsonSerialization) {
    return AlertRule(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      featureKey: jsonSerialization['featureKey'] as String,
      name: jsonSerialization['name'] as String,
      comparison: _i2.AlertComparison.fromJson(
        (jsonSerialization['comparison'] as String),
      ),
      threshold: (jsonSerialization['threshold'] as num).toDouble(),
      severity: _i3.AlertSeverity.fromJson(
        (jsonSerialization['severity'] as String),
      ),
      mobileNotificationEnabled:
          jsonSerialization['mobileNotificationEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['mobileNotificationEnabled'],
            ),
      enabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  int deviceId;

  String featureKey;

  String name;

  _i2.AlertComparison comparison;

  double threshold;

  /// 觸發時產生的告警等級。
  _i3.AlertSeverity severity;

  /// 規則觸發時是否要求行動 App 顯示通知。
  bool mobileNotificationEnabled;

  bool enabled;

  DateTime createdAt;

  /// Returns a shallow copy of this [AlertRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AlertRule copyWith({
    int? id,
    int? companyId,
    int? deviceId,
    String? featureKey,
    String? name,
    _i2.AlertComparison? comparison,
    double? threshold,
    _i3.AlertSeverity? severity,
    bool? mobileNotificationEnabled,
    bool? enabled,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AlertRule',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'featureKey': featureKey,
      'name': name,
      'comparison': comparison.toJson(),
      'threshold': threshold,
      'severity': severity.toJson(),
      'mobileNotificationEnabled': mobileNotificationEnabled,
      'enabled': enabled,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AlertRuleImpl extends AlertRule {
  _AlertRuleImpl({
    int? id,
    required int companyId,
    required int deviceId,
    required String featureKey,
    required String name,
    required _i2.AlertComparison comparison,
    required double threshold,
    required _i3.AlertSeverity severity,
    bool? mobileNotificationEnabled,
    required bool enabled,
    required DateTime createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         deviceId: deviceId,
         featureKey: featureKey,
         name: name,
         comparison: comparison,
         threshold: threshold,
         severity: severity,
         mobileNotificationEnabled: mobileNotificationEnabled,
         enabled: enabled,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AlertRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AlertRule copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? deviceId,
    String? featureKey,
    String? name,
    _i2.AlertComparison? comparison,
    double? threshold,
    _i3.AlertSeverity? severity,
    bool? mobileNotificationEnabled,
    bool? enabled,
    DateTime? createdAt,
  }) {
    return AlertRule(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      deviceId: deviceId ?? this.deviceId,
      featureKey: featureKey ?? this.featureKey,
      name: name ?? this.name,
      comparison: comparison ?? this.comparison,
      threshold: threshold ?? this.threshold,
      severity: severity ?? this.severity,
      mobileNotificationEnabled:
          mobileNotificationEnabled ?? this.mobileNotificationEnabled,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
