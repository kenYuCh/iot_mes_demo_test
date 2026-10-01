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

abstract class WorkstationAssignment implements _i1.SerializableModel {
  WorkstationAssignment._({
    this.id,
    required this.companyId,
    required this.workstationId,
    required this.membershipId,
    bool? active,
    required this.assignedBy,
    required this.createdAt,
    required this.updatedAt,
  }) : active = active ?? true;

  factory WorkstationAssignment({
    int? id,
    required int companyId,
    required int workstationId,
    required int membershipId,
    bool? active,
    required String assignedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WorkstationAssignmentImpl;

  factory WorkstationAssignment.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return WorkstationAssignment(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      workstationId: jsonSerialization['workstationId'] as int,
      membershipId: jsonSerialization['membershipId'] as int,
      active: jsonSerialization['active'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['active']),
      assignedBy: jsonSerialization['assignedBy'] as String,
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

  int workstationId;

  int membershipId;

  bool active;

  String assignedBy;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [WorkstationAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkstationAssignment copyWith({
    int? id,
    int? companyId,
    int? workstationId,
    int? membershipId,
    bool? active,
    String? assignedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkstationAssignment',
      if (id != null) 'id': id,
      'companyId': companyId,
      'workstationId': workstationId,
      'membershipId': membershipId,
      'active': active,
      'assignedBy': assignedBy,
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

class _WorkstationAssignmentImpl extends WorkstationAssignment {
  _WorkstationAssignmentImpl({
    int? id,
    required int companyId,
    required int workstationId,
    required int membershipId,
    bool? active,
    required String assignedBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         workstationId: workstationId,
         membershipId: membershipId,
         active: active,
         assignedBy: assignedBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WorkstationAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkstationAssignment copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? workstationId,
    int? membershipId,
    bool? active,
    String? assignedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkstationAssignment(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      workstationId: workstationId ?? this.workstationId,
      membershipId: membershipId ?? this.membershipId,
      active: active ?? this.active,
      assignedBy: assignedBy ?? this.assignedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
