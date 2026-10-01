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

abstract class ProductionLine implements _i1.SerializableModel {
  ProductionLine._({
    this.id,
    required this.companyId,
    required this.code,
    required this.name,
    this.description,
    bool? active,
    required this.createdAt,
    required this.updatedAt,
  }) : active = active ?? true;

  factory ProductionLine({
    int? id,
    required int companyId,
    required String code,
    required String name,
    String? description,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProductionLineImpl;

  factory ProductionLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductionLine(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
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

  String? description;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ProductionLine]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductionLine copyWith({
    int? id,
    int? companyId,
    String? code,
    String? name,
    String? description,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductionLine',
      if (id != null) 'id': id,
      'companyId': companyId,
      'code': code,
      'name': name,
      if (description != null) 'description': description,
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

class _ProductionLineImpl extends ProductionLine {
  _ProductionLineImpl({
    int? id,
    required int companyId,
    required String code,
    required String name,
    String? description,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         code: code,
         name: name,
         description: description,
         active: active,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProductionLine]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductionLine copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? code,
    String? name,
    Object? description = _Undefined,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductionLine(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
