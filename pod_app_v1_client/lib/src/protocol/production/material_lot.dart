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

abstract class MaterialLot implements _i1.SerializableModel {
  MaterialLot._({
    this.id,
    required this.companyId,
    required this.materialId,
    required this.lotNumber,
    required this.quantity,
    required this.receivedAt,
    this.expiresAt,
    this.supplierLot,
    this.qrCode,
    this.rfidEpc,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MaterialLot({
    int? id,
    required int companyId,
    required int materialId,
    required String lotNumber,
    required double quantity,
    required DateTime receivedAt,
    DateTime? expiresAt,
    String? supplierLot,
    String? qrCode,
    String? rfidEpc,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MaterialLotImpl;

  factory MaterialLot.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaterialLot(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      materialId: jsonSerialization['materialId'] as int,
      lotNumber: jsonSerialization['lotNumber'] as String,
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      receivedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      supplierLot: jsonSerialization['supplierLot'] as String?,
      qrCode: jsonSerialization['qrCode'] as String?,
      rfidEpc: jsonSerialization['rfidEpc'] as String?,
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

  int materialId;

  String lotNumber;

  double quantity;

  DateTime receivedAt;

  DateTime? expiresAt;

  String? supplierLot;

  String? qrCode;

  String? rfidEpc;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [MaterialLot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MaterialLot copyWith({
    int? id,
    int? companyId,
    int? materialId,
    String? lotNumber,
    double? quantity,
    DateTime? receivedAt,
    DateTime? expiresAt,
    String? supplierLot,
    String? qrCode,
    String? rfidEpc,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaterialLot',
      if (id != null) 'id': id,
      'companyId': companyId,
      'materialId': materialId,
      'lotNumber': lotNumber,
      'quantity': quantity,
      'receivedAt': receivedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (supplierLot != null) 'supplierLot': supplierLot,
      if (qrCode != null) 'qrCode': qrCode,
      if (rfidEpc != null) 'rfidEpc': rfidEpc,
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

class _MaterialLotImpl extends MaterialLot {
  _MaterialLotImpl({
    int? id,
    required int companyId,
    required int materialId,
    required String lotNumber,
    required double quantity,
    required DateTime receivedAt,
    DateTime? expiresAt,
    String? supplierLot,
    String? qrCode,
    String? rfidEpc,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         materialId: materialId,
         lotNumber: lotNumber,
         quantity: quantity,
         receivedAt: receivedAt,
         expiresAt: expiresAt,
         supplierLot: supplierLot,
         qrCode: qrCode,
         rfidEpc: rfidEpc,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MaterialLot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MaterialLot copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? materialId,
    String? lotNumber,
    double? quantity,
    DateTime? receivedAt,
    Object? expiresAt = _Undefined,
    Object? supplierLot = _Undefined,
    Object? qrCode = _Undefined,
    Object? rfidEpc = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MaterialLot(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      materialId: materialId ?? this.materialId,
      lotNumber: lotNumber ?? this.lotNumber,
      quantity: quantity ?? this.quantity,
      receivedAt: receivedAt ?? this.receivedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      supplierLot: supplierLot is String? ? supplierLot : this.supplierLot,
      qrCode: qrCode is String? ? qrCode : this.qrCode,
      rfidEpc: rfidEpc is String? ? rfidEpc : this.rfidEpc,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
