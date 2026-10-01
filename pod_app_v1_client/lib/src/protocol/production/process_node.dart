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
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i2;

abstract class ProcessNode implements _i1.SerializableModel {
  ProcessNode._({
    this.id,
    required this.companyId,
    required this.routeId,
    required this.sequence,
    required this.code,
    required this.name,
    required this.stationCode,
    required this.standardSeconds,
    String? scanMode,
    bool? allowSkip,
    bool? allowRework,
    this.measurementRequirements,
    required this.createdAt,
    required this.updatedAt,
  }) : scanMode = scanMode ?? 'startComplete',
       allowSkip = allowSkip ?? false,
       allowRework = allowRework ?? true;

  factory ProcessNode({
    int? id,
    required int companyId,
    required int routeId,
    required int sequence,
    required String code,
    required String name,
    required String stationCode,
    required int standardSeconds,
    String? scanMode,
    bool? allowSkip,
    bool? allowRework,
    Map<String, String>? measurementRequirements,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProcessNodeImpl;

  factory ProcessNode.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProcessNode(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      routeId: jsonSerialization['routeId'] as int,
      sequence: jsonSerialization['sequence'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      stationCode: jsonSerialization['stationCode'] as String,
      standardSeconds: jsonSerialization['standardSeconds'] as int,
      scanMode: jsonSerialization['scanMode'] as String?,
      allowSkip: jsonSerialization['allowSkip'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['allowSkip']),
      allowRework: jsonSerialization['allowRework'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['allowRework']),
      measurementRequirements:
          jsonSerialization['measurementRequirements'] == null
          ? null
          : _i2.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['measurementRequirements'],
            ),
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

  int routeId;

  int sequence;

  String code;

  String name;

  String stationCode;

  int standardSeconds;

  String scanMode;

  bool allowSkip;

  bool allowRework;

  Map<String, String>? measurementRequirements;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ProcessNode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProcessNode copyWith({
    int? id,
    int? companyId,
    int? routeId,
    int? sequence,
    String? code,
    String? name,
    String? stationCode,
    int? standardSeconds,
    String? scanMode,
    bool? allowSkip,
    bool? allowRework,
    Map<String, String>? measurementRequirements,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProcessNode',
      if (id != null) 'id': id,
      'companyId': companyId,
      'routeId': routeId,
      'sequence': sequence,
      'code': code,
      'name': name,
      'stationCode': stationCode,
      'standardSeconds': standardSeconds,
      'scanMode': scanMode,
      'allowSkip': allowSkip,
      'allowRework': allowRework,
      if (measurementRequirements != null)
        'measurementRequirements': measurementRequirements?.toJson(),
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

class _ProcessNodeImpl extends ProcessNode {
  _ProcessNodeImpl({
    int? id,
    required int companyId,
    required int routeId,
    required int sequence,
    required String code,
    required String name,
    required String stationCode,
    required int standardSeconds,
    String? scanMode,
    bool? allowSkip,
    bool? allowRework,
    Map<String, String>? measurementRequirements,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         routeId: routeId,
         sequence: sequence,
         code: code,
         name: name,
         stationCode: stationCode,
         standardSeconds: standardSeconds,
         scanMode: scanMode,
         allowSkip: allowSkip,
         allowRework: allowRework,
         measurementRequirements: measurementRequirements,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProcessNode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProcessNode copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? routeId,
    int? sequence,
    String? code,
    String? name,
    String? stationCode,
    int? standardSeconds,
    String? scanMode,
    bool? allowSkip,
    bool? allowRework,
    Object? measurementRequirements = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProcessNode(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      routeId: routeId ?? this.routeId,
      sequence: sequence ?? this.sequence,
      code: code ?? this.code,
      name: name ?? this.name,
      stationCode: stationCode ?? this.stationCode,
      standardSeconds: standardSeconds ?? this.standardSeconds,
      scanMode: scanMode ?? this.scanMode,
      allowSkip: allowSkip ?? this.allowSkip,
      allowRework: allowRework ?? this.allowRework,
      measurementRequirements: measurementRequirements is Map<String, String>?
          ? measurementRequirements
          : this.measurementRequirements?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
