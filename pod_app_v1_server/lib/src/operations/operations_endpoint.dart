import 'package:serverpod/serverpod.dart';

import '../company/tenant_service.dart';
import '../device/device_profiles.dart';
import '../generated/protocol.dart';

class OperationsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<AutomationRule>> listAutomationRules(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    return AutomationRule.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
    );
  }

  /// 回傳目前公司可用於自動化觸發與控制的設備。
  Future<List<Device>> listAutomationDevices(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    final devices = await Device.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.name,
    );
    return [
      for (final device in devices)
        device.copyWith(features: DeviceProfiles.featuresFor(device)),
    ];
  }

  Future<AutomationRule> createAutomationRule(
    Session session,
    String name,
    int triggerDeviceId,
    String triggerFeatureKey,
    AlertComparison comparison,
    double threshold,
    double recoveryThreshold,
    int actionDeviceId,
    String actionFeatureKey,
    double actionValue,
    int pulseOnSeconds,
    int intervalSeconds,
    int maxRepeats,
    int mixingDelaySeconds,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final trigger = await TenantService.assertDeviceAccess(
      session,
      companyId,
      triggerDeviceId,
    );
    final action = await TenantService.assertDeviceAccess(
      session,
      companyId,
      actionDeviceId,
    );
    if (!DeviceProfiles.featuresFor(
      trigger,
    ).any((f) => f.key == triggerFeatureKey)) {
      throw ValidationException(message: '觸發特徵不存在');
    }
    final control = DeviceProfiles.controlsOf(
      action,
    ).where((feature) => feature.key == actionFeatureKey).firstOrNull;
    if (control == null ||
        actionValue < control.minValue ||
        actionValue > control.maxValue) {
      throw ValidationException(message: '目標控制參數或設定值無效');
    }
    if (name.trim().isEmpty ||
        pulseOnSeconds < 1 ||
        intervalSeconds < pulseOnSeconds ||
        maxRepeats < 1 ||
        maxRepeats > 20 ||
        mixingDelaySeconds < 0) {
      throw ValidationException(message: '請確認名稱、間隔、運行時間與最大次數');
    }
    final now = DateTime.now().toUtc();
    final row = await AutomationRule.db.insertRow(
      session,
      AutomationRule(
        companyId: companyId,
        name: name.trim(),
        triggerDeviceId: triggerDeviceId,
        triggerFeatureKey: triggerFeatureKey,
        comparison: comparison,
        threshold: threshold,
        recoveryThreshold: recoveryThreshold,
        actionDeviceId: actionDeviceId,
        actionFeatureKey: actionFeatureKey,
        actionValue: actionValue,
        pulseOnSeconds: pulseOnSeconds,
        intervalSeconds: intervalSeconds,
        maxRepeats: maxRepeats,
        mixingDelaySeconds: mixingDelaySeconds,
        enabled: false,
        createdBy: session.authenticated!.userIdentifier,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await _audit(
      session,
      companyId,
      'automation.create',
      'automationRule',
      row.id,
      actionDeviceId,
      '建立自動化規則「${row.name}」',
    );
    return row;
  }

  /// 建立或更新視覺化 IF / ELSE IF / ELSE 多分支規則。
  ///
  /// 編輯後一律停用，避免尚未人工覆核的新動作立即控制實體設備。
  Future<AutomationRule> saveAdvancedAutomationRule(
    Session session,
    int? ruleId,
    String name,
    List<AutomationBranch> branches,
    int sensorTimeoutSeconds,
    int cooldownSeconds,
    int maxRepeats,
    int mixingDelaySeconds,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    await _validateAdvancedRule(
      session,
      companyId,
      name,
      branches,
      sensorTimeoutSeconds,
      cooldownSeconds,
      maxRepeats,
      mixingDelaySeconds,
    );
    final firstCondition = branches.first.conditions.first;
    final firstAction = branches.first.actions.first;
    final now = DateTime.now().toUtc();
    AutomationRule? current;
    if (ruleId != null) {
      current = await AutomationRule.db.findFirstRow(
        session,
        where: (t) => t.id.equals(ruleId) & t.companyId.equals(companyId),
      );
      if (current == null) {
        throw NotFoundException(message: '自動化規則不存在');
      }
    }
    final next = AutomationRule(
      id: current?.id,
      companyId: companyId,
      name: name.trim(),
      triggerDeviceId: firstCondition.deviceId,
      triggerFeatureKey: firstCondition.featureKey,
      comparison: firstCondition.comparison,
      threshold: firstCondition.value,
      recoveryThreshold: firstCondition.value,
      actionDeviceId: firstAction.deviceId,
      actionFeatureKey: firstAction.featureKey,
      actionValue: firstAction.value,
      pulseOnSeconds: firstAction.durationSeconds.clamp(1, 3600),
      intervalSeconds: (firstAction.durationSeconds + firstAction.delaySeconds)
          .clamp(firstAction.durationSeconds.clamp(1, 3600), 7200),
      maxRepeats: maxRepeats,
      mixingDelaySeconds: mixingDelaySeconds,
      branches: branches,
      sensorTimeoutSeconds: sensorTimeoutSeconds,
      cooldownSeconds: cooldownSeconds,
      enabled: false,
      createdBy: current?.createdBy ?? session.authenticated!.userIdentifier,
      createdAt: current?.createdAt ?? now,
      updatedAt: now,
    );
    final saved = current == null
        ? await AutomationRule.db.insertRow(session, next)
        : await AutomationRule.db.updateRow(session, next);
    await _audit(
      session,
      companyId,
      current == null ? 'automation.create' : 'automation.update',
      'automationRule',
      saved.id,
      firstAction.deviceId,
      '${current == null ? '建立' : '編輯'}多分支自動化規則「${saved.name}」（${branches.length} 個分支）',
    );
    return saved;
  }

  Future<void> _validateAdvancedRule(
    Session session,
    int companyId,
    String name,
    List<AutomationBranch> branches,
    int sensorTimeoutSeconds,
    int cooldownSeconds,
    int maxRepeats,
    int mixingDelaySeconds,
  ) async {
    if (name.trim().isEmpty || branches.isEmpty || branches.length > 10) {
      throw ValidationException(message: '規則名稱與分支數量無效');
    }
    if (sensorTimeoutSeconds < 5 ||
        sensorTimeoutSeconds > 86400 ||
        cooldownSeconds < 0 ||
        cooldownSeconds > 86400 ||
        maxRepeats < 1 ||
        maxRepeats > 20 ||
        mixingDelaySeconds < 0 ||
        mixingDelaySeconds > 86400) {
      throw ValidationException(message: '安全逾時、冷卻或執行次數設定無效');
    }
    for (var index = 0; index < branches.length; index++) {
      final branch = branches[index];
      final isElse = branch.conditions.isEmpty;
      if (isElse && index != branches.length - 1) {
        throw ValidationException(message: 'ELSE 必須是最後一個分支');
      }
      if (!isElse && branch.conditions.length > 8) {
        throw ValidationException(message: '每個分支最多 8 個條件');
      }
      if (branch.actions.isEmpty || branch.actions.length > 16) {
        throw ValidationException(message: '每個分支需有 1～16 個控制動作');
      }
      for (final condition in branch.conditions) {
        final device = await TenantService.assertDeviceAccess(
          session,
          companyId,
          condition.deviceId,
        );
        final feature = DeviceProfiles.featuresFor(
          device,
        ).where((item) => item.key == condition.featureKey).firstOrNull;
        if (feature == null ||
            feature.kind == FeatureKind.control ||
            condition.value < feature.minValue ||
            condition.value > feature.maxValue) {
          throw ValidationException(message: '分支 ${index + 1} 的感測條件無效');
        }
      }
      final targets = <String>{};
      for (final action in branch.actions) {
        final device = await TenantService.assertDeviceAccess(
          session,
          companyId,
          action.deviceId,
        );
        final feature = DeviceProfiles.controlsOf(
          device,
        ).where((item) => item.key == action.featureKey).firstOrNull;
        if (feature == null ||
            action.value < feature.minValue ||
            action.value > feature.maxValue ||
            action.durationSeconds < 0 ||
            action.durationSeconds > 3600 ||
            action.delaySeconds < 0 ||
            action.delaySeconds > 3600) {
          throw ValidationException(message: '分支 ${index + 1} 的控制動作無效');
        }
        if (!targets.add('${action.deviceId}:${action.featureKey}')) {
          throw ValidationException(message: '同一分支不可重複控制相同參數');
        }
      }
    }
  }

  Future<AutomationRule> setAutomationEnabled(
    Session session,
    int ruleId,
    bool enabled,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final row = await AutomationRule.db.findFirstRow(
      session,
      where: (t) => t.id.equals(ruleId) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '自動化規則不存在');
    final updated = await AutomationRule.db.updateRow(
      session,
      row.copyWith(enabled: enabled, updatedAt: DateTime.now().toUtc()),
    );
    await _audit(
      session,
      companyId,
      enabled ? 'automation.enable' : 'automation.disable',
      'automationRule',
      ruleId,
      row.actionDeviceId,
      '${enabled ? '啟用' : '停用'}自動化規則「${row.name}」',
    );
    return updated;
  }

  Future<AutomationRule> updateAutomationRule(
    Session session,
    int ruleId,
    String name,
    int triggerDeviceId,
    String triggerFeatureKey,
    AlertComparison comparison,
    double threshold,
    double recoveryThreshold,
    int actionDeviceId,
    String actionFeatureKey,
    double actionValue,
    int pulseOnSeconds,
    int intervalSeconds,
    int maxRepeats,
    int mixingDelaySeconds,
  ) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final current = await AutomationRule.db.findFirstRow(
      session,
      where: (t) => t.id.equals(ruleId) & t.companyId.equals(companyId),
    );
    if (current == null) throw NotFoundException(message: '自動化規則不存在');
    await _validateRule(
      session,
      companyId,
      name,
      triggerDeviceId,
      triggerFeatureKey,
      actionDeviceId,
      actionFeatureKey,
      actionValue,
      pulseOnSeconds,
      intervalSeconds,
      maxRepeats,
      mixingDelaySeconds,
    );
    final updated = await AutomationRule.db.updateRow(
      session,
      current.copyWith(
        name: name.trim(),
        triggerDeviceId: triggerDeviceId,
        triggerFeatureKey: triggerFeatureKey,
        comparison: comparison,
        threshold: threshold,
        recoveryThreshold: recoveryThreshold,
        actionDeviceId: actionDeviceId,
        actionFeatureKey: actionFeatureKey,
        actionValue: actionValue,
        pulseOnSeconds: pulseOnSeconds,
        intervalSeconds: intervalSeconds,
        maxRepeats: maxRepeats,
        mixingDelaySeconds: mixingDelaySeconds,
        enabled: false,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
    await _audit(
      session,
      companyId,
      'automation.update',
      'automationRule',
      ruleId,
      actionDeviceId,
      '編輯自動化規則「${updated.name}」（已自動停用待確認）',
    );
    return updated;
  }

  Future<void> deleteAutomationRule(Session session, int ruleId) async {
    final companyId = await TenantService.assertFirmwareAdmin(session);
    final row = await AutomationRule.db.findFirstRow(
      session,
      where: (t) => t.id.equals(ruleId) & t.companyId.equals(companyId),
    );
    if (row == null) throw NotFoundException(message: '自動化規則不存在');
    if (row.enabled) throw ValidationException(message: '請先停用規則再刪除');
    final running = await AutomationRun.db.findFirstRow(
      session,
      where: (t) => t.ruleId.equals(ruleId) & t.finishedAt.equals(null),
    );
    if (running != null) throw ValidationException(message: '規則仍在執行，無法刪除');
    await AutomationRule.db.deleteRow(session, row);
    await _audit(
      session,
      companyId,
      'automation.delete',
      'automationRule',
      ruleId,
      row.actionDeviceId,
      '刪除自動化規則「${row.name}」',
    );
  }

  Future<void> _validateRule(
    Session session,
    int companyId,
    String name,
    int triggerDeviceId,
    String triggerFeatureKey,
    int actionDeviceId,
    String actionFeatureKey,
    double actionValue,
    int pulseOnSeconds,
    int intervalSeconds,
    int maxRepeats,
    int mixingDelaySeconds,
  ) async {
    final trigger = await TenantService.assertDeviceAccess(
      session,
      companyId,
      triggerDeviceId,
    );
    final action = await TenantService.assertDeviceAccess(
      session,
      companyId,
      actionDeviceId,
    );
    if (!DeviceProfiles.featuresFor(
      trigger,
    ).any((f) => f.key == triggerFeatureKey)) {
      throw ValidationException(message: '觸發特徵不存在');
    }
    final control = DeviceProfiles.controlsOf(
      action,
    ).where((feature) => feature.key == actionFeatureKey).firstOrNull;
    if (control == null ||
        actionValue < control.minValue ||
        actionValue > control.maxValue) {
      throw ValidationException(message: '目標控制參數或設定值無效');
    }
    if (name.trim().isEmpty ||
        pulseOnSeconds < 1 ||
        intervalSeconds < pulseOnSeconds ||
        maxRepeats < 1 ||
        maxRepeats > 20 ||
        mixingDelaySeconds < 0) {
      throw ValidationException(message: '請確認名稱、間隔、運行時間與最大次數');
    }
  }

  Future<List<AutomationRun>> listAutomationRuns(Session session) async {
    final companyId = await TenantService.resolveCompanyId(session);
    return AutomationRun.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.startedAt,
      orderDescending: true,
      limit: 100,
    );
  }

  Future<List<AuditLog>> listAuditLogs(
    Session session, {
    int limit = 100,
  }) async {
    final companyId = await TenantService.resolveCompanyId(session);
    return AuditLog.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit.clamp(1, 200),
    );
  }

  Future<void> _audit(
    Session session,
    int companyId,
    String action,
    String resourceType,
    int? resourceId,
    int? deviceId,
    String summary,
  ) async {
    await AuditLog.db.insertRow(
      session,
      AuditLog(
        companyId: companyId,
        userIdentifier: session.authenticated!.userIdentifier,
        source: 'app',
        action: action,
        resourceType: resourceType,
        resourceId: resourceId,
        deviceId: deviceId,
        summary: summary,
        success: true,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }
}
