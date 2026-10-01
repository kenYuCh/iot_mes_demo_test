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

/// 單一場域 OEE 彙總。
abstract class OeeSiteSummary implements _i1.SerializableModel {
  OeeSiteSummary._({
    required this.siteId,
    required this.name,
    required this.availability,
    required this.performance,
    required this.quality,
    required this.oee,
  });

  factory OeeSiteSummary({
    required int siteId,
    required String name,
    required double availability,
    required double performance,
    required double quality,
    required double oee,
  }) = _OeeSiteSummaryImpl;

  factory OeeSiteSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return OeeSiteSummary(
      siteId: jsonSerialization['siteId'] as int,
      name: jsonSerialization['name'] as String,
      availability: (jsonSerialization['availability'] as num).toDouble(),
      performance: (jsonSerialization['performance'] as num).toDouble(),
      quality: (jsonSerialization['quality'] as num).toDouble(),
      oee: (jsonSerialization['oee'] as num).toDouble(),
    );
  }

  int siteId;

  String name;

  /// 稼動率 = 運轉時間 / 計畫時間（0..1）。
  double availability;

  /// 性能 = 實際產量 / 理想產量（0..1）。
  double performance;

  /// 品質 = 良品數 / 實際產量（0..1）。
  double quality;

  /// OEE = 稼動率 × 性能 × 品質（0..1）。
  double oee;

  /// Returns a shallow copy of this [OeeSiteSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OeeSiteSummary copyWith({
    int? siteId,
    String? name,
    double? availability,
    double? performance,
    double? quality,
    double? oee,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OeeSiteSummary',
      'siteId': siteId,
      'name': name,
      'availability': availability,
      'performance': performance,
      'quality': quality,
      'oee': oee,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OeeSiteSummaryImpl extends OeeSiteSummary {
  _OeeSiteSummaryImpl({
    required int siteId,
    required String name,
    required double availability,
    required double performance,
    required double quality,
    required double oee,
  }) : super._(
         siteId: siteId,
         name: name,
         availability: availability,
         performance: performance,
         quality: quality,
         oee: oee,
       );

  /// Returns a shallow copy of this [OeeSiteSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OeeSiteSummary copyWith({
    int? siteId,
    String? name,
    double? availability,
    double? performance,
    double? quality,
    double? oee,
  }) {
    return OeeSiteSummary(
      siteId: siteId ?? this.siteId,
      name: name ?? this.name,
      availability: availability ?? this.availability,
      performance: performance ?? this.performance,
      quality: quality ?? this.quality,
      oee: oee ?? this.oee,
    );
  }
}
