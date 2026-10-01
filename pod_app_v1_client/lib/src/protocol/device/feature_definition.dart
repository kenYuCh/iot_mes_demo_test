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
import '../device/feature_kind.dart' as _i2;
import '../device/feature_data_type.dart' as _i3;
import '../device/control_presentation.dart' as _i4;
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i5;

/// 公司級可重用特徵定義。設備型別選用時複製為快照，避免已部署協定被目錄修改連動。
abstract class FeatureDefinition implements _i1.SerializableModel {
  FeatureDefinition._({
    this.id,
    required this.companyId,
    required this.featureKey,
    required this.label,
    required this.unit,
    required this.kind,
    this.dataType,
    this.controlPresentation,
    this.enumOptions,
    this.precision,
    this.description,
    required this.minValue,
    required this.maxValue,
    this.defaultValue,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FeatureDefinition({
    int? id,
    required int companyId,
    required String featureKey,
    required String label,
    required String unit,
    required _i2.FeatureKind kind,
    _i3.FeatureDataType? dataType,
    _i4.ControlPresentation? controlPresentation,
    List<String>? enumOptions,
    int? precision,
    String? description,
    required double minValue,
    required double maxValue,
    double? defaultValue,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FeatureDefinitionImpl;

  factory FeatureDefinition.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureDefinition(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      featureKey: jsonSerialization['featureKey'] as String,
      label: jsonSerialization['label'] as String,
      unit: jsonSerialization['unit'] as String,
      kind: _i2.FeatureKind.fromJson((jsonSerialization['kind'] as String)),
      dataType: jsonSerialization['dataType'] == null
          ? null
          : _i3.FeatureDataType.fromJson(
              (jsonSerialization['dataType'] as String),
            ),
      controlPresentation: jsonSerialization['controlPresentation'] == null
          ? null
          : _i4.ControlPresentation.fromJson(
              (jsonSerialization['controlPresentation'] as String),
            ),
      enumOptions: jsonSerialization['enumOptions'] == null
          ? null
          : _i5.Protocol().deserialize<List<String>>(
              jsonSerialization['enumOptions'],
            ),
      precision: jsonSerialization['precision'] as int?,
      description: jsonSerialization['description'] as String?,
      minValue: (jsonSerialization['minValue'] as num).toDouble(),
      maxValue: (jsonSerialization['maxValue'] as num).toDouble(),
      defaultValue: (jsonSerialization['defaultValue'] as num?)?.toDouble(),
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

  String featureKey;

  String label;

  String unit;

  _i2.FeatureKind kind;

  _i3.FeatureDataType? dataType;

  _i4.ControlPresentation? controlPresentation;

  List<String>? enumOptions;

  int? precision;

  String? description;

  double minValue;

  double maxValue;

  double? defaultValue;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [FeatureDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureDefinition copyWith({
    int? id,
    int? companyId,
    String? featureKey,
    String? label,
    String? unit,
    _i2.FeatureKind? kind,
    _i3.FeatureDataType? dataType,
    _i4.ControlPresentation? controlPresentation,
    List<String>? enumOptions,
    int? precision,
    String? description,
    double? minValue,
    double? maxValue,
    double? defaultValue,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureDefinition',
      if (id != null) 'id': id,
      'companyId': companyId,
      'featureKey': featureKey,
      'label': label,
      'unit': unit,
      'kind': kind.toJson(),
      if (dataType != null) 'dataType': dataType?.toJson(),
      if (controlPresentation != null)
        'controlPresentation': controlPresentation?.toJson(),
      if (enumOptions != null) 'enumOptions': enumOptions?.toJson(),
      if (precision != null) 'precision': precision,
      if (description != null) 'description': description,
      'minValue': minValue,
      'maxValue': maxValue,
      if (defaultValue != null) 'defaultValue': defaultValue,
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

class _FeatureDefinitionImpl extends FeatureDefinition {
  _FeatureDefinitionImpl({
    int? id,
    required int companyId,
    required String featureKey,
    required String label,
    required String unit,
    required _i2.FeatureKind kind,
    _i3.FeatureDataType? dataType,
    _i4.ControlPresentation? controlPresentation,
    List<String>? enumOptions,
    int? precision,
    String? description,
    required double minValue,
    required double maxValue,
    double? defaultValue,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         featureKey: featureKey,
         label: label,
         unit: unit,
         kind: kind,
         dataType: dataType,
         controlPresentation: controlPresentation,
         enumOptions: enumOptions,
         precision: precision,
         description: description,
         minValue: minValue,
         maxValue: maxValue,
         defaultValue: defaultValue,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FeatureDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureDefinition copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? featureKey,
    String? label,
    String? unit,
    _i2.FeatureKind? kind,
    Object? dataType = _Undefined,
    Object? controlPresentation = _Undefined,
    Object? enumOptions = _Undefined,
    Object? precision = _Undefined,
    Object? description = _Undefined,
    double? minValue,
    double? maxValue,
    Object? defaultValue = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FeatureDefinition(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      featureKey: featureKey ?? this.featureKey,
      label: label ?? this.label,
      unit: unit ?? this.unit,
      kind: kind ?? this.kind,
      dataType: dataType is _i3.FeatureDataType? ? dataType : this.dataType,
      controlPresentation: controlPresentation is _i4.ControlPresentation?
          ? controlPresentation
          : this.controlPresentation,
      enumOptions: enumOptions is List<String>?
          ? enumOptions
          : this.enumOptions?.map((e0) => e0).toList(),
      precision: precision is int? ? precision : this.precision,
      description: description is String? ? description : this.description,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      defaultValue: defaultValue is double? ? defaultValue : this.defaultValue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
