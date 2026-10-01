import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../generated/protocol.dart';
import '../device/device_presence_service.dart';

/// 首頁 Dashboard 彙總（見 docs/product/enterprise-iot-platform-spec.md 4.1）。
class DashboardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 全公司 KPI 與各場域狀態卡片資料。
  Future<DashboardSummary> getSummary(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);

    final sites = await Site.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.createdAt,
    );
    final gatewayCount = await Gateway.db.count(
      session,
      where: (t) => t.companyId.equals(companyId),
    );
    final devices = await Device.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
    );
    var statuses = await DeviceStatus.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
    );
    statuses = await DevicePresenceService.refresh(session, devices, statuses);
    final openAlerts = await Alert.db.find(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.state.inSet({AlertState.active, AlertState.acknowledged}),
    );

    final stateByDevice = {
      for (final s in statuses) s.deviceId: s.connectionState,
    };
    var online = 0;
    var stale = 0;
    var offline = 0;
    for (final state in stateByDevice.values) {
      switch (state) {
        case DeviceConnectionState.online:
          online++;
        case DeviceConnectionState.stale:
          stale++;
        case DeviceConnectionState.offline:
          offline++;
        default:
          break;
      }
    }

    final siteSummaries = [
      for (final site in sites)
        SiteSummary(
          siteId: site.id!,
          name: site.name,
          deviceCount: devices.where((d) => d.siteId == site.id).length,
          onlineCount: devices
              .where(
                (d) =>
                    d.siteId == site.id &&
                    stateByDevice[d.id] == DeviceConnectionState.online,
              )
              .length,
          openAlertCount: openAlerts.where((a) => a.siteId == site.id).length,
        ),
    ];

    return DashboardSummary(
      siteCount: sites.length,
      gatewayCount: gatewayCount,
      deviceCount: devices.length,
      onlineCount: online,
      staleCount: stale,
      offlineCount: offline,
      openAlertCount: openAlerts.length,
      sites: siteSummaries,
    );
  }

  /// 近 8 小時 OEE（稼動率 × 性能 × 品質，資料來源 ProductionStat）。
  Future<OeeSummary> getOee(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final since = DateTime.now().toUtc().subtract(const Duration(hours: 8));

    final sites = await Site.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.createdAt,
    );
    final stats = await ProductionStat.db.find(
      session,
      where: (t) => t.companyId.equals(companyId) & (t.windowStart >= since),
    );

    (double, double, double, double) compute(Iterable<ProductionStat> rows) {
      var planned = 0.0;
      var run = 0.0;
      var ideal = 0;
      var actual = 0;
      var good = 0;
      for (final row in rows) {
        planned += row.plannedMinutes;
        run += row.runMinutes;
        ideal += row.idealCount;
        actual += row.actualCount;
        good += row.goodCount;
      }
      final availability = planned == 0 ? 0.0 : (run / planned).clamp(0.0, 1.0);
      final performance = ideal == 0 ? 0.0 : (actual / ideal).clamp(0.0, 1.0);
      final quality = actual == 0 ? 0.0 : (good / actual).clamp(0.0, 1.0);
      return (
        availability,
        performance,
        quality,
        availability * performance * quality,
      );
    }

    final (availability, performance, quality, oee) = compute(stats);
    return OeeSummary(
      availability: availability,
      performance: performance,
      quality: quality,
      oee: oee,
      sites: [
        for (final site in sites)
          () {
            final (a, p, q, o) = compute(
              stats.where((s) => s.siteId == site.id),
            );
            return OeeSiteSummary(
              siteId: site.id!,
              name: site.name,
              availability: a,
              performance: p,
              quality: q,
              oee: o,
            );
          }(),
      ],
    );
  }
}
