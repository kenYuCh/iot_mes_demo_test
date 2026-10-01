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
import '../ota/firmware_package.dart' as _i2;
import '../ota/firmware_artifact.dart' as _i3;
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i4;

/// 韌體版本與其全部檔案產物。
abstract class FirmwareReleaseDetail implements _i1.SerializableModel {
  FirmwareReleaseDetail._({
    required this.release,
    required this.artifacts,
  });

  factory FirmwareReleaseDetail({
    required _i2.FirmwarePackage release,
    required List<_i3.FirmwareArtifact> artifacts,
  }) = _FirmwareReleaseDetailImpl;

  factory FirmwareReleaseDetail.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FirmwareReleaseDetail(
      release: _i4.Protocol().deserialize<_i2.FirmwarePackage>(
        jsonSerialization['release'],
      ),
      artifacts: _i4.Protocol().deserialize<List<_i3.FirmwareArtifact>>(
        jsonSerialization['artifacts'],
      ),
    );
  }

  _i2.FirmwarePackage release;

  List<_i3.FirmwareArtifact> artifacts;

  /// Returns a shallow copy of this [FirmwareReleaseDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FirmwareReleaseDetail copyWith({
    _i2.FirmwarePackage? release,
    List<_i3.FirmwareArtifact>? artifacts,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FirmwareReleaseDetail',
      'release': release.toJson(),
      'artifacts': artifacts.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FirmwareReleaseDetailImpl extends FirmwareReleaseDetail {
  _FirmwareReleaseDetailImpl({
    required _i2.FirmwarePackage release,
    required List<_i3.FirmwareArtifact> artifacts,
  }) : super._(
         release: release,
         artifacts: artifacts,
       );

  /// Returns a shallow copy of this [FirmwareReleaseDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FirmwareReleaseDetail copyWith({
    _i2.FirmwarePackage? release,
    List<_i3.FirmwareArtifact>? artifacts,
  }) {
    return FirmwareReleaseDetail(
      release: release ?? this.release.copyWith(),
      artifacts:
          artifacts ?? this.artifacts.map((e0) => e0.copyWith()).toList(),
    );
  }
}
