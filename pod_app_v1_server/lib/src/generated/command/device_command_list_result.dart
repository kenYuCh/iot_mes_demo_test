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
import '../command/device_command.dart' as _i2;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i3;

/// 控制命令 cursor 分頁結果。
abstract class DeviceCommandListResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DeviceCommandListResult._({
    required this.items,
    this.nextCursorId,
  });

  factory DeviceCommandListResult({
    required List<_i2.DeviceCommand> items,
    int? nextCursorId,
  }) = _DeviceCommandListResultImpl;

  factory DeviceCommandListResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DeviceCommandListResult(
      items: _i3.Protocol().deserialize<List<_i2.DeviceCommand>>(
        jsonSerialization['items'],
      ),
      nextCursorId: jsonSerialization['nextCursorId'] as int?,
    );
  }

  List<_i2.DeviceCommand> items;

  /// 下一頁 cursor；null 表示沒有更多資料。
  int? nextCursorId;

  /// Returns a shallow copy of this [DeviceCommandListResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceCommandListResult copyWith({
    List<_i2.DeviceCommand>? items,
    int? nextCursorId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceCommandListResult',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursorId != null) 'nextCursorId': nextCursorId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceCommandListResult',
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

class _DeviceCommandListResultImpl extends DeviceCommandListResult {
  _DeviceCommandListResultImpl({
    required List<_i2.DeviceCommand> items,
    int? nextCursorId,
  }) : super._(
         items: items,
         nextCursorId: nextCursorId,
       );

  /// Returns a shallow copy of this [DeviceCommandListResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceCommandListResult copyWith({
    List<_i2.DeviceCommand>? items,
    Object? nextCursorId = _Undefined,
  }) {
    return DeviceCommandListResult(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      nextCursorId: nextCursorId is int? ? nextCursorId : this.nextCursorId,
    );
  }
}
