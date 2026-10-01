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

abstract class AutomationRun implements _i1.SerializableModel {
  AutomationRun._({
    this.id,
    required this.companyId,
    required this.ruleId,
    required this.state,
    required this.triggerValue,
    required this.repeatCount,
    required this.currentStep,
    this.message,
    required this.startedAt,
    this.finishedAt,
  });

  factory AutomationRun({
    int? id,
    required int companyId,
    required int ruleId,
    required String state,
    required double triggerValue,
    required int repeatCount,
    required String currentStep,
    String? message,
    required DateTime startedAt,
    DateTime? finishedAt,
  }) = _AutomationRunImpl;

  factory AutomationRun.fromJson(Map<String, dynamic> jsonSerialization) {
    return AutomationRun(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      ruleId: jsonSerialization['ruleId'] as int,
      state: jsonSerialization['state'] as String,
      triggerValue: (jsonSerialization['triggerValue'] as num).toDouble(),
      repeatCount: jsonSerialization['repeatCount'] as int,
      currentStep: jsonSerialization['currentStep'] as String,
      message: jsonSerialization['message'] as String?,
      startedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      finishedAt: jsonSerialization['finishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['finishedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  int ruleId;

  String state;

  double triggerValue;

  int repeatCount;

  String currentStep;

  String? message;

  DateTime startedAt;

  DateTime? finishedAt;

  /// Returns a shallow copy of this [AutomationRun]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AutomationRun copyWith({
    int? id,
    int? companyId,
    int? ruleId,
    String? state,
    double? triggerValue,
    int? repeatCount,
    String? currentStep,
    String? message,
    DateTime? startedAt,
    DateTime? finishedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AutomationRun',
      if (id != null) 'id': id,
      'companyId': companyId,
      'ruleId': ruleId,
      'state': state,
      'triggerValue': triggerValue,
      'repeatCount': repeatCount,
      'currentStep': currentStep,
      if (message != null) 'message': message,
      'startedAt': startedAt.toJson(),
      if (finishedAt != null) 'finishedAt': finishedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AutomationRunImpl extends AutomationRun {
  _AutomationRunImpl({
    int? id,
    required int companyId,
    required int ruleId,
    required String state,
    required double triggerValue,
    required int repeatCount,
    required String currentStep,
    String? message,
    required DateTime startedAt,
    DateTime? finishedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         ruleId: ruleId,
         state: state,
         triggerValue: triggerValue,
         repeatCount: repeatCount,
         currentStep: currentStep,
         message: message,
         startedAt: startedAt,
         finishedAt: finishedAt,
       );

  /// Returns a shallow copy of this [AutomationRun]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AutomationRun copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? ruleId,
    String? state,
    double? triggerValue,
    int? repeatCount,
    String? currentStep,
    Object? message = _Undefined,
    DateTime? startedAt,
    Object? finishedAt = _Undefined,
  }) {
    return AutomationRun(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      ruleId: ruleId ?? this.ruleId,
      state: state ?? this.state,
      triggerValue: triggerValue ?? this.triggerValue,
      repeatCount: repeatCount ?? this.repeatCount,
      currentStep: currentStep ?? this.currentStep,
      message: message is String? ? message : this.message,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt is DateTime? ? finishedAt : this.finishedAt,
    );
  }
}
