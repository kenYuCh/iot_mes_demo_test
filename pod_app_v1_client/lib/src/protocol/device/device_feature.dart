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

/// 設備的一個特徵：量測通道（唯讀）或控制參數（可寫，經命令下發）。
/// 同一台設備可有多個量測通道與控制參數（例如馬達驅動器 6 量測 + 3 控制）。
abstract class DeviceFeature implements _i1.SerializableModel {
  DeviceFeature._({
    required this.key,
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
  });

  factory DeviceFeature({
    required String key,
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
  }) = _DeviceFeatureImpl;

  factory DeviceFeature.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceFeature(
      key: jsonSerialization['key'] as String,
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
    );
  }

  /// 特徵鍵，即 Measurement.featureKey / DeviceStatus.latestValues 的 key。
  String key;

  /// 顯示名稱，例如「馬達轉速」。
  String label;

  String unit;

  _i2.FeatureKind kind;

  /// 數值語意。boolean 使用 0/1；enumeration 使用 enumOptions 的索引。
  _i3.FeatureDataType? dataType;

  /// 前端控制呈現；量測通道為 null。
  _i4.ControlPresentation? controlPresentation;

  /// enumeration 的顯示選項，索引即實際下發值。
  List<String>? enumOptions;

  /// 建議顯示的小數位數。
  int? precision;

  String? description;

  double minValue;

  double maxValue;

  /// 控制參數的出廠預設值（量測通道為 null）。
  double? defaultValue;

  /// Returns a shallow copy of this [DeviceFeature]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceFeature copyWith({
    String? key,
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
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceFeature',
      'key': key,
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
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceFeatureImpl extends DeviceFeature {
  _DeviceFeatureImpl({
    required String key,
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
  }) : super._(
         key: key,
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
       );

  /// Returns a shallow copy of this [DeviceFeature]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceFeature copyWith({
    String? key,
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
  }) {
    return DeviceFeature(
      key: key ?? this.key,
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
    );
  }
}
