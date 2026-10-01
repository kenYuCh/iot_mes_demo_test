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
import '../oee/oee_site_summary.dart' as _i2;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i3;

/// 全公司 OEE 彙總（近 8 小時視窗）。
abstract class OeeSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  OeeSummary._({
    required this.availability,
    required this.performance,
    required this.quality,
    required this.oee,
    required this.sites,
  });

  factory OeeSummary({
    required double availability,
    required double performance,
    required double quality,
    required double oee,
    required List<_i2.OeeSiteSummary> sites,
  }) = _OeeSummaryImpl;

  factory OeeSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return OeeSummary(
      availability: (jsonSerialization['availability'] as num).toDouble(),
      performance: (jsonSerialization['performance'] as num).toDouble(),
      quality: (jsonSerialization['quality'] as num).toDouble(),
      oee: (jsonSerialization['oee'] as num).toDouble(),
      sites: _i3.Protocol().deserialize<List<_i2.OeeSiteSummary>>(
        jsonSerialization['sites'],
      ),
    );
  }

  double availability;

  double performance;

  double quality;

  double oee;

  List<_i2.OeeSiteSummary> sites;

  /// Returns a shallow copy of this [OeeSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OeeSummary copyWith({
    double? availability,
    double? performance,
    double? quality,
    double? oee,
    List<_i2.OeeSiteSummary>? sites,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OeeSummary',
      'availability': availability,
      'performance': performance,
      'quality': quality,
      'oee': oee,
      'sites': sites.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OeeSummary',
      'availability': availability,
      'performance': performance,
      'quality': quality,
      'oee': oee,
      'sites': sites.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OeeSummaryImpl extends OeeSummary {
  _OeeSummaryImpl({
    required double availability,
    required double performance,
    required double quality,
    required double oee,
    required List<_i2.OeeSiteSummary> sites,
  }) : super._(
         availability: availability,
         performance: performance,
         quality: quality,
         oee: oee,
         sites: sites,
       );

  /// Returns a shallow copy of this [OeeSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OeeSummary copyWith({
    double? availability,
    double? performance,
    double? quality,
    double? oee,
    List<_i2.OeeSiteSummary>? sites,
  }) {
    return OeeSummary(
      availability: availability ?? this.availability,
      performance: performance ?? this.performance,
      quality: quality ?? this.quality,
      oee: oee ?? this.oee,
      sites: sites ?? this.sites.map((e0) => e0.copyWith()).toList(),
    );
  }
}
