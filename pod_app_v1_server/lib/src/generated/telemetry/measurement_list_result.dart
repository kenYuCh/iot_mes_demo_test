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
import '../telemetry/measurement.dart' as _i2;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i3;

/// 量測歷史查詢結果（cursor 分頁）。
abstract class MeasurementListResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  MeasurementListResult._({
    required this.items,
    this.nextCursorId,
  });

  factory MeasurementListResult({
    required List<_i2.Measurement> items,
    int? nextCursorId,
  }) = _MeasurementListResultImpl;

  factory MeasurementListResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MeasurementListResult(
      items: _i3.Protocol().deserialize<List<_i2.Measurement>>(
        jsonSerialization['items'],
      ),
      nextCursorId: jsonSerialization['nextCursorId'] as int?,
    );
  }

  List<_i2.Measurement> items;

  /// 下一頁 cursor（最後一筆 id）；null 表示沒有更多資料。
  int? nextCursorId;

  /// Returns a shallow copy of this [MeasurementListResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MeasurementListResult copyWith({
    List<_i2.Measurement>? items,
    int? nextCursorId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MeasurementListResult',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursorId != null) 'nextCursorId': nextCursorId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MeasurementListResult',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (nextCursorId != null) 'nextCursorId': nextCursorId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MeasurementListResultImpl extends MeasurementListResult {
  _MeasurementListResultImpl({
    required List<_i2.Measurement> items,
    int? nextCursorId,
  }) : super._(
         items: items,
         nextCursorId: nextCursorId,
       );

  /// Returns a shallow copy of this [MeasurementListResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MeasurementListResult copyWith({
    List<_i2.Measurement>? items,
    Object? nextCursorId = _Undefined,
  }) {
    return MeasurementListResult(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      nextCursorId: nextCursorId is int? ? nextCursorId : this.nextCursorId,
    );
  }
}
