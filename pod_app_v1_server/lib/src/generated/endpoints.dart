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
import '../alert/alert_endpoint.dart' as _i2;
import '../auth/email_idp_endpoint.dart' as _i3;
import '../auth/jwt_refresh_endpoint.dart' as _i4;
import '../command/command_endpoint.dart' as _i5;
import '../company/access_endpoint.dart' as _i6;
import '../dashboard/dashboard_endpoint.dart' as _i7;
import '../device/device_endpoint.dart' as _i8;
import '../gateway/gateway_endpoint.dart' as _i9;
import '../greetings/greeting_endpoint.dart' as _i10;
import '../operations/operations_endpoint.dart' as _i11;
import '../ota/ota_endpoint.dart' as _i12;
import '../production/production_endpoint.dart' as _i13;
import '../provisioning/provisioning_endpoint.dart' as _i14;
import '../site/site_endpoint.dart' as _i15;
import '../telemetry/telemetry_endpoint.dart' as _i16;
import '../workorder/work_order_endpoint.dart' as _i17;
import 'package:pod_app_v1_server/src/generated/alert/alert_comparison.dart'
    as _i18;
import 'package:pod_app_v1_server/src/generated/alert/alert_severity.dart'
    as _i19;
import 'package:pod_app_v1_server/src/generated/company/company_role.dart'
    as _i20;
import 'package:pod_app_v1_server/src/generated/company/platform_permission.dart'
    as _i21;
import 'package:pod_app_v1_server/src/generated/device/device_feature.dart'
    as _i22;
import 'package:pod_app_v1_server/src/generated/operations/automation_branch.dart'
    as _i23;
import 'dart:typed_data' as _i24;
import 'package:pod_app_v1_server/src/generated/ota/ota_strategy.dart' as _i25;
import 'package:pod_app_v1_server/src/generated/ota/ota_job_state.dart' as _i26;
import 'package:pod_app_v1_server/src/generated/production/material_type.dart'
    as _i27;
import 'package:pod_app_v1_server/src/generated/production/production_order_status.dart'
    as _i28;
import 'package:pod_app_v1_server/src/generated/production/process_event_type.dart'
    as _i29;
import 'package:pod_app_v1_server/src/generated/production/process_result.dart'
    as _i30;
import 'package:pod_app_v1_server/src/generated/workorder/work_order_priority.dart'
    as _i31;
import 'package:pod_app_v1_server/src/generated/workorder/work_order_status.dart'
    as _i32;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i33;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i34;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'alert': _i2.AlertEndpoint()
        ..initialize(
          server,
          'alert',
          null,
        ),
      'emailIdp': _i3.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i4.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'command': _i5.CommandEndpoint()
        ..initialize(
          server,
          'command',
          null,
        ),
      'access': _i6.AccessEndpoint()
        ..initialize(
          server,
          'access',
          null,
        ),
      'dashboard': _i7.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'device': _i8.DeviceEndpoint()
        ..initialize(
          server,
          'device',
          null,
        ),
      'gateway': _i9.GatewayEndpoint()
        ..initialize(
          server,
          'gateway',
          null,
        ),
      'greeting': _i10.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'operations': _i11.OperationsEndpoint()
        ..initialize(
          server,
          'operations',
          null,
        ),
      'ota': _i12.OtaEndpoint()
        ..initialize(
          server,
          'ota',
          null,
        ),
      'production': _i13.ProductionEndpoint()
        ..initialize(
          server,
          'production',
          null,
        ),
      'provisioning': _i14.ProvisioningEndpoint()
        ..initialize(
          server,
          'provisioning',
          null,
        ),
      'site': _i15.SiteEndpoint()
        ..initialize(
          server,
          'site',
          null,
        ),
      'telemetry': _i16.TelemetryEndpoint()
        ..initialize(
          server,
          'telemetry',
          null,
        ),
      'workOrder': _i17.WorkOrderEndpoint()
        ..initialize(
          server,
          'workOrder',
          null,
        ),
    };
    connectors['alert'] = _i1.EndpointConnector(
      name: 'alert',
      endpoint: endpoints['alert']!,
      methodConnectors: {
        'listRules': _i1.MethodConnector(
          name: 'listRules',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['alert'] as _i2.AlertEndpoint).listRules(session),
        ),
        'createRule': _i1.MethodConnector(
          name: 'createRule',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'featureKey': _i1.ParameterDescription(
              name: 'featureKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'comparison': _i1.ParameterDescription(
              name: 'comparison',
              type: _i1.getType<_i18.AlertComparison>(),
              nullable: false,
            ),
            'threshold': _i1.ParameterDescription(
              name: 'threshold',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'severity': _i1.ParameterDescription(
              name: 'severity',
              type: _i1.getType<_i19.AlertSeverity>(),
              nullable: false,
            ),
            'mobileNotificationEnabled': _i1.ParameterDescription(
              name: 'mobileNotificationEnabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['alert'] as _i2.AlertEndpoint).createRule(
                session,
                params['deviceId'],
                params['featureKey'],
                params['comparison'],
                params['threshold'],
                params['name'],
                params['severity'],
                params['mobileNotificationEnabled'],
              ),
        ),
        'setRuleEnabled': _i1.MethodConnector(
          name: 'setRuleEnabled',
          params: {
            'ruleId': _i1.ParameterDescription(
              name: 'ruleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'enabled': _i1.ParameterDescription(
              name: 'enabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['alert'] as _i2.AlertEndpoint).setRuleEnabled(
                    session,
                    params['ruleId'],
                    params['enabled'],
                  ),
        ),
        'deleteRule': _i1.MethodConnector(
          name: 'deleteRule',
          params: {
            'ruleId': _i1.ParameterDescription(
              name: 'ruleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['alert'] as _i2.AlertEndpoint).deleteRule(
                session,
                params['ruleId'],
              ),
        ),
        'listAlerts': _i1.MethodConnector(
          name: 'listAlerts',
          params: {
            'openOnly': _i1.ParameterDescription(
              name: 'openOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'cursorId': _i1.ParameterDescription(
              name: 'cursorId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['alert'] as _i2.AlertEndpoint).listAlerts(
                session,
                openOnly: params['openOnly'],
                limit: params['limit'],
                cursorId: params['cursorId'],
              ),
        ),
        'acknowledgeAlert': _i1.MethodConnector(
          name: 'acknowledgeAlert',
          params: {
            'alertId': _i1.ParameterDescription(
              name: 'alertId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['alert'] as _i2.AlertEndpoint).acknowledgeAlert(
                    session,
                    params['alertId'],
                  ),
        ),
        'watchAlerts': _i1.MethodStreamConnector(
          name: 'watchAlerts',
          params: {},
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['alert'] as _i2.AlertEndpoint).watchAlerts(
                session,
              ),
        ),
      },
    );
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i3.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i4.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['command'] = _i1.EndpointConnector(
      name: 'command',
      endpoint: endpoints['command']!,
      methodConnectors: {
        'sendCommand': _i1.MethodConnector(
          name: 'sendCommand',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'commandType': _i1.ParameterDescription(
              name: 'commandType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'payload': _i1.ParameterDescription(
              name: 'payload',
              type: _i1.getType<Map<String, String>>(),
              nullable: false,
            ),
            'idempotencyKey': _i1.ParameterDescription(
              name: 'idempotencyKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['command'] as _i5.CommandEndpoint).sendCommand(
                    session,
                    params['deviceId'],
                    params['commandType'],
                    params['payload'],
                    params['idempotencyKey'],
                  ),
        ),
        'cancelCommand': _i1.MethodConnector(
          name: 'cancelCommand',
          params: {
            'commandId': _i1.ParameterDescription(
              name: 'commandId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['command'] as _i5.CommandEndpoint).cancelCommand(
                    session,
                    params['commandId'],
                  ),
        ),
        'listCommands': _i1.MethodConnector(
          name: 'listCommands',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'cursorId': _i1.ParameterDescription(
              name: 'cursorId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['command'] as _i5.CommandEndpoint).listCommands(
                    session,
                    params['deviceId'],
                    limit: params['limit'],
                    cursorId: params['cursorId'],
                  ),
        ),
        'watchDeviceCommands': _i1.MethodStreamConnector(
          name: 'watchDeviceCommands',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['command'] as _i5.CommandEndpoint)
                  .watchDeviceCommands(
                    session,
                    params['deviceId'],
                  ),
        ),
      },
    );
    connectors['access'] = _i1.EndpointConnector(
      name: 'access',
      endpoint: endpoints['access']!,
      methodConnectors: {
        'getMyAccess': _i1.MethodConnector(
          name: 'getMyAccess',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['access'] as _i6.AccessEndpoint)
                  .getMyAccess(session),
        ),
        'listMembers': _i1.MethodConnector(
          name: 'listMembers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['access'] as _i6.AccessEndpoint)
                  .listMembers(session),
        ),
        'addMember': _i1.MethodConnector(
          name: 'addMember',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'displayName': _i1.ParameterDescription(
              name: 'displayName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i20.CompanyRole>(),
              nullable: false,
            ),
            'permissions': _i1.ParameterDescription(
              name: 'permissions',
              type: _i1.getType<List<_i21.PlatformPermission>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['access'] as _i6.AccessEndpoint).addMember(
                session,
                params['email'],
                params['displayName'],
                params['role'],
                params['permissions'],
              ),
        ),
        'updateMember': _i1.MethodConnector(
          name: 'updateMember',
          params: {
            'membershipId': _i1.ParameterDescription(
              name: 'membershipId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i20.CompanyRole>(),
              nullable: false,
            ),
            'permissions': _i1.ParameterDescription(
              name: 'permissions',
              type: _i1.getType<List<_i21.PlatformPermission>>(),
              nullable: false,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['access'] as _i6.AccessEndpoint).updateMember(
                    session,
                    params['membershipId'],
                    params['role'],
                    params['permissions'],
                    params['isActive'],
                  ),
        ),
        'setDeviceShare': _i1.MethodConnector(
          name: 'setDeviceShare',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'membershipId': _i1.ParameterDescription(
              name: 'membershipId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'canRead': _i1.ParameterDescription(
              name: 'canRead',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'canWrite': _i1.ParameterDescription(
              name: 'canWrite',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['access'] as _i6.AccessEndpoint).setDeviceShare(
                    session,
                    params['deviceId'],
                    params['membershipId'],
                    params['canRead'],
                    params['canWrite'],
                  ),
        ),
      },
    );
    connectors['dashboard'] = _i1.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'getSummary': _i1.MethodConnector(
          name: 'getSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getSummary(session),
        ),
        'getOee': _i1.MethodConnector(
          name: 'getOee',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i7.DashboardEndpoint)
                  .getOee(session),
        ),
      },
    );
    connectors['device'] = _i1.EndpointConnector(
      name: 'device',
      endpoint: endpoints['device']!,
      methodConnectors: {
        'listProfiles': _i1.MethodConnector(
          name: 'listProfiles',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['device'] as _i8.DeviceEndpoint)
                  .listProfiles(session),
        ),
        'listFeatureCatalog': _i1.MethodConnector(
          name: 'listFeatureCatalog',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['device'] as _i8.DeviceEndpoint)
                  .listFeatureCatalog(session),
        ),
        'createFeatureDefinition': _i1.MethodConnector(
          name: 'createFeatureDefinition',
          params: {
            'feature': _i1.ParameterDescription(
              name: 'feature',
              type: _i1.getType<_i22.DeviceFeature>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['device'] as _i8.DeviceEndpoint)
                  .createFeatureDefinition(
                    session,
                    params['feature'],
                  ),
        ),
        'updateFeatureDefinition': _i1.MethodConnector(
          name: 'updateFeatureDefinition',
          params: {
            'definitionId': _i1.ParameterDescription(
              name: 'definitionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'feature': _i1.ParameterDescription(
              name: 'feature',
              type: _i1.getType<_i22.DeviceFeature>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['device'] as _i8.DeviceEndpoint)
                  .updateFeatureDefinition(
                    session,
                    params['definitionId'],
                    params['feature'],
                  ),
        ),
        'deleteFeatureDefinition': _i1.MethodConnector(
          name: 'deleteFeatureDefinition',
          params: {
            'definitionId': _i1.ParameterDescription(
              name: 'definitionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['device'] as _i8.DeviceEndpoint)
                  .deleteFeatureDefinition(
                    session,
                    params['definitionId'],
                    params['email'],
                    params['password'],
                  ),
        ),
        'createProfile': _i1.MethodConnector(
          name: 'createProfile',
          params: {
            'profileKey': _i1.ParameterDescription(
              name: 'profileKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'mcuFamily': _i1.ParameterDescription(
              name: 'mcuFamily',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'features': _i1.ParameterDescription(
              name: 'features',
              type: _i1.getType<List<_i22.DeviceFeature>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['device'] as _i8.DeviceEndpoint).createProfile(
                    session,
                    params['profileKey'],
                    params['name'],
                    params['description'],
                    params['mcuFamily'],
                    params['features'],
                  ),
        ),
        'updateProfile': _i1.MethodConnector(
          name: 'updateProfile',
          params: {
            'profileKey': _i1.ParameterDescription(
              name: 'profileKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'mcuFamily': _i1.ParameterDescription(
              name: 'mcuFamily',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'features': _i1.ParameterDescription(
              name: 'features',
              type: _i1.getType<List<_i22.DeviceFeature>>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['device'] as _i8.DeviceEndpoint).updateProfile(
                    session,
                    params['profileKey'],
                    params['name'],
                    params['description'],
                    params['mcuFamily'],
                    params['features'],
                    params['email'],
                    params['password'],
                  ),
        ),
        'applyProfileToDevices': _i1.MethodConnector(
          name: 'applyProfileToDevices',
          params: {
            'profileKey': _i1.ParameterDescription(
              name: 'profileKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['device'] as _i8.DeviceEndpoint)
                  .applyProfileToDevices(
                    session,
                    params['profileKey'],
                  ),
        ),
        'deleteProfile': _i1.MethodConnector(
          name: 'deleteProfile',
          params: {
            'profileKey': _i1.ParameterDescription(
              name: 'profileKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['device'] as _i8.DeviceEndpoint).deleteProfile(
                    session,
                    params['profileKey'],
                    params['email'],
                    params['password'],
                  ),
        ),
        'verifyDestructivePassword': _i1.MethodConnector(
          name: 'verifyDestructivePassword',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['device'] as _i8.DeviceEndpoint)
                  .verifyDestructivePassword(
                    session,
                    params['email'],
                    params['password'],
                  ),
        ),
        'createDevice': _i1.MethodConnector(
          name: 'createDevice',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'gatewayId': _i1.ParameterDescription(
              name: 'gatewayId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'model': _i1.ParameterDescription(
              name: 'model',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'deviceType': _i1.ParameterDescription(
              name: 'deviceType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'expectedIntervalSeconds': _i1.ParameterDescription(
              name: 'expectedIntervalSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['device'] as _i8.DeviceEndpoint).createDevice(
                    session,
                    params['siteId'],
                    params['gatewayId'],
                    params['name'],
                    params['model'],
                    params['deviceType'],
                    params['expectedIntervalSeconds'],
                  ),
        ),
        'updateDevice': _i1.MethodConnector(
          name: 'updateDevice',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'model': _i1.ParameterDescription(
              name: 'model',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'expectedIntervalSeconds': _i1.ParameterDescription(
              name: 'expectedIntervalSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['device'] as _i8.DeviceEndpoint).updateDevice(
                    session,
                    params['deviceId'],
                    params['name'],
                    params['model'],
                    params['expectedIntervalSeconds'],
                  ),
        ),
        'updateMapPosition': _i1.MethodConnector(
          name: 'updateMapPosition',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'mapX': _i1.ParameterDescription(
              name: 'mapX',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'mapY': _i1.ParameterDescription(
              name: 'mapY',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['device'] as _i8.DeviceEndpoint).updateMapPosition(
                    session,
                    params['deviceId'],
                    params['mapX'],
                    params['mapY'],
                  ),
        ),
        'deleteDevice': _i1.MethodConnector(
          name: 'deleteDevice',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['device'] as _i8.DeviceEndpoint).deleteDevice(
                    session,
                    params['deviceId'],
                    params['email'],
                    params['password'],
                  ),
        ),
        'listBySite': _i1.MethodConnector(
          name: 'listBySite',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['device'] as _i8.DeviceEndpoint).listBySite(
                session,
                params['siteId'],
              ),
        ),
        'getDevice': _i1.MethodConnector(
          name: 'getDevice',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['device'] as _i8.DeviceEndpoint).getDevice(
                session,
                params['deviceId'],
              ),
        ),
      },
    );
    connectors['gateway'] = _i1.EndpointConnector(
      name: 'gateway',
      endpoint: endpoints['gateway']!,
      methodConnectors: {
        'createGateway': _i1.MethodConnector(
          name: 'createGateway',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'serialNumber': _i1.ParameterDescription(
              name: 'serialNumber',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['gateway'] as _i9.GatewayEndpoint).createGateway(
                    session,
                    params['siteId'],
                    params['serialNumber'],
                    params['name'],
                  ),
        ),
        'updateGateway': _i1.MethodConnector(
          name: 'updateGateway',
          params: {
            'gatewayId': _i1.ParameterDescription(
              name: 'gatewayId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['gateway'] as _i9.GatewayEndpoint).updateGateway(
                    session,
                    params['gatewayId'],
                    params['name'],
                  ),
        ),
        'deleteGateway': _i1.MethodConnector(
          name: 'deleteGateway',
          params: {
            'gatewayId': _i1.ParameterDescription(
              name: 'gatewayId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['gateway'] as _i9.GatewayEndpoint).deleteGateway(
                    session,
                    params['gatewayId'],
                  ),
        ),
        'listBySite': _i1.MethodConnector(
          name: 'listBySite',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['gateway'] as _i9.GatewayEndpoint).listBySite(
                    session,
                    params['siteId'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i10.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    connectors['operations'] = _i1.EndpointConnector(
      name: 'operations',
      endpoint: endpoints['operations']!,
      methodConnectors: {
        'listAutomationRules': _i1.MethodConnector(
          name: 'listAutomationRules',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['operations'] as _i11.OperationsEndpoint)
                  .listAutomationRules(session),
        ),
        'listAutomationDevices': _i1.MethodConnector(
          name: 'listAutomationDevices',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['operations'] as _i11.OperationsEndpoint)
                  .listAutomationDevices(session),
        ),
        'createAutomationRule': _i1.MethodConnector(
          name: 'createAutomationRule',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'triggerDeviceId': _i1.ParameterDescription(
              name: 'triggerDeviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'triggerFeatureKey': _i1.ParameterDescription(
              name: 'triggerFeatureKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'comparison': _i1.ParameterDescription(
              name: 'comparison',
              type: _i1.getType<_i18.AlertComparison>(),
              nullable: false,
            ),
            'threshold': _i1.ParameterDescription(
              name: 'threshold',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'recoveryThreshold': _i1.ParameterDescription(
              name: 'recoveryThreshold',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'actionDeviceId': _i1.ParameterDescription(
              name: 'actionDeviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'actionFeatureKey': _i1.ParameterDescription(
              name: 'actionFeatureKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'actionValue': _i1.ParameterDescription(
              name: 'actionValue',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'pulseOnSeconds': _i1.ParameterDescription(
              name: 'pulseOnSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'intervalSeconds': _i1.ParameterDescription(
              name: 'intervalSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'maxRepeats': _i1.ParameterDescription(
              name: 'maxRepeats',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'mixingDelaySeconds': _i1.ParameterDescription(
              name: 'mixingDelaySeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['operations'] as _i11.OperationsEndpoint)
                  .createAutomationRule(
                    session,
                    params['name'],
                    params['triggerDeviceId'],
                    params['triggerFeatureKey'],
                    params['comparison'],
                    params['threshold'],
                    params['recoveryThreshold'],
                    params['actionDeviceId'],
                    params['actionFeatureKey'],
                    params['actionValue'],
                    params['pulseOnSeconds'],
                    params['intervalSeconds'],
                    params['maxRepeats'],
                    params['mixingDelaySeconds'],
                  ),
        ),
        'saveAdvancedAutomationRule': _i1.MethodConnector(
          name: 'saveAdvancedAutomationRule',
          params: {
            'ruleId': _i1.ParameterDescription(
              name: 'ruleId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'branches': _i1.ParameterDescription(
              name: 'branches',
              type: _i1.getType<List<_i23.AutomationBranch>>(),
              nullable: false,
            ),
            'sensorTimeoutSeconds': _i1.ParameterDescription(
              name: 'sensorTimeoutSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'cooldownSeconds': _i1.ParameterDescription(
              name: 'cooldownSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'maxRepeats': _i1.ParameterDescription(
              name: 'maxRepeats',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'mixingDelaySeconds': _i1.ParameterDescription(
              name: 'mixingDelaySeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['operations'] as _i11.OperationsEndpoint)
                  .saveAdvancedAutomationRule(
                    session,
                    params['ruleId'],
                    params['name'],
                    params['branches'],
                    params['sensorTimeoutSeconds'],
                    params['cooldownSeconds'],
                    params['maxRepeats'],
                    params['mixingDelaySeconds'],
                  ),
        ),
        'setAutomationEnabled': _i1.MethodConnector(
          name: 'setAutomationEnabled',
          params: {
            'ruleId': _i1.ParameterDescription(
              name: 'ruleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'enabled': _i1.ParameterDescription(
              name: 'enabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['operations'] as _i11.OperationsEndpoint)
                  .setAutomationEnabled(
                    session,
                    params['ruleId'],
                    params['enabled'],
                  ),
        ),
        'updateAutomationRule': _i1.MethodConnector(
          name: 'updateAutomationRule',
          params: {
            'ruleId': _i1.ParameterDescription(
              name: 'ruleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'triggerDeviceId': _i1.ParameterDescription(
              name: 'triggerDeviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'triggerFeatureKey': _i1.ParameterDescription(
              name: 'triggerFeatureKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'comparison': _i1.ParameterDescription(
              name: 'comparison',
              type: _i1.getType<_i18.AlertComparison>(),
              nullable: false,
            ),
            'threshold': _i1.ParameterDescription(
              name: 'threshold',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'recoveryThreshold': _i1.ParameterDescription(
              name: 'recoveryThreshold',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'actionDeviceId': _i1.ParameterDescription(
              name: 'actionDeviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'actionFeatureKey': _i1.ParameterDescription(
              name: 'actionFeatureKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'actionValue': _i1.ParameterDescription(
              name: 'actionValue',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'pulseOnSeconds': _i1.ParameterDescription(
              name: 'pulseOnSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'intervalSeconds': _i1.ParameterDescription(
              name: 'intervalSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'maxRepeats': _i1.ParameterDescription(
              name: 'maxRepeats',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'mixingDelaySeconds': _i1.ParameterDescription(
              name: 'mixingDelaySeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['operations'] as _i11.OperationsEndpoint)
                  .updateAutomationRule(
                    session,
                    params['ruleId'],
                    params['name'],
                    params['triggerDeviceId'],
                    params['triggerFeatureKey'],
                    params['comparison'],
                    params['threshold'],
                    params['recoveryThreshold'],
                    params['actionDeviceId'],
                    params['actionFeatureKey'],
                    params['actionValue'],
                    params['pulseOnSeconds'],
                    params['intervalSeconds'],
                    params['maxRepeats'],
                    params['mixingDelaySeconds'],
                  ),
        ),
        'deleteAutomationRule': _i1.MethodConnector(
          name: 'deleteAutomationRule',
          params: {
            'ruleId': _i1.ParameterDescription(
              name: 'ruleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['operations'] as _i11.OperationsEndpoint)
                  .deleteAutomationRule(
                    session,
                    params['ruleId'],
                  ),
        ),
        'listAutomationRuns': _i1.MethodConnector(
          name: 'listAutomationRuns',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['operations'] as _i11.OperationsEndpoint)
                  .listAutomationRuns(session),
        ),
        'listAuditLogs': _i1.MethodConnector(
          name: 'listAuditLogs',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['operations'] as _i11.OperationsEndpoint)
                  .listAuditLogs(
                    session,
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['ota'] = _i1.EndpointConnector(
      name: 'ota',
      endpoint: endpoints['ota']!,
      methodConnectors: {
        'canManageFirmware': _i1.MethodConnector(
          name: 'canManageFirmware',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ota'] as _i12.OtaEndpoint)
                  .canManageFirmware(session),
        ),
        'listFirmwarePackages': _i1.MethodConnector(
          name: 'listFirmwarePackages',
          params: {
            'deviceType': _i1.ParameterDescription(
              name: 'deviceType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).listFirmwarePackages(
                    session,
                    deviceType: params['deviceType'],
                  ),
        ),
        'listFirmwareReleases': _i1.MethodConnector(
          name: 'listFirmwareReleases',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ota'] as _i12.OtaEndpoint)
                  .listFirmwareReleases(session),
        ),
        'createFirmwarePackage': _i1.MethodConnector(
          name: 'createFirmwarePackage',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetDeviceType': _i1.ParameterDescription(
              name: 'targetDeviceType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'hardwareRevision': _i1.ParameterDescription(
              name: 'hardwareRevision',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'releaseNotes': _i1.ParameterDescription(
              name: 'releaseNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'downloadUrl': _i1.ParameterDescription(
              name: 'downloadUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sha256': _i1.ParameterDescription(
              name: 'sha256',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sizeBytes': _i1.ParameterDescription(
              name: 'sizeBytes',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).createFirmwarePackage(
                    session,
                    params['name'],
                    params['version'],
                    params['targetDeviceType'],
                    params['hardwareRevision'],
                    params['releaseNotes'],
                    params['downloadUrl'],
                    params['sha256'],
                    params['sizeBytes'],
                  ),
        ),
        'importFirmwareBinary': _i1.MethodConnector(
          name: 'importFirmwareBinary',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetDeviceType': _i1.ParameterDescription(
              name: 'targetDeviceType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'hardwareRevision': _i1.ParameterDescription(
              name: 'hardwareRevision',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'releaseNotes': _i1.ParameterDescription(
              name: 'releaseNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'fileName': _i1.ParameterDescription(
              name: 'fileName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).importFirmwareBinary(
                    session,
                    params['name'],
                    params['version'],
                    params['targetDeviceType'],
                    params['hardwareRevision'],
                    params['releaseNotes'],
                    params['fileName'],
                  ),
        ),
        'uploadFirmwareRelease': _i1.MethodConnector(
          name: 'uploadFirmwareRelease',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'productKey': _i1.ParameterDescription(
              name: 'productKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetDeviceType': _i1.ParameterDescription(
              name: 'targetDeviceType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'chipFamily': _i1.ParameterDescription(
              name: 'chipFamily',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'updateProtocol': _i1.ParameterDescription(
              name: 'updateProtocol',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'hardwareRevision': _i1.ParameterDescription(
              name: 'hardwareRevision',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'releaseNotes': _i1.ParameterDescription(
              name: 'releaseNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'fileNames': _i1.ParameterDescription(
              name: 'fileNames',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'fileContents': _i1.ParameterDescription(
              name: 'fileContents',
              type: _i1.getType<List<_i24.ByteData>>(),
              nullable: false,
            ),
            'primaryFileIndex': _i1.ParameterDescription(
              name: 'primaryFileIndex',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).uploadFirmwareRelease(
                    session,
                    params['name'],
                    params['version'],
                    params['productKey'],
                    params['targetDeviceType'],
                    params['chipFamily'],
                    params['updateProtocol'],
                    params['hardwareRevision'],
                    params['releaseNotes'],
                    params['fileNames'],
                    params['fileContents'],
                    params['primaryFileIndex'],
                  ),
        ),
        'importFirmwareRelease': _i1.MethodConnector(
          name: 'importFirmwareRelease',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'productKey': _i1.ParameterDescription(
              name: 'productKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetDeviceType': _i1.ParameterDescription(
              name: 'targetDeviceType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'chipFamily': _i1.ParameterDescription(
              name: 'chipFamily',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'updateProtocol': _i1.ParameterDescription(
              name: 'updateProtocol',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'hardwareRevision': _i1.ParameterDescription(
              name: 'hardwareRevision',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'releaseNotes': _i1.ParameterDescription(
              name: 'releaseNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'fileNames': _i1.ParameterDescription(
              name: 'fileNames',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'primaryFileName': _i1.ParameterDescription(
              name: 'primaryFileName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).importFirmwareRelease(
                    session,
                    params['name'],
                    params['version'],
                    params['productKey'],
                    params['targetDeviceType'],
                    params['chipFamily'],
                    params['updateProtocol'],
                    params['hardwareRevision'],
                    params['releaseNotes'],
                    params['fileNames'],
                    params['primaryFileName'],
                  ),
        ),
        'deleteFirmwareArtifact': _i1.MethodConnector(
          name: 'deleteFirmwareArtifact',
          params: {
            'artifactId': _i1.ParameterDescription(
              name: 'artifactId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).deleteFirmwareArtifact(
                    session,
                    params['artifactId'],
                  ),
        ),
        'deleteFirmwareBinary': _i1.MethodConnector(
          name: 'deleteFirmwareBinary',
          params: {
            'packageId': _i1.ParameterDescription(
              name: 'packageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).deleteFirmwareBinary(
                    session,
                    params['packageId'],
                  ),
        ),
        'listCampaigns': _i1.MethodConnector(
          name: 'listCampaigns',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).listCampaigns(session),
        ),
        'listTargets': _i1.MethodConnector(
          name: 'listTargets',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).listTargets(session),
        ),
        'getActiveDeviceCampaign': _i1.MethodConnector(
          name: 'getActiveDeviceCampaign',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ota'] as _i12.OtaEndpoint)
                  .getActiveDeviceCampaign(
                    session,
                    params['deviceId'],
                  ),
        ),
        'createTargetCampaign': _i1.MethodConnector(
          name: 'createTargetCampaign',
          params: {
            'firmwarePackageId': _i1.ParameterDescription(
              name: 'firmwarePackageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'strategy': _i1.ParameterDescription(
              name: 'strategy',
              type: _i1.getType<_i25.OtaStrategy>(),
              nullable: false,
            ),
            'targetKeys': _i1.ParameterDescription(
              name: 'targetKeys',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).createTargetCampaign(
                    session,
                    params['firmwarePackageId'],
                    params['name'],
                    params['strategy'],
                    params['targetKeys'],
                    params['scheduledAt'],
                  ),
        ),
        'createCampaign': _i1.MethodConnector(
          name: 'createCampaign',
          params: {
            'firmwarePackageId': _i1.ParameterDescription(
              name: 'firmwarePackageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'strategy': _i1.ParameterDescription(
              name: 'strategy',
              type: _i1.getType<_i25.OtaStrategy>(),
              nullable: false,
            ),
            'targetDeviceIds': _i1.ParameterDescription(
              name: 'targetDeviceIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ota'] as _i12.OtaEndpoint).createCampaign(
                session,
                params['firmwarePackageId'],
                params['name'],
                params['strategy'],
                params['targetDeviceIds'],
                params['scheduledAt'],
              ),
        ),
        'getCampaign': _i1.MethodConnector(
          name: 'getCampaign',
          params: {
            'campaignId': _i1.ParameterDescription(
              name: 'campaignId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ota'] as _i12.OtaEndpoint).getCampaign(
                session,
                params['campaignId'],
              ),
        ),
        'stopStalledCampaign': _i1.MethodConnector(
          name: 'stopStalledCampaign',
          params: {
            'campaignId': _i1.ParameterDescription(
              name: 'campaignId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'expectedState': _i1.ParameterDescription(
              name: 'expectedState',
              type: _i1.getType<_i26.OtaJobState>(),
              nullable: false,
            ),
            'expectedProgress': _i1.ParameterDescription(
              name: 'expectedProgress',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).stopStalledCampaign(
                    session,
                    params['campaignId'],
                    params['deviceId'],
                    params['expectedState'],
                    params['expectedProgress'],
                  ),
        ),
        'startCampaign': _i1.MethodConnector(
          name: 'startCampaign',
          params: {
            'campaignId': _i1.ParameterDescription(
              name: 'campaignId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ota'] as _i12.OtaEndpoint).startCampaign(
                session,
                params['campaignId'],
              ),
        ),
        'restartSimulation': _i1.MethodConnector(
          name: 'restartSimulation',
          params: {
            'campaignId': _i1.ParameterDescription(
              name: 'campaignId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).restartSimulation(
                    session,
                    params['campaignId'],
                  ),
        ),
        'advanceSimulation': _i1.MethodConnector(
          name: 'advanceSimulation',
          params: {
            'campaignId': _i1.ParameterDescription(
              name: 'campaignId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['ota'] as _i12.OtaEndpoint).advanceSimulation(
                    session,
                    params['campaignId'],
                  ),
        ),
      },
    );
    connectors['production'] = _i1.EndpointConnector(
      name: 'production',
      endpoint: endpoints['production']!,
      methodConnectors: {
        'getSummary': _i1.MethodConnector(
          name: 'getSummary',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .getSummary(session),
        ),
        'listMaterials': _i1.MethodConnector(
          name: 'listMaterials',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listMaterials(session),
        ),
        'saveMaterial': _i1.MethodConnector(
          name: 'saveMaterial',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i27.MaterialType>(),
              nullable: false,
            ),
            'unit': _i1.ParameterDescription(
              name: 'unit',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'specification': _i1.ParameterDescription(
              name: 'specification',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'supplier': _i1.ParameterDescription(
              name: 'supplier',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'safetyStock': _i1.ParameterDescription(
              name: 'safetyStock',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'active': _i1.ParameterDescription(
              name: 'active',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .saveMaterial(
                    session,
                    params['id'],
                    params['code'],
                    params['name'],
                    params['type'],
                    params['unit'],
                    params['specification'],
                    params['supplier'],
                    params['safetyStock'],
                    params['active'],
                  ),
        ),
        'deleteMaterial': _i1.MethodConnector(
          name: 'deleteMaterial',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .deleteMaterial(
                    session,
                    params['id'],
                  ),
        ),
        'listMaterialLots': _i1.MethodConnector(
          name: 'listMaterialLots',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listMaterialLots(
                    session,
                    materialId: params['materialId'],
                  ),
        ),
        'saveMaterialLot': _i1.MethodConnector(
          name: 'saveMaterialLot',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'lotNumber': _i1.ParameterDescription(
              name: 'lotNumber',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'quantity': _i1.ParameterDescription(
              name: 'quantity',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'receivedAt': _i1.ParameterDescription(
              name: 'receivedAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'expiresAt': _i1.ParameterDescription(
              name: 'expiresAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'supplierLot': _i1.ParameterDescription(
              name: 'supplierLot',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'qrCode': _i1.ParameterDescription(
              name: 'qrCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'rfidEpc': _i1.ParameterDescription(
              name: 'rfidEpc',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .saveMaterialLot(
                    session,
                    params['id'],
                    params['materialId'],
                    params['lotNumber'],
                    params['quantity'],
                    params['receivedAt'],
                    params['expiresAt'],
                    params['supplierLot'],
                    params['qrCode'],
                    params['rfidEpc'],
                  ),
        ),
        'deleteMaterialLot': _i1.MethodConnector(
          name: 'deleteMaterialLot',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .deleteMaterialLot(
                    session,
                    params['id'],
                  ),
        ),
        'listProducts': _i1.MethodConnector(
          name: 'listProducts',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listProducts(session),
        ),
        'saveProduct': _i1.MethodConnector(
          name: 'saveProduct',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'unit': _i1.ParameterDescription(
              name: 'unit',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'specification': _i1.ParameterDescription(
              name: 'specification',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'active': _i1.ParameterDescription(
              name: 'active',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .saveProduct(
                    session,
                    params['id'],
                    params['code'],
                    params['name'],
                    params['unit'],
                    params['specification'],
                    params['active'],
                  ),
        ),
        'deleteProduct': _i1.MethodConnector(
          name: 'deleteProduct',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .deleteProduct(
                    session,
                    params['id'],
                  ),
        ),
        'listBom': _i1.MethodConnector(
          name: 'listBom',
          params: {
            'productId': _i1.ParameterDescription(
              name: 'productId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['production'] as _i13.ProductionEndpoint).listBom(
                    session,
                    params['productId'],
                  ),
        ),
        'saveBomItem': _i1.MethodConnector(
          name: 'saveBomItem',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'productId': _i1.ParameterDescription(
              name: 'productId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'quantity': _i1.ParameterDescription(
              name: 'quantity',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'unit': _i1.ParameterDescription(
              name: 'unit',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scrapRatePercent': _i1.ParameterDescription(
              name: 'scrapRatePercent',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .saveBomItem(
                    session,
                    params['id'],
                    params['productId'],
                    params['materialId'],
                    params['quantity'],
                    params['unit'],
                    params['scrapRatePercent'],
                    params['note'],
                  ),
        ),
        'deleteBomItem': _i1.MethodConnector(
          name: 'deleteBomItem',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .deleteBomItem(
                    session,
                    params['id'],
                  ),
        ),
        'listRoutes': _i1.MethodConnector(
          name: 'listRoutes',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listRoutes(session),
        ),
        'listProductionLines': _i1.MethodConnector(
          name: 'listProductionLines',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listProductionLines(session),
        ),
        'saveProductionLine': _i1.MethodConnector(
          name: 'saveProductionLine',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'active': _i1.ParameterDescription(
              name: 'active',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .saveProductionLine(
                    session,
                    params['id'],
                    params['code'],
                    params['name'],
                    params['description'],
                    params['active'],
                  ),
        ),
        'deleteProductionLine': _i1.MethodConnector(
          name: 'deleteProductionLine',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .deleteProductionLine(
                    session,
                    params['id'],
                  ),
        ),
        'listWorkstations': _i1.MethodConnector(
          name: 'listWorkstations',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listWorkstations(session),
        ),
        'saveWorkstation': _i1.MethodConnector(
          name: 'saveWorkstation',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'productionLineId': _i1.ParameterDescription(
              name: 'productionLineId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'active': _i1.ParameterDescription(
              name: 'active',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .saveWorkstation(
                    session,
                    params['id'],
                    params['productionLineId'],
                    params['code'],
                    params['name'],
                    params['description'],
                    params['active'],
                  ),
        ),
        'deleteWorkstation': _i1.MethodConnector(
          name: 'deleteWorkstation',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .deleteWorkstation(
                    session,
                    params['id'],
                  ),
        ),
        'listWorkstationAssignments': _i1.MethodConnector(
          name: 'listWorkstationAssignments',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listWorkstationAssignments(session),
        ),
        'assignWorkstation': _i1.MethodConnector(
          name: 'assignWorkstation',
          params: {
            'workstationId': _i1.ParameterDescription(
              name: 'workstationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'membershipId': _i1.ParameterDescription(
              name: 'membershipId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .assignWorkstation(
                    session,
                    params['workstationId'],
                    params['membershipId'],
                  ),
        ),
        'removeWorkstationAssignment': _i1.MethodConnector(
          name: 'removeWorkstationAssignment',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .removeWorkstationAssignment(
                    session,
                    params['id'],
                  ),
        ),
        'listMyWorkstations': _i1.MethodConnector(
          name: 'listMyWorkstations',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listMyWorkstations(session),
        ),
        'listMyPendingTransfers': _i1.MethodConnector(
          name: 'listMyPendingTransfers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listMyPendingTransfers(session),
        ),
        'dispatchLineTransfer': _i1.MethodConnector(
          name: 'dispatchLineTransfer',
          params: {
            'transferId': _i1.ParameterDescription(
              name: 'transferId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .dispatchLineTransfer(
                    session,
                    params['transferId'],
                  ),
        ),
        'receiveLineTransfer': _i1.MethodConnector(
          name: 'receiveLineTransfer',
          params: {
            'transferId': _i1.ParameterDescription(
              name: 'transferId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .receiveLineTransfer(
                    session,
                    params['transferId'],
                  ),
        ),
        'saveRoute': _i1.MethodConnector(
          name: 'saveRoute',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'productId': _i1.ParameterDescription(
              name: 'productId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'version': _i1.ParameterDescription(
              name: 'version',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'active': _i1.ParameterDescription(
              name: 'active',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .saveRoute(
                    session,
                    params['id'],
                    params['productId'],
                    params['code'],
                    params['name'],
                    params['version'],
                    params['active'],
                  ),
        ),
        'deleteRoute': _i1.MethodConnector(
          name: 'deleteRoute',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .deleteRoute(
                    session,
                    params['id'],
                  ),
        ),
        'listProcessNodes': _i1.MethodConnector(
          name: 'listProcessNodes',
          params: {
            'routeId': _i1.ParameterDescription(
              name: 'routeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listProcessNodes(
                    session,
                    params['routeId'],
                  ),
        ),
        'saveProcessNode': _i1.MethodConnector(
          name: 'saveProcessNode',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'routeId': _i1.ParameterDescription(
              name: 'routeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'sequence': _i1.ParameterDescription(
              name: 'sequence',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'stationCode': _i1.ParameterDescription(
              name: 'stationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'standardSeconds': _i1.ParameterDescription(
              name: 'standardSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'scanMode': _i1.ParameterDescription(
              name: 'scanMode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'allowSkip': _i1.ParameterDescription(
              name: 'allowSkip',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'allowRework': _i1.ParameterDescription(
              name: 'allowRework',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'measurementRequirements': _i1.ParameterDescription(
              name: 'measurementRequirements',
              type: _i1.getType<Map<String, String>?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .saveProcessNode(
                    session,
                    params['id'],
                    params['routeId'],
                    params['sequence'],
                    params['code'],
                    params['name'],
                    params['stationCode'],
                    params['standardSeconds'],
                    params['scanMode'],
                    params['allowSkip'],
                    params['allowRework'],
                    params['measurementRequirements'],
                  ),
        ),
        'deleteProcessNode': _i1.MethodConnector(
          name: 'deleteProcessNode',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .deleteProcessNode(
                    session,
                    params['id'],
                  ),
        ),
        'listProductionOrders': _i1.MethodConnector(
          name: 'listProductionOrders',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listProductionOrders(session),
        ),
        'createProductionOrder': _i1.MethodConnector(
          name: 'createProductionOrder',
          params: {
            'orderNumber': _i1.ParameterDescription(
              name: 'orderNumber',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'productId': _i1.ParameterDescription(
              name: 'productId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'routeId': _i1.ParameterDescription(
              name: 'routeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'plannedQuantity': _i1.ParameterDescription(
              name: 'plannedQuantity',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'scheduledStart': _i1.ParameterDescription(
              name: 'scheduledStart',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'scheduledEnd': _i1.ParameterDescription(
              name: 'scheduledEnd',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .createProductionOrder(
                    session,
                    params['orderNumber'],
                    params['productId'],
                    params['routeId'],
                    params['plannedQuantity'],
                    params['scheduledStart'],
                    params['scheduledEnd'],
                  ),
        ),
        'setProductionOrderStatus': _i1.MethodConnector(
          name: 'setProductionOrderStatus',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i28.ProductionOrderStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .setProductionOrderStatus(
                    session,
                    params['id'],
                    params['status'],
                  ),
        ),
        'deleteProductionOrder': _i1.MethodConnector(
          name: 'deleteProductionOrder',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .deleteProductionOrder(
                    session,
                    params['id'],
                  ),
        ),
        'listProductUnits': _i1.MethodConnector(
          name: 'listProductUnits',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .listProductUnits(
                    session,
                    orderId: params['orderId'],
                  ),
        ),
        'generateProductUnits': _i1.MethodConnector(
          name: 'generateProductUnits',
          params: {
            'orderId': _i1.ParameterDescription(
              name: 'orderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'quantity': _i1.ParameterDescription(
              name: 'quantity',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'serialPrefix': _i1.ParameterDescription(
              name: 'serialPrefix',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .generateProductUnits(
                    session,
                    params['orderId'],
                    params['quantity'],
                    params['serialPrefix'],
                  ),
        ),
        'recordWorkstationEvent': _i1.MethodConnector(
          name: 'recordWorkstationEvent',
          params: {
            'clientEventId': _i1.ParameterDescription(
              name: 'clientEventId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'workstationId': _i1.ParameterDescription(
              name: 'workstationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'productIdentifier': _i1.ParameterDescription(
              name: 'productIdentifier',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<_i29.ProcessEventType>(),
              nullable: false,
            ),
            'result': _i1.ParameterDescription(
              name: 'result',
              type: _i1.getType<_i30.ProcessResult>(),
              nullable: false,
            ),
            'occurredAt': _i1.ParameterDescription(
              name: 'occurredAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'materialLotIds': _i1.ParameterDescription(
              name: 'materialLotIds',
              type: _i1.getType<List<int>?>(),
              nullable: true,
            ),
            'measurements': _i1.ParameterDescription(
              name: 'measurements',
              type: _i1.getType<Map<String, double>?>(),
              nullable: true,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .recordWorkstationEvent(
                    session,
                    params['clientEventId'],
                    params['workstationId'],
                    params['productIdentifier'],
                    params['eventType'],
                    params['result'],
                    params['occurredAt'],
                    materialLotIds: params['materialLotIds'],
                    measurements: params['measurements'],
                    note: params['note'],
                  ),
        ),
        'recordProcessEvent': _i1.MethodConnector(
          name: 'recordProcessEvent',
          params: {
            'clientEventId': _i1.ParameterDescription(
              name: 'clientEventId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'productIdentifier': _i1.ParameterDescription(
              name: 'productIdentifier',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'processNodeId': _i1.ParameterDescription(
              name: 'processNodeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<_i29.ProcessEventType>(),
              nullable: false,
            ),
            'result': _i1.ParameterDescription(
              name: 'result',
              type: _i1.getType<_i30.ProcessResult>(),
              nullable: false,
            ),
            'occurredAt': _i1.ParameterDescription(
              name: 'occurredAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'materialLotIds': _i1.ParameterDescription(
              name: 'materialLotIds',
              type: _i1.getType<List<int>?>(),
              nullable: true,
            ),
            'measurements': _i1.ParameterDescription(
              name: 'measurements',
              type: _i1.getType<Map<String, double>?>(),
              nullable: true,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .recordProcessEvent(
                    session,
                    params['clientEventId'],
                    params['productIdentifier'],
                    params['processNodeId'],
                    params['eventType'],
                    params['result'],
                    params['occurredAt'],
                    deviceId: params['deviceId'],
                    materialLotIds: params['materialLotIds'],
                    measurements: params['measurements'],
                    note: params['note'],
                  ),
        ),
        'getProductTrace': _i1.MethodConnector(
          name: 'getProductTrace',
          params: {
            'identifier': _i1.ParameterDescription(
              name: 'identifier',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['production'] as _i13.ProductionEndpoint)
                  .getProductTrace(
                    session,
                    params['identifier'],
                  ),
        ),
      },
    );
    connectors['provisioning'] = _i1.EndpointConnector(
      name: 'provisioning',
      endpoint: endpoints['provisioning']!,
      methodConnectors: {
        'listDevices': _i1.MethodConnector(
          name: 'listDevices',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['provisioning'] as _i14.ProvisioningEndpoint)
                      .listDevices(session),
        ),
        'beginManufacturerPairing': _i1.MethodConnector(
          name: 'beginManufacturerPairing',
          params: {
            'serial': _i1.ParameterDescription(
              name: 'serial',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['provisioning'] as _i14.ProvisioningEndpoint)
                      .beginManufacturerPairing(
                        session,
                        params['serial'],
                      ),
        ),
        'simulateDeviceProvision': _i1.MethodConnector(
          name: 'simulateDeviceProvision',
          params: {
            'claimSessionId': _i1.ParameterDescription(
              name: 'claimSessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['provisioning'] as _i14.ProvisioningEndpoint)
                      .simulateDeviceProvision(
                        session,
                        params['claimSessionId'],
                      ),
        ),
        'listUnlinkedDevices': _i1.MethodConnector(
          name: 'listUnlinkedDevices',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['provisioning'] as _i14.ProvisioningEndpoint)
                      .listUnlinkedDevices(session),
        ),
        'attachToPlatform': _i1.MethodConnector(
          name: 'attachToPlatform',
          params: {
            'serial': _i1.ParameterDescription(
              name: 'serial',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'gatewayId': _i1.ParameterDescription(
              name: 'gatewayId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'expectedIntervalSeconds': _i1.ParameterDescription(
              name: 'expectedIntervalSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'model': _i1.ParameterDescription(
              name: 'model',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['provisioning'] as _i14.ProvisioningEndpoint)
                      .attachToPlatform(
                        session,
                        params['serial'],
                        params['siteId'],
                        params['gatewayId'],
                        params['name'],
                        params['profileId'],
                        params['expectedIntervalSeconds'],
                        params['model'],
                      ),
        ),
        'listCertificates': _i1.MethodConnector(
          name: 'listCertificates',
          params: {
            'serial': _i1.ParameterDescription(
              name: 'serial',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['provisioning'] as _i14.ProvisioningEndpoint)
                      .listCertificates(
                        session,
                        params['serial'],
                      ),
        ),
        'revokeCertificate': _i1.MethodConnector(
          name: 'revokeCertificate',
          params: {
            'certificateId': _i1.ParameterDescription(
              name: 'certificateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['provisioning'] as _i14.ProvisioningEndpoint)
                      .revokeCertificate(
                        session,
                        params['certificateId'],
                      ),
        ),
        'resetDevice': _i1.MethodConnector(
          name: 'resetDevice',
          params: {
            'serial': _i1.ParameterDescription(
              name: 'serial',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['provisioning'] as _i14.ProvisioningEndpoint)
                      .resetDevice(
                        session,
                        params['serial'],
                      ),
        ),
      },
    );
    connectors['site'] = _i1.EndpointConnector(
      name: 'site',
      endpoint: endpoints['site']!,
      methodConnectors: {
        'createSite': _i1.MethodConnector(
          name: 'createSite',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['site'] as _i15.SiteEndpoint).createSite(
                session,
                params['name'],
                params['description'],
              ),
        ),
        'updateSite': _i1.MethodConnector(
          name: 'updateSite',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['site'] as _i15.SiteEndpoint).updateSite(
                session,
                params['siteId'],
                params['name'],
                params['description'],
              ),
        ),
        'deleteSite': _i1.MethodConnector(
          name: 'deleteSite',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['site'] as _i15.SiteEndpoint).deleteSite(
                session,
                params['siteId'],
              ),
        ),
        'listSites': _i1.MethodConnector(
          name: 'listSites',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['site'] as _i15.SiteEndpoint).listSites(session),
        ),
        'getSite': _i1.MethodConnector(
          name: 'getSite',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['site'] as _i15.SiteEndpoint).getSite(
                session,
                params['siteId'],
              ),
        ),
      },
    );
    connectors['telemetry'] = _i1.EndpointConnector(
      name: 'telemetry',
      endpoint: endpoints['telemetry']!,
      methodConnectors: {
        'listSiteStatuses': _i1.MethodConnector(
          name: 'listSiteStatuses',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['telemetry'] as _i16.TelemetryEndpoint)
                  .listSiteStatuses(
                    session,
                    params['siteId'],
                  ),
        ),
        'listMeasurements': _i1.MethodConnector(
          name: 'listMeasurements',
          params: {
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'featureKey': _i1.ParameterDescription(
              name: 'featureKey',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'cursorId': _i1.ParameterDescription(
              name: 'cursorId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'startAt': _i1.ParameterDescription(
              name: 'startAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endAt': _i1.ParameterDescription(
              name: 'endAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['telemetry'] as _i16.TelemetryEndpoint)
                  .listMeasurements(
                    session,
                    params['deviceId'],
                    featureKey: params['featureKey'],
                    limit: params['limit'],
                    cursorId: params['cursorId'],
                    startAt: params['startAt'],
                    endAt: params['endAt'],
                  ),
        ),
        'watchSiteStatus': _i1.MethodStreamConnector(
          name: 'watchSiteStatus',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['telemetry'] as _i16.TelemetryEndpoint)
                  .watchSiteStatus(
                    session,
                    params['siteId'],
                  ),
        ),
      },
    );
    connectors['workOrder'] = _i1.EndpointConnector(
      name: 'workOrder',
      endpoint: endpoints['workOrder']!,
      methodConnectors: {
        'createWorkOrder': _i1.MethodConnector(
          name: 'createWorkOrder',
          params: {
            'siteId': _i1.ParameterDescription(
              name: 'siteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<_i31.WorkOrderPriority>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workOrder'] as _i17.WorkOrderEndpoint)
                  .createWorkOrder(
                    session,
                    params['siteId'],
                    params['deviceId'],
                    params['title'],
                    params['description'],
                    params['priority'],
                  ),
        ),
        'createFromAlert': _i1.MethodConnector(
          name: 'createFromAlert',
          params: {
            'alertId': _i1.ParameterDescription(
              name: 'alertId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workOrder'] as _i17.WorkOrderEndpoint)
                  .createFromAlert(
                    session,
                    params['alertId'],
                  ),
        ),
        'listWorkOrders': _i1.MethodConnector(
          name: 'listWorkOrders',
          params: {
            'openOnly': _i1.ParameterDescription(
              name: 'openOnly',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'cursorId': _i1.ParameterDescription(
              name: 'cursorId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workOrder'] as _i17.WorkOrderEndpoint)
                  .listWorkOrders(
                    session,
                    openOnly: params['openOnly'],
                    limit: params['limit'],
                    cursorId: params['cursorId'],
                  ),
        ),
        'updateStatus': _i1.MethodConnector(
          name: 'updateStatus',
          params: {
            'workOrderId': _i1.ParameterDescription(
              name: 'workOrderId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i32.WorkOrderStatus>(),
              nullable: false,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['workOrder'] as _i17.WorkOrderEndpoint)
                  .updateStatus(
                    session,
                    params['workOrderId'],
                    params['status'],
                    note: params['note'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i33.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i34.Endpoints()
      ..initializeEndpoints(server);
  }
}
