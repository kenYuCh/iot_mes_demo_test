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
import '../production/product_unit_status.dart' as _i2;

abstract class ProductUnit implements _i1.SerializableModel {
  ProductUnit._({
    this.id,
    required this.companyId,
    required this.productionOrderId,
    required this.productDefinitionId,
    required this.serialNumber,
    required this.qrCode,
    this.rfidEpc,
    required this.status,
    this.currentNodeId,
    this.currentStationCode,
    this.enteredNodeAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductUnit({
    int? id,
    required int companyId,
    required int productionOrderId,
    required int productDefinitionId,
    required String serialNumber,
    required String qrCode,
    String? rfidEpc,
    required _i2.ProductUnitStatus status,
    int? currentNodeId,
    String? currentStationCode,
    DateTime? enteredNodeAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProductUnitImpl;

  factory ProductUnit.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductUnit(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      productionOrderId: jsonSerialization['productionOrderId'] as int,
      productDefinitionId: jsonSerialization['productDefinitionId'] as int,
      serialNumber: jsonSerialization['serialNumber'] as String,
      qrCode: jsonSerialization['qrCode'] as String,
      rfidEpc: jsonSerialization['rfidEpc'] as String?,
      status: _i2.ProductUnitStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      currentNodeId: jsonSerialization['currentNodeId'] as int?,
      currentStationCode: jsonSerialization['currentStationCode'] as String?,
      enteredNodeAt: jsonSerialization['enteredNodeAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['enteredNodeAt'],
            ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
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

  int productionOrderId;

  int productDefinitionId;

  String serialNumber;

  String qrCode;

  String? rfidEpc;

  _i2.ProductUnitStatus status;

  int? currentNodeId;

  String? currentStationCode;

  DateTime? enteredNodeAt;

  DateTime? completedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ProductUnit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductUnit copyWith({
    int? id,
    int? companyId,
    int? productionOrderId,
    int? productDefinitionId,
    String? serialNumber,
    String? qrCode,
    String? rfidEpc,
    _i2.ProductUnitStatus? status,
    int? currentNodeId,
    String? currentStationCode,
    DateTime? enteredNodeAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductUnit',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productionOrderId': productionOrderId,
      'productDefinitionId': productDefinitionId,
      'serialNumber': serialNumber,
      'qrCode': qrCode,
      if (rfidEpc != null) 'rfidEpc': rfidEpc,
      'status': status.toJson(),
      if (currentNodeId != null) 'currentNodeId': currentNodeId,
      if (currentStationCode != null) 'currentStationCode': currentStationCode,
      if (enteredNodeAt != null) 'enteredNodeAt': enteredNodeAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
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

class _ProductUnitImpl extends ProductUnit {
  _ProductUnitImpl({
    int? id,
    required int companyId,
    required int productionOrderId,
    required int productDefinitionId,
    required String serialNumber,
    required String qrCode,
    String? rfidEpc,
    required _i2.ProductUnitStatus status,
    int? currentNodeId,
    String? currentStationCode,
    DateTime? enteredNodeAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         productionOrderId: productionOrderId,
         productDefinitionId: productDefinitionId,
         serialNumber: serialNumber,
         qrCode: qrCode,
         rfidEpc: rfidEpc,
         status: status,
         currentNodeId: currentNodeId,
         currentStationCode: currentStationCode,
         enteredNodeAt: enteredNodeAt,
         completedAt: completedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProductUnit]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductUnit copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? productionOrderId,
    int? productDefinitionId,
    String? serialNumber,
    String? qrCode,
    Object? rfidEpc = _Undefined,
    _i2.ProductUnitStatus? status,
    Object? currentNodeId = _Undefined,
    Object? currentStationCode = _Undefined,
    Object? enteredNodeAt = _Undefined,
    Object? completedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductUnit(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      productionOrderId: productionOrderId ?? this.productionOrderId,
      productDefinitionId: productDefinitionId ?? this.productDefinitionId,
      serialNumber: serialNumber ?? this.serialNumber,
      qrCode: qrCode ?? this.qrCode,
      rfidEpc: rfidEpc is String? ? rfidEpc : this.rfidEpc,
      status: status ?? this.status,
      currentNodeId: currentNodeId is int? ? currentNodeId : this.currentNodeId,
      currentStationCode: currentStationCode is String?
          ? currentStationCode
          : this.currentStationCode,
      enteredNodeAt: enteredNodeAt is DateTime?
          ? enteredNodeAt
          : this.enteredNodeAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
