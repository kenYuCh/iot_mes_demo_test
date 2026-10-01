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
import '../alert/alert.dart' as _i2;
import 'package:pod_app_v1_client/src/protocol/protocol.dart' as _i3;

/// 告警 cursor 分頁結果。
abstract class AlertListResult implements _i1.SerializableModel {
  AlertListResult._({
    required this.items,
    this.nextCursorId,
  });

  factory AlertListResult({
    required List<_i2.Alert> items,
    int? nextCursorId,
  }) = _AlertListResultImpl;

  factory AlertListResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AlertListResult(
      items: _i3.Protocol().deserialize<List<_i2.Alert>>(
        jsonSerialization['items'],
      ),
      nextCursorId: jsonSerialization['nextCursorId'] as int?,
    );
  }

  List<_i2.Alert> items;

  /// 下一頁 cursor；null 表示沒有更多資料。
  int? nextCursorId;

  /// Returns a shallow copy of this [AlertListResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AlertListResult copyWith({
    List<_i2.Alert>? items,
    int? nextCursorId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AlertListResult',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursorId != null) 'nextCursorId': nextCursorId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AlertListResultImpl extends AlertListResult {
  _AlertListResultImpl({
    required List<_i2.Alert> items,
    int? nextCursorId,
  }) : super._(
         items: items,
         nextCursorId: nextCursorId,
       );

  /// Returns a shallow copy of this [AlertListResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AlertListResult copyWith({
    List<_i2.Alert>? items,
    Object? nextCursorId = _Undefined,
  }) {
    return AlertListResult(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      nextCursorId: nextCursorId is int? ? nextCursorId : this.nextCursorId,
    );
  }
}
