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
import '../alert/alert_state.dart' as _i4;

/// 告警事件：規則被觸發後產生，恢復正常時自動 resolved。
abstract class Alert implements _i1.SerializableModel {
  Alert._({
    this.id,
    required this.companyId,
    required this.siteId,
    required this.deviceId,
    required this.ruleId,
    required this.featureKey,
    required this.triggeredValue,
    required this.threshold,
    required this.comparison,
    required this.severity,
    bool? mobileNotificationEnabled,
    required this.state,
    required this.message,
    required this.triggeredAt,
    this.acknowledgedAt,
    this.resolvedAt,
  }) : mobileNotificationEnabled = mobileNotificationEnabled ?? false;

  factory Alert({
    int? id,
    required int companyId,
    required int siteId,
    required int deviceId,
    required int ruleId,
    required String featureKey,
    required double triggeredValue,
    required double threshold,
    required _i2.AlertComparison comparison,
    required _i3.AlertSeverity severity,
    bool? mobileNotificationEnabled,
    required _i4.AlertState state,
    required String message,
    required DateTime triggeredAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  }) = _AlertImpl;

  factory Alert.fromJson(Map<String, dynamic> jsonSerialization) {
    return Alert(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      siteId: jsonSerialization['siteId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      ruleId: jsonSerialization['ruleId'] as int,
      featureKey: jsonSerialization['featureKey'] as String,
      triggeredValue: (jsonSerialization['triggeredValue'] as num).toDouble(),
      threshold: (jsonSerialization['threshold'] as num).toDouble(),
      comparison: _i2.AlertComparison.fromJson(
        (jsonSerialization['comparison'] as String),
      ),
      severity: _i3.AlertSeverity.fromJson(
        (jsonSerialization['severity'] as String),
      ),
      mobileNotificationEnabled:
          jsonSerialization['mobileNotificationEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['mobileNotificationEnabled'],
            ),
      state: _i4.AlertState.fromJson((jsonSerialization['state'] as String)),
      message: jsonSerialization['message'] as String,
      triggeredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['triggeredAt'],
      ),
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt'],
            ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  int siteId;

  int deviceId;

  int ruleId;

  String featureKey;

  /// 觸發當下的量測值。
  double triggeredValue;

  double threshold;

  _i2.AlertComparison comparison;

  _i3.AlertSeverity severity;

  /// 觸發當下規則的手機通知決策；保存在事件上供即時客戶端判斷。
  bool mobileNotificationEnabled;

  _i4.AlertState state;

  String message;

  DateTime triggeredAt;

  DateTime? acknowledgedAt;

  DateTime? resolvedAt;

  /// Returns a shallow copy of this [Alert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Alert copyWith({
    int? id,
    int? companyId,
    int? siteId,
    int? deviceId,
    int? ruleId,
    String? featureKey,
    double? triggeredValue,
    double? threshold,
    _i2.AlertComparison? comparison,
    _i3.AlertSeverity? severity,
    bool? mobileNotificationEnabled,
    _i4.AlertState? state,
    String? message,
    DateTime? triggeredAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Alert',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      'deviceId': deviceId,
      'ruleId': ruleId,
      'featureKey': featureKey,
      'triggeredValue': triggeredValue,
      'threshold': threshold,
      'comparison': comparison.toJson(),
      'severity': severity.toJson(),
      'mobileNotificationEnabled': mobileNotificationEnabled,
      'state': state.toJson(),
      'message': message,
      'triggeredAt': triggeredAt.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AlertImpl extends Alert {
  _AlertImpl({
    int? id,
    required int companyId,
    required int siteId,
    required int deviceId,
    required int ruleId,
    required String featureKey,
    required double triggeredValue,
    required double threshold,
    required _i2.AlertComparison comparison,
    required _i3.AlertSeverity severity,
    bool? mobileNotificationEnabled,
    required _i4.AlertState state,
    required String message,
    required DateTime triggeredAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         siteId: siteId,
         deviceId: deviceId,
         ruleId: ruleId,
         featureKey: featureKey,
         triggeredValue: triggeredValue,
         threshold: threshold,
         comparison: comparison,
         severity: severity,
         mobileNotificationEnabled: mobileNotificationEnabled,
         state: state,
         message: message,
         triggeredAt: triggeredAt,
         acknowledgedAt: acknowledgedAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [Alert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Alert copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? siteId,
    int? deviceId,
    int? ruleId,
    String? featureKey,
    double? triggeredValue,
    double? threshold,
    _i2.AlertComparison? comparison,
    _i3.AlertSeverity? severity,
    bool? mobileNotificationEnabled,
    _i4.AlertState? state,
    String? message,
    DateTime? triggeredAt,
    Object? acknowledgedAt = _Undefined,
    Object? resolvedAt = _Undefined,
  }) {
    return Alert(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      siteId: siteId ?? this.siteId,
      deviceId: deviceId ?? this.deviceId,
      ruleId: ruleId ?? this.ruleId,
      featureKey: featureKey ?? this.featureKey,
      triggeredValue: triggeredValue ?? this.triggeredValue,
      threshold: threshold ?? this.threshold,
      comparison: comparison ?? this.comparison,
      severity: severity ?? this.severity,
      mobileNotificationEnabled:
          mobileNotificationEnabled ?? this.mobileNotificationEnabled,
      state: state ?? this.state,
      message: message ?? this.message,
      triggeredAt: triggeredAt ?? this.triggeredAt,
      acknowledgedAt: acknowledgedAt is DateTime?
          ? acknowledgedAt
          : this.acknowledgedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}
