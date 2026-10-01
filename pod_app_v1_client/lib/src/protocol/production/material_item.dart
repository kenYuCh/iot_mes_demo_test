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
import '../production/material_type.dart' as _i2;

abstract class MaterialItem implements _i1.SerializableModel {
  MaterialItem._({
    this.id,
    required this.companyId,
    required this.code,
    required this.name,
    required this.type,
    this.specification,
    required this.unit,
    this.supplier,
    double? safetyStock,
    bool? active,
    required this.createdAt,
    required this.updatedAt,
  }) : safetyStock = safetyStock ?? 0.0,
       active = active ?? true;

  factory MaterialItem({
    int? id,
    required int companyId,
    required String code,
    required String name,
    required _i2.MaterialType type,
    String? specification,
    required String unit,
    String? supplier,
    double? safetyStock,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MaterialItemImpl;

  factory MaterialItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaterialItem(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      type: _i2.MaterialType.fromJson((jsonSerialization['type'] as String)),
      specification: jsonSerialization['specification'] as String?,
      unit: jsonSerialization['unit'] as String,
      supplier: jsonSerialization['supplier'] as String?,
      safetyStock: (jsonSerialization['safetyStock'] as num?)?.toDouble(),
      active: jsonSerialization['active'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['active']),
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

  String code;

  String name;

  _i2.MaterialType type;

  String? specification;

  String unit;

  String? supplier;

  double safetyStock;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [MaterialItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MaterialItem copyWith({
    int? id,
    int? companyId,
    String? code,
    String? name,
    _i2.MaterialType? type,
    String? specification,
    String? unit,
    String? supplier,
    double? safetyStock,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaterialItem',
      if (id != null) 'id': id,
      'companyId': companyId,
      'code': code,
      'name': name,
      'type': type.toJson(),
      if (specification != null) 'specification': specification,
      'unit': unit,
      if (supplier != null) 'supplier': supplier,
      'safetyStock': safetyStock,
      'active': active,
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

class _MaterialItemImpl extends MaterialItem {
  _MaterialItemImpl({
    int? id,
    required int companyId,
    required String code,
    required String name,
    required _i2.MaterialType type,
    String? specification,
    required String unit,
    String? supplier,
    double? safetyStock,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         code: code,
         name: name,
         type: type,
         specification: specification,
         unit: unit,
         supplier: supplier,
         safetyStock: safetyStock,
         active: active,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MaterialItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MaterialItem copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? code,
    String? name,
    _i2.MaterialType? type,
    Object? specification = _Undefined,
    String? unit,
    Object? supplier = _Undefined,
    double? safetyStock,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MaterialItem(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      specification: specification is String?
          ? specification
          : this.specification,
      unit: unit ?? this.unit,
      supplier: supplier is String? ? supplier : this.supplier,
      safetyStock: safetyStock ?? this.safetyStock,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
