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

/// 場域（廠區／樓層等監控範圍）。
abstract class Site implements _i1.SerializableModel {
  Site._({
    this.id,
    required this.companyId,
    required this.name,
    this.description,
    required this.createdAt,
  });

  factory Site({
    int? id,
    required int companyId,
    required String name,
    String? description,
    required DateTime createdAt,
  }) = _SiteImpl;

  factory Site.fromJson(Map<String, dynamic> jsonSerialization) {
    return Site(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  String name;

  String? description;

  DateTime createdAt;

  /// Returns a shallow copy of this [Site]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Site copyWith({
    int? id,
    int? companyId,
    String? name,
    String? description,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Site',
      if (id != null) 'id': id,
      'companyId': companyId,
      'name': name,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SiteImpl extends Site {
  _SiteImpl({
    int? id,
    required int companyId,
    required String name,
    String? description,
    required DateTime createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         name: name,
         description: description,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Site]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Site copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? name,
    Object? description = _Undefined,
    DateTime? createdAt,
  }) {
    return Site(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
