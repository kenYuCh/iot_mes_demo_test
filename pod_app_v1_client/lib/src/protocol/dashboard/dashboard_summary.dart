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
import '../dashboard/site_summary.dart' as _i2;
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i3;

/// 全公司 Dashboard 彙總（KPI 與場域狀態卡片）。
abstract class DashboardSummary implements _i1.SerializableModel {
  DashboardSummary._({
    required this.siteCount,
    required this.gatewayCount,
    required this.deviceCount,
    required this.onlineCount,
    required this.staleCount,
    required this.offlineCount,
    required this.openAlertCount,
    required this.sites,
  });

  factory DashboardSummary({
    required int siteCount,
    required int gatewayCount,
    required int deviceCount,
    required int onlineCount,
    required int staleCount,
    required int offlineCount,
    required int openAlertCount,
    required List<_i2.SiteSummary> sites,
  }) = _DashboardSummaryImpl;

  factory DashboardSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardSummary(
      siteCount: jsonSerialization['siteCount'] as int,
      gatewayCount: jsonSerialization['gatewayCount'] as int,
      deviceCount: jsonSerialization['deviceCount'] as int,
      onlineCount: jsonSerialization['onlineCount'] as int,
      staleCount: jsonSerialization['staleCount'] as int,
      offlineCount: jsonSerialization['offlineCount'] as int,
      openAlertCount: jsonSerialization['openAlertCount'] as int,
      sites: _i3.Protocol().deserialize<List<_i2.SiteSummary>>(
        jsonSerialization['sites'],
      ),
    );
  }

  int siteCount;

  int gatewayCount;

  int deviceCount;

  int onlineCount;

  int staleCount;

  int offlineCount;

  int openAlertCount;

  List<_i2.SiteSummary> sites;

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardSummary copyWith({
    int? siteCount,
    int? gatewayCount,
    int? deviceCount,
    int? onlineCount,
    int? staleCount,
    int? offlineCount,
    int? openAlertCount,
    List<_i2.SiteSummary>? sites,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardSummary',
      'siteCount': siteCount,
      'gatewayCount': gatewayCount,
      'deviceCount': deviceCount,
      'onlineCount': onlineCount,
      'staleCount': staleCount,
      'offlineCount': offlineCount,
      'openAlertCount': openAlertCount,
      'sites': sites.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DashboardSummaryImpl extends DashboardSummary {
  _DashboardSummaryImpl({
    required int siteCount,
    required int gatewayCount,
    required int deviceCount,
    required int onlineCount,
    required int staleCount,
    required int offlineCount,
    required int openAlertCount,
    required List<_i2.SiteSummary> sites,
  }) : super._(
         siteCount: siteCount,
         gatewayCount: gatewayCount,
         deviceCount: deviceCount,
         onlineCount: onlineCount,
         staleCount: staleCount,
         offlineCount: offlineCount,
         openAlertCount: openAlertCount,
         sites: sites,
       );

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardSummary copyWith({
    int? siteCount,
    int? gatewayCount,
    int? deviceCount,
    int? onlineCount,
    int? staleCount,
    int? offlineCount,
    int? openAlertCount,
    List<_i2.SiteSummary>? sites,
  }) {
    return DashboardSummary(
      siteCount: siteCount ?? this.siteCount,
      gatewayCount: gatewayCount ?? this.gatewayCount,
      deviceCount: deviceCount ?? this.deviceCount,
      onlineCount: onlineCount ?? this.onlineCount,
      staleCount: staleCount ?? this.staleCount,
      offlineCount: offlineCount ?? this.offlineCount,
      openAlertCount: openAlertCount ?? this.openAlertCount,
      sites: sites ?? this.sites.map((e0) => e0.copyWith()).toList(),
    );
  }
}
