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
import 'package:serverpod/serverpod.dart' as _i1;
import '../device/device_feature.dart' as _i2;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i3;

/// 特徵資料庫列表項目；系統內建項目的 definitionId 為 null，僅能選用不可修改。
abstract class FeatureCatalogItem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FeatureCatalogItem._({
    this.definitionId,
    required this.feature,
    required this.system,
    required this.usageCount,
  });

  factory FeatureCatalogItem({
    int? definitionId,
    required _i2.DeviceFeature feature,
    required bool system,
    required int usageCount,
  }) = _FeatureCatalogItemImpl;

  factory FeatureCatalogItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureCatalogItem(
      definitionId: jsonSerialization['definitionId'] as int?,
      feature: _i3.Protocol().deserialize<_i2.DeviceFeature>(
        jsonSerialization['feature'],
      ),
      system: _i1.BoolJsonExtension.fromJson(jsonSerialization['system']),
      usageCount: jsonSerialization['usageCount'] as int,
    );
  }

  int? definitionId;

  _i2.DeviceFeature feature;

  bool system;

  int usageCount;

  /// Returns a shallow copy of this [FeatureCatalogItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureCatalogItem copyWith({
    int? definitionId,
    _i2.DeviceFeature? feature,
    bool? system,
    int? usageCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureCatalogItem',
      if (definitionId != null) 'definitionId': definitionId,
      'feature': feature.toJson(),
      'system': system,
      'usageCount': usageCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureCatalogItem',
      if (definitionId != null) 'definitionId': definitionId,
      'feature': feature.toJsonForProtocol(),
      'system': system,
      'usageCount': usageCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureCatalogItemImpl extends FeatureCatalogItem {
  _FeatureCatalogItemImpl({
    int? definitionId,
    required _i2.DeviceFeature feature,
    required bool system,
    required int usageCount,
  }) : super._(
         definitionId: definitionId,
         feature: feature,
         system: system,
         usageCount: usageCount,
       );

  /// Returns a shallow copy of this [FeatureCatalogItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureCatalogItem copyWith({
    Object? definitionId = _Undefined,
    _i2.DeviceFeature? feature,
    bool? system,
    int? usageCount,
  }) {
    return FeatureCatalogItem(
      definitionId: definitionId is int? ? definitionId : this.definitionId,
      feature: feature ?? this.feature.copyWith(),
      system: system ?? this.system,
      usageCount: usageCount ?? this.usageCount,
    );
  }
}
