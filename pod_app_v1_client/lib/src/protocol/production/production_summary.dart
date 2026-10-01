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

abstract class ProductionSummary implements _i1.SerializableModel {
  ProductionSummary._({
    required this.totalUnits,
    required this.inProgressUnits,
    required this.completedUnits,
    required this.abnormalUnits,
    required this.activeOrders,
  });

  factory ProductionSummary({
    required int totalUnits,
    required int inProgressUnits,
    required int completedUnits,
    required int abnormalUnits,
    required int activeOrders,
  }) = _ProductionSummaryImpl;

  factory ProductionSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductionSummary(
      totalUnits: jsonSerialization['totalUnits'] as int,
      inProgressUnits: jsonSerialization['inProgressUnits'] as int,
      completedUnits: jsonSerialization['completedUnits'] as int,
      abnormalUnits: jsonSerialization['abnormalUnits'] as int,
      activeOrders: jsonSerialization['activeOrders'] as int,
    );
  }

  int totalUnits;

  int inProgressUnits;

  int completedUnits;

  int abnormalUnits;

  int activeOrders;

  /// Returns a shallow copy of this [ProductionSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductionSummary copyWith({
    int? totalUnits,
    int? inProgressUnits,
    int? completedUnits,
    int? abnormalUnits,
    int? activeOrders,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductionSummary',
      'totalUnits': totalUnits,
      'inProgressUnits': inProgressUnits,
      'completedUnits': completedUnits,
      'abnormalUnits': abnormalUnits,
      'activeOrders': activeOrders,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ProductionSummaryImpl extends ProductionSummary {
  _ProductionSummaryImpl({
    required int totalUnits,
    required int inProgressUnits,
    required int completedUnits,
    required int abnormalUnits,
    required int activeOrders,
  }) : super._(
         totalUnits: totalUnits,
         inProgressUnits: inProgressUnits,
         completedUnits: completedUnits,
         abnormalUnits: abnormalUnits,
         activeOrders: activeOrders,
       );

  /// Returns a shallow copy of this [ProductionSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductionSummary copyWith({
    int? totalUnits,
    int? inProgressUnits,
    int? completedUnits,
    int? abnormalUnits,
    int? activeOrders,
  }) {
    return ProductionSummary(
      totalUnits: totalUnits ?? this.totalUnits,
      inProgressUnits: inProgressUnits ?? this.inProgressUnits,
      completedUnits: completedUnits ?? this.completedUnits,
      abnormalUnits: abnormalUnits ?? this.abnormalUnits,
      activeOrders: activeOrders ?? this.activeOrders,
    );
  }
}
