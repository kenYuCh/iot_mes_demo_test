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
import '../production/line_transfer_status.dart' as _i2;

abstract class LineTransfer implements _i1.SerializableModel {
  LineTransfer._({
    this.id,
    required this.companyId,
    required this.productUnitId,
    required this.productionOrderId,
    required this.fromLineId,
    required this.toLineId,
    required this.fromWorkstationId,
    required this.toWorkstationId,
    required this.fromNodeId,
    required this.toNodeId,
    required this.status,
    this.dispatchedBy,
    this.dispatchedAt,
    this.receivedBy,
    this.receivedAt,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LineTransfer({
    int? id,
    required int companyId,
    required int productUnitId,
    required int productionOrderId,
    required int fromLineId,
    required int toLineId,
    required int fromWorkstationId,
    required int toWorkstationId,
    required int fromNodeId,
    required int toNodeId,
    required _i2.LineTransferStatus status,
    String? dispatchedBy,
    DateTime? dispatchedAt,
    String? receivedBy,
    DateTime? receivedAt,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LineTransferImpl;

  factory LineTransfer.fromJson(Map<String, dynamic> jsonSerialization) {
    return LineTransfer(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      productUnitId: jsonSerialization['productUnitId'] as int,
      productionOrderId: jsonSerialization['productionOrderId'] as int,
      fromLineId: jsonSerialization['fromLineId'] as int,
      toLineId: jsonSerialization['toLineId'] as int,
      fromWorkstationId: jsonSerialization['fromWorkstationId'] as int,
      toWorkstationId: jsonSerialization['toWorkstationId'] as int,
      fromNodeId: jsonSerialization['fromNodeId'] as int,
      toNodeId: jsonSerialization['toNodeId'] as int,
      status: _i2.LineTransferStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      dispatchedBy: jsonSerialization['dispatchedBy'] as String?,
      dispatchedAt: jsonSerialization['dispatchedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['dispatchedAt'],
            ),
      receivedBy: jsonSerialization['receivedBy'] as String?,
      receivedAt: jsonSerialization['receivedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['receivedAt']),
      note: jsonSerialization['note'] as String?,
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

  int productUnitId;

  int productionOrderId;

  int fromLineId;

  int toLineId;

  int fromWorkstationId;

  int toWorkstationId;

  int fromNodeId;

  int toNodeId;

  _i2.LineTransferStatus status;

  String? dispatchedBy;

  DateTime? dispatchedAt;

  String? receivedBy;

  DateTime? receivedAt;

  String? note;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [LineTransfer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LineTransfer copyWith({
    int? id,
    int? companyId,
    int? productUnitId,
    int? productionOrderId,
    int? fromLineId,
    int? toLineId,
    int? fromWorkstationId,
    int? toWorkstationId,
    int? fromNodeId,
    int? toNodeId,
    _i2.LineTransferStatus? status,
    String? dispatchedBy,
    DateTime? dispatchedAt,
    String? receivedBy,
    DateTime? receivedAt,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LineTransfer',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productUnitId': productUnitId,
      'productionOrderId': productionOrderId,
      'fromLineId': fromLineId,
      'toLineId': toLineId,
      'fromWorkstationId': fromWorkstationId,
      'toWorkstationId': toWorkstationId,
      'fromNodeId': fromNodeId,
      'toNodeId': toNodeId,
      'status': status.toJson(),
      if (dispatchedBy != null) 'dispatchedBy': dispatchedBy,
      if (dispatchedAt != null) 'dispatchedAt': dispatchedAt?.toJson(),
      if (receivedBy != null) 'receivedBy': receivedBy,
      if (receivedAt != null) 'receivedAt': receivedAt?.toJson(),
      if (note != null) 'note': note,
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

class _LineTransferImpl extends LineTransfer {
  _LineTransferImpl({
    int? id,
    required int companyId,
    required int productUnitId,
    required int productionOrderId,
    required int fromLineId,
    required int toLineId,
    required int fromWorkstationId,
    required int toWorkstationId,
    required int fromNodeId,
    required int toNodeId,
    required _i2.LineTransferStatus status,
    String? dispatchedBy,
    DateTime? dispatchedAt,
    String? receivedBy,
    DateTime? receivedAt,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         productUnitId: productUnitId,
         productionOrderId: productionOrderId,
         fromLineId: fromLineId,
         toLineId: toLineId,
         fromWorkstationId: fromWorkstationId,
         toWorkstationId: toWorkstationId,
         fromNodeId: fromNodeId,
         toNodeId: toNodeId,
         status: status,
         dispatchedBy: dispatchedBy,
         dispatchedAt: dispatchedAt,
         receivedBy: receivedBy,
         receivedAt: receivedAt,
         note: note,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [LineTransfer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LineTransfer copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? productUnitId,
    int? productionOrderId,
    int? fromLineId,
    int? toLineId,
    int? fromWorkstationId,
    int? toWorkstationId,
    int? fromNodeId,
    int? toNodeId,
    _i2.LineTransferStatus? status,
    Object? dispatchedBy = _Undefined,
    Object? dispatchedAt = _Undefined,
    Object? receivedBy = _Undefined,
    Object? receivedAt = _Undefined,
    Object? note = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LineTransfer(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      productUnitId: productUnitId ?? this.productUnitId,
      productionOrderId: productionOrderId ?? this.productionOrderId,
      fromLineId: fromLineId ?? this.fromLineId,
      toLineId: toLineId ?? this.toLineId,
      fromWorkstationId: fromWorkstationId ?? this.fromWorkstationId,
      toWorkstationId: toWorkstationId ?? this.toWorkstationId,
      fromNodeId: fromNodeId ?? this.fromNodeId,
      toNodeId: toNodeId ?? this.toNodeId,
      status: status ?? this.status,
      dispatchedBy: dispatchedBy is String? ? dispatchedBy : this.dispatchedBy,
      dispatchedAt: dispatchedAt is DateTime?
          ? dispatchedAt
          : this.dispatchedAt,
      receivedBy: receivedBy is String? ? receivedBy : this.receivedBy,
      receivedAt: receivedAt is DateTime? ? receivedAt : this.receivedAt,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
