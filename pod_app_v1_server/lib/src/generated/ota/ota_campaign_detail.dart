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
import '../ota/ota_campaign.dart' as _i2;
import '../ota/firmware_package.dart' as _i3;
import '../ota/ota_device_job.dart' as _i4;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i5;

/// OTA 中心顯示用 DTO，避免前端逐筆查詢造成 N+1。
abstract class OtaCampaignDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  OtaCampaignDetail._({
    required this.campaign,
    required this.firmware,
    required this.jobs,
  });

  factory OtaCampaignDetail({
    required _i2.OtaCampaign campaign,
    required _i3.FirmwarePackage firmware,
    required List<_i4.OtaDeviceJob> jobs,
  }) = _OtaCampaignDetailImpl;

  factory OtaCampaignDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return OtaCampaignDetail(
      campaign: _i5.Protocol().deserialize<_i2.OtaCampaign>(
        jsonSerialization['campaign'],
      ),
      firmware: _i5.Protocol().deserialize<_i3.FirmwarePackage>(
        jsonSerialization['firmware'],
      ),
      jobs: _i5.Protocol().deserialize<List<_i4.OtaDeviceJob>>(
        jsonSerialization['jobs'],
      ),
    );
  }

  _i2.OtaCampaign campaign;

  _i3.FirmwarePackage firmware;

  List<_i4.OtaDeviceJob> jobs;

  /// Returns a shallow copy of this [OtaCampaignDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OtaCampaignDetail copyWith({
    _i2.OtaCampaign? campaign,
    _i3.FirmwarePackage? firmware,
    List<_i4.OtaDeviceJob>? jobs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OtaCampaignDetail',
      'campaign': campaign.toJson(),
      'firmware': firmware.toJson(),
      'jobs': jobs.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OtaCampaignDetail',
      'campaign': campaign.toJsonForProtocol(),
      'firmware': firmware.toJsonForProtocol(),
      'jobs': jobs.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OtaCampaignDetailImpl extends OtaCampaignDetail {
  _OtaCampaignDetailImpl({
    required _i2.OtaCampaign campaign,
    required _i3.FirmwarePackage firmware,
    required List<_i4.OtaDeviceJob> jobs,
  }) : super._(
         campaign: campaign,
         firmware: firmware,
         jobs: jobs,
       );

  /// Returns a shallow copy of this [OtaCampaignDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OtaCampaignDetail copyWith({
    _i2.OtaCampaign? campaign,
    _i3.FirmwarePackage? firmware,
    List<_i4.OtaDeviceJob>? jobs,
  }) {
    return OtaCampaignDetail(
      campaign: campaign ?? this.campaign.copyWith(),
      firmware: firmware ?? this.firmware.copyWith(),
      jobs: jobs ?? this.jobs.map((e0) => e0.copyWith()).toList(),
    );
  }
}
