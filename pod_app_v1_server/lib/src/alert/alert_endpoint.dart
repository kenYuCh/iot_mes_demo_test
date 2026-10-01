import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../generated/protocol.dart';
import '../telemetry/telemetry_channels.dart';

/// 告警規則管理與告警事件查詢。
///
/// 規則評估在資料 ingestion 路徑執行（開發環境為 TelemetrySimulator）：
/// 超出閾值產生 active 告警，恢復正常自動 resolved。
class AlertEndpoint extends Endpoint {
  static const _defaultLimit = 50;
  static const _maxLimit = 100;

  @override
  bool get requireLogin => true;

  // ---- 規則管理 ----

  /// 列出公司所有告警規則。
  Future<List<AlertRule>> listRules(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    return AlertRule.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.id,
      orderDescending: true,
    );
  }

  /// 建立告警規則。
  Future<AlertRule> createRule(
    Session session,
    int deviceId,
    String featureKey,
    AlertComparison comparison,
    double threshold,
    String name,
    AlertSeverity severity,
    bool mobileNotificationEnabled,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final device = await TenantService.assertDeviceAccess(
      session,
      companyId,
      deviceId,
    );
    return AlertRule.db.insertRow(
      session,
      AlertRule(
        companyId: companyId,
        deviceId: device.id!,
        featureKey: featureKey,
        name: name,
        comparison: comparison,
        threshold: threshold,
        severity: severity,
        mobileNotificationEnabled: mobileNotificationEnabled,
        enabled: true,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// 啟用／停用規則。
  Future<AlertRule> setRuleEnabled(
    Session session,
    int ruleId,
    bool enabled,
  ) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final rule = await _findRule(session, companyId, ruleId);
    return AlertRule.db.updateRow(session, rule.copyWith(enabled: enabled));
  }

  /// 刪除規則，並自動 resolve 其未結束的告警。
  Future<void> deleteRule(Session session, int ruleId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final rule = await _findRule(session, companyId, ruleId);

    final openAlerts = await Alert.db.find(
      session,
      where: (t) =>
          t.ruleId.equals(rule.id!) &
          t.state.inSet({AlertState.active, AlertState.acknowledged}),
    );
    final now = DateTime.now().toUtc();
    for (final alert in openAlerts) {
      final resolved = await Alert.db.updateRow(
        session,
        alert.copyWith(state: AlertState.resolved, resolvedAt: now),
      );
      await session.messages.postMessage(
        TelemetryChannels.companyAlerts(companyId),
        resolved,
      );
    }
    await AlertRule.db.deleteRow(session, rule);
  }

  // ---- 告警事件 ----

  /// 查詢告警（cursor 分頁，新到舊）。[openOnly] 為 true 時僅回傳未 resolved。
  Future<AlertListResult> listAlerts(
    Session session, {
    bool openOnly = false,
    int limit = _defaultLimit,
    int? cursorId,
  }) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final effectiveLimit = limit.clamp(1, _maxLimit);
    final items = await Alert.db.find(
      session,
      where: (t) {
        var expr = t.companyId.equals(companyId);
        if (openOnly) {
          expr =
              expr &
              t.state.inSet({AlertState.active, AlertState.acknowledged});
        }
        if (cursorId != null) {
          expr = expr & (t.id < cursorId);
        }
        return expr;
      },
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: effectiveLimit,
    );
    return AlertListResult(
      items: items,
      nextCursorId: items.length == effectiveLimit ? items.last.id : null,
    );
  }

  /// 確認告警（active → acknowledged）。
  Future<Alert> acknowledgeAlert(Session session, int alertId) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final alert = await Alert.db.findFirstRow(
      session,
      where: (t) => t.id.equals(alertId) & t.companyId.equals(companyId),
    );
    if (alert == null) {
      throw NotFoundException(message: '告警不存在');
    }
    if (alert.state != AlertState.active) return alert;

    final acknowledged = await Alert.db.updateRow(
      session,
      alert.copyWith(
        state: AlertState.acknowledged,
        acknowledgedAt: DateTime.now().toUtc(),
      ),
    );
    await session.messages.postMessage(
      TelemetryChannels.companyAlerts(companyId),
      acknowledged,
    );
    return acknowledged;
  }

  /// 訂閱公司告警事件（觸發、確認、恢復；Serverpod Streaming）。
  Stream<Alert> watchAlerts(Session session) async* {
    final companyId = await TenantService.resolveCompanyId(session);
    yield* session.messages.createStream<Alert>(
      TelemetryChannels.companyAlerts(companyId),
    );
  }

  Future<AlertRule> _findRule(
    Session session,
    int companyId,
    int ruleId,
  ) async {
    final rule = await AlertRule.db.findFirstRow(
      session,
      where: (t) => t.id.equals(ruleId) & t.companyId.equals(companyId),
    );
    if (rule == null) {
      throw NotFoundException(message: '告警規則不存在');
    }
    return rule;
  }
}
