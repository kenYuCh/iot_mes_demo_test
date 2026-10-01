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

/// 歷史量測資料（高頻寫入，批次插入，不逐筆交易）。
abstract class Measurement implements _i1.SerializableModel {
  Measurement._({
    this.id,
    required this.companyId,
    required this.deviceId,
    required this.featureKey,
    required this.value,
    required this.measuredAt,
    required this.receivedAt,
  });

  factory Measurement({
    int? id,
    required int companyId,
    required int deviceId,
    required String featureKey,
    required double value,
    required DateTime measuredAt,
    required DateTime receivedAt,
  }) = _MeasurementImpl;

  factory Measurement.fromJson(Map<String, dynamic> jsonSerialization) {
    return Measurement(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      deviceId: jsonSerialization['deviceId'] as int,
      featureKey: jsonSerialization['featureKey'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      measuredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['measuredAt'],
      ),
      receivedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  int deviceId;

  String featureKey;

  double value;

  /// 設備量測時間（UTC）。
  DateTime measuredAt;

  /// 平台收到時間（UTC）。
  DateTime receivedAt;

  /// Returns a shallow copy of this [Measurement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Measurement copyWith({
    int? id,
    int? companyId,
    int? deviceId,
    String? featureKey,
    double? value,
    DateTime? measuredAt,
    DateTime? receivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Measurement',
      if (id != null) 'id': id,
      'companyId': companyId,
      'deviceId': deviceId,
      'featureKey': featureKey,
      'value': value,
      'measuredAt': measuredAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MeasurementImpl extends Measurement {
  _MeasurementImpl({
    int? id,
    required int companyId,
    required int deviceId,
    required String featureKey,
    required double value,
    required DateTime measuredAt,
    required DateTime receivedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         deviceId: deviceId,
         featureKey: featureKey,
         value: value,
         measuredAt: measuredAt,
         receivedAt: receivedAt,
       );

  /// Returns a shallow copy of this [Measurement]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Measurement copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? deviceId,
    String? featureKey,
    double? value,
    DateTime? measuredAt,
    DateTime? receivedAt,
  }) {
    return Measurement(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      deviceId: deviceId ?? this.deviceId,
      featureKey: featureKey ?? this.featureKey,
      value: value ?? this.value,
      measuredAt: measuredAt ?? this.measuredAt,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }
}
