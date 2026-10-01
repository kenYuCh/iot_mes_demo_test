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

/// 單一場域的彙總狀態（Dashboard 場域卡片）。
abstract class SiteSummary implements _i1.SerializableModel {
  SiteSummary._({
    required this.siteId,
    required this.name,
    required this.deviceCount,
    required this.onlineCount,
    required this.openAlertCount,
  });

  factory SiteSummary({
    required int siteId,
    required String name,
    required int deviceCount,
    required int onlineCount,
    required int openAlertCount,
  }) = _SiteSummaryImpl;

  factory SiteSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return SiteSummary(
      siteId: jsonSerialization['siteId'] as int,
      name: jsonSerialization['name'] as String,
      deviceCount: jsonSerialization['deviceCount'] as int,
      onlineCount: jsonSerialization['onlineCount'] as int,
      openAlertCount: jsonSerialization['openAlertCount'] as int,
    );
  }

  int siteId;

  String name;

  int deviceCount;

  int onlineCount;

  int openAlertCount;

  /// Returns a shallow copy of this [SiteSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SiteSummary copyWith({
    int? siteId,
    String? name,
    int? deviceCount,
    int? onlineCount,
    int? openAlertCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SiteSummary',
      'siteId': siteId,
      'name': name,
      'deviceCount': deviceCount,
      'onlineCount': onlineCount,
      'openAlertCount': openAlertCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SiteSummaryImpl extends SiteSummary {
  _SiteSummaryImpl({
    required int siteId,
    required String name,
    required int deviceCount,
    required int onlineCount,
    required int openAlertCount,
  }) : super._(
         siteId: siteId,
         name: name,
         deviceCount: deviceCount,
         onlineCount: onlineCount,
         openAlertCount: openAlertCount,
       );

  /// Returns a shallow copy of this [SiteSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SiteSummary copyWith({
    int? siteId,
    String? name,
    int? deviceCount,
    int? onlineCount,
    int? openAlertCount,
  }) {
    return SiteSummary(
      siteId: siteId ?? this.siteId,
      name: name ?? this.name,
      deviceCount: deviceCount ?? this.deviceCount,
      onlineCount: onlineCount ?? this.onlineCount,
      openAlertCount: openAlertCount ?? this.openAlertCount,
    );
  }
}
