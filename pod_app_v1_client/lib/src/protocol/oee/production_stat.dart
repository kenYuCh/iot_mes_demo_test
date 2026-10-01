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

/// 產線小時統計（OEE 計算來源）。開發環境由模擬器產生，
/// 正式環境由產線 PLC / MES 匯入。
abstract class ProductionStat implements _i1.SerializableModel {
  ProductionStat._({
    this.id,
    required this.companyId,
    required this.siteId,
    required this.windowStart,
    required this.plannedMinutes,
    required this.runMinutes,
    required this.idealCount,
    required this.actualCount,
    required this.goodCount,
  });

  factory ProductionStat({
    int? id,
    required int companyId,
    required int siteId,
    required DateTime windowStart,
    required double plannedMinutes,
    required double runMinutes,
    required int idealCount,
    required int actualCount,
    required int goodCount,
  }) = _ProductionStatImpl;

  factory ProductionStat.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductionStat(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      siteId: jsonSerialization['siteId'] as int,
      windowStart: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['windowStart'],
      ),
      plannedMinutes: (jsonSerialization['plannedMinutes'] as num).toDouble(),
      runMinutes: (jsonSerialization['runMinutes'] as num).toDouble(),
      idealCount: jsonSerialization['idealCount'] as int,
      actualCount: jsonSerialization['actualCount'] as int,
      goodCount: jsonSerialization['goodCount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  int siteId;

  /// 統計視窗起點（整點，UTC）。
  DateTime windowStart;

  /// 計畫生產時間（分鐘）。
  double plannedMinutes;

  /// 實際運轉時間（分鐘）。
  double runMinutes;

  /// 理想產量（依理想節拍計算）。
  int idealCount;

  /// 實際產量。
  int actualCount;

  /// 良品數。
  int goodCount;

  /// Returns a shallow copy of this [ProductionStat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductionStat copyWith({
    int? id,
    int? companyId,
    int? siteId,
    DateTime? windowStart,
    double? plannedMinutes,
    double? runMinutes,
    int? idealCount,
    int? actualCount,
    int? goodCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductionStat',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      'windowStart': windowStart.toJson(),
      'plannedMinutes': plannedMinutes,
      'runMinutes': runMinutes,
      'idealCount': idealCount,
      'actualCount': actualCount,
      'goodCount': goodCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductionStatImpl extends ProductionStat {
  _ProductionStatImpl({
    int? id,
    required int companyId,
    required int siteId,
    required DateTime windowStart,
    required double plannedMinutes,
    required double runMinutes,
    required int idealCount,
    required int actualCount,
    required int goodCount,
  }) : super._(
         id: id,
         companyId: companyId,
         siteId: siteId,
         windowStart: windowStart,
         plannedMinutes: plannedMinutes,
         runMinutes: runMinutes,
         idealCount: idealCount,
         actualCount: actualCount,
         goodCount: goodCount,
       );

  /// Returns a shallow copy of this [ProductionStat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductionStat copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? siteId,
    DateTime? windowStart,
    double? plannedMinutes,
    double? runMinutes,
    int? idealCount,
    int? actualCount,
    int? goodCount,
  }) {
    return ProductionStat(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      siteId: siteId ?? this.siteId,
      windowStart: windowStart ?? this.windowStart,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      runMinutes: runMinutes ?? this.runMinutes,
      idealCount: idealCount ?? this.idealCount,
      actualCount: actualCount ?? this.actualCount,
      goodCount: goodCount ?? this.goodCount,
    );
  }
}
