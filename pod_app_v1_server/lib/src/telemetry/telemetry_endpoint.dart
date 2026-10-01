import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../generated/protocol.dart';
import '../device/device_presence_service.dart';
import 'telemetry_channels.dart';

/// 即時狀態與歷史量測查詢。
class TelemetryEndpoint extends Endpoint {
  static const _defaultLimit = 50;
  static const _maxLimit = 300;

  @override
  bool get requireLogin => true;

  /// 取得場域內所有設備目前狀態（進入頁面時的 snapshot）。
  Future<List<DeviceStatus>> listSiteStatuses(
    Session session,
    int siteId,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    await TenantService.assertSiteAccess(session, companyId, siteId);
    final devices = await Device.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & t.siteId.equals(siteId),
    );
    final accessible = await TenantService.filterReadableDevices(
      session,
      devices,
    );
    final deviceIds = accessible.map((d) => d.id!).toSet();
    final statuses = await DeviceStatus.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
    );
    final visible = statuses
        .where((s) => deviceIds.contains(s.deviceId))
        .toList();
    return DevicePresenceService.refresh(session, accessible, visible);
  }

  /// 訂閱場域內設備狀態更新（Serverpod Streaming）。
  ///
  /// 前端應先呼叫 [listSiteStatuses] 取得 snapshot，再以本 stream 接收增量。
  Stream<DeviceStatus> watchSiteStatus(Session session, int siteId) async* {
    final companyId = await TenantService.resolveCompanyId(session);
    await TenantService.assertSiteAccess(session, companyId, siteId);
    final devices = await Device.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & t.siteId.equals(siteId),
    );
    final accessible = await TenantService.filterReadableDevices(
      session,
      devices,
    );
    final deviceIds = {for (final device in accessible) device.id};
    final stream = session.messages.createStream<DeviceStatus>(
      TelemetryChannels.siteStatus(companyId, siteId),
    );
    await for (final status in stream) {
      if (deviceIds.contains(status.deviceId)) yield status;
    }
  }

  /// 查詢設備歷史量測（cursor 分頁，新到舊）。
  /// 多通道設備以 [featureKey] 指定通道；null 表示全部通道。
  Future<MeasurementListResult> listMeasurements(
    Session session,
    int deviceId, {
    String? featureKey,
    int limit = _defaultLimit,
    int? cursorId,
    DateTime? startAt,
    DateTime? endAt,
  }) async {
    final companyId = await TenantService.resolveCompanyId(session);
    await TenantService.assertDeviceAccess(session, companyId, deviceId);

    final effectiveLimit = limit.clamp(1, _maxLimit);
    if (startAt != null || endAt != null) {
      return _listRangeMeasurements(
        session,
        companyId: companyId,
        deviceId: deviceId,
        featureKey: featureKey,
        startAt: startAt,
        endAt: endAt,
        limit: effectiveLimit,
      );
    }
    final items = await Measurement.db.find(
      session,
      where: (t) {
        var expr = t.companyId.equals(companyId) & t.deviceId.equals(deviceId);
        if (featureKey != null) {
          expr = expr & t.featureKey.equals(featureKey);
        }
        if (cursorId != null) {
          expr = expr & (t.id < cursorId);
        }
        if (startAt != null) {
          expr = expr & (t.measuredAt >= startAt);
        }
        if (endAt != null) {
          expr = expr & (t.measuredAt <= endAt);
        }
        return expr;
      },
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: effectiveLimit,
    );
    return MeasurementListResult(
      items: items,
      nextCursorId: items.length == effectiveLimit ? items.last.id : null,
    );
  }

  /// 將長時間區間平均分成至多 [limit] 個桶，每桶保留最新一筆。
  /// 這可讓 4 週圖表涵蓋整段時間，而不是只取區間尾端的 300 筆。
  Future<MeasurementListResult> _listRangeMeasurements(
    Session session, {
    required int companyId,
    required int deviceId,
    required String? featureKey,
    required DateTime? startAt,
    required DateTime? endAt,
    required int limit,
  }) async {
    final featureClause = featureKey == null
        ? ''
        : 'AND "featureKey" = @featureKey';
    final startClause = startAt == null ? '' : 'AND "measuredAt" >= @startAt';
    final endClause = endAt == null ? '' : 'AND "measuredAt" <= @endAt';
    final rows = await session.db.unsafeQuery(
      '''
WITH ranked AS (
  SELECT id, "companyId", "deviceId", "featureKey", value,
         "measuredAt", "receivedAt",
         row_number() OVER (ORDER BY "measuredAt") AS rn,
         count(*) OVER () AS total
  FROM measurement
  WHERE "companyId" = @companyId AND "deviceId" = @deviceId
    $featureClause $startClause $endClause
), bucketed AS (
  SELECT *, floor((rn - 1) * @sampleLimit / greatest(total, 1)) AS bucket
  FROM ranked
), chosen AS (
  SELECT DISTINCT ON (bucket)
         id, "companyId", "deviceId", "featureKey", value,
         "measuredAt", "receivedAt", bucket
  FROM bucketed
  ORDER BY bucket, "measuredAt" DESC
)
SELECT id, "companyId", "deviceId", "featureKey", value,
       "measuredAt", "receivedAt"
FROM chosen
ORDER BY "measuredAt" DESC
''',
      parameters: QueryParameters.named({
        'companyId': companyId,
        'deviceId': deviceId,
        'featureKey': featureKey,
        'startAt': startAt,
        'endAt': endAt,
        'sampleLimit': limit,
      }),
    );
    return MeasurementListResult(
      items: [
        for (final row in rows)
          Measurement(
            id: row[0] as int,
            companyId: row[1] as int,
            deviceId: row[2] as int,
            featureKey: row[3] as String,
            value: (row[4] as num).toDouble(),
            measuredAt: row[5] as DateTime,
            receivedAt: row[6] as DateTime,
          ),
      ],
      nextCursorId: null,
    );
  }
}
