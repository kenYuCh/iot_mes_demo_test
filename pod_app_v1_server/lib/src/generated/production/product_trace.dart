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
import '../production/product_unit.dart' as _i2;
import '../production/production_order.dart' as _i3;
import '../production/product_definition.dart' as _i4;
import '../production/process_event.dart' as _i5;
import 'package:pod_app_v1_server/src/generated/protocol.dart' as _i6;

abstract class ProductTrace
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ProductTrace._({
    required this.unit,
    required this.order,
    required this.product,
    required this.events,
  });

  factory ProductTrace({
    required _i2.ProductUnit unit,
    required _i3.ProductionOrder order,
    required _i4.ProductDefinition product,
    required List<_i5.ProcessEvent> events,
  }) = _ProductTraceImpl;

  factory ProductTrace.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductTrace(
      unit: _i6.Protocol().deserialize<_i2.ProductUnit>(
        jsonSerialization['unit'],
      ),
      order: _i6.Protocol().deserialize<_i3.ProductionOrder>(
        jsonSerialization['order'],
      ),
      product: _i6.Protocol().deserialize<_i4.ProductDefinition>(
        jsonSerialization['product'],
      ),
      events: _i6.Protocol().deserialize<List<_i5.ProcessEvent>>(
        jsonSerialization['events'],
      ),
    );
  }

  _i2.ProductUnit unit;

  _i3.ProductionOrder order;

  _i4.ProductDefinition product;

  List<_i5.ProcessEvent> events;

  /// Returns a shallow copy of this [ProductTrace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductTrace copyWith({
    _i2.ProductUnit? unit,
    _i3.ProductionOrder? order,
    _i4.ProductDefinition? product,
    List<_i5.ProcessEvent>? events,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductTrace',
      'unit': unit.toJson(),
      'order': order.toJson(),
      'product': product.toJson(),
      'events': events.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProductTrace',
      'unit': unit.toJsonForProtocol(),
      'order': order.toJsonForProtocol(),
      'product': product.toJsonForProtocol(),
      'events': events.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ProductTraceImpl extends ProductTrace {
  _ProductTraceImpl({
    required _i2.ProductUnit unit,
    required _i3.ProductionOrder order,
    required _i4.ProductDefinition product,
    required List<_i5.ProcessEvent> events,
  }) : super._(
         unit: unit,
         order: order,
         product: product,
         events: events,
       );

  /// Returns a shallow copy of this [ProductTrace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductTrace copyWith({
    _i2.ProductUnit? unit,
    _i3.ProductionOrder? order,
    _i4.ProductDefinition? product,
    List<_i5.ProcessEvent>? events,
  }) {
    return ProductTrace(
      unit: unit ?? this.unit.copyWith(),
      order: order ?? this.order.copyWith(),
      product: product ?? this.product.copyWith(),
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
    );
  }
}
