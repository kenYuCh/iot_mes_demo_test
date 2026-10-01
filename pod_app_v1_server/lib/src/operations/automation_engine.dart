import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../telemetry/telemetry_channels.dart';

typedef CommandPublisher =
    Future<bool> Function({
      required String serial,
      required DeviceCommand command,
    });

/// Evaluates enabled IF / ELSE IF / ELSE rules after MQTT telemetry is stored.
/// Runtime throttling is deliberately kept server-side so devices only execute
/// authenticated, validated commands and never evaluate user-authored rules.
class AutomationEngine {
  AutomationEngine(this._pod, this._publish) {
    _watchdog = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkSensorTimeouts(),
    );
  }

  final Serverpod _pod;
  final CommandPublisher _publish;
  final Map<int, _RuntimeState> _runtime = {};
  final Map<String, Timer> _offTimers = {};
  final Set<int> _evaluating = {};
  Timer? _watchdog;

  void stop() {
    _watchdog?.cancel();
    for (final timer in _offTimers.values) {
      timer.cancel();
    }
    _offTimers.clear();
  }

  Future<void> _checkSensorTimeouts() async {
    final session = await _pod.createSession(enableLogging: false);
    try {
      final rules = await AutomationRule.db.find(
        session,
        where: (t) => t.enabled.equals(true),
      );
      final now = DateTime.now().toUtc();
      for (final rule in rules) {
        final branches = rule.branches;
        if (branches == null ||
            branches.isEmpty ||
            !_evaluating.add(rule.id!)) {
          continue;
        }
        try {
          final ids = branches
              .expand((branch) => branch.conditions)
              .map((condition) => condition.deviceId)
              .toSet();
          final statuses = await DeviceStatus.db.find(
            session,
            where: (t) =>
                t.companyId.equals(rule.companyId) & t.deviceId.inSet(ids),
          );
          final latest = {
            for (final status in statuses)
              status.deviceId: status.lastUpdatedAt,
          };
          final timeout = Duration(seconds: rule.sensorTimeoutSeconds ?? 60);
          final stale = ids.any(
            (id) => latest[id] == null || now.difference(latest[id]!) > timeout,
          );
          if (stale) await _evaluateRule(session, rule, branches, now);
        } finally {
          _evaluating.remove(rule.id!);
        }
      }
    } catch (error, stackTrace) {
      session.log(
        'Automation watchdog failed: $error',
        level: LogLevel.error,
        stackTrace: stackTrace,
      );
    } finally {
      await session.close();
    }
  }

  Future<void> onTelemetry(
    Session session,
    Device source,
    Map<String, double> values,
    DateTime now,
  ) async {
    final rules = await AutomationRule.db.find(
      session,
      where: (t) =>
          t.companyId.equals(source.companyId) & t.enabled.equals(true),
    );
    for (final rule in rules) {
      final branches = rule.branches;
      if (branches == null || branches.isEmpty) continue;
      final relevant = branches
          .expand((branch) => branch.conditions)
          .any(
            (condition) =>
                condition.deviceId == source.id &&
                values.containsKey(condition.featureKey),
          );
      if (!relevant) continue;
      if (!_evaluating.add(rule.id!)) continue;
      try {
        await _evaluateRule(session, rule, branches, now);
      } catch (error, stackTrace) {
        session.log(
          'Automation rule ${rule.id} failed: $error',
          level: LogLevel.error,
          stackTrace: stackTrace,
        );
        await _recordFailure(session, rule, error.toString(), now);
      } finally {
        _evaluating.remove(rule.id!);
      }
    }
  }

  Future<void> _evaluateRule(
    Session session,
    AutomationRule rule,
    List<AutomationBranch> branches,
    DateTime now,
  ) async {
    final conditionDeviceIds = branches
        .expand((branch) => branch.conditions)
        .map((condition) => condition.deviceId)
        .toSet();
    final statuses = await DeviceStatus.db.find(
      session,
      where: (t) =>
          t.companyId.equals(rule.companyId) &
          t.deviceId.inSet(conditionDeviceIds),
    );
    final byDevice = {for (final status in statuses) status.deviceId: status};
    final timeout = Duration(seconds: rule.sensorTimeoutSeconds ?? 60);
    final stale = conditionDeviceIds.any((id) {
      final received = byDevice[id]?.lastUpdatedAt;
      return received == null || now.difference(received) > timeout;
    });

    AutomationBranch? selected;
    if (!stale) {
      for (final branch in branches.where(
        (branch) => branch.conditions.isNotEmpty,
      )) {
        final results = branch.conditions.map((condition) {
          final current =
              byDevice[condition.deviceId]?.latestValues[condition.featureKey];
          return current != null &&
              _compare(current, condition.comparison, condition.value);
        });
        final matched = branch.matchAll
            ? results.every((value) => value)
            : results.any((value) => value);
        if (matched) {
          selected = branch;
          break;
        }
      }
    }
    selected ??= branches
        .where((branch) => branch.conditions.isEmpty)
        .firstOrNull;
    if (selected == null) return;

    final state = _runtime.putIfAbsent(rule.id!, _RuntimeState.new);
    final branchChanged = state.branchLabel != selected.label;
    if (branchChanged) {
      state
        ..branchLabel = selected.label
        ..repeatCount = 0
        ..nextAllowedAt = null;
    }
    if (state.nextAllowedAt?.isAfter(now) ?? false) return;
    if (selected.conditions.isNotEmpty &&
        state.repeatCount >= rule.maxRepeats) {
      return;
    }

    final run = await AutomationRun.db.insertRow(
      session,
      AutomationRun(
        companyId: rule.companyId,
        ruleId: rule.id!,
        state: 'executing',
        triggerValue: _triggerValue(selected, byDevice),
        repeatCount: state.repeatCount + 1,
        currentStep: '${stale ? '感測逾時安全分支' : '命中'} ${selected.label}',
        startedAt: now,
      ),
    );

    var sent = 0;
    final failures = <String>[];
    for (var index = 0; index < selected.actions.length; index++) {
      final action = selected.actions[index];
      if (action.delaySeconds > 0) {
        await Future<void>.delayed(Duration(seconds: action.delaySeconds));
      }
      final result = await _sendAction(session, rule, run, action, index, now);
      if (result) {
        sent++;
        if (action.durationSeconds > 0 && action.value != 0) {
          _scheduleOff(rule, run, action, index);
        }
      } else {
        failures.add('${action.deviceId}:${action.featureKey}');
      }
    }
    state.repeatCount++;
    state.nextAllowedAt = now.add(
      Duration(seconds: (rule.cooldownSeconds ?? 10) + rule.mixingDelaySeconds),
    );
    await AutomationRun.db.updateRow(
      session,
      run.copyWith(
        state: failures.isEmpty ? 'completed' : 'failed',
        currentStep:
            '${selected.label}：已送出 $sent/${selected.actions.length} 個動作',
        message: failures.isEmpty ? null : '下發失敗：${failures.join(', ')}',
        finishedAt: DateTime.now().toUtc(),
      ),
    );
    await AuditLog.db.insertRow(
      session,
      AuditLog(
        companyId: rule.companyId,
        userIdentifier: 'automation:${rule.id}',
        source: 'rule-engine',
        action: failures.isEmpty ? 'automation.execute' : 'automation.failed',
        resourceType: 'automationRule',
        resourceId: rule.id,
        summary: '${rule.name} 命中 ${selected.label}，送出 $sent 個控制動作',
        details: {
          'branch': selected.label,
          'staleFallback': '$stale',
          'actions': '${selected.actions.length}',
        },
        success: failures.isEmpty,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<bool> _sendAction(
    Session session,
    AutomationRule rule,
    AutomationRun run,
    AutomationAction action,
    int index,
    DateTime now,
  ) async {
    final provisioned = await ProvisionedDevice.db.findFirstRow(
      session,
      where: (t) => t.linkedDeviceId.equals(action.deviceId),
    );
    final command = await DeviceCommand.db.insertRow(
      session,
      DeviceCommand(
        companyId: rule.companyId,
        deviceId: action.deviceId,
        commandType: 'setParam',
        payload: {'featureKey': action.featureKey, 'value': '${action.value}'},
        state: DeviceCommandState.created,
        idempotencyKey: 'auto-${rule.id}-${run.id}-$index',
        issuedBy: 'automation:${rule.id}',
        createdAt: now,
      ),
    );
    final published =
        provisioned != null &&
        await _publish(serial: provisioned.serial, command: command);
    final updated = await DeviceCommand.db.updateRow(
      session,
      command.copyWith(
        state: published ? DeviceCommandState.sent : DeviceCommandState.failed,
        sentAt: published ? DateTime.now().toUtc() : null,
        completedAt: published ? null : DateTime.now().toUtc(),
        errorMessage: published ? null : '設備未配對或 MQTT 未連線',
      ),
    );
    await session.messages.postMessage(
      TelemetryChannels.deviceCommands(rule.companyId, action.deviceId),
      updated,
    );
    return published;
  }

  void _scheduleOff(
    AutomationRule rule,
    AutomationRun run,
    AutomationAction action,
    int index,
  ) {
    final key = '${rule.id}:${action.deviceId}:${action.featureKey}';
    _offTimers.remove(key)?.cancel();
    _offTimers[key] = Timer(
      Duration(seconds: action.durationSeconds),
      () async {
        final session = await _pod.createSession(enableLogging: false);
        try {
          final off = AutomationAction(
            deviceId: action.deviceId,
            featureKey: action.featureKey,
            value: 0,
            durationSeconds: 0,
            delaySeconds: 0,
          );
          await _sendAction(
            session,
            rule,
            run,
            off,
            1000 + index,
            DateTime.now().toUtc(),
          );
        } finally {
          await session.close();
          _offTimers.remove(key);
        }
      },
    );
  }

  Future<void> _recordFailure(
    Session session,
    AutomationRule rule,
    String message,
    DateTime now,
  ) async {
    await AutomationRun.db.insertRow(
      session,
      AutomationRun(
        companyId: rule.companyId,
        ruleId: rule.id!,
        state: 'failed',
        triggerValue: 0,
        repeatCount: 0,
        currentStep: '規則執行錯誤',
        message: message,
        startedAt: now,
        finishedAt: now,
      ),
    );
  }

  bool _compare(double current, AlertComparison comparison, double target) =>
      switch (comparison) {
        AlertComparison.greaterThan => current > target,
        AlertComparison.greaterOrEqual => current >= target,
        AlertComparison.lessThan => current < target,
        AlertComparison.lessOrEqual => current <= target,
      };

  double _triggerValue(
    AutomationBranch branch,
    Map<int, DeviceStatus> statuses,
  ) {
    final condition = branch.conditions.firstOrNull;
    return condition == null
        ? 0
        : statuses[condition.deviceId]?.latestValues[condition.featureKey] ?? 0;
  }
}

class _RuntimeState {
  String? branchLabel;
  int repeatCount = 0;
  DateTime? nextAllowedAt;
}
