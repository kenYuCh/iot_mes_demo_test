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
import '../production/workstation_assignment.dart' as _i2;
import '../production/workstation.dart' as _i3;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i4;

abstract class WorkstationAssignmentDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  WorkstationAssignmentDetail._({
    required this.assignment,
    required this.workstation,
    required this.memberEmail,
    this.memberDisplayName,
  });

  factory WorkstationAssignmentDetail({
    required _i2.WorkstationAssignment assignment,
    required _i3.Workstation workstation,
    required String memberEmail,
    String? memberDisplayName,
  }) = _WorkstationAssignmentDetailImpl;

  factory WorkstationAssignmentDetail.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return WorkstationAssignmentDetail(
      assignment: _i4.Protocol().deserialize<_i2.WorkstationAssignment>(
        jsonSerialization['assignment'],
      ),
      workstation: _i4.Protocol().deserialize<_i3.Workstation>(
        jsonSerialization['workstation'],
      ),
      memberEmail: jsonSerialization['memberEmail'] as String,
      memberDisplayName: jsonSerialization['memberDisplayName'] as String?,
    );
  }

  _i2.WorkstationAssignment assignment;

  _i3.Workstation workstation;

  String memberEmail;

  String? memberDisplayName;

  /// Returns a shallow copy of this [WorkstationAssignmentDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkstationAssignmentDetail copyWith({
    _i2.WorkstationAssignment? assignment,
    _i3.Workstation? workstation,
    String? memberEmail,
    String? memberDisplayName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkstationAssignmentDetail',
      'assignment': assignment.toJson(),
      'workstation': workstation.toJson(),
      'memberEmail': memberEmail,
      if (memberDisplayName != null) 'memberDisplayName': memberDisplayName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkstationAssignmentDetail',
      'assignment': assignment.toJsonForProtocol(),
      'workstation': workstation.toJsonForProtocol(),
      'memberEmail': memberEmail,
      if (memberDisplayName != null) 'memberDisplayName': memberDisplayName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkstationAssignmentDetailImpl extends WorkstationAssignmentDetail {
  _WorkstationAssignmentDetailImpl({
    required _i2.WorkstationAssignment assignment,
    required _i3.Workstation workstation,
    required String memberEmail,
    String? memberDisplayName,
  }) : super._(
         assignment: assignment,
         workstation: workstation,
         memberEmail: memberEmail,
         memberDisplayName: memberDisplayName,
       );

  /// Returns a shallow copy of this [WorkstationAssignmentDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkstationAssignmentDetail copyWith({
    _i2.WorkstationAssignment? assignment,
    _i3.Workstation? workstation,
    String? memberEmail,
    Object? memberDisplayName = _Undefined,
  }) {
    return WorkstationAssignmentDetail(
      assignment: assignment ?? this.assignment.copyWith(),
      workstation: workstation ?? this.workstation.copyWith(),
      memberEmail: memberEmail ?? this.memberEmail,
      memberDisplayName: memberDisplayName is String?
          ? memberDisplayName
          : this.memberDisplayName,
    );
  }
}
