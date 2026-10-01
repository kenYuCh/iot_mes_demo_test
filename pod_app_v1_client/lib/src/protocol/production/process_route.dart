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

abstract class ProcessRoute implements _i1.SerializableModel {
  ProcessRoute._({
    this.id,
    required this.companyId,
    required this.productDefinitionId,
    required this.code,
    required this.name,
    int? version,
    bool? active,
    required this.createdAt,
    required this.updatedAt,
  }) : version = version ?? 1,
       active = active ?? true;

  factory ProcessRoute({
    int? id,
    required int companyId,
    required int productDefinitionId,
    required String code,
    required String name,
    int? version,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProcessRouteImpl;

  factory ProcessRoute.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProcessRoute(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      productDefinitionId: jsonSerialization['productDefinitionId'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      version: jsonSerialization['version'] as int?,
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

  int productDefinitionId;

  String code;

  String name;

  int version;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ProcessRoute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProcessRoute copyWith({
    int? id,
    int? companyId,
    int? productDefinitionId,
    String? code,
    String? name,
    int? version,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProcessRoute',
      if (id != null) 'id': id,
      'companyId': companyId,
      'productDefinitionId': productDefinitionId,
      'code': code,
      'name': name,
      'version': version,
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

class _ProcessRouteImpl extends ProcessRoute {
  _ProcessRouteImpl({
    int? id,
    required int companyId,
    required int productDefinitionId,
    required String code,
    required String name,
    int? version,
    bool? active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         productDefinitionId: productDefinitionId,
         code: code,
         name: name,
         version: version,
         active: active,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProcessRoute]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProcessRoute copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? productDefinitionId,
    String? code,
    String? name,
    int? version,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProcessRoute(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      productDefinitionId: productDefinitionId ?? this.productDefinitionId,
      code: code ?? this.code,
      name: name ?? this.name,
      version: version ?? this.version,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
