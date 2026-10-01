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
import '../production/production_order_status.dart' as _i2;

abstract class ProductionOrder implements _i1.SerializableModel {
  ProductionOrder._({
    this.id,
    required this.companyId,
    required this.orderNumber,
    required this.productDefinitionId,
    required this.routeId,
    required this.plannedQuantity,
    int? completedQuantity,
    int? rejectedQuantity,
    required this.status,
    this.scheduledStart,
    this.scheduledEnd,
    this.startedAt,
    this.completedAt,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  }) : completedQuantity = completedQuantity ?? 0,
       rejectedQuantity = rejectedQuantity ?? 0;

  factory ProductionOrder({
    int? id,
    required int companyId,
    required String orderNumber,
    required int productDefinitionId,
    required int routeId,
    required int plannedQuantity,
    int? completedQuantity,
    int? rejectedQuantity,
    required _i2.ProductionOrderStatus status,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    DateTime? startedAt,
    DateTime? completedAt,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProductionOrderImpl;

  factory ProductionOrder.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductionOrder(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      orderNumber: jsonSerialization['orderNumber'] as String,
      productDefinitionId: jsonSerialization['productDefinitionId'] as int,
      routeId: jsonSerialization['routeId'] as int,
      plannedQuantity: jsonSerialization['plannedQuantity'] as int,
      completedQuantity: jsonSerialization['completedQuantity'] as int?,
      rejectedQuantity: jsonSerialization['rejectedQuantity'] as int?,
      status: _i2.ProductionOrderStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      scheduledStart: jsonSerialization['scheduledStart'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scheduledStart'],
            ),
      scheduledEnd: jsonSerialization['scheduledEnd'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scheduledEnd'],
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
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

  String orderNumber;

  int productDefinitionId;

  int routeId;

  int plannedQuantity;

  int completedQuantity;

  int rejectedQuantity;

  _i2.ProductionOrderStatus status;

  DateTime? scheduledStart;

  DateTime? scheduledEnd;

  DateTime? startedAt;

  DateTime? completedAt;

  String createdBy;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ProductionOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductionOrder copyWith({
    int? id,
    int? companyId,
    String? orderNumber,
    int? productDefinitionId,
    int? routeId,
    int? plannedQuantity,
    int? completedQuantity,
    int? rejectedQuantity,
    _i2.ProductionOrderStatus? status,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    DateTime? startedAt,
    DateTime? completedAt,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductionOrder',
      if (id != null) 'id': id,
      'companyId': companyId,
      'orderNumber': orderNumber,
      'productDefinitionId': productDefinitionId,
      'routeId': routeId,
      'plannedQuantity': plannedQuantity,
      'completedQuantity': completedQuantity,
      'rejectedQuantity': rejectedQuantity,
      'status': status.toJson(),
      if (scheduledStart != null) 'scheduledStart': scheduledStart?.toJson(),
      if (scheduledEnd != null) 'scheduledEnd': scheduledEnd?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
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

class _ProductionOrderImpl extends ProductionOrder {
  _ProductionOrderImpl({
    int? id,
    required int companyId,
    required String orderNumber,
    required int productDefinitionId,
    required int routeId,
    required int plannedQuantity,
    int? completedQuantity,
    int? rejectedQuantity,
    required _i2.ProductionOrderStatus status,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
    DateTime? startedAt,
    DateTime? completedAt,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         orderNumber: orderNumber,
         productDefinitionId: productDefinitionId,
         routeId: routeId,
         plannedQuantity: plannedQuantity,
         completedQuantity: completedQuantity,
         rejectedQuantity: rejectedQuantity,
         status: status,
         scheduledStart: scheduledStart,
         scheduledEnd: scheduledEnd,
         startedAt: startedAt,
         completedAt: completedAt,
         createdBy: createdBy,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProductionOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductionOrder copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? orderNumber,
    int? productDefinitionId,
    int? routeId,
    int? plannedQuantity,
    int? completedQuantity,
    int? rejectedQuantity,
    _i2.ProductionOrderStatus? status,
    Object? scheduledStart = _Undefined,
    Object? scheduledEnd = _Undefined,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductionOrder(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      orderNumber: orderNumber ?? this.orderNumber,
      productDefinitionId: productDefinitionId ?? this.productDefinitionId,
      routeId: routeId ?? this.routeId,
      plannedQuantity: plannedQuantity ?? this.plannedQuantity,
      completedQuantity: completedQuantity ?? this.completedQuantity,
      rejectedQuantity: rejectedQuantity ?? this.rejectedQuantity,
      status: status ?? this.status,
      scheduledStart: scheduledStart is DateTime?
          ? scheduledStart
          : this.scheduledStart,
      scheduledEnd: scheduledEnd is DateTime?
          ? scheduledEnd
          : this.scheduledEnd,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
