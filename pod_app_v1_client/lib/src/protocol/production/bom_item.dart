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

abstract class BomItem implements _i1.SerializableModel {
  BomItem._({
    this.id,
    required this.companyId,
    required this.productDefinitionId,
    required this.materialId,
    required this.quantity,
    required this.unit,
    double? scrapRatePercent,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  }) : scrapRatePercent = scrapRatePercent ?? 0.0;

  factory BomItem({
    int? id,
    required int companyId,
    required int productDefinitionId,
    required int materialId,
    required double quantity,
    required String unit,
    double? scrapRatePercent,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BomItemImpl;

  factory BomItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return BomItem(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      productDefinitionId: jsonSerialization['productDefinitionId'] as int,
      materialId: jsonSerialization['materialId'] as int,
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      scrapRatePercent: (jsonSerialization['scrapRatePercent'] as num?)
          ?.toDouble(),
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

  int productDefinitionId;

  int materialId;

  double quantity;

  String unit;

  double scrapRatePercent;

  String? note;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [BomItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BomItem copyWith({
    int? id,
    int? companyId,
    int? productDefinitionId,
    int? materialId,
    double? quantity,
    String? unit,
    double? scrapRatePercent,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BomItem',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productDefinitionId': productDefinitionId,
      'materialId': materialId,
      'quantity': quantity,
      'unit': unit,
      'scrapRatePercent': scrapRatePercent,
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

class _BomItemImpl extends BomItem {
  _BomItemImpl({
    int? id,
    required int companyId,
    required int productDefinitionId,
    required int materialId,
    required double quantity,
    required String unit,
    double? scrapRatePercent,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         productDefinitionId: productDefinitionId,
         materialId: materialId,
         quantity: quantity,
         unit: unit,
         scrapRatePercent: scrapRatePercent,
         note: note,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BomItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BomItem copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? productDefinitionId,
    int? materialId,
    double? quantity,
    String? unit,
    double? scrapRatePercent,
    Object? note = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BomItem(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      productDefinitionId: productDefinitionId ?? this.productDefinitionId,
      materialId: materialId ?? this.materialId,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      scrapRatePercent: scrapRatePercent ?? this.scrapRatePercent,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
