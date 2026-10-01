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
import '../production/process_event_type.dart' as _i2;
import '../production/process_result.dart' as _i3;
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i4;

/// Append-only 製程事件；禁止 update/delete，以保留稽核與產品追溯。
abstract class ProcessEvent implements _i1.SerializableModel {
  ProcessEvent._({
    this.id,
    required this.companyId,
    required this.clientEventId,
    required this.productUnitId,
    required this.productionOrderId,
    required this.processNodeId,
    required this.stationCode,
    required this.eventType,
    required this.result,
    required this.operatorId,
    this.deviceId,
    this.materialLotIds,
    this.measurements,
    this.note,
    required this.occurredAt,
    required this.receivedAt,
  });

  factory ProcessEvent({
    int? id,
    required int companyId,
    required String clientEventId,
    required int productUnitId,
    required int productionOrderId,
    required int processNodeId,
    required String stationCode,
    required _i2.ProcessEventType eventType,
    required _i3.ProcessResult result,
    required String operatorId,
    int? deviceId,
    List<int>? materialLotIds,
    Map<String, double>? measurements,
    String? note,
    required DateTime occurredAt,
    required DateTime receivedAt,
  }) = _ProcessEventImpl;

  factory ProcessEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProcessEvent(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      clientEventId: jsonSerialization['clientEventId'] as String,
      productUnitId: jsonSerialization['productUnitId'] as int,
      productionOrderId: jsonSerialization['productionOrderId'] as int,
      processNodeId: jsonSerialization['processNodeId'] as int,
      stationCode: jsonSerialization['stationCode'] as String,
      eventType: _i2.ProcessEventType.fromJson(
        (jsonSerialization['eventType'] as String),
      ),
      result: _i3.ProcessResult.fromJson(
        (jsonSerialization['result'] as String),
      ),
      operatorId: jsonSerialization['operatorId'] as String,
      deviceId: jsonSerialization['deviceId'] as int?,
      materialLotIds: jsonSerialization['materialLotIds'] == null
          ? null
          : _i4.Protocol().deserialize<List<int>>(
              jsonSerialization['materialLotIds'],
            ),
      measurements: jsonSerialization['measurements'] == null
          ? null
          : _i4.Protocol().deserialize<Map<String, double>>(
              jsonSerialization['measurements'],
            ),
      note: jsonSerialization['note'] as String?,
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
      receivedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  String clientEventId;

  int productUnitId;

  int productionOrderId;

  int processNodeId;

  String stationCode;

  _i2.ProcessEventType eventType;

  _i3.ProcessResult result;

  String operatorId;

  int? deviceId;

  List<int>? materialLotIds;

  Map<String, double>? measurements;

  String? note;

  DateTime occurredAt;

  DateTime receivedAt;

  /// Returns a shallow copy of this [ProcessEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProcessEvent copyWith({
    int? id,
    int? companyId,
    String? clientEventId,
    int? productUnitId,
    int? productionOrderId,
    int? processNodeId,
    String? stationCode,
    _i2.ProcessEventType? eventType,
    _i3.ProcessResult? result,
    String? operatorId,
    int? deviceId,
    List<int>? materialLotIds,
    Map<String, double>? measurements,
    String? note,
    DateTime? occurredAt,
    DateTime? receivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProcessEvent',
      if (id != null) 'id': id,
      'companyId': companyId,
      'clientEventId': clientEventId,
      'productUnitId': productUnitId,
      'productionOrderId': productionOrderId,
      'processNodeId': processNodeId,
      'stationCode': stationCode,
      'eventType': eventType.toJson(),
      'result': result.toJson(),
      'operatorId': operatorId,
      if (deviceId != null) 'deviceId': deviceId,
      if (materialLotIds != null) 'materialLotIds': materialLotIds?.toJson(),
      if (measurements != null) 'measurements': measurements?.toJson(),
      if (note != null) 'note': note,
      'occurredAt': occurredAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProcessEventImpl extends ProcessEvent {
  _ProcessEventImpl({
    int? id,
    required int companyId,
    required String clientEventId,
    required int productUnitId,
    required int productionOrderId,
    required int processNodeId,
    required String stationCode,
    required _i2.ProcessEventType eventType,
    required _i3.ProcessResult result,
    required String operatorId,
    int? deviceId,
    List<int>? materialLotIds,
    Map<String, double>? measurements,
    String? note,
    required DateTime occurredAt,
    required DateTime receivedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         clientEventId: clientEventId,
         productUnitId: productUnitId,
         productionOrderId: productionOrderId,
         processNodeId: processNodeId,
         stationCode: stationCode,
         eventType: eventType,
         result: result,
         operatorId: operatorId,
         deviceId: deviceId,
         materialLotIds: materialLotIds,
         measurements: measurements,
         note: note,
         occurredAt: occurredAt,
         receivedAt: receivedAt,
       );

  /// Returns a shallow copy of this [ProcessEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProcessEvent copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? clientEventId,
    int? productUnitId,
    int? productionOrderId,
    int? processNodeId,
    String? stationCode,
    _i2.ProcessEventType? eventType,
    _i3.ProcessResult? result,
    String? operatorId,
    Object? deviceId = _Undefined,
    Object? materialLotIds = _Undefined,
    Object? measurements = _Undefined,
    Object? note = _Undefined,
    DateTime? occurredAt,
    DateTime? receivedAt,
  }) {
    return ProcessEvent(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      clientEventId: clientEventId ?? this.clientEventId,
      productUnitId: productUnitId ?? this.productUnitId,
      productionOrderId: productionOrderId ?? this.productionOrderId,
      processNodeId: processNodeId ?? this.processNodeId,
      stationCode: stationCode ?? this.stationCode,
      eventType: eventType ?? this.eventType,
      result: result ?? this.result,
      operatorId: operatorId ?? this.operatorId,
      deviceId: deviceId is int? ? deviceId : this.deviceId,
      materialLotIds: materialLotIds is List<int>?
          ? materialLotIds
          : this.materialLotIds?.map((e0) => e0).toList(),
      measurements: measurements is Map<String, double>?
          ? measurements
          : this.measurements?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      note: note is String? ? note : this.note,
      occurredAt: occurredAt ?? this.occurredAt,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }
}
