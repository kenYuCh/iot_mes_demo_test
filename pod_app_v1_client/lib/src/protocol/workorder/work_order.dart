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
import '../workorder/work_order_status.dart' as _i2;
import '../workorder/work_order_priority.dart' as _i3;

/// 維修/巡檢工單（Mobile CMMS，見 docs/product/design.md）。
abstract class WorkOrder implements _i1.SerializableModel {
  WorkOrder._({
    this.id,
    required this.companyId,
    required this.siteId,
    this.deviceId,
    this.alertId,
    required this.title,
    this.description,
    required this.status,
    required this.priority,
    this.note,
    required this.createdBy,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
  });

  factory WorkOrder({
    int? id,
    required int companyId,
    required int siteId,
    int? deviceId,
    int? alertId,
    required String title,
    String? description,
    required _i2.WorkOrderStatus status,
    required _i3.WorkOrderPriority priority,
    String? note,
    required String createdBy,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _WorkOrderImpl;

  factory WorkOrder.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkOrder(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      siteId: jsonSerialization['siteId'] as int,
      deviceId: jsonSerialization['deviceId'] as int?,
      alertId: jsonSerialization['alertId'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      status: _i2.WorkOrderStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      priority: _i3.WorkOrderPriority.fromJson(
        (jsonSerialization['priority'] as String),
      ),
      note: jsonSerialization['note'] as String?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int companyId;

  int siteId;

  /// 關聯設備；廠務類工單可不綁設備。
  int? deviceId;

  /// 由告警轉開的工單來源。
  int? alertId;

  String title;

  String? description;

  _i2.WorkOrderStatus status;

  _i3.WorkOrderPriority priority;

  /// 處理紀錄（結案備註）。
  String? note;

  String createdBy;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? completedAt;

  /// Returns a shallow copy of this [WorkOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WorkOrder copyWith({
    int? id,
    int? companyId,
    int? siteId,
    int? deviceId,
    int? alertId,
    String? title,
    String? description,
    _i2.WorkOrderStatus? status,
    _i3.WorkOrderPriority? priority,
    String? note,
    String? createdBy,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkOrder',
      if (id != null) 'id': id,
      'companyId': companyId,
      'siteId': siteId,
      if (deviceId != null) 'deviceId': deviceId,
      if (alertId != null) 'alertId': alertId,
      'title': title,
      if (description != null) 'description': description,
      'status': status.toJson(),
      'priority': priority.toJson(),
      if (note != null) 'note': note,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkOrderImpl extends WorkOrder {
  _WorkOrderImpl({
    int? id,
    required int companyId,
    required int siteId,
    int? deviceId,
    int? alertId,
    required String title,
    String? description,
    required _i2.WorkOrderStatus status,
    required _i3.WorkOrderPriority priority,
    String? note,
    required String createdBy,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         companyId: companyId,
         siteId: siteId,
         deviceId: deviceId,
         alertId: alertId,
         title: title,
         description: description,
         status: status,
         priority: priority,
         note: note,
         createdBy: createdBy,
         createdAt: createdAt,
         startedAt: startedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [WorkOrder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WorkOrder copyWith({
    Object? id = _Undefined,
    int? companyId,
    int? siteId,
    Object? deviceId = _Undefined,
    Object? alertId = _Undefined,
    String? title,
    Object? description = _Undefined,
    _i2.WorkOrderStatus? status,
    _i3.WorkOrderPriority? priority,
    Object? note = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return WorkOrder(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      siteId: siteId ?? this.siteId,
      deviceId: deviceId is int? ? deviceId : this.deviceId,
      alertId: alertId is int? ? alertId : this.alertId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      note: note is String? ? note : this.note,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}
