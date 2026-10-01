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
import 'dart:async' as _i2;
import 'package:pod_app_v1_client/src/protocol/alert/alert_rule.dart' as _i3;
import 'package:pod_app_v1_client/src/protocol/alert/alert_comparison.dart'
    as _i4;
import 'package:pod_app_v1_client/src/protocol/alert/alert_severity.dart'
    as _i5;
import 'package:pod_app_v1_client/src/protocol/alert/alert_list_result.dart'
    as _i6;
import 'package:pod_app_v1_client/src/protocol/alert/alert.dart' as _i7;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i8;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i9;
import 'package:pod_app_v1_client/src/protocol/command/device_command.dart'
    as _i10;
import 'package:pod_app_v1_client/src/protocol/command/device_command_list_result.dart'
    as _i11;
import 'package:pod_app_v1_client/src/protocol/company/member_access_summary.dart'
    as _i12;
import 'package:pod_app_v1_client/src/protocol/company/company_role.dart'
    as _i13;
import 'package:pod_app_v1_client/src/protocol/company/platform_permission.dart'
    as _i14;
import 'package:pod_app_v1_client/src/protocol/dashboard/dashboard_summary.dart'
    as _i15;
import 'package:pod_app_v1_client/src/protocol/oee/oee_summary.dart' as _i16;
import 'package:pod_app_v1_client/src/protocol/device/device_profile.dart'
    as _i17;
import 'package:pod_app_v1_client/src/protocol/device/feature_catalog_item.dart'
    as _i18;
import 'package:pod_app_v1_client/src/protocol/device/device_feature.dart'
    as _i19;
import 'package:pod_app_v1_client/src/protocol/device/device.dart' as _i20;
import 'package:pod_app_v1_client/src/protocol/gateway/gateway.dart' as _i21;
import 'package:pod_app_v1_client/src/protocol/greetings/greeting.dart' as _i22;
import 'package:pod_app_v1_client/src/protocol/operations/automation_rule.dart'
    as _i23;
import 'package:pod_app_v1_client/src/protocol/operations/automation_branch.dart'
    as _i24;
import 'package:pod_app_v1_client/src/protocol/operations/automation_run.dart'
    as _i25;
import 'package:pod_app_v1_client/src/protocol/operations/audit_log.dart'
    as _i26;
import 'package:pod_app_v1_client/src/protocol/ota/firmware_package.dart'
    as _i27;
import 'package:pod_app_v1_client/src/protocol/ota/firmware_release_detail.dart'
    as _i28;
import 'dart:typed_data' as _i29;
import 'package:pod_app_v1_client/src/protocol/ota/ota_campaign.dart' as _i30;
import 'package:pod_app_v1_client/src/protocol/ota/ota_target.dart' as _i31;
import 'package:pod_app_v1_client/src/protocol/ota/ota_campaign_detail.dart'
    as _i32;
import 'package:pod_app_v1_client/src/protocol/ota/ota_strategy.dart' as _i33;
import 'package:pod_app_v1_client/src/protocol/ota/ota_job_state.dart' as _i34;
import 'package:pod_app_v1_client/src/protocol/production/production_summary.dart'
    as _i35;
import 'package:pod_app_v1_client/src/protocol/production/material_item.dart'
    as _i36;
import 'package:pod_app_v1_client/src/protocol/production/material_type.dart'
    as _i37;
import 'package:pod_app_v1_client/src/protocol/production/material_lot.dart'
    as _i38;
import 'package:pod_app_v1_client/src/protocol/production/product_definition.dart'
    as _i39;
import 'package:pod_app_v1_client/src/protocol/production/bom_item.dart'
    as _i40;
import 'package:pod_app_v1_client/src/protocol/production/process_route.dart'
    as _i41;
import 'package:pod_app_v1_client/src/protocol/production/production_line.dart'
    as _i42;
import 'package:pod_app_v1_client/src/protocol/production/workstation.dart'
    as _i43;
import 'package:pod_app_v1_client/src/protocol/production/workstation_assignment_detail.dart'
    as _i44;
import 'package:pod_app_v1_client/src/protocol/production/workstation_assignment.dart'
    as _i45;
import 'package:pod_app_v1_client/src/protocol/production/line_transfer.dart'
    as _i46;
import 'package:pod_app_v1_client/src/protocol/production/process_node.dart'
    as _i47;
import 'package:pod_app_v1_client/src/protocol/production/production_order.dart'
    as _i48;
import 'package:pod_app_v1_client/src/protocol/production/production_order_status.dart'
    as _i49;
import 'package:pod_app_v1_client/src/protocol/production/product_unit.dart'
    as _i50;
import 'package:pod_app_v1_client/src/protocol/production/process_event.dart'
    as _i51;
import 'package:pod_app_v1_client/src/protocol/production/process_event_type.dart'
    as _i52;
import 'package:pod_app_v1_client/src/protocol/production/process_result.dart'
    as _i53;
import 'package:pod_app_v1_client/src/protocol/production/product_trace.dart'
    as _i54;
import 'package:pod_app_v1_client/src/protocol/provisioning/provisioned_device.dart'
    as _i55;
import 'package:pod_app_v1_client/src/protocol/provisioning/claim_session_result.dart'
    as _i56;
import 'package:pod_app_v1_client/src/protocol/provisioning/certificate_issue_result.dart'
    as _i57;
import 'package:pod_app_v1_client/src/protocol/provisioning/device_certificate.dart'
    as _i58;
import 'package:pod_app_v1_client/src/protocol/site/site.dart' as _i59;
import 'package:pod_app_v1_client/src/protocol/device/device_status.dart'
    as _i60;
import 'package:pod_app_v1_client/src/protocol/telemetry/measurement_list_result.dart'
    as _i61;
import 'package:pod_app_v1_client/src/protocol/workorder/work_order.dart'
    as _i62;
import 'package:pod_app_v1_client/src/protocol/workorder/work_order_priority.dart'
    as _i63;
import 'package:pod_app_v1_client/src/protocol/workorder/work_order_list_result.dart'
    as _i64;
import 'package:pod_app_v1_client/src/protocol/workorder/work_order_status.dart'
    as _i65;
import 'protocol.dart' as _i66;

/// 告警規則管理與告警事件查詢。
///
/// 規則評估在資料 ingestion 路徑執行（開發環境為 TelemetrySimulator）：
/// 超出閾值產生 active 告警，恢復正常自動 resolved。
/// {@category Endpoint}
class EndpointAlert extends _i1.EndpointRef {
  EndpointAlert(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'alert';

  /// 列出公司所有告警規則。
  _i2.Future<List<_i3.AlertRule>> listRules() =>
      caller.callServerEndpoint<List<_i3.AlertRule>>(
        'alert',
        'listRules',
        {},
      );

  /// 建立告警規則。
  _i2.Future<_i3.AlertRule> createRule(
    int deviceId,
    String featureKey,
    _i4.AlertComparison comparison,
    double threshold,
    String name,
    _i5.AlertSeverity severity,
    bool mobileNotificationEnabled,
  ) => caller.callServerEndpoint<_i3.AlertRule>(
    'alert',
    'createRule',
    {
      'deviceId': deviceId,
      'featureKey': featureKey,
      'comparison': comparison,
      'threshold': threshold,
      'name': name,
      'severity': severity,
      'mobileNotificationEnabled': mobileNotificationEnabled,
    },
  );

  /// 啟用／停用規則。
  _i2.Future<_i3.AlertRule> setRuleEnabled(
    int ruleId,
    bool enabled,
  ) => caller.callServerEndpoint<_i3.AlertRule>(
    'alert',
    'setRuleEnabled',
    {
      'ruleId': ruleId,
      'enabled': enabled,
    },
  );

  /// 刪除規則，並自動 resolve 其未結束的告警。
  _i2.Future<void> deleteRule(int ruleId) => caller.callServerEndpoint<void>(
    'alert',
    'deleteRule',
    {'ruleId': ruleId},
  );

  /// 查詢告警（cursor 分頁，新到舊）。[openOnly] 為 true 時僅回傳未 resolved。
  _i2.Future<_i6.AlertListResult> listAlerts({
    required bool openOnly,
    required int limit,
    int? cursorId,
  }) => caller.callServerEndpoint<_i6.AlertListResult>(
    'alert',
    'listAlerts',
    {
      'openOnly': openOnly,
      'limit': limit,
      'cursorId': cursorId,
    },
  );

  /// 確認告警（active → acknowledged）。
  _i2.Future<_i7.Alert> acknowledgeAlert(int alertId) =>
      caller.callServerEndpoint<_i7.Alert>(
        'alert',
        'acknowledgeAlert',
        {'alertId': alertId},
      );

  /// 訂閱公司告警事件（觸發、確認、恢復；Serverpod Streaming）。
  _i2.Stream<_i7.Alert> watchAlerts() =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i7.Alert>, _i7.Alert>(
        'alert',
        'watchAlerts',
        {},
        {},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i8.EndpointEmailIdpBase {
  EndpointEmailIdp(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<_i9.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i9.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i2.Future<_i1.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i2.Future<String> verifyRegistrationCode({
    required _i1.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i2.Future<_i9.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i9.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i2.Future<_i1.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i2.Future<String> verifyPasswordResetCode({
    required _i1.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i2.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i9.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i2.Future<_i9.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i9.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// 控制命令下發與查詢。
///
/// 命令生命週期（docs/backend/api-rules.md）：
/// CREATED → SENT → ACKNOWLEDGED → COMPLETED / FAILED / TIMED_OUT / CANCELLED。
/// 開發環境由 TelemetrySimulator 模擬裝置端推進狀態。
/// {@category Endpoint}
class EndpointCommand extends _i1.EndpointRef {
  EndpointCommand(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'command';

  /// 下發控制命令。冪等：同一 [idempotencyKey] 重複呼叫回傳既有命令。
  _i2.Future<_i10.DeviceCommand> sendCommand(
    int deviceId,
    String commandType,
    Map<String, String> payload,
    String idempotencyKey,
  ) => caller.callServerEndpoint<_i10.DeviceCommand>(
    'command',
    'sendCommand',
    {
      'deviceId': deviceId,
      'commandType': commandType,
      'payload': payload,
      'idempotencyKey': idempotencyKey,
    },
  );

  /// 取消尚未送達的命令（created/sent）。已進入其他狀態則回傳現況。
  _i2.Future<_i10.DeviceCommand> cancelCommand(int commandId) =>
      caller.callServerEndpoint<_i10.DeviceCommand>(
        'command',
        'cancelCommand',
        {'commandId': commandId},
      );

  /// 查詢裝置命令歷史（cursor 分頁，新到舊）。
  _i2.Future<_i11.DeviceCommandListResult> listCommands(
    int deviceId, {
    required int limit,
    int? cursorId,
  }) => caller.callServerEndpoint<_i11.DeviceCommandListResult>(
    'command',
    'listCommands',
    {
      'deviceId': deviceId,
      'limit': limit,
      'cursorId': cursorId,
    },
  );

  /// 訂閱裝置命令狀態更新（Serverpod Streaming）。
  _i2.Stream<_i10.DeviceCommand> watchDeviceCommands(int deviceId) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i10.DeviceCommand>,
        _i10.DeviceCommand
      >(
        'command',
        'watchDeviceCommands',
        {'deviceId': deviceId},
        {},
      );
}

/// 公司成員、模組權限與逐設備分享管理。
/// {@category Endpoint}
class EndpointAccess extends _i1.EndpointRef {
  EndpointAccess(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'access';

  _i2.Future<_i12.MemberAccessSummary> getMyAccess() =>
      caller.callServerEndpoint<_i12.MemberAccessSummary>(
        'access',
        'getMyAccess',
        {},
      );

  _i2.Future<List<_i12.MemberAccessSummary>> listMembers() =>
      caller.callServerEndpoint<List<_i12.MemberAccessSummary>>(
        'access',
        'listMembers',
        {},
      );

  _i2.Future<_i12.MemberAccessSummary> addMember(
    String email,
    String? displayName,
    _i13.CompanyRole role,
    List<_i14.PlatformPermission> permissions,
  ) => caller.callServerEndpoint<_i12.MemberAccessSummary>(
    'access',
    'addMember',
    {
      'email': email,
      'displayName': displayName,
      'role': role,
      'permissions': permissions,
    },
  );

  _i2.Future<_i12.MemberAccessSummary> updateMember(
    int membershipId,
    _i13.CompanyRole role,
    List<_i14.PlatformPermission> permissions,
    bool isActive,
  ) => caller.callServerEndpoint<_i12.MemberAccessSummary>(
    'access',
    'updateMember',
    {
      'membershipId': membershipId,
      'role': role,
      'permissions': permissions,
      'isActive': isActive,
    },
  );

  _i2.Future<void> setDeviceShare(
    int deviceId,
    int membershipId,
    bool canRead,
    bool canWrite,
  ) => caller.callServerEndpoint<void>(
    'access',
    'setDeviceShare',
    {
      'deviceId': deviceId,
      'membershipId': membershipId,
      'canRead': canRead,
      'canWrite': canWrite,
    },
  );
}

/// 首頁 Dashboard 彙總（見 docs/product/enterprise-iot-platform-spec.md 4.1）。
/// {@category Endpoint}
class EndpointDashboard extends _i1.EndpointRef {
  EndpointDashboard(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  /// 全公司 KPI 與各場域狀態卡片資料。
  _i2.Future<_i15.DashboardSummary> getSummary() =>
      caller.callServerEndpoint<_i15.DashboardSummary>(
        'dashboard',
        'getSummary',
        {},
      );

  /// 近 8 小時 OEE（稼動率 × 性能 × 品質，資料來源 ProductionStat）。
  _i2.Future<_i16.OeeSummary> getOee() =>
      caller.callServerEndpoint<_i16.OeeSummary>(
        'dashboard',
        'getOee',
        {},
      );
}

/// 設備查詢與管理。
/// {@category Endpoint}
class EndpointDevice extends _i1.EndpointRef {
  EndpointDevice(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'device';

  /// 可選用的設備型別檔（量測通道＋控制參數組合）。
  _i2.Future<List<_i17.DeviceProfile>> listProfiles() =>
      caller.callServerEndpoint<List<_i17.DeviceProfile>>(
        'device',
        'listProfiles',
        {},
      );

  /// 公司可重用特徵目錄；同 key 的公司定義會覆蓋系統建議範本。
  _i2.Future<List<_i18.FeatureCatalogItem>> listFeatureCatalog() =>
      caller.callServerEndpoint<List<_i18.FeatureCatalogItem>>(
        'device',
        'listFeatureCatalog',
        {},
      );

  _i2.Future<_i18.FeatureCatalogItem> createFeatureDefinition(
    _i19.DeviceFeature feature,
  ) => caller.callServerEndpoint<_i18.FeatureCatalogItem>(
    'device',
    'createFeatureDefinition',
    {'feature': feature},
  );

  _i2.Future<_i18.FeatureCatalogItem> updateFeatureDefinition(
    int definitionId,
    _i19.DeviceFeature feature,
  ) => caller.callServerEndpoint<_i18.FeatureCatalogItem>(
    'device',
    'updateFeatureDefinition',
    {
      'definitionId': definitionId,
      'feature': feature,
    },
  );

  _i2.Future<void> deleteFeatureDefinition(
    int definitionId,
    String email,
    String password,
  ) => caller.callServerEndpoint<void>(
    'device',
    'deleteFeatureDefinition',
    {
      'definitionId': definitionId,
      'email': email,
      'password': password,
    },
  );

  /// 建立公司級設備型別檔。僅管理者可異動。
  _i2.Future<_i17.DeviceProfile> createProfile(
    String profileKey,
    String name,
    String description,
    String mcuFamily,
    List<_i19.DeviceFeature> features,
  ) => caller.callServerEndpoint<_i17.DeviceProfile>(
    'device',
    'createProfile',
    {
      'profileKey': profileKey,
      'name': name,
      'description': description,
      'mcuFamily': mcuFamily,
      'features': features,
    },
  );

  /// 編輯公司級設備型別檔；型別代碼固定，避免歷史資料失去對應。
  _i2.Future<_i17.DeviceProfile> updateProfile(
    String profileKey,
    String name,
    String description,
    String mcuFamily,
    List<_i19.DeviceFeature> features,
    String? email,
    String? password,
  ) => caller.callServerEndpoint<_i17.DeviceProfile>(
    'device',
    'updateProfile',
    {
      'profileKey': profileKey,
      'name': name,
      'description': description,
      'mcuFamily': mcuFamily,
      'features': features,
      'email': email,
      'password': password,
    },
  );

  /// 將型別檔最新特徵套用至所有使用該型別的設備。
  _i2.Future<int> applyProfileToDevices(String profileKey) =>
      caller.callServerEndpoint<int>(
        'device',
        'applyProfileToDevices',
        {'profileKey': profileKey},
      );

  _i2.Future<void> deleteProfile(
    String profileKey,
    String email,
    String password,
  ) => caller.callServerEndpoint<void>(
    'device',
    'deleteProfile',
    {
      'profileKey': profileKey,
      'email': email,
      'password': password,
    },
  );

  /// 破壞性 UI 操作前先重新驗證；實際寫入端點仍會再次驗證。
  _i2.Future<void> verifyDestructivePassword(
    String email,
    String password,
  ) => caller.callServerEndpoint<void>(
    'device',
    'verifyDestructivePassword',
    {
      'email': email,
      'password': password,
    },
  );

  /// 註冊設備並建立初始狀態（unknown，等待第一筆資料）。
  /// [deviceType] 為型別檔 id，特徵清單由型別檔目錄套用。
  _i2.Future<_i20.Device> createDevice(
    int siteId,
    int? gatewayId,
    String name,
    String model,
    String deviceType,
    int expectedIntervalSeconds,
  ) => caller.callServerEndpoint<_i20.Device>(
    'device',
    'createDevice',
    {
      'siteId': siteId,
      'gatewayId': gatewayId,
      'name': name,
      'model': model,
      'deviceType': deviceType,
      'expectedIntervalSeconds': expectedIntervalSeconds,
    },
  );

  /// 更新設備基本資料（類型不可變更，避免歷史量測失去意義）。
  _i2.Future<_i20.Device> updateDevice(
    int deviceId,
    String name,
    String model,
    int expectedIntervalSeconds,
  ) => caller.callServerEndpoint<_i20.Device>(
    'device',
    'updateDevice',
    {
      'deviceId': deviceId,
      'name': name,
      'model': model,
      'expectedIntervalSeconds': expectedIntervalSeconds,
    },
  );

  /// 儲存設備在 2D 廠房平面圖上的正規化座標。
  _i2.Future<_i20.Device> updateMapPosition(
    int deviceId,
    double mapX,
    double mapY,
  ) => caller.callServerEndpoint<_i20.Device>(
    'device',
    'updateMapPosition',
    {
      'deviceId': deviceId,
      'mapX': mapX,
      'mapY': mapY,
    },
  );

  /// 刪除設備，並連帶清除其狀態、量測、命令、告警與規則。
  _i2.Future<void> deleteDevice(
    int deviceId,
    String email,
    String password,
  ) => caller.callServerEndpoint<void>(
    'device',
    'deleteDevice',
    {
      'deviceId': deviceId,
      'email': email,
      'password': password,
    },
  );

  /// 列出場域底下的設備。舊資料的特徵清單由型別檔目錄補齊。
  _i2.Future<List<_i20.Device>> listBySite(int siteId) =>
      caller.callServerEndpoint<List<_i20.Device>>(
        'device',
        'listBySite',
        {'siteId': siteId},
      );

  /// 取得單一設備。舊資料的特徵清單由型別檔目錄補齊。
  _i2.Future<_i20.Device> getDevice(int deviceId) =>
      caller.callServerEndpoint<_i20.Device>(
        'device',
        'getDevice',
        {'deviceId': deviceId},
      );
}

/// 閘道器查詢與管理。
/// {@category Endpoint}
class EndpointGateway extends _i1.EndpointRef {
  EndpointGateway(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'gateway';

  /// 註冊閘道器（序號全平台唯一）。
  _i2.Future<_i21.Gateway> createGateway(
    int siteId,
    String serialNumber,
    String name,
  ) => caller.callServerEndpoint<_i21.Gateway>(
    'gateway',
    'createGateway',
    {
      'siteId': siteId,
      'serialNumber': serialNumber,
      'name': name,
    },
  );

  /// 更新閘道器名稱。
  _i2.Future<_i21.Gateway> updateGateway(
    int gatewayId,
    String name,
  ) => caller.callServerEndpoint<_i21.Gateway>(
    'gateway',
    'updateGateway',
    {
      'gatewayId': gatewayId,
      'name': name,
    },
  );

  /// 刪除閘道器。底下仍有設備時拒絕。
  _i2.Future<void> deleteGateway(int gatewayId) =>
      caller.callServerEndpoint<void>(
        'gateway',
        'deleteGateway',
        {'gatewayId': gatewayId},
      );

  /// 列出場域底下的 Gateway。
  _i2.Future<List<_i21.Gateway>> listBySite(int siteId) =>
      caller.callServerEndpoint<List<_i21.Gateway>>(
        'gateway',
        'listBySite',
        {'siteId': siteId},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i22.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i22.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointOperations extends _i1.EndpointRef {
  EndpointOperations(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'operations';

  _i2.Future<List<_i23.AutomationRule>> listAutomationRules() =>
      caller.callServerEndpoint<List<_i23.AutomationRule>>(
        'operations',
        'listAutomationRules',
        {},
      );

  /// 回傳目前公司可用於自動化觸發與控制的設備。
  _i2.Future<List<_i20.Device>> listAutomationDevices() =>
      caller.callServerEndpoint<List<_i20.Device>>(
        'operations',
        'listAutomationDevices',
        {},
      );

  _i2.Future<_i23.AutomationRule> createAutomationRule(
    String name,
    int triggerDeviceId,
    String triggerFeatureKey,
    _i4.AlertComparison comparison,
    double threshold,
    double recoveryThreshold,
    int actionDeviceId,
    String actionFeatureKey,
    double actionValue,
    int pulseOnSeconds,
    int intervalSeconds,
    int maxRepeats,
    int mixingDelaySeconds,
  ) => caller.callServerEndpoint<_i23.AutomationRule>(
    'operations',
    'createAutomationRule',
    {
      'name': name,
      'triggerDeviceId': triggerDeviceId,
      'triggerFeatureKey': triggerFeatureKey,
      'comparison': comparison,
      'threshold': threshold,
      'recoveryThreshold': recoveryThreshold,
      'actionDeviceId': actionDeviceId,
      'actionFeatureKey': actionFeatureKey,
      'actionValue': actionValue,
      'pulseOnSeconds': pulseOnSeconds,
      'intervalSeconds': intervalSeconds,
      'maxRepeats': maxRepeats,
      'mixingDelaySeconds': mixingDelaySeconds,
    },
  );

  /// 建立或更新視覺化 IF / ELSE IF / ELSE 多分支規則。
  ///
  /// 編輯後一律停用，避免尚未人工覆核的新動作立即控制實體設備。
  _i2.Future<_i23.AutomationRule> saveAdvancedAutomationRule(
    int? ruleId,
    String name,
    List<_i24.AutomationBranch> branches,
    int sensorTimeoutSeconds,
    int cooldownSeconds,
    int maxRepeats,
    int mixingDelaySeconds,
  ) => caller.callServerEndpoint<_i23.AutomationRule>(
    'operations',
    'saveAdvancedAutomationRule',
    {
      'ruleId': ruleId,
      'name': name,
      'branches': branches,
      'sensorTimeoutSeconds': sensorTimeoutSeconds,
      'cooldownSeconds': cooldownSeconds,
      'maxRepeats': maxRepeats,
      'mixingDelaySeconds': mixingDelaySeconds,
    },
  );

  _i2.Future<_i23.AutomationRule> setAutomationEnabled(
    int ruleId,
    bool enabled,
  ) => caller.callServerEndpoint<_i23.AutomationRule>(
    'operations',
    'setAutomationEnabled',
    {
      'ruleId': ruleId,
      'enabled': enabled,
    },
  );

  _i2.Future<_i23.AutomationRule> updateAutomationRule(
    int ruleId,
    String name,
    int triggerDeviceId,
    String triggerFeatureKey,
    _i4.AlertComparison comparison,
    double threshold,
    double recoveryThreshold,
    int actionDeviceId,
    String actionFeatureKey,
    double actionValue,
    int pulseOnSeconds,
    int intervalSeconds,
    int maxRepeats,
    int mixingDelaySeconds,
  ) => caller.callServerEndpoint<_i23.AutomationRule>(
    'operations',
    'updateAutomationRule',
    {
      'ruleId': ruleId,
      'name': name,
      'triggerDeviceId': triggerDeviceId,
      'triggerFeatureKey': triggerFeatureKey,
      'comparison': comparison,
      'threshold': threshold,
      'recoveryThreshold': recoveryThreshold,
      'actionDeviceId': actionDeviceId,
      'actionFeatureKey': actionFeatureKey,
      'actionValue': actionValue,
      'pulseOnSeconds': pulseOnSeconds,
      'intervalSeconds': intervalSeconds,
      'maxRepeats': maxRepeats,
      'mixingDelaySeconds': mixingDelaySeconds,
    },
  );

  _i2.Future<void> deleteAutomationRule(int ruleId) =>
      caller.callServerEndpoint<void>(
        'operations',
        'deleteAutomationRule',
        {'ruleId': ruleId},
      );

  _i2.Future<List<_i25.AutomationRun>> listAutomationRuns() =>
      caller.callServerEndpoint<List<_i25.AutomationRun>>(
        'operations',
        'listAutomationRuns',
        {},
      );

  _i2.Future<List<_i26.AuditLog>> listAuditLogs({required int limit}) =>
      caller.callServerEndpoint<List<_i26.AuditLog>>(
        'operations',
        'listAuditLogs',
        {'limit': limit},
      );
}

/// OTA 韌體與灰度發布管理。
///
/// 此 Endpoint 管理可稽核的發布 Metadata 與單機 Job。實際檔案上傳應由
/// Object Storage 的短效簽名 URL 完成；裝置下載前必須驗證 SHA-256 與簽章。
/// {@category Endpoint}
class EndpointOta extends _i1.EndpointRef {
  EndpointOta(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ota';

  _i2.Future<bool> canManageFirmware() => caller.callServerEndpoint<bool>(
    'ota',
    'canManageFirmware',
    {},
  );

  _i2.Future<List<_i27.FirmwarePackage>> listFirmwarePackages({
    String? deviceType,
  }) => caller.callServerEndpoint<List<_i27.FirmwarePackage>>(
    'ota',
    'listFirmwarePackages',
    {'deviceType': deviceType},
  );

  _i2.Future<List<_i28.FirmwareReleaseDetail>> listFirmwareReleases() =>
      caller.callServerEndpoint<List<_i28.FirmwareReleaseDetail>>(
        'ota',
        'listFirmwareReleases',
        {},
      );

  _i2.Future<_i27.FirmwarePackage> createFirmwarePackage(
    String name,
    String version,
    String targetDeviceType,
    String? hardwareRevision,
    String? releaseNotes,
    String downloadUrl,
    String sha256,
    int sizeBytes,
  ) => caller.callServerEndpoint<_i27.FirmwarePackage>(
    'ota',
    'createFirmwarePackage',
    {
      'name': name,
      'version': version,
      'targetDeviceType': targetDeviceType,
      'hardwareRevision': hardwareRevision,
      'releaseNotes': releaseNotes,
      'downloadUrl': downloadUrl,
      'sha256': sha256,
      'sizeBytes': sizeBytes,
    },
  );

  /// 登錄已放入 Server 韌體目錄的 .bin，雜湊與大小一律由 Server 計算。
  _i2.Future<_i27.FirmwarePackage> importFirmwareBinary(
    String name,
    String version,
    String targetDeviceType,
    String? hardwareRevision,
    String? releaseNotes,
    String fileName,
  ) => caller.callServerEndpoint<_i27.FirmwarePackage>(
    'ota',
    'importFirmwareBinary',
    {
      'name': name,
      'version': version,
      'targetDeviceType': targetDeviceType,
      'hardwareRevision': hardwareRevision,
      'releaseNotes': releaseNotes,
      'fileName': fileName,
    },
  );

  /// 從管理端直接上傳韌體檔案，寫入 Server storage 後建立版本資產。
  ///
  /// 開發環境先透過 Serverpod request 傳輸；正式環境可再替換成 Object
  /// Storage signed URL，而不影響 FirmwarePackage / FirmwareArtifact 結構。
  _i2.Future<_i28.FirmwareReleaseDetail> uploadFirmwareRelease(
    String name,
    String version,
    String productKey,
    String targetDeviceType,
    String chipFamily,
    String updateProtocol,
    String? hardwareRevision,
    String? releaseNotes,
    List<String> fileNames,
    List<_i29.ByteData> fileContents,
    int primaryFileIndex,
  ) => caller.callServerEndpoint<_i28.FirmwareReleaseDetail>(
    'ota',
    'uploadFirmwareRelease',
    {
      'name': name,
      'version': version,
      'productKey': productKey,
      'targetDeviceType': targetDeviceType,
      'chipFamily': chipFamily,
      'updateProtocol': updateProtocol,
      'hardwareRevision': hardwareRevision,
      'releaseNotes': releaseNotes,
      'fileNames': fileNames,
      'fileContents': fileContents,
      'primaryFileIndex': primaryFileIndex,
    },
  );

  /// 將同一版本的多個產物（HEX/BIN/ZIP/manifest/signature）登錄為一個 Release。
  _i2.Future<_i28.FirmwareReleaseDetail> importFirmwareRelease(
    String name,
    String version,
    String productKey,
    String targetDeviceType,
    String chipFamily,
    String updateProtocol,
    String? hardwareRevision,
    String? releaseNotes,
    List<String> fileNames,
    String primaryFileName,
  ) => caller.callServerEndpoint<_i28.FirmwareReleaseDetail>(
    'ota',
    'importFirmwareRelease',
    {
      'name': name,
      'version': version,
      'productKey': productKey,
      'targetDeviceType': targetDeviceType,
      'chipFamily': chipFamily,
      'updateProtocol': updateProtocol,
      'hardwareRevision': hardwareRevision,
      'releaseNotes': releaseNotes,
      'fileNames': fileNames,
      'primaryFileName': primaryFileName,
    },
  );

  _i2.Future<bool> deleteFirmwareArtifact(int artifactId) =>
      caller.callServerEndpoint<bool>(
        'ota',
        'deleteFirmwareArtifact',
        {'artifactId': artifactId},
      );

  /// 清除 Server 上的 .bin。已被發布引用時保留 Metadata 與歷史稽核。
  _i2.Future<bool> deleteFirmwareBinary(int packageId) =>
      caller.callServerEndpoint<bool>(
        'ota',
        'deleteFirmwareBinary',
        {'packageId': packageId},
      );

  _i2.Future<List<_i30.OtaCampaign>> listCampaigns() =>
      caller.callServerEndpoint<List<_i30.OtaCampaign>>(
        'ota',
        'listCampaigns',
        {},
      );

  /// 統一列出可更新的感測／致動設備與 Gateway，供前端以實體設備選版本。
  _i2.Future<List<_i31.OtaTarget>> listTargets() =>
      caller.callServerEndpoint<List<_i31.OtaTarget>>(
        'ota',
        'listTargets',
        {},
      );

  /// 取得單台設備尚未結束的 OTA，讓設備頁重開後能接續顯示進度。
  _i2.Future<_i32.OtaCampaignDetail?> getActiveDeviceCampaign(int deviceId) =>
      caller.callServerEndpoint<_i32.OtaCampaignDetail?>(
        'ota',
        'getActiveDeviceCampaign',
        {'deviceId': deviceId},
      );

  /// 以統一 targetKey 建立任務，支援指定單台設備升級或降版。
  _i2.Future<_i30.OtaCampaign> createTargetCampaign(
    int firmwarePackageId,
    String name,
    _i33.OtaStrategy strategy,
    List<String> targetKeys,
    DateTime? scheduledAt,
  ) => caller.callServerEndpoint<_i30.OtaCampaign>(
    'ota',
    'createTargetCampaign',
    {
      'firmwarePackageId': firmwarePackageId,
      'name': name,
      'strategy': strategy,
      'targetKeys': targetKeys,
      'scheduledAt': scheduledAt,
    },
  );

  _i2.Future<_i30.OtaCampaign> createCampaign(
    int firmwarePackageId,
    String name,
    _i33.OtaStrategy strategy,
    List<int> targetDeviceIds,
    DateTime? scheduledAt,
  ) => caller.callServerEndpoint<_i30.OtaCampaign>(
    'ota',
    'createCampaign',
    {
      'firmwarePackageId': firmwarePackageId,
      'name': name,
      'strategy': strategy,
      'targetDeviceIds': targetDeviceIds,
      'scheduledAt': scheduledAt,
    },
  );

  _i2.Future<_i32.OtaCampaignDetail> getCampaign(int campaignId) =>
      caller.callServerEndpoint<_i32.OtaCampaignDetail>(
        'ota',
        'getCampaign',
        {'campaignId': campaignId},
      );

  /// 前端無進度 watchdog：只有 Job 的狀態與進度仍等於觀察值時才結束，
  /// 避免逾時請求與剛到達的設備進度更新互相覆蓋。
  _i2.Future<_i32.OtaCampaignDetail> stopStalledCampaign(
    int campaignId,
    int deviceId,
    _i34.OtaJobState expectedState,
    int expectedProgress,
  ) => caller.callServerEndpoint<_i32.OtaCampaignDetail>(
    'ota',
    'stopStalledCampaign',
    {
      'campaignId': campaignId,
      'deviceId': deviceId,
      'expectedState': expectedState,
      'expectedProgress': expectedProgress,
    },
  );

  _i2.Future<_i30.OtaCampaign> startCampaign(int campaignId) =>
      caller.callServerEndpoint<_i30.OtaCampaign>(
        'ota',
        'startCampaign',
        {'campaignId': campaignId},
      );

  /// 開發環境 OTA 模擬：將既有活動重設為待下載，供 App 重播完整流程。
  ///
  /// 實機版本會改由 MQTT 指令觸發 ESP32，並由裝置上報相同的 Job 狀態。
  _i2.Future<_i30.OtaCampaign> restartSimulation(int campaignId) =>
      caller.callServerEndpoint<_i30.OtaCampaign>(
        'ota',
        'restartSimulation',
        {'campaignId': campaignId},
      );

  /// 推進一次模擬裝置狀態：下載 → 寫入 OTA 分區 → 驗證 → 重啟成功。
  _i2.Future<_i32.OtaCampaignDetail> advanceSimulation(int campaignId) =>
      caller.callServerEndpoint<_i32.OtaCampaignDetail>(
        'ota',
        'advanceSimulation',
        {'campaignId': campaignId},
      );
}

/// 製程、WIP、產品與物料管理。
/// {@category Endpoint}
class EndpointProduction extends _i1.EndpointRef {
  EndpointProduction(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'production';

  _i2.Future<_i35.ProductionSummary> getSummary() =>
      caller.callServerEndpoint<_i35.ProductionSummary>(
        'production',
        'getSummary',
        {},
      );

  _i2.Future<List<_i36.MaterialItem>> listMaterials() =>
      caller.callServerEndpoint<List<_i36.MaterialItem>>(
        'production',
        'listMaterials',
        {},
      );

  _i2.Future<_i36.MaterialItem> saveMaterial(
    int? id,
    String code,
    String name,
    _i37.MaterialType type,
    String unit,
    String? specification,
    String? supplier,
    double safetyStock,
    bool active,
  ) => caller.callServerEndpoint<_i36.MaterialItem>(
    'production',
    'saveMaterial',
    {
      'id': id,
      'code': code,
      'name': name,
      'type': type,
      'unit': unit,
      'specification': specification,
      'supplier': supplier,
      'safetyStock': safetyStock,
      'active': active,
    },
  );

  _i2.Future<void> deleteMaterial(int id) => caller.callServerEndpoint<void>(
    'production',
    'deleteMaterial',
    {'id': id},
  );

  _i2.Future<List<_i38.MaterialLot>> listMaterialLots({int? materialId}) =>
      caller.callServerEndpoint<List<_i38.MaterialLot>>(
        'production',
        'listMaterialLots',
        {'materialId': materialId},
      );

  _i2.Future<_i38.MaterialLot> saveMaterialLot(
    int? id,
    int materialId,
    String lotNumber,
    double quantity,
    DateTime receivedAt,
    DateTime? expiresAt,
    String? supplierLot,
    String? qrCode,
    String? rfidEpc,
  ) => caller.callServerEndpoint<_i38.MaterialLot>(
    'production',
    'saveMaterialLot',
    {
      'id': id,
      'materialId': materialId,
      'lotNumber': lotNumber,
      'quantity': quantity,
      'receivedAt': receivedAt,
      'expiresAt': expiresAt,
      'supplierLot': supplierLot,
      'qrCode': qrCode,
      'rfidEpc': rfidEpc,
    },
  );

  _i2.Future<void> deleteMaterialLot(int id) => caller.callServerEndpoint<void>(
    'production',
    'deleteMaterialLot',
    {'id': id},
  );

  _i2.Future<List<_i39.ProductDefinition>> listProducts() =>
      caller.callServerEndpoint<List<_i39.ProductDefinition>>(
        'production',
        'listProducts',
        {},
      );

  _i2.Future<_i39.ProductDefinition> saveProduct(
    int? id,
    String code,
    String name,
    String unit,
    String? specification,
    bool active,
  ) => caller.callServerEndpoint<_i39.ProductDefinition>(
    'production',
    'saveProduct',
    {
      'id': id,
      'code': code,
      'name': name,
      'unit': unit,
      'specification': specification,
      'active': active,
    },
  );

  _i2.Future<void> deleteProduct(int id) => caller.callServerEndpoint<void>(
    'production',
    'deleteProduct',
    {'id': id},
  );

  _i2.Future<List<_i40.BomItem>> listBom(int productId) =>
      caller.callServerEndpoint<List<_i40.BomItem>>(
        'production',
        'listBom',
        {'productId': productId},
      );

  _i2.Future<_i40.BomItem> saveBomItem(
    int? id,
    int productId,
    int materialId,
    double quantity,
    String unit,
    double scrapRatePercent,
    String? note,
  ) => caller.callServerEndpoint<_i40.BomItem>(
    'production',
    'saveBomItem',
    {
      'id': id,
      'productId': productId,
      'materialId': materialId,
      'quantity': quantity,
      'unit': unit,
      'scrapRatePercent': scrapRatePercent,
      'note': note,
    },
  );

  _i2.Future<void> deleteBomItem(int id) => caller.callServerEndpoint<void>(
    'production',
    'deleteBomItem',
    {'id': id},
  );

  _i2.Future<List<_i41.ProcessRoute>> listRoutes() =>
      caller.callServerEndpoint<List<_i41.ProcessRoute>>(
        'production',
        'listRoutes',
        {},
      );

  _i2.Future<List<_i42.ProductionLine>> listProductionLines() =>
      caller.callServerEndpoint<List<_i42.ProductionLine>>(
        'production',
        'listProductionLines',
        {},
      );

  _i2.Future<_i42.ProductionLine> saveProductionLine(
    int? id,
    String code,
    String name,
    String? description,
    bool active,
  ) => caller.callServerEndpoint<_i42.ProductionLine>(
    'production',
    'saveProductionLine',
    {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'active': active,
    },
  );

  _i2.Future<void> deleteProductionLine(int id) =>
      caller.callServerEndpoint<void>(
        'production',
        'deleteProductionLine',
        {'id': id},
      );

  _i2.Future<List<_i43.Workstation>> listWorkstations() =>
      caller.callServerEndpoint<List<_i43.Workstation>>(
        'production',
        'listWorkstations',
        {},
      );

  _i2.Future<_i43.Workstation> saveWorkstation(
    int? id,
    int productionLineId,
    String code,
    String name,
    String? description,
    bool active,
  ) => caller.callServerEndpoint<_i43.Workstation>(
    'production',
    'saveWorkstation',
    {
      'id': id,
      'productionLineId': productionLineId,
      'code': code,
      'name': name,
      'description': description,
      'active': active,
    },
  );

  _i2.Future<void> deleteWorkstation(int id) => caller.callServerEndpoint<void>(
    'production',
    'deleteWorkstation',
    {'id': id},
  );

  _i2.Future<List<_i44.WorkstationAssignmentDetail>>
  listWorkstationAssignments() =>
      caller.callServerEndpoint<List<_i44.WorkstationAssignmentDetail>>(
        'production',
        'listWorkstationAssignments',
        {},
      );

  _i2.Future<_i45.WorkstationAssignment> assignWorkstation(
    int workstationId,
    int membershipId,
  ) => caller.callServerEndpoint<_i45.WorkstationAssignment>(
    'production',
    'assignWorkstation',
    {
      'workstationId': workstationId,
      'membershipId': membershipId,
    },
  );

  _i2.Future<void> removeWorkstationAssignment(int id) =>
      caller.callServerEndpoint<void>(
        'production',
        'removeWorkstationAssignment',
        {'id': id},
      );

  _i2.Future<List<_i43.Workstation>> listMyWorkstations() =>
      caller.callServerEndpoint<List<_i43.Workstation>>(
        'production',
        'listMyWorkstations',
        {},
      );

  _i2.Future<List<_i46.LineTransfer>> listMyPendingTransfers() =>
      caller.callServerEndpoint<List<_i46.LineTransfer>>(
        'production',
        'listMyPendingTransfers',
        {},
      );

  _i2.Future<_i46.LineTransfer> dispatchLineTransfer(int transferId) =>
      caller.callServerEndpoint<_i46.LineTransfer>(
        'production',
        'dispatchLineTransfer',
        {'transferId': transferId},
      );

  _i2.Future<_i46.LineTransfer> receiveLineTransfer(int transferId) =>
      caller.callServerEndpoint<_i46.LineTransfer>(
        'production',
        'receiveLineTransfer',
        {'transferId': transferId},
      );

  _i2.Future<_i41.ProcessRoute> saveRoute(
    int? id,
    int productId,
    String code,
    String name,
    int version,
    bool active,
  ) => caller.callServerEndpoint<_i41.ProcessRoute>(
    'production',
    'saveRoute',
    {
      'id': id,
      'productId': productId,
      'code': code,
      'name': name,
      'version': version,
      'active': active,
    },
  );

  _i2.Future<void> deleteRoute(int id) => caller.callServerEndpoint<void>(
    'production',
    'deleteRoute',
    {'id': id},
  );

  _i2.Future<List<_i47.ProcessNode>> listProcessNodes(int routeId) =>
      caller.callServerEndpoint<List<_i47.ProcessNode>>(
        'production',
        'listProcessNodes',
        {'routeId': routeId},
      );

  _i2.Future<_i47.ProcessNode> saveProcessNode(
    int? id,
    int routeId,
    int sequence,
    String code,
    String name,
    String stationCode,
    int standardSeconds,
    String scanMode,
    bool allowSkip,
    bool allowRework,
    Map<String, String>? measurementRequirements,
  ) => caller.callServerEndpoint<_i47.ProcessNode>(
    'production',
    'saveProcessNode',
    {
      'id': id,
      'routeId': routeId,
      'sequence': sequence,
      'code': code,
      'name': name,
      'stationCode': stationCode,
      'standardSeconds': standardSeconds,
      'scanMode': scanMode,
      'allowSkip': allowSkip,
      'allowRework': allowRework,
      'measurementRequirements': measurementRequirements,
    },
  );

  _i2.Future<void> deleteProcessNode(int id) => caller.callServerEndpoint<void>(
    'production',
    'deleteProcessNode',
    {'id': id},
  );

  _i2.Future<List<_i48.ProductionOrder>> listProductionOrders() =>
      caller.callServerEndpoint<List<_i48.ProductionOrder>>(
        'production',
        'listProductionOrders',
        {},
      );

  _i2.Future<_i48.ProductionOrder> createProductionOrder(
    String orderNumber,
    int productId,
    int routeId,
    int plannedQuantity,
    DateTime? scheduledStart,
    DateTime? scheduledEnd,
  ) => caller.callServerEndpoint<_i48.ProductionOrder>(
    'production',
    'createProductionOrder',
    {
      'orderNumber': orderNumber,
      'productId': productId,
      'routeId': routeId,
      'plannedQuantity': plannedQuantity,
      'scheduledStart': scheduledStart,
      'scheduledEnd': scheduledEnd,
    },
  );

  _i2.Future<_i48.ProductionOrder> setProductionOrderStatus(
    int id,
    _i49.ProductionOrderStatus status,
  ) => caller.callServerEndpoint<_i48.ProductionOrder>(
    'production',
    'setProductionOrderStatus',
    {
      'id': id,
      'status': status,
    },
  );

  _i2.Future<void> deleteProductionOrder(int id) =>
      caller.callServerEndpoint<void>(
        'production',
        'deleteProductionOrder',
        {'id': id},
      );

  _i2.Future<List<_i50.ProductUnit>> listProductUnits({int? orderId}) =>
      caller.callServerEndpoint<List<_i50.ProductUnit>>(
        'production',
        'listProductUnits',
        {'orderId': orderId},
      );

  _i2.Future<List<_i50.ProductUnit>> generateProductUnits(
    int orderId,
    int quantity,
    String serialPrefix,
  ) => caller.callServerEndpoint<List<_i50.ProductUnit>>(
    'production',
    'generateProductUnits',
    {
      'orderId': orderId,
      'quantity': quantity,
      'serialPrefix': serialPrefix,
    },
  );

  /// 現場工位模式：員工只提供被指派的工作站與產品識別，
  /// Server 依工單路線自動決定此工位可執行的節點。
  _i2.Future<_i51.ProcessEvent> recordWorkstationEvent(
    String clientEventId,
    int workstationId,
    String productIdentifier,
    _i52.ProcessEventType eventType,
    _i53.ProcessResult result,
    DateTime occurredAt, {
    List<int>? materialLotIds,
    Map<String, double>? measurements,
    String? note,
  }) => caller.callServerEndpoint<_i51.ProcessEvent>(
    'production',
    'recordWorkstationEvent',
    {
      'clientEventId': clientEventId,
      'workstationId': workstationId,
      'productIdentifier': productIdentifier,
      'eventType': eventType,
      'result': result,
      'occurredAt': occurredAt,
      'materialLotIds': materialLotIds,
      'measurements': measurements,
      'note': note,
    },
  );

  _i2.Future<_i51.ProcessEvent> recordProcessEvent(
    String clientEventId,
    String productIdentifier,
    int processNodeId,
    _i52.ProcessEventType eventType,
    _i53.ProcessResult result,
    DateTime occurredAt, {
    int? deviceId,
    List<int>? materialLotIds,
    Map<String, double>? measurements,
    String? note,
  }) => caller.callServerEndpoint<_i51.ProcessEvent>(
    'production',
    'recordProcessEvent',
    {
      'clientEventId': clientEventId,
      'productIdentifier': productIdentifier,
      'processNodeId': processNodeId,
      'eventType': eventType,
      'result': result,
      'occurredAt': occurredAt,
      'deviceId': deviceId,
      'materialLotIds': materialLotIds,
      'measurements': measurements,
      'note': note,
    },
  );

  _i2.Future<_i54.ProductTrace> getProductTrace(String identifier) =>
      caller.callServerEndpoint<_i54.ProductTrace>(
        'production',
        'getProductTrace',
        {'identifier': identifier},
      );
}

/// 設備配對與憑證管理（手冊 §6～§8）。
///
/// 使用者登入＋公司 Factory CA 身分＋短效配對 Session。
/// {@category Endpoint}
class EndpointProvisioning extends _i1.EndpointRef {
  EndpointProvisioning(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'provisioning';

  /// 出廠設備列表（含配對狀態，供 App 顯示）。
  _i2.Future<List<_i55.ProvisionedDevice>> listDevices() =>
      caller.callServerEndpoint<List<_i55.ProvisionedDevice>>(
        'provisioning',
        'listDevices',
        {},
      );

  /// 建立製造商驗證配對 Session。使用者不輸入 Claim Code；Server 會驗證
  /// Factory Certificate 的公司 CA 信任鏈、CN 與既有指紋。
  _i2.Future<_i56.ClaimSessionResult> beginManufacturerPairing(String serial) =>
      caller.callServerEndpoint<_i56.ClaimSessionResult>(
        'provisioning',
        'beginManufacturerPairing',
        {'serial': serial},
      );

  /// 模擬 ESP32 完成配對（開發環境專用；實機階段由設備透過
  /// Bootstrap mTLS 呼叫 claim-confirm 與憑證申請）：
  /// 1) 確認 Claim Session 有效 → 綁定（CLAIMED）
  /// 2) 模擬設備本機產生私鑰與 CSR（私鑰不出設備）
  /// 3) 內部 CA 真實簽發憑證並驗證信任鏈（CERTIFICATE_ISSUED）
  /// 4) 設備啟用（ACTIVE）
  _i2.Future<_i57.CertificateIssueResult> simulateDeviceProvision(
    String claimSessionId,
  ) => caller.callServerEndpoint<_i57.CertificateIssueResult>(
    'provisioning',
    'simulateDeviceProvision',
    {'claimSessionId': claimSessionId},
  );

  /// 已配對（ACTIVE）且尚未掛到設備庫的實體清單（供建檔頁選序號）。
  _i2.Future<List<_i55.ProvisionedDevice>> listUnlinkedDevices() =>
      caller.callServerEndpoint<List<_i55.ProvisionedDevice>>(
        'provisioning',
        'listUnlinkedDevices',
        {},
      );

  /// 把已啟用（ACTIVE）的配對設備加入設備庫（營運層）：
  /// - GW 型號 → 建立或重新連結平台 Gateway（序號即設備序號）
  /// - 感測器型號 → 掛在指定閘道器下建立平台 Device ＋ 初始狀態
  /// 加入後模擬器（實機為 MQTT 上行）即開始提供量測數據。
  ///
  /// [profileId] 空字串則依出廠型號推斷；[expectedIntervalSeconds] ≤0 則用 5；
  /// [model] 空字串則沿用出廠型號。
  _i2.Future<_i55.ProvisionedDevice> attachToPlatform(
    String serial,
    int siteId,
    int? gatewayId,
    String name,
    String profileId,
    int expectedIntervalSeconds,
    String model,
  ) => caller.callServerEndpoint<_i55.ProvisionedDevice>(
    'provisioning',
    'attachToPlatform',
    {
      'serial': serial,
      'siteId': siteId,
      'gatewayId': gatewayId,
      'name': name,
      'profileId': profileId,
      'expectedIntervalSeconds': expectedIntervalSeconds,
      'model': model,
    },
  );

  /// 設備的憑證歷史（新到舊）。
  _i2.Future<List<_i58.DeviceCertificate>> listCertificates(String serial) =>
      caller.callServerEndpoint<List<_i58.DeviceCertificate>>(
        'provisioning',
        'listCertificates',
        {'serial': serial},
      );

  /// 撤銷憑證（手冊 §11）：憑證列入撤銷、設備轉為 REVOKED。
  _i2.Future<void> revokeCertificate(int certificateId) =>
      caller.callServerEndpoint<void>(
        'provisioning',
        'revokeCertificate',
        {'certificateId': certificateId},
      );

  /// 開發用：解除綁定並撤銷所有憑證，讓同一設備可重複示範配對。
  _i2.Future<_i55.ProvisionedDevice> resetDevice(String serial) =>
      caller.callServerEndpoint<_i55.ProvisionedDevice>(
        'provisioning',
        'resetDevice',
        {'serial': serial},
      );
}

/// 場域查詢與管理。
/// {@category Endpoint}
class EndpointSite extends _i1.EndpointRef {
  EndpointSite(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'site';

  /// 建立場域。
  _i2.Future<_i59.Site> createSite(
    String name,
    String? description,
  ) => caller.callServerEndpoint<_i59.Site>(
    'site',
    'createSite',
    {
      'name': name,
      'description': description,
    },
  );

  /// 更新場域名稱與描述。
  _i2.Future<_i59.Site> updateSite(
    int siteId,
    String name,
    String? description,
  ) => caller.callServerEndpoint<_i59.Site>(
    'site',
    'updateSite',
    {
      'siteId': siteId,
      'name': name,
      'description': description,
    },
  );

  /// 刪除場域。場域內仍有閘道器或設備時拒絕，避免誤刪整批資料。
  _i2.Future<void> deleteSite(int siteId) => caller.callServerEndpoint<void>(
    'site',
    'deleteSite',
    {'siteId': siteId},
  );

  /// 列出目前租戶的場域（場域數量有限，單頁上限 100）。
  _i2.Future<List<_i59.Site>> listSites() =>
      caller.callServerEndpoint<List<_i59.Site>>(
        'site',
        'listSites',
        {},
      );

  /// 取得單一場域。
  _i2.Future<_i59.Site> getSite(int siteId) =>
      caller.callServerEndpoint<_i59.Site>(
        'site',
        'getSite',
        {'siteId': siteId},
      );
}

/// 即時狀態與歷史量測查詢。
/// {@category Endpoint}
class EndpointTelemetry extends _i1.EndpointRef {
  EndpointTelemetry(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'telemetry';

  /// 取得場域內所有設備目前狀態（進入頁面時的 snapshot）。
  _i2.Future<List<_i60.DeviceStatus>> listSiteStatuses(int siteId) =>
      caller.callServerEndpoint<List<_i60.DeviceStatus>>(
        'telemetry',
        'listSiteStatuses',
        {'siteId': siteId},
      );

  /// 訂閱場域內設備狀態更新（Serverpod Streaming）。
  ///
  /// 前端應先呼叫 [listSiteStatuses] 取得 snapshot，再以本 stream 接收增量。
  _i2.Stream<_i60.DeviceStatus> watchSiteStatus(int siteId) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i60.DeviceStatus>,
        _i60.DeviceStatus
      >(
        'telemetry',
        'watchSiteStatus',
        {'siteId': siteId},
        {},
      );

  /// 查詢設備歷史量測（cursor 分頁，新到舊）。
  /// 多通道設備以 [featureKey] 指定通道；null 表示全部通道。
  _i2.Future<_i61.MeasurementListResult> listMeasurements(
    int deviceId, {
    String? featureKey,
    required int limit,
    int? cursorId,
    DateTime? startAt,
    DateTime? endAt,
  }) => caller.callServerEndpoint<_i61.MeasurementListResult>(
    'telemetry',
    'listMeasurements',
    {
      'deviceId': deviceId,
      'featureKey': featureKey,
      'limit': limit,
      'cursorId': cursorId,
      'startAt': startAt,
      'endAt': endAt,
    },
  );
}

/// 巡檢與維修工單（Mobile CMMS，見 docs/product/enterprise-iot-platform-spec.md）。
///
/// 狀態機：open → inProgress → done / cancelled。
/// 拍照、掃碼與語音回傳需實體機，於 BLE/實機階段補上。
/// {@category Endpoint}
class EndpointWorkOrder extends _i1.EndpointRef {
  EndpointWorkOrder(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'workOrder';

  /// 手動開立工單。
  _i2.Future<_i62.WorkOrder> createWorkOrder(
    int siteId,
    int? deviceId,
    String title,
    String? description,
    _i63.WorkOrderPriority priority,
  ) => caller.callServerEndpoint<_i62.WorkOrder>(
    'workOrder',
    'createWorkOrder',
    {
      'siteId': siteId,
      'deviceId': deviceId,
      'title': title,
      'description': description,
      'priority': priority,
    },
  );

  /// 由告警轉開工單（產品規格「轉為維修工單」）。
  /// 冪等：同一告警已有工單時回傳既有工單。
  _i2.Future<_i62.WorkOrder> createFromAlert(int alertId) =>
      caller.callServerEndpoint<_i62.WorkOrder>(
        'workOrder',
        'createFromAlert',
        {'alertId': alertId},
      );

  /// 查詢工單（cursor 分頁，新到舊）。[openOnly] 為 true 時僅回傳未結案。
  _i2.Future<_i64.WorkOrderListResult> listWorkOrders({
    required bool openOnly,
    required int limit,
    int? cursorId,
  }) => caller.callServerEndpoint<_i64.WorkOrderListResult>(
    'workOrder',
    'listWorkOrders',
    {
      'openOnly': openOnly,
      'limit': limit,
      'cursorId': cursorId,
    },
  );

  /// 工單狀態流轉：open → inProgress → done / cancelled。
  /// 結案（done/cancelled）可附處理備註。
  _i2.Future<_i62.WorkOrder> updateStatus(
    int workOrderId,
    _i65.WorkOrderStatus status, {
    String? note,
  }) => caller.callServerEndpoint<_i62.WorkOrder>(
    'workOrder',
    'updateStatus',
    {
      'workOrderId': workOrderId,
      'status': status,
      'note': note,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i8.Caller(client);
    serverpod_auth_core = _i9.Caller(client);
  }

  late final _i8.Caller serverpod_auth_idp;

  late final _i9.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i66.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    alert = EndpointAlert(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    command = EndpointCommand(this);
    access = EndpointAccess(this);
    dashboard = EndpointDashboard(this);
    device = EndpointDevice(this);
    gateway = EndpointGateway(this);
    greeting = EndpointGreeting(this);
    operations = EndpointOperations(this);
    ota = EndpointOta(this);
    production = EndpointProduction(this);
    provisioning = EndpointProvisioning(this);
    site = EndpointSite(this);
    telemetry = EndpointTelemetry(this);
    workOrder = EndpointWorkOrder(this);
    modules = Modules(this);
  }

  late final EndpointAlert alert;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointCommand command;

  late final EndpointAccess access;

  late final EndpointDashboard dashboard;

  late final EndpointDevice device;

  late final EndpointGateway gateway;

  late final EndpointGreeting greeting;

  late final EndpointOperations operations;

  late final EndpointOta ota;

  late final EndpointProduction production;

  late final EndpointProvisioning provisioning;

  late final EndpointSite site;

  late final EndpointTelemetry telemetry;

  late final EndpointWorkOrder workOrder;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'alert': alert,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'command': command,
    'access': access,
    'dashboard': dashboard,
    'device': device,
    'gateway': gateway,
    'greeting': greeting,
    'operations': operations,
    'ota': ota,
    'production': production,
    'provisioning': provisioning,
    'site': site,
    'telemetry': telemetry,
    'workOrder': workOrder,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
