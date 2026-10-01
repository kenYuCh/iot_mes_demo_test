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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'alert/alert.dart' as _i5;
import 'alert/alert_comparison.dart' as _i6;
import 'alert/alert_list_result.dart' as _i7;
import 'alert/alert_rule.dart' as _i8;
import 'alert/alert_severity.dart' as _i9;
import 'alert/alert_state.dart' as _i10;
import 'command/device_command.dart' as _i11;
import 'command/device_command_list_result.dart' as _i12;
import 'command/device_command_state.dart' as _i13;
import 'common/not_found_exception.dart' as _i14;
import 'common/validation_exception.dart' as _i15;
import 'company/company.dart' as _i16;
import 'company/company_membership.dart' as _i17;
import 'company/company_role.dart' as _i18;
import 'company/device_share.dart' as _i19;
import 'company/member_access_summary.dart' as _i20;
import 'company/platform_permission.dart' as _i21;
import 'dashboard/dashboard_summary.dart' as _i22;
import 'dashboard/site_summary.dart' as _i23;
import 'device/control_presentation.dart' as _i24;
import 'device/custom_device_profile.dart' as _i25;
import 'device/device.dart' as _i26;
import 'device/device_connection_state.dart' as _i27;
import 'device/device_feature.dart' as _i28;
import 'device/device_profile.dart' as _i29;
import 'device/device_status.dart' as _i30;
import 'device/feature_catalog_item.dart' as _i31;
import 'device/feature_data_type.dart' as _i32;
import 'device/feature_definition.dart' as _i33;
import 'device/feature_kind.dart' as _i34;
import 'gateway/gateway.dart' as _i35;
import 'greetings/greeting.dart' as _i36;
import 'oee/oee_site_summary.dart' as _i37;
import 'oee/oee_summary.dart' as _i38;
import 'oee/production_stat.dart' as _i39;
import 'operations/audit_log.dart' as _i40;
import 'operations/automation_action.dart' as _i41;
import 'operations/automation_branch.dart' as _i42;
import 'operations/automation_condition.dart' as _i43;
import 'operations/automation_rule.dart' as _i44;
import 'operations/automation_run.dart' as _i45;
import 'ota/firmware_artifact.dart' as _i46;
import 'ota/firmware_package.dart' as _i47;
import 'ota/firmware_package_state.dart' as _i48;
import 'ota/firmware_release_detail.dart' as _i49;
import 'ota/ota_campaign.dart' as _i50;
import 'ota/ota_campaign_detail.dart' as _i51;
import 'ota/ota_campaign_state.dart' as _i52;
import 'ota/ota_device_job.dart' as _i53;
import 'ota/ota_job_state.dart' as _i54;
import 'ota/ota_strategy.dart' as _i55;
import 'ota/ota_target.dart' as _i56;
import 'production/bom_item.dart' as _i57;
import 'production/line_transfer.dart' as _i58;
import 'production/line_transfer_status.dart' as _i59;
import 'production/material_item.dart' as _i60;
import 'production/material_lot.dart' as _i61;
import 'production/material_type.dart' as _i62;
import 'production/process_event.dart' as _i63;
import 'production/process_event_type.dart' as _i64;
import 'production/process_node.dart' as _i65;
import 'production/process_result.dart' as _i66;
import 'production/process_route.dart' as _i67;
import 'production/product_definition.dart' as _i68;
import 'production/product_trace.dart' as _i69;
import 'production/product_unit.dart' as _i70;
import 'production/product_unit_status.dart' as _i71;
import 'production/production_line.dart' as _i72;
import 'production/production_order.dart' as _i73;
import 'production/production_order_status.dart' as _i74;
import 'production/production_summary.dart' as _i75;
import 'production/workstation.dart' as _i76;
import 'production/workstation_assignment.dart' as _i77;
import 'production/workstation_assignment_detail.dart' as _i78;
import 'provisioning/certificate_issue_result.dart' as _i79;
import 'provisioning/claim_session_result.dart' as _i80;
import 'provisioning/device_certificate.dart' as _i81;
import 'provisioning/device_claim.dart' as _i82;
import 'provisioning/provisioned_device.dart' as _i83;
import 'provisioning/provisioning_state.dart' as _i84;
import 'site/site.dart' as _i85;
import 'telemetry/measurement.dart' as _i86;
import 'telemetry/measurement_list_result.dart' as _i87;
import 'workorder/work_order.dart' as _i88;
import 'workorder/work_order_list_result.dart' as _i89;
import 'workorder/work_order_priority.dart' as _i90;
import 'workorder/work_order_status.dart' as _i91;
import 'package:pod_app_v1_server/src/generated/alert/alert_rule.dart' as _i92;
import 'package:pod_app_v1_server/src/generated/company/member_access_summary.dart'
    as _i93;
import 'package:pod_app_v1_server/src/generated/company/platform_permission.dart'
    as _i94;
import 'package:pod_app_v1_server/src/generated/device/device_profile.dart'
    as _i95;
import 'package:pod_app_v1_server/src/generated/device/feature_catalog_item.dart'
    as _i96;
import 'package:pod_app_v1_server/src/generated/device/device_feature.dart'
    as _i97;
import 'package:pod_app_v1_server/src/generated/device/device.dart' as _i98;
import 'package:pod_app_v1_server/src/generated/gateway/gateway.dart' as _i99;
import 'package:pod_app_v1_server/src/generated/operations/automation_rule.dart'
    as _i100;
import 'package:pod_app_v1_server/src/generated/operations/automation_branch.dart'
    as _i101;
import 'package:pod_app_v1_server/src/generated/operations/automation_run.dart'
    as _i102;
import 'package:pod_app_v1_server/src/generated/operations/audit_log.dart'
    as _i103;
import 'package:pod_app_v1_server/src/generated/ota/firmware_package.dart'
    as _i104;
import 'package:pod_app_v1_server/src/generated/ota/firmware_release_detail.dart'
    as _i105;
import 'dart:typed_data' as _i106;
import 'package:pod_app_v1_server/src/generated/ota/ota_campaign.dart' as _i107;
import 'package:pod_app_v1_server/src/generated/ota/ota_target.dart' as _i108;
import 'package:pod_app_v1_server/src/generated/production/material_item.dart'
    as _i109;
import 'package:pod_app_v1_server/src/generated/production/material_lot.dart'
    as _i110;
import 'package:pod_app_v1_server/src/generated/production/product_definition.dart'
    as _i111;
import 'package:pod_app_v1_server/src/generated/production/bom_item.dart'
    as _i112;
import 'package:pod_app_v1_server/src/generated/production/process_route.dart'
    as _i113;
import 'package:pod_app_v1_server/src/generated/production/production_line.dart'
    as _i114;
import 'package:pod_app_v1_server/src/generated/production/workstation.dart'
    as _i115;
import 'package:pod_app_v1_server/src/generated/production/workstation_assignment_detail.dart'
    as _i116;
import 'package:pod_app_v1_server/src/generated/production/line_transfer.dart'
    as _i117;
import 'package:pod_app_v1_server/src/generated/production/process_node.dart'
    as _i118;
import 'package:pod_app_v1_server/src/generated/production/production_order.dart'
    as _i119;
import 'package:pod_app_v1_server/src/generated/production/product_unit.dart'
    as _i120;
import 'package:pod_app_v1_server/src/generated/provisioning/provisioned_device.dart'
    as _i121;
import 'package:pod_app_v1_server/src/generated/provisioning/device_certificate.dart'
    as _i122;
import 'package:pod_app_v1_server/src/generated/site/site.dart' as _i123;
import 'package:pod_app_v1_server/src/generated/device/device_status.dart'
    as _i124;
export 'alert/alert.dart';
export 'alert/alert_comparison.dart';
export 'alert/alert_list_result.dart';
export 'alert/alert_rule.dart';
export 'alert/alert_severity.dart';
export 'alert/alert_state.dart';
export 'command/device_command.dart';
export 'command/device_command_list_result.dart';
export 'command/device_command_state.dart';
export 'common/not_found_exception.dart';
export 'common/validation_exception.dart';
export 'company/company.dart';
export 'company/company_membership.dart';
export 'company/company_role.dart';
export 'company/device_share.dart';
export 'company/member_access_summary.dart';
export 'company/platform_permission.dart';
export 'dashboard/dashboard_summary.dart';
export 'dashboard/site_summary.dart';
export 'device/control_presentation.dart';
export 'device/custom_device_profile.dart';
export 'device/device.dart';
export 'device/device_connection_state.dart';
export 'device/device_feature.dart';
export 'device/device_profile.dart';
export 'device/device_status.dart';
export 'device/feature_catalog_item.dart';
export 'device/feature_data_type.dart';
export 'device/feature_definition.dart';
export 'device/feature_kind.dart';
export 'gateway/gateway.dart';
export 'greetings/greeting.dart';
export 'oee/oee_site_summary.dart';
export 'oee/oee_summary.dart';
export 'oee/production_stat.dart';
export 'operations/audit_log.dart';
export 'operations/automation_action.dart';
export 'operations/automation_branch.dart';
export 'operations/automation_condition.dart';
export 'operations/automation_rule.dart';
export 'operations/automation_run.dart';
export 'ota/firmware_artifact.dart';
export 'ota/firmware_package.dart';
export 'ota/firmware_package_state.dart';
export 'ota/firmware_release_detail.dart';
export 'ota/ota_campaign.dart';
export 'ota/ota_campaign_detail.dart';
export 'ota/ota_campaign_state.dart';
export 'ota/ota_device_job.dart';
export 'ota/ota_job_state.dart';
export 'ota/ota_strategy.dart';
export 'ota/ota_target.dart';
export 'production/bom_item.dart';
export 'production/line_transfer.dart';
export 'production/line_transfer_status.dart';
export 'production/material_item.dart';
export 'production/material_lot.dart';
export 'production/material_type.dart';
export 'production/process_event.dart';
export 'production/process_event_type.dart';
export 'production/process_node.dart';
export 'production/process_result.dart';
export 'production/process_route.dart';
export 'production/product_definition.dart';
export 'production/product_trace.dart';
export 'production/product_unit.dart';
export 'production/product_unit_status.dart';
export 'production/production_line.dart';
export 'production/production_order.dart';
export 'production/production_order_status.dart';
export 'production/production_summary.dart';
export 'production/workstation.dart';
export 'production/workstation_assignment.dart';
export 'production/workstation_assignment_detail.dart';
export 'provisioning/certificate_issue_result.dart';
export 'provisioning/claim_session_result.dart';
export 'provisioning/device_certificate.dart';
export 'provisioning/device_claim.dart';
export 'provisioning/provisioned_device.dart';
export 'provisioning/provisioning_state.dart';
export 'site/site.dart';
export 'telemetry/measurement.dart';
export 'telemetry/measurement_list_result.dart';
export 'workorder/work_order.dart';
export 'workorder/work_order_list_result.dart';
export 'workorder/work_order_priority.dart';
export 'workorder/work_order_status.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'alert',
      dartName: 'Alert',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'alert_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'ruleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'featureKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'triggeredValue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'threshold',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'comparison',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertComparison',
        ),
        _i2.ColumnDefinition(
          name: 'severity',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertSeverity',
        ),
        _i2.ColumnDefinition(
          name: 'mobileNotificationEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'state',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertState',
        ),
        _i2.ColumnDefinition(
          name: 'message',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'triggeredAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'acknowledgedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'alert_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'alert_company_state_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'state',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'alert_rule_active_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'ruleId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'state',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'alert_device_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'alert_rule',
      dartName: 'AlertRule',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'alert_rule_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'featureKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'comparison',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertComparison',
        ),
        _i2.ColumnDefinition(
          name: 'threshold',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'severity',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertSeverity',
        ),
        _i2.ColumnDefinition(
          name: 'mobileNotificationEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'enabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'alert_rule_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'alert_rule_device_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'alert_rule_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'audit_log',
      dartName: 'AuditLog',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'audit_log_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userIdentifier',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'resourceType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'resourceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'summary',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'details',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _i2.ColumnDefinition(
          name: 'success',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'audit_log_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'audit_log_company_time_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'audit_log_device_time_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'automation_rule',
      dartName: 'AutomationRule',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'automation_rule_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'triggerDeviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'triggerFeatureKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'comparison',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertComparison',
        ),
        _i2.ColumnDefinition(
          name: 'threshold',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'recoveryThreshold',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'actionDeviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'actionFeatureKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'actionValue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'pulseOnSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'intervalSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'maxRepeats',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'mixingDelaySeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'branches',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:AutomationBranch>?',
        ),
        _i2.ColumnDefinition(
          name: 'sensorTimeoutSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
          columnDefault: '60',
        ),
        _i2.ColumnDefinition(
          name: 'cooldownSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
          columnDefault: '10',
        ),
        _i2.ColumnDefinition(
          name: 'enabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'automation_rule_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'automation_rule_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'automation_rule_trigger_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'triggerDeviceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'triggerFeatureKey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'automation_run',
      dartName: 'AutomationRun',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'automation_run_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'ruleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'state',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'triggerValue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'repeatCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'currentStep',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'message',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'finishedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'automation_run_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'automation_run_company_time_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'startedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'automation_run_rule_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'ruleId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'startedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bom_item',
      dartName: 'BomItem',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'bom_item_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productDefinitionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'materialId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'unit',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'scrapRatePercent',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bom_item_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'bom_product_material_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'productDefinitionId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'materialId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'bom_product_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'productDefinitionId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'company',
      dartName: 'Company',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'company_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'company_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'company_name_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'company_membership',
      dartName: 'CompanyMembership',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'company_membership_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:CompanyRole?',
        ),
        _i2.ColumnDefinition(
          name: 'permissions',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:PlatformPermission>?',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'displayName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'company_membership_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'company_membership_auth_user_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'company_membership_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'custom_device_profile',
      dartName: 'CustomDeviceProfile',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'custom_device_profile_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'profileKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'mcuFamily',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'features',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:DeviceFeature>',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'custom_device_profile_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'custom_device_profile_company_key_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'profileKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'custom_device_profile_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'device',
      dartName: 'Device',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'device_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'gatewayId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'serialNumber',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'model',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'hardwareRevision',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'firmwareVersion',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'deviceType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'features',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:DeviceFeature>?',
        ),
        _i2.ColumnDefinition(
          name: 'expectedIntervalSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'mapX',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'mapY',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'device_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'device_company_site_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'siteId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_gateway_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'gatewayId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_serial_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'serialNumber',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'device_certificate',
      dartName: 'DeviceCertificate',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'device_certificate_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'serial',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'certSerialNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'subjectCn',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'certificatePem',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'issuedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'revoked',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'revokedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'device_certificate_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'device_certificate_serial_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'serial',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_certificate_cert_serial_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'certSerialNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'device_claim',
      dartName: 'DeviceClaim',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'device_claim_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'sessionId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'serial',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'userIdentifier',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'confirmedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'device_claim_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'device_claim_session_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_claim_serial_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'serial',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'device_command',
      dartName: 'DeviceCommand',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'device_command_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'commandType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'payload',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'Map<String,String>',
        ),
        _i2.ColumnDefinition(
          name: 'state',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DeviceCommandState',
        ),
        _i2.ColumnDefinition(
          name: 'idempotencyKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'issuedBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'errorMessage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'sentAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'acknowledgedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'device_command_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'device_command_idem_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'idempotencyKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_command_device_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_command_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'device_share',
      dartName: 'DeviceShare',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'device_share_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'membershipId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'canRead',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'canWrite',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'device_share_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'device_share_device_member_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'membershipId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_share_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_share_membership_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'membershipId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'device_status',
      dartName: 'DeviceStatus',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'device_status_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'connectionState',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DeviceConnectionState',
        ),
        _i2.ColumnDefinition(
          name: 'latestValues',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'Map<String,double>',
        ),
        _i2.ColumnDefinition(
          name: 'lastUpdatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'device_status_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'device_status_device_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_status_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'feature_definition',
      dartName: 'FeatureDefinition',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'feature_definition_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'featureKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'label',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'unit',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'kind',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FeatureKind',
        ),
        _i2.ColumnDefinition(
          name: 'dataType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureDataType?',
        ),
        _i2.ColumnDefinition(
          name: 'controlPresentation',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ControlPresentation?',
        ),
        _i2.ColumnDefinition(
          name: 'enumOptions',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'precision',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'minValue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'maxValue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'defaultValue',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'feature_definition_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'feature_definition_company_key_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'featureKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'feature_definition_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'firmware_artifact',
      dartName: 'FirmwareArtifact',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'firmware_artifact_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'firmwarePackageId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'fileName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fileType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'core',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'storagePath',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sha256',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sizeBytes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isPrimary',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'deletedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'firmware_artifact_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'firmware_artifact_package_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'firmwarePackageId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'firmware_artifact_package_name_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'firmwarePackageId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'fileName',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'firmware_package',
      dartName: 'FirmwarePackage',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'firmware_package_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetDeviceType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'productKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'chipFamily',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'updateProtocol',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'hardwareRevision',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'releaseNotes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'downloadUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fileName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'storagePath',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'sha256',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sizeBytes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'state',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FirmwarePackageState',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'deletedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'deletedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'firmware_package_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'firmware_company_type_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'targetDeviceType',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'firmware_company_version_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'targetDeviceType',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'version',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'gateway',
      dartName: 'Gateway',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'gateway_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'serialNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'model',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'productKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'chipFamily',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'updateProtocol',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'hardwareRevision',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'firmwareVersion',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'connectionState',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DeviceConnectionState',
        ),
        _i2.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'gateway_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'gateway_serial_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'serialNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'gateway_company_site_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'siteId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'line_transfer',
      dartName: 'LineTransfer',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'line_transfer_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productUnitId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productionOrderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'fromLineId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'toLineId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'fromWorkstationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'toWorkstationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'fromNodeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'toNodeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:LineTransferStatus',
        ),
        _i2.ColumnDefinition(
          name: 'dispatchedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'dispatchedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'receivedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'receivedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'line_transfer_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'line_transfer_unit_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'productUnitId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'line_transfer_destination_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'toWorkstationId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'material',
      dartName: 'MaterialItem',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'material_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MaterialType',
        ),
        _i2.ColumnDefinition(
          name: 'specification',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'unit',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'supplier',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'safetyStock',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'material_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'material_company_code_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'material_company_name_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'material_lot',
      dartName: 'MaterialLot',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'material_lot_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'materialId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'lotNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'receivedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'supplierLot',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'qrCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'rfidEpc',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'material_lot_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'material_lot_company_number_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'lotNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'material_lot_material_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'materialId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'receivedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'material_lot_qr_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'qrCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'material_lot_rfid_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'rfidEpc',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'measurement',
      dartName: 'Measurement',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'measurement_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'featureKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'measuredAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'receivedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'measurement_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'measurement_device_time_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'measuredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'measurement_company_time_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'measuredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ota_campaign',
      dartName: 'OtaCampaign',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ota_campaign_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'firmwarePackageId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetDeviceType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'strategy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OtaStrategy',
        ),
        _i2.ColumnDefinition(
          name: 'state',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OtaCampaignState',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'totalDevices',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'succeededDevices',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'failedDevices',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ota_campaign_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'ota_campaign_company_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'ota_campaign_firmware_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'firmwarePackageId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ota_device_job',
      dartName: 'OtaDeviceJob',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ota_device_job_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'campaignId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'gatewayId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'state',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OtaJobState',
        ),
        _i2.ColumnDefinition(
          name: 'progress',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'previousVersion',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'errorMessage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ota_device_job_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'ota_job_campaign_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'campaignId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'ota_job_device_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'updatedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'ota_job_gateway_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'gatewayId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'updatedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'ota_job_campaign_device_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'campaignId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'process_event',
      dartName: 'ProcessEvent',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'process_event_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'clientEventId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'productUnitId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productionOrderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'processNodeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'stationCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'eventType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProcessEventType',
        ),
        _i2.ColumnDefinition(
          name: 'result',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProcessResult',
        ),
        _i2.ColumnDefinition(
          name: 'operatorId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'materialLotIds',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _i2.ColumnDefinition(
          name: 'measurements',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,double>?',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'occurredAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'receivedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'process_event_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'process_event_company_client_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'clientEventId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'process_event_unit_time_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'productUnitId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'occurredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'process_event_order_time_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'productionOrderId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'occurredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'process_event_station_time_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'stationCode',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'occurredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'process_node',
      dartName: 'ProcessNode',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'process_node_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'routeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sequence',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'stationCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'standardSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scanMode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'startComplete\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'allowSkip',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'allowRework',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'measurementRequirements',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'process_node_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'process_node_route_sequence_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'routeId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sequence',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'process_node_route_code_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'routeId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'process_node_station_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'stationCode',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'process_route',
      dartName: 'ProcessRoute',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'process_route_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productDefinitionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'process_route_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'process_route_company_code_version_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'version',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'process_route_product_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'productDefinitionId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'product_definition',
      dartName: 'ProductDefinition',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'product_definition_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'specification',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'unit',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'product_definition_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'product_definition_company_code_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'product_unit',
      dartName: 'ProductUnit',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'product_unit_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productionOrderId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productDefinitionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'serialNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'qrCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'rfidEpc',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProductUnitStatus',
        ),
        _i2.ColumnDefinition(
          name: 'currentNodeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'currentStationCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'enteredNodeAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'product_unit_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'product_unit_company_serial_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'serialNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'product_unit_company_qr_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'qrCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'product_unit_company_rfid_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'rfidEpc',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'product_unit_order_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'productionOrderId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'production_line',
      dartName: 'ProductionLine',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'production_line_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'production_line_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'production_line_company_code_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'production_order',
      dartName: 'ProductionOrder',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'production_order_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'orderNumber',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'productDefinitionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'routeId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'plannedQuantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'completedQuantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'rejectedQuantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProductionOrderStatus',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledStart',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledEnd',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'production_order_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'production_order_company_number_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'orderNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'production_order_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'production_stat',
      dartName: 'ProductionStat',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'production_stat_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'windowStart',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'plannedMinutes',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'runMinutes',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'idealCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'actualCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'goodCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'production_stat_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'production_stat_site_window_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'siteId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'windowStart',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'production_stat_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'windowStart',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'provisioned_device',
      dartName: 'ProvisionedDevice',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'provisioned_device_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'serial',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'model',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'claimCodeHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'manufacturerVerified',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'factoryCertificateFingerprint',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'manufacturerVerifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'state',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProvisioningState',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'claimedBy',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'claimedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'linkedGatewayId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'linkedDeviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'provisioned_device_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'provisioned_device_serial_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'serial',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'provisioned_device_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'site',
      dartName: 'Site',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'site_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'site_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'site_company_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'work_order',
      dartName: 'WorkOrder',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'work_order_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'siteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'alertId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:WorkOrderStatus',
        ),
        _i2.ColumnDefinition(
          name: 'priority',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:WorkOrderPriority',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'work_order_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'work_order_company_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'work_order_site_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'siteId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'work_order_device_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'deviceId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'workstation',
      dartName: 'Workstation',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'workstation_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'productionLineId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'workstation_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'workstation_company_code_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'workstation_assignment',
      dartName: 'WorkstationAssignment',
      schema: 'public',
      module: 'pod_app_v1',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'workstation_assignment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'companyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'workstationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'membershipId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'assignedBy',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'workstation_assignment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'workstation_assignment_member_station_uidx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'membershipId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'workstationId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'workstation_assignment_company_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'active',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.Alert) {
      return _i5.Alert.fromJson(data) as T;
    }
    if (t == _i6.AlertComparison) {
      return _i6.AlertComparison.fromJson(data) as T;
    }
    if (t == _i7.AlertListResult) {
      return _i7.AlertListResult.fromJson(data) as T;
    }
    if (t == _i8.AlertRule) {
      return _i8.AlertRule.fromJson(data) as T;
    }
    if (t == _i9.AlertSeverity) {
      return _i9.AlertSeverity.fromJson(data) as T;
    }
    if (t == _i10.AlertState) {
      return _i10.AlertState.fromJson(data) as T;
    }
    if (t == _i11.DeviceCommand) {
      return _i11.DeviceCommand.fromJson(data) as T;
    }
    if (t == _i12.DeviceCommandListResult) {
      return _i12.DeviceCommandListResult.fromJson(data) as T;
    }
    if (t == _i13.DeviceCommandState) {
      return _i13.DeviceCommandState.fromJson(data) as T;
    }
    if (t == _i14.NotFoundException) {
      return _i14.NotFoundException.fromJson(data) as T;
    }
    if (t == _i15.ValidationException) {
      return _i15.ValidationException.fromJson(data) as T;
    }
    if (t == _i16.Company) {
      return _i16.Company.fromJson(data) as T;
    }
    if (t == _i17.CompanyMembership) {
      return _i17.CompanyMembership.fromJson(data) as T;
    }
    if (t == _i18.CompanyRole) {
      return _i18.CompanyRole.fromJson(data) as T;
    }
    if (t == _i19.DeviceShare) {
      return _i19.DeviceShare.fromJson(data) as T;
    }
    if (t == _i20.MemberAccessSummary) {
      return _i20.MemberAccessSummary.fromJson(data) as T;
    }
    if (t == _i21.PlatformPermission) {
      return _i21.PlatformPermission.fromJson(data) as T;
    }
    if (t == _i22.DashboardSummary) {
      return _i22.DashboardSummary.fromJson(data) as T;
    }
    if (t == _i23.SiteSummary) {
      return _i23.SiteSummary.fromJson(data) as T;
    }
    if (t == _i24.ControlPresentation) {
      return _i24.ControlPresentation.fromJson(data) as T;
    }
    if (t == _i25.CustomDeviceProfile) {
      return _i25.CustomDeviceProfile.fromJson(data) as T;
    }
    if (t == _i26.Device) {
      return _i26.Device.fromJson(data) as T;
    }
    if (t == _i27.DeviceConnectionState) {
      return _i27.DeviceConnectionState.fromJson(data) as T;
    }
    if (t == _i28.DeviceFeature) {
      return _i28.DeviceFeature.fromJson(data) as T;
    }
    if (t == _i29.DeviceProfile) {
      return _i29.DeviceProfile.fromJson(data) as T;
    }
    if (t == _i30.DeviceStatus) {
      return _i30.DeviceStatus.fromJson(data) as T;
    }
    if (t == _i31.FeatureCatalogItem) {
      return _i31.FeatureCatalogItem.fromJson(data) as T;
    }
    if (t == _i32.FeatureDataType) {
      return _i32.FeatureDataType.fromJson(data) as T;
    }
    if (t == _i33.FeatureDefinition) {
      return _i33.FeatureDefinition.fromJson(data) as T;
    }
    if (t == _i34.FeatureKind) {
      return _i34.FeatureKind.fromJson(data) as T;
    }
    if (t == _i35.Gateway) {
      return _i35.Gateway.fromJson(data) as T;
    }
    if (t == _i36.Greeting) {
      return _i36.Greeting.fromJson(data) as T;
    }
    if (t == _i37.OeeSiteSummary) {
      return _i37.OeeSiteSummary.fromJson(data) as T;
    }
    if (t == _i38.OeeSummary) {
      return _i38.OeeSummary.fromJson(data) as T;
    }
    if (t == _i39.ProductionStat) {
      return _i39.ProductionStat.fromJson(data) as T;
    }
    if (t == _i40.AuditLog) {
      return _i40.AuditLog.fromJson(data) as T;
    }
    if (t == _i41.AutomationAction) {
      return _i41.AutomationAction.fromJson(data) as T;
    }
    if (t == _i42.AutomationBranch) {
      return _i42.AutomationBranch.fromJson(data) as T;
    }
    if (t == _i43.AutomationCondition) {
      return _i43.AutomationCondition.fromJson(data) as T;
    }
    if (t == _i44.AutomationRule) {
      return _i44.AutomationRule.fromJson(data) as T;
    }
    if (t == _i45.AutomationRun) {
      return _i45.AutomationRun.fromJson(data) as T;
    }
    if (t == _i46.FirmwareArtifact) {
      return _i46.FirmwareArtifact.fromJson(data) as T;
    }
    if (t == _i47.FirmwarePackage) {
      return _i47.FirmwarePackage.fromJson(data) as T;
    }
    if (t == _i48.FirmwarePackageState) {
      return _i48.FirmwarePackageState.fromJson(data) as T;
    }
    if (t == _i49.FirmwareReleaseDetail) {
      return _i49.FirmwareReleaseDetail.fromJson(data) as T;
    }
    if (t == _i50.OtaCampaign) {
      return _i50.OtaCampaign.fromJson(data) as T;
    }
    if (t == _i51.OtaCampaignDetail) {
      return _i51.OtaCampaignDetail.fromJson(data) as T;
    }
    if (t == _i52.OtaCampaignState) {
      return _i52.OtaCampaignState.fromJson(data) as T;
    }
    if (t == _i53.OtaDeviceJob) {
      return _i53.OtaDeviceJob.fromJson(data) as T;
    }
    if (t == _i54.OtaJobState) {
      return _i54.OtaJobState.fromJson(data) as T;
    }
    if (t == _i55.OtaStrategy) {
      return _i55.OtaStrategy.fromJson(data) as T;
    }
    if (t == _i56.OtaTarget) {
      return _i56.OtaTarget.fromJson(data) as T;
    }
    if (t == _i57.BomItem) {
      return _i57.BomItem.fromJson(data) as T;
    }
    if (t == _i58.LineTransfer) {
      return _i58.LineTransfer.fromJson(data) as T;
    }
    if (t == _i59.LineTransferStatus) {
      return _i59.LineTransferStatus.fromJson(data) as T;
    }
    if (t == _i60.MaterialItem) {
      return _i60.MaterialItem.fromJson(data) as T;
    }
    if (t == _i61.MaterialLot) {
      return _i61.MaterialLot.fromJson(data) as T;
    }
    if (t == _i62.MaterialType) {
      return _i62.MaterialType.fromJson(data) as T;
    }
    if (t == _i63.ProcessEvent) {
      return _i63.ProcessEvent.fromJson(data) as T;
    }
    if (t == _i64.ProcessEventType) {
      return _i64.ProcessEventType.fromJson(data) as T;
    }
    if (t == _i65.ProcessNode) {
      return _i65.ProcessNode.fromJson(data) as T;
    }
    if (t == _i66.ProcessResult) {
      return _i66.ProcessResult.fromJson(data) as T;
    }
    if (t == _i67.ProcessRoute) {
      return _i67.ProcessRoute.fromJson(data) as T;
    }
    if (t == _i68.ProductDefinition) {
      return _i68.ProductDefinition.fromJson(data) as T;
    }
    if (t == _i69.ProductTrace) {
      return _i69.ProductTrace.fromJson(data) as T;
    }
    if (t == _i70.ProductUnit) {
      return _i70.ProductUnit.fromJson(data) as T;
    }
    if (t == _i71.ProductUnitStatus) {
      return _i71.ProductUnitStatus.fromJson(data) as T;
    }
    if (t == _i72.ProductionLine) {
      return _i72.ProductionLine.fromJson(data) as T;
    }
    if (t == _i73.ProductionOrder) {
      return _i73.ProductionOrder.fromJson(data) as T;
    }
    if (t == _i74.ProductionOrderStatus) {
      return _i74.ProductionOrderStatus.fromJson(data) as T;
    }
    if (t == _i75.ProductionSummary) {
      return _i75.ProductionSummary.fromJson(data) as T;
    }
    if (t == _i76.Workstation) {
      return _i76.Workstation.fromJson(data) as T;
    }
    if (t == _i77.WorkstationAssignment) {
      return _i77.WorkstationAssignment.fromJson(data) as T;
    }
    if (t == _i78.WorkstationAssignmentDetail) {
      return _i78.WorkstationAssignmentDetail.fromJson(data) as T;
    }
    if (t == _i79.CertificateIssueResult) {
      return _i79.CertificateIssueResult.fromJson(data) as T;
    }
    if (t == _i80.ClaimSessionResult) {
      return _i80.ClaimSessionResult.fromJson(data) as T;
    }
    if (t == _i81.DeviceCertificate) {
      return _i81.DeviceCertificate.fromJson(data) as T;
    }
    if (t == _i82.DeviceClaim) {
      return _i82.DeviceClaim.fromJson(data) as T;
    }
    if (t == _i83.ProvisionedDevice) {
      return _i83.ProvisionedDevice.fromJson(data) as T;
    }
    if (t == _i84.ProvisioningState) {
      return _i84.ProvisioningState.fromJson(data) as T;
    }
    if (t == _i85.Site) {
      return _i85.Site.fromJson(data) as T;
    }
    if (t == _i86.Measurement) {
      return _i86.Measurement.fromJson(data) as T;
    }
    if (t == _i87.MeasurementListResult) {
      return _i87.MeasurementListResult.fromJson(data) as T;
    }
    if (t == _i88.WorkOrder) {
      return _i88.WorkOrder.fromJson(data) as T;
    }
    if (t == _i89.WorkOrderListResult) {
      return _i89.WorkOrderListResult.fromJson(data) as T;
    }
    if (t == _i90.WorkOrderPriority) {
      return _i90.WorkOrderPriority.fromJson(data) as T;
    }
    if (t == _i91.WorkOrderStatus) {
      return _i91.WorkOrderStatus.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.Alert?>()) {
      return (data != null ? _i5.Alert.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AlertComparison?>()) {
      return (data != null ? _i6.AlertComparison.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AlertListResult?>()) {
      return (data != null ? _i7.AlertListResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AlertRule?>()) {
      return (data != null ? _i8.AlertRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AlertSeverity?>()) {
      return (data != null ? _i9.AlertSeverity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AlertState?>()) {
      return (data != null ? _i10.AlertState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.DeviceCommand?>()) {
      return (data != null ? _i11.DeviceCommand.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.DeviceCommandListResult?>()) {
      return (data != null ? _i12.DeviceCommandListResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.DeviceCommandState?>()) {
      return (data != null ? _i13.DeviceCommandState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.NotFoundException?>()) {
      return (data != null ? _i14.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.ValidationException?>()) {
      return (data != null ? _i15.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.Company?>()) {
      return (data != null ? _i16.Company.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.CompanyMembership?>()) {
      return (data != null ? _i17.CompanyMembership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.CompanyRole?>()) {
      return (data != null ? _i18.CompanyRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.DeviceShare?>()) {
      return (data != null ? _i19.DeviceShare.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.MemberAccessSummary?>()) {
      return (data != null ? _i20.MemberAccessSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.PlatformPermission?>()) {
      return (data != null ? _i21.PlatformPermission.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.DashboardSummary?>()) {
      return (data != null ? _i22.DashboardSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.SiteSummary?>()) {
      return (data != null ? _i23.SiteSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.ControlPresentation?>()) {
      return (data != null ? _i24.ControlPresentation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.CustomDeviceProfile?>()) {
      return (data != null ? _i25.CustomDeviceProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.Device?>()) {
      return (data != null ? _i26.Device.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.DeviceConnectionState?>()) {
      return (data != null ? _i27.DeviceConnectionState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.DeviceFeature?>()) {
      return (data != null ? _i28.DeviceFeature.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.DeviceProfile?>()) {
      return (data != null ? _i29.DeviceProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.DeviceStatus?>()) {
      return (data != null ? _i30.DeviceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.FeatureCatalogItem?>()) {
      return (data != null ? _i31.FeatureCatalogItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.FeatureDataType?>()) {
      return (data != null ? _i32.FeatureDataType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.FeatureDefinition?>()) {
      return (data != null ? _i33.FeatureDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.FeatureKind?>()) {
      return (data != null ? _i34.FeatureKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Gateway?>()) {
      return (data != null ? _i35.Gateway.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.Greeting?>()) {
      return (data != null ? _i36.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.OeeSiteSummary?>()) {
      return (data != null ? _i37.OeeSiteSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.OeeSummary?>()) {
      return (data != null ? _i38.OeeSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.ProductionStat?>()) {
      return (data != null ? _i39.ProductionStat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.AuditLog?>()) {
      return (data != null ? _i40.AuditLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.AutomationAction?>()) {
      return (data != null ? _i41.AutomationAction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.AutomationBranch?>()) {
      return (data != null ? _i42.AutomationBranch.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.AutomationCondition?>()) {
      return (data != null ? _i43.AutomationCondition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.AutomationRule?>()) {
      return (data != null ? _i44.AutomationRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.AutomationRun?>()) {
      return (data != null ? _i45.AutomationRun.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.FirmwareArtifact?>()) {
      return (data != null ? _i46.FirmwareArtifact.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.FirmwarePackage?>()) {
      return (data != null ? _i47.FirmwarePackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.FirmwarePackageState?>()) {
      return (data != null ? _i48.FirmwarePackageState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.FirmwareReleaseDetail?>()) {
      return (data != null ? _i49.FirmwareReleaseDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i50.OtaCampaign?>()) {
      return (data != null ? _i50.OtaCampaign.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.OtaCampaignDetail?>()) {
      return (data != null ? _i51.OtaCampaignDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.OtaCampaignState?>()) {
      return (data != null ? _i52.OtaCampaignState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.OtaDeviceJob?>()) {
      return (data != null ? _i53.OtaDeviceJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.OtaJobState?>()) {
      return (data != null ? _i54.OtaJobState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.OtaStrategy?>()) {
      return (data != null ? _i55.OtaStrategy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.OtaTarget?>()) {
      return (data != null ? _i56.OtaTarget.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.BomItem?>()) {
      return (data != null ? _i57.BomItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.LineTransfer?>()) {
      return (data != null ? _i58.LineTransfer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.LineTransferStatus?>()) {
      return (data != null ? _i59.LineTransferStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.MaterialItem?>()) {
      return (data != null ? _i60.MaterialItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.MaterialLot?>()) {
      return (data != null ? _i61.MaterialLot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.MaterialType?>()) {
      return (data != null ? _i62.MaterialType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.ProcessEvent?>()) {
      return (data != null ? _i63.ProcessEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.ProcessEventType?>()) {
      return (data != null ? _i64.ProcessEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.ProcessNode?>()) {
      return (data != null ? _i65.ProcessNode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.ProcessResult?>()) {
      return (data != null ? _i66.ProcessResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.ProcessRoute?>()) {
      return (data != null ? _i67.ProcessRoute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.ProductDefinition?>()) {
      return (data != null ? _i68.ProductDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.ProductTrace?>()) {
      return (data != null ? _i69.ProductTrace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.ProductUnit?>()) {
      return (data != null ? _i70.ProductUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.ProductUnitStatus?>()) {
      return (data != null ? _i71.ProductUnitStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.ProductionLine?>()) {
      return (data != null ? _i72.ProductionLine.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.ProductionOrder?>()) {
      return (data != null ? _i73.ProductionOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.ProductionOrderStatus?>()) {
      return (data != null ? _i74.ProductionOrderStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i75.ProductionSummary?>()) {
      return (data != null ? _i75.ProductionSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.Workstation?>()) {
      return (data != null ? _i76.Workstation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.WorkstationAssignment?>()) {
      return (data != null ? _i77.WorkstationAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i78.WorkstationAssignmentDetail?>()) {
      return (data != null
              ? _i78.WorkstationAssignmentDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i79.CertificateIssueResult?>()) {
      return (data != null ? _i79.CertificateIssueResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i80.ClaimSessionResult?>()) {
      return (data != null ? _i80.ClaimSessionResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i81.DeviceCertificate?>()) {
      return (data != null ? _i81.DeviceCertificate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.DeviceClaim?>()) {
      return (data != null ? _i82.DeviceClaim.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i83.ProvisionedDevice?>()) {
      return (data != null ? _i83.ProvisionedDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.ProvisioningState?>()) {
      return (data != null ? _i84.ProvisioningState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.Site?>()) {
      return (data != null ? _i85.Site.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i86.Measurement?>()) {
      return (data != null ? _i86.Measurement.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.MeasurementListResult?>()) {
      return (data != null ? _i87.MeasurementListResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i88.WorkOrder?>()) {
      return (data != null ? _i88.WorkOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i89.WorkOrderListResult?>()) {
      return (data != null ? _i89.WorkOrderListResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i90.WorkOrderPriority?>()) {
      return (data != null ? _i90.WorkOrderPriority.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i91.WorkOrderStatus?>()) {
      return (data != null ? _i91.WorkOrderStatus.fromJson(data) : null) as T;
    }
    if (t == List<_i5.Alert>) {
      return (data as List).map((e) => deserialize<_i5.Alert>(e)).toList() as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i11.DeviceCommand>) {
      return (data as List)
              .map((e) => deserialize<_i11.DeviceCommand>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.PlatformPermission>) {
      return (data as List)
              .map((e) => deserialize<_i21.PlatformPermission>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i21.PlatformPermission>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i21.PlatformPermission>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i23.SiteSummary>) {
      return (data as List)
              .map((e) => deserialize<_i23.SiteSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.DeviceFeature>) {
      return (data as List)
              .map((e) => deserialize<_i28.DeviceFeature>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i28.DeviceFeature>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i28.DeviceFeature>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<double>(v)),
          )
          as T;
    }
    if (t == List<_i37.OeeSiteSummary>) {
      return (data as List)
              .map((e) => deserialize<_i37.OeeSiteSummary>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i43.AutomationCondition>) {
      return (data as List)
              .map((e) => deserialize<_i43.AutomationCondition>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.AutomationAction>) {
      return (data as List)
              .map((e) => deserialize<_i41.AutomationAction>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.AutomationBranch>) {
      return (data as List)
              .map((e) => deserialize<_i42.AutomationBranch>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i42.AutomationBranch>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i42.AutomationBranch>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i46.FirmwareArtifact>) {
      return (data as List)
              .map((e) => deserialize<_i46.FirmwareArtifact>(e))
              .toList()
          as T;
    }
    if (t == List<_i53.OtaDeviceJob>) {
      return (data as List)
              .map((e) => deserialize<_i53.OtaDeviceJob>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == _i1.getType<Map<String, double>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<double>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i63.ProcessEvent>) {
      return (data as List)
              .map((e) => deserialize<_i63.ProcessEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i86.Measurement>) {
      return (data as List)
              .map((e) => deserialize<_i86.Measurement>(e))
              .toList()
          as T;
    }
    if (t == List<_i88.WorkOrder>) {
      return (data as List).map((e) => deserialize<_i88.WorkOrder>(e)).toList()
          as T;
    }
    if (t == List<_i92.AlertRule>) {
      return (data as List).map((e) => deserialize<_i92.AlertRule>(e)).toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i93.MemberAccessSummary>) {
      return (data as List)
              .map((e) => deserialize<_i93.MemberAccessSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i94.PlatformPermission>) {
      return (data as List)
              .map((e) => deserialize<_i94.PlatformPermission>(e))
              .toList()
          as T;
    }
    if (t == List<_i95.DeviceProfile>) {
      return (data as List)
              .map((e) => deserialize<_i95.DeviceProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i96.FeatureCatalogItem>) {
      return (data as List)
              .map((e) => deserialize<_i96.FeatureCatalogItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i97.DeviceFeature>) {
      return (data as List)
              .map((e) => deserialize<_i97.DeviceFeature>(e))
              .toList()
          as T;
    }
    if (t == List<_i98.Device>) {
      return (data as List).map((e) => deserialize<_i98.Device>(e)).toList()
          as T;
    }
    if (t == List<_i99.Gateway>) {
      return (data as List).map((e) => deserialize<_i99.Gateway>(e)).toList()
          as T;
    }
    if (t == List<_i100.AutomationRule>) {
      return (data as List)
              .map((e) => deserialize<_i100.AutomationRule>(e))
              .toList()
          as T;
    }
    if (t == List<_i101.AutomationBranch>) {
      return (data as List)
              .map((e) => deserialize<_i101.AutomationBranch>(e))
              .toList()
          as T;
    }
    if (t == List<_i102.AutomationRun>) {
      return (data as List)
              .map((e) => deserialize<_i102.AutomationRun>(e))
              .toList()
          as T;
    }
    if (t == List<_i103.AuditLog>) {
      return (data as List).map((e) => deserialize<_i103.AuditLog>(e)).toList()
          as T;
    }
    if (t == List<_i104.FirmwarePackage>) {
      return (data as List)
              .map((e) => deserialize<_i104.FirmwarePackage>(e))
              .toList()
          as T;
    }
    if (t == List<_i105.FirmwareReleaseDetail>) {
      return (data as List)
              .map((e) => deserialize<_i105.FirmwareReleaseDetail>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i106.ByteData>) {
      return (data as List).map((e) => deserialize<_i106.ByteData>(e)).toList()
          as T;
    }
    if (t == List<_i107.OtaCampaign>) {
      return (data as List)
              .map((e) => deserialize<_i107.OtaCampaign>(e))
              .toList()
          as T;
    }
    if (t == List<_i108.OtaTarget>) {
      return (data as List).map((e) => deserialize<_i108.OtaTarget>(e)).toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i109.MaterialItem>) {
      return (data as List)
              .map((e) => deserialize<_i109.MaterialItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i110.MaterialLot>) {
      return (data as List)
              .map((e) => deserialize<_i110.MaterialLot>(e))
              .toList()
          as T;
    }
    if (t == List<_i111.ProductDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i111.ProductDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i112.BomItem>) {
      return (data as List).map((e) => deserialize<_i112.BomItem>(e)).toList()
          as T;
    }
    if (t == List<_i113.ProcessRoute>) {
      return (data as List)
              .map((e) => deserialize<_i113.ProcessRoute>(e))
              .toList()
          as T;
    }
    if (t == List<_i114.ProductionLine>) {
      return (data as List)
              .map((e) => deserialize<_i114.ProductionLine>(e))
              .toList()
          as T;
    }
    if (t == List<_i115.Workstation>) {
      return (data as List)
              .map((e) => deserialize<_i115.Workstation>(e))
              .toList()
          as T;
    }
    if (t == List<_i116.WorkstationAssignmentDetail>) {
      return (data as List)
              .map((e) => deserialize<_i116.WorkstationAssignmentDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i117.LineTransfer>) {
      return (data as List)
              .map((e) => deserialize<_i117.LineTransfer>(e))
              .toList()
          as T;
    }
    if (t == List<_i118.ProcessNode>) {
      return (data as List)
              .map((e) => deserialize<_i118.ProcessNode>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i119.ProductionOrder>) {
      return (data as List)
              .map((e) => deserialize<_i119.ProductionOrder>(e))
              .toList()
          as T;
    }
    if (t == List<_i120.ProductUnit>) {
      return (data as List)
              .map((e) => deserialize<_i120.ProductUnit>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<String, double>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<double>(v)),
          )
          as T;
    }
    if (t == _i1.getType<Map<String, double>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<double>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i121.ProvisionedDevice>) {
      return (data as List)
              .map((e) => deserialize<_i121.ProvisionedDevice>(e))
              .toList()
          as T;
    }
    if (t == List<_i122.DeviceCertificate>) {
      return (data as List)
              .map((e) => deserialize<_i122.DeviceCertificate>(e))
              .toList()
          as T;
    }
    if (t == List<_i123.Site>) {
      return (data as List).map((e) => deserialize<_i123.Site>(e)).toList()
          as T;
    }
    if (t == List<_i124.DeviceStatus>) {
      return (data as List)
              .map((e) => deserialize<_i124.DeviceStatus>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.Alert => 'Alert',
      _i6.AlertComparison => 'AlertComparison',
      _i7.AlertListResult => 'AlertListResult',
      _i8.AlertRule => 'AlertRule',
      _i9.AlertSeverity => 'AlertSeverity',
      _i10.AlertState => 'AlertState',
      _i11.DeviceCommand => 'DeviceCommand',
      _i12.DeviceCommandListResult => 'DeviceCommandListResult',
      _i13.DeviceCommandState => 'DeviceCommandState',
      _i14.NotFoundException => 'NotFoundException',
      _i15.ValidationException => 'ValidationException',
      _i16.Company => 'Company',
      _i17.CompanyMembership => 'CompanyMembership',
      _i18.CompanyRole => 'CompanyRole',
      _i19.DeviceShare => 'DeviceShare',
      _i20.MemberAccessSummary => 'MemberAccessSummary',
      _i21.PlatformPermission => 'PlatformPermission',
      _i22.DashboardSummary => 'DashboardSummary',
      _i23.SiteSummary => 'SiteSummary',
      _i24.ControlPresentation => 'ControlPresentation',
      _i25.CustomDeviceProfile => 'CustomDeviceProfile',
      _i26.Device => 'Device',
      _i27.DeviceConnectionState => 'DeviceConnectionState',
      _i28.DeviceFeature => 'DeviceFeature',
      _i29.DeviceProfile => 'DeviceProfile',
      _i30.DeviceStatus => 'DeviceStatus',
      _i31.FeatureCatalogItem => 'FeatureCatalogItem',
      _i32.FeatureDataType => 'FeatureDataType',
      _i33.FeatureDefinition => 'FeatureDefinition',
      _i34.FeatureKind => 'FeatureKind',
      _i35.Gateway => 'Gateway',
      _i36.Greeting => 'Greeting',
      _i37.OeeSiteSummary => 'OeeSiteSummary',
      _i38.OeeSummary => 'OeeSummary',
      _i39.ProductionStat => 'ProductionStat',
      _i40.AuditLog => 'AuditLog',
      _i41.AutomationAction => 'AutomationAction',
      _i42.AutomationBranch => 'AutomationBranch',
      _i43.AutomationCondition => 'AutomationCondition',
      _i44.AutomationRule => 'AutomationRule',
      _i45.AutomationRun => 'AutomationRun',
      _i46.FirmwareArtifact => 'FirmwareArtifact',
      _i47.FirmwarePackage => 'FirmwarePackage',
      _i48.FirmwarePackageState => 'FirmwarePackageState',
      _i49.FirmwareReleaseDetail => 'FirmwareReleaseDetail',
      _i50.OtaCampaign => 'OtaCampaign',
      _i51.OtaCampaignDetail => 'OtaCampaignDetail',
      _i52.OtaCampaignState => 'OtaCampaignState',
      _i53.OtaDeviceJob => 'OtaDeviceJob',
      _i54.OtaJobState => 'OtaJobState',
      _i55.OtaStrategy => 'OtaStrategy',
      _i56.OtaTarget => 'OtaTarget',
      _i57.BomItem => 'BomItem',
      _i58.LineTransfer => 'LineTransfer',
      _i59.LineTransferStatus => 'LineTransferStatus',
      _i60.MaterialItem => 'MaterialItem',
      _i61.MaterialLot => 'MaterialLot',
      _i62.MaterialType => 'MaterialType',
      _i63.ProcessEvent => 'ProcessEvent',
      _i64.ProcessEventType => 'ProcessEventType',
      _i65.ProcessNode => 'ProcessNode',
      _i66.ProcessResult => 'ProcessResult',
      _i67.ProcessRoute => 'ProcessRoute',
      _i68.ProductDefinition => 'ProductDefinition',
      _i69.ProductTrace => 'ProductTrace',
      _i70.ProductUnit => 'ProductUnit',
      _i71.ProductUnitStatus => 'ProductUnitStatus',
      _i72.ProductionLine => 'ProductionLine',
      _i73.ProductionOrder => 'ProductionOrder',
      _i74.ProductionOrderStatus => 'ProductionOrderStatus',
      _i75.ProductionSummary => 'ProductionSummary',
      _i76.Workstation => 'Workstation',
      _i77.WorkstationAssignment => 'WorkstationAssignment',
      _i78.WorkstationAssignmentDetail => 'WorkstationAssignmentDetail',
      _i79.CertificateIssueResult => 'CertificateIssueResult',
      _i80.ClaimSessionResult => 'ClaimSessionResult',
      _i81.DeviceCertificate => 'DeviceCertificate',
      _i82.DeviceClaim => 'DeviceClaim',
      _i83.ProvisionedDevice => 'ProvisionedDevice',
      _i84.ProvisioningState => 'ProvisioningState',
      _i85.Site => 'Site',
      _i86.Measurement => 'Measurement',
      _i87.MeasurementListResult => 'MeasurementListResult',
      _i88.WorkOrder => 'WorkOrder',
      _i89.WorkOrderListResult => 'WorkOrderListResult',
      _i90.WorkOrderPriority => 'WorkOrderPriority',
      _i91.WorkOrderStatus => 'WorkOrderStatus',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('pod_app_v1.', '');
    }

    switch (data) {
      case _i5.Alert():
        return 'Alert';
      case _i6.AlertComparison():
        return 'AlertComparison';
      case _i7.AlertListResult():
        return 'AlertListResult';
      case _i8.AlertRule():
        return 'AlertRule';
      case _i9.AlertSeverity():
        return 'AlertSeverity';
      case _i10.AlertState():
        return 'AlertState';
      case _i11.DeviceCommand():
        return 'DeviceCommand';
      case _i12.DeviceCommandListResult():
        return 'DeviceCommandListResult';
      case _i13.DeviceCommandState():
        return 'DeviceCommandState';
      case _i14.NotFoundException():
        return 'NotFoundException';
      case _i15.ValidationException():
        return 'ValidationException';
      case _i16.Company():
        return 'Company';
      case _i17.CompanyMembership():
        return 'CompanyMembership';
      case _i18.CompanyRole():
        return 'CompanyRole';
      case _i19.DeviceShare():
        return 'DeviceShare';
      case _i20.MemberAccessSummary():
        return 'MemberAccessSummary';
      case _i21.PlatformPermission():
        return 'PlatformPermission';
      case _i22.DashboardSummary():
        return 'DashboardSummary';
      case _i23.SiteSummary():
        return 'SiteSummary';
      case _i24.ControlPresentation():
        return 'ControlPresentation';
      case _i25.CustomDeviceProfile():
        return 'CustomDeviceProfile';
      case _i26.Device():
        return 'Device';
      case _i27.DeviceConnectionState():
        return 'DeviceConnectionState';
      case _i28.DeviceFeature():
        return 'DeviceFeature';
      case _i29.DeviceProfile():
        return 'DeviceProfile';
      case _i30.DeviceStatus():
        return 'DeviceStatus';
      case _i31.FeatureCatalogItem():
        return 'FeatureCatalogItem';
      case _i32.FeatureDataType():
        return 'FeatureDataType';
      case _i33.FeatureDefinition():
        return 'FeatureDefinition';
      case _i34.FeatureKind():
        return 'FeatureKind';
      case _i35.Gateway():
        return 'Gateway';
      case _i36.Greeting():
        return 'Greeting';
      case _i37.OeeSiteSummary():
        return 'OeeSiteSummary';
      case _i38.OeeSummary():
        return 'OeeSummary';
      case _i39.ProductionStat():
        return 'ProductionStat';
      case _i40.AuditLog():
        return 'AuditLog';
      case _i41.AutomationAction():
        return 'AutomationAction';
      case _i42.AutomationBranch():
        return 'AutomationBranch';
      case _i43.AutomationCondition():
        return 'AutomationCondition';
      case _i44.AutomationRule():
        return 'AutomationRule';
      case _i45.AutomationRun():
        return 'AutomationRun';
      case _i46.FirmwareArtifact():
        return 'FirmwareArtifact';
      case _i47.FirmwarePackage():
        return 'FirmwarePackage';
      case _i48.FirmwarePackageState():
        return 'FirmwarePackageState';
      case _i49.FirmwareReleaseDetail():
        return 'FirmwareReleaseDetail';
      case _i50.OtaCampaign():
        return 'OtaCampaign';
      case _i51.OtaCampaignDetail():
        return 'OtaCampaignDetail';
      case _i52.OtaCampaignState():
        return 'OtaCampaignState';
      case _i53.OtaDeviceJob():
        return 'OtaDeviceJob';
      case _i54.OtaJobState():
        return 'OtaJobState';
      case _i55.OtaStrategy():
        return 'OtaStrategy';
      case _i56.OtaTarget():
        return 'OtaTarget';
      case _i57.BomItem():
        return 'BomItem';
      case _i58.LineTransfer():
        return 'LineTransfer';
      case _i59.LineTransferStatus():
        return 'LineTransferStatus';
      case _i60.MaterialItem():
        return 'MaterialItem';
      case _i61.MaterialLot():
        return 'MaterialLot';
      case _i62.MaterialType():
        return 'MaterialType';
      case _i63.ProcessEvent():
        return 'ProcessEvent';
      case _i64.ProcessEventType():
        return 'ProcessEventType';
      case _i65.ProcessNode():
        return 'ProcessNode';
      case _i66.ProcessResult():
        return 'ProcessResult';
      case _i67.ProcessRoute():
        return 'ProcessRoute';
      case _i68.ProductDefinition():
        return 'ProductDefinition';
      case _i69.ProductTrace():
        return 'ProductTrace';
      case _i70.ProductUnit():
        return 'ProductUnit';
      case _i71.ProductUnitStatus():
        return 'ProductUnitStatus';
      case _i72.ProductionLine():
        return 'ProductionLine';
      case _i73.ProductionOrder():
        return 'ProductionOrder';
      case _i74.ProductionOrderStatus():
        return 'ProductionOrderStatus';
      case _i75.ProductionSummary():
        return 'ProductionSummary';
      case _i76.Workstation():
        return 'Workstation';
      case _i77.WorkstationAssignment():
        return 'WorkstationAssignment';
      case _i78.WorkstationAssignmentDetail():
        return 'WorkstationAssignmentDetail';
      case _i79.CertificateIssueResult():
        return 'CertificateIssueResult';
      case _i80.ClaimSessionResult():
        return 'ClaimSessionResult';
      case _i81.DeviceCertificate():
        return 'DeviceCertificate';
      case _i82.DeviceClaim():
        return 'DeviceClaim';
      case _i83.ProvisionedDevice():
        return 'ProvisionedDevice';
      case _i84.ProvisioningState():
        return 'ProvisioningState';
      case _i85.Site():
        return 'Site';
      case _i86.Measurement():
        return 'Measurement';
      case _i87.MeasurementListResult():
        return 'MeasurementListResult';
      case _i88.WorkOrder():
        return 'WorkOrder';
      case _i89.WorkOrderListResult():
        return 'WorkOrderListResult';
      case _i90.WorkOrderPriority():
        return 'WorkOrderPriority';
      case _i91.WorkOrderStatus():
        return 'WorkOrderStatus';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Alert') {
      return deserialize<_i5.Alert>(data['data']);
    }
    if (dataClassName == 'AlertComparison') {
      return deserialize<_i6.AlertComparison>(data['data']);
    }
    if (dataClassName == 'AlertListResult') {
      return deserialize<_i7.AlertListResult>(data['data']);
    }
    if (dataClassName == 'AlertRule') {
      return deserialize<_i8.AlertRule>(data['data']);
    }
    if (dataClassName == 'AlertSeverity') {
      return deserialize<_i9.AlertSeverity>(data['data']);
    }
    if (dataClassName == 'AlertState') {
      return deserialize<_i10.AlertState>(data['data']);
    }
    if (dataClassName == 'DeviceCommand') {
      return deserialize<_i11.DeviceCommand>(data['data']);
    }
    if (dataClassName == 'DeviceCommandListResult') {
      return deserialize<_i12.DeviceCommandListResult>(data['data']);
    }
    if (dataClassName == 'DeviceCommandState') {
      return deserialize<_i13.DeviceCommandState>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i14.NotFoundException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i15.ValidationException>(data['data']);
    }
    if (dataClassName == 'Company') {
      return deserialize<_i16.Company>(data['data']);
    }
    if (dataClassName == 'CompanyMembership') {
      return deserialize<_i17.CompanyMembership>(data['data']);
    }
    if (dataClassName == 'CompanyRole') {
      return deserialize<_i18.CompanyRole>(data['data']);
    }
    if (dataClassName == 'DeviceShare') {
      return deserialize<_i19.DeviceShare>(data['data']);
    }
    if (dataClassName == 'MemberAccessSummary') {
      return deserialize<_i20.MemberAccessSummary>(data['data']);
    }
    if (dataClassName == 'PlatformPermission') {
      return deserialize<_i21.PlatformPermission>(data['data']);
    }
    if (dataClassName == 'DashboardSummary') {
      return deserialize<_i22.DashboardSummary>(data['data']);
    }
    if (dataClassName == 'SiteSummary') {
      return deserialize<_i23.SiteSummary>(data['data']);
    }
    if (dataClassName == 'ControlPresentation') {
      return deserialize<_i24.ControlPresentation>(data['data']);
    }
    if (dataClassName == 'CustomDeviceProfile') {
      return deserialize<_i25.CustomDeviceProfile>(data['data']);
    }
    if (dataClassName == 'Device') {
      return deserialize<_i26.Device>(data['data']);
    }
    if (dataClassName == 'DeviceConnectionState') {
      return deserialize<_i27.DeviceConnectionState>(data['data']);
    }
    if (dataClassName == 'DeviceFeature') {
      return deserialize<_i28.DeviceFeature>(data['data']);
    }
    if (dataClassName == 'DeviceProfile') {
      return deserialize<_i29.DeviceProfile>(data['data']);
    }
    if (dataClassName == 'DeviceStatus') {
      return deserialize<_i30.DeviceStatus>(data['data']);
    }
    if (dataClassName == 'FeatureCatalogItem') {
      return deserialize<_i31.FeatureCatalogItem>(data['data']);
    }
    if (dataClassName == 'FeatureDataType') {
      return deserialize<_i32.FeatureDataType>(data['data']);
    }
    if (dataClassName == 'FeatureDefinition') {
      return deserialize<_i33.FeatureDefinition>(data['data']);
    }
    if (dataClassName == 'FeatureKind') {
      return deserialize<_i34.FeatureKind>(data['data']);
    }
    if (dataClassName == 'Gateway') {
      return deserialize<_i35.Gateway>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i36.Greeting>(data['data']);
    }
    if (dataClassName == 'OeeSiteSummary') {
      return deserialize<_i37.OeeSiteSummary>(data['data']);
    }
    if (dataClassName == 'OeeSummary') {
      return deserialize<_i38.OeeSummary>(data['data']);
    }
    if (dataClassName == 'ProductionStat') {
      return deserialize<_i39.ProductionStat>(data['data']);
    }
    if (dataClassName == 'AuditLog') {
      return deserialize<_i40.AuditLog>(data['data']);
    }
    if (dataClassName == 'AutomationAction') {
      return deserialize<_i41.AutomationAction>(data['data']);
    }
    if (dataClassName == 'AutomationBranch') {
      return deserialize<_i42.AutomationBranch>(data['data']);
    }
    if (dataClassName == 'AutomationCondition') {
      return deserialize<_i43.AutomationCondition>(data['data']);
    }
    if (dataClassName == 'AutomationRule') {
      return deserialize<_i44.AutomationRule>(data['data']);
    }
    if (dataClassName == 'AutomationRun') {
      return deserialize<_i45.AutomationRun>(data['data']);
    }
    if (dataClassName == 'FirmwareArtifact') {
      return deserialize<_i46.FirmwareArtifact>(data['data']);
    }
    if (dataClassName == 'FirmwarePackage') {
      return deserialize<_i47.FirmwarePackage>(data['data']);
    }
    if (dataClassName == 'FirmwarePackageState') {
      return deserialize<_i48.FirmwarePackageState>(data['data']);
    }
    if (dataClassName == 'FirmwareReleaseDetail') {
      return deserialize<_i49.FirmwareReleaseDetail>(data['data']);
    }
    if (dataClassName == 'OtaCampaign') {
      return deserialize<_i50.OtaCampaign>(data['data']);
    }
    if (dataClassName == 'OtaCampaignDetail') {
      return deserialize<_i51.OtaCampaignDetail>(data['data']);
    }
    if (dataClassName == 'OtaCampaignState') {
      return deserialize<_i52.OtaCampaignState>(data['data']);
    }
    if (dataClassName == 'OtaDeviceJob') {
      return deserialize<_i53.OtaDeviceJob>(data['data']);
    }
    if (dataClassName == 'OtaJobState') {
      return deserialize<_i54.OtaJobState>(data['data']);
    }
    if (dataClassName == 'OtaStrategy') {
      return deserialize<_i55.OtaStrategy>(data['data']);
    }
    if (dataClassName == 'OtaTarget') {
      return deserialize<_i56.OtaTarget>(data['data']);
    }
    if (dataClassName == 'BomItem') {
      return deserialize<_i57.BomItem>(data['data']);
    }
    if (dataClassName == 'LineTransfer') {
      return deserialize<_i58.LineTransfer>(data['data']);
    }
    if (dataClassName == 'LineTransferStatus') {
      return deserialize<_i59.LineTransferStatus>(data['data']);
    }
    if (dataClassName == 'MaterialItem') {
      return deserialize<_i60.MaterialItem>(data['data']);
    }
    if (dataClassName == 'MaterialLot') {
      return deserialize<_i61.MaterialLot>(data['data']);
    }
    if (dataClassName == 'MaterialType') {
      return deserialize<_i62.MaterialType>(data['data']);
    }
    if (dataClassName == 'ProcessEvent') {
      return deserialize<_i63.ProcessEvent>(data['data']);
    }
    if (dataClassName == 'ProcessEventType') {
      return deserialize<_i64.ProcessEventType>(data['data']);
    }
    if (dataClassName == 'ProcessNode') {
      return deserialize<_i65.ProcessNode>(data['data']);
    }
    if (dataClassName == 'ProcessResult') {
      return deserialize<_i66.ProcessResult>(data['data']);
    }
    if (dataClassName == 'ProcessRoute') {
      return deserialize<_i67.ProcessRoute>(data['data']);
    }
    if (dataClassName == 'ProductDefinition') {
      return deserialize<_i68.ProductDefinition>(data['data']);
    }
    if (dataClassName == 'ProductTrace') {
      return deserialize<_i69.ProductTrace>(data['data']);
    }
    if (dataClassName == 'ProductUnit') {
      return deserialize<_i70.ProductUnit>(data['data']);
    }
    if (dataClassName == 'ProductUnitStatus') {
      return deserialize<_i71.ProductUnitStatus>(data['data']);
    }
    if (dataClassName == 'ProductionLine') {
      return deserialize<_i72.ProductionLine>(data['data']);
    }
    if (dataClassName == 'ProductionOrder') {
      return deserialize<_i73.ProductionOrder>(data['data']);
    }
    if (dataClassName == 'ProductionOrderStatus') {
      return deserialize<_i74.ProductionOrderStatus>(data['data']);
    }
    if (dataClassName == 'ProductionSummary') {
      return deserialize<_i75.ProductionSummary>(data['data']);
    }
    if (dataClassName == 'Workstation') {
      return deserialize<_i76.Workstation>(data['data']);
    }
    if (dataClassName == 'WorkstationAssignment') {
      return deserialize<_i77.WorkstationAssignment>(data['data']);
    }
    if (dataClassName == 'WorkstationAssignmentDetail') {
      return deserialize<_i78.WorkstationAssignmentDetail>(data['data']);
    }
    if (dataClassName == 'CertificateIssueResult') {
      return deserialize<_i79.CertificateIssueResult>(data['data']);
    }
    if (dataClassName == 'ClaimSessionResult') {
      return deserialize<_i80.ClaimSessionResult>(data['data']);
    }
    if (dataClassName == 'DeviceCertificate') {
      return deserialize<_i81.DeviceCertificate>(data['data']);
    }
    if (dataClassName == 'DeviceClaim') {
      return deserialize<_i82.DeviceClaim>(data['data']);
    }
    if (dataClassName == 'ProvisionedDevice') {
      return deserialize<_i83.ProvisionedDevice>(data['data']);
    }
    if (dataClassName == 'ProvisioningState') {
      return deserialize<_i84.ProvisioningState>(data['data']);
    }
    if (dataClassName == 'Site') {
      return deserialize<_i85.Site>(data['data']);
    }
    if (dataClassName == 'Measurement') {
      return deserialize<_i86.Measurement>(data['data']);
    }
    if (dataClassName == 'MeasurementListResult') {
      return deserialize<_i87.MeasurementListResult>(data['data']);
    }
    if (dataClassName == 'WorkOrder') {
      return deserialize<_i88.WorkOrder>(data['data']);
    }
    if (dataClassName == 'WorkOrderListResult') {
      return deserialize<_i89.WorkOrderListResult>(data['data']);
    }
    if (dataClassName == 'WorkOrderPriority') {
      return deserialize<_i90.WorkOrderPriority>(data['data']);
    }
    if (dataClassName == 'WorkOrderStatus') {
      return deserialize<_i91.WorkOrderStatus>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.Alert:
        return _i5.Alert.t;
      case _i8.AlertRule:
        return _i8.AlertRule.t;
      case _i11.DeviceCommand:
        return _i11.DeviceCommand.t;
      case _i16.Company:
        return _i16.Company.t;
      case _i17.CompanyMembership:
        return _i17.CompanyMembership.t;
      case _i19.DeviceShare:
        return _i19.DeviceShare.t;
      case _i25.CustomDeviceProfile:
        return _i25.CustomDeviceProfile.t;
      case _i26.Device:
        return _i26.Device.t;
      case _i30.DeviceStatus:
        return _i30.DeviceStatus.t;
      case _i33.FeatureDefinition:
        return _i33.FeatureDefinition.t;
      case _i35.Gateway:
        return _i35.Gateway.t;
      case _i39.ProductionStat:
        return _i39.ProductionStat.t;
      case _i40.AuditLog:
        return _i40.AuditLog.t;
      case _i44.AutomationRule:
        return _i44.AutomationRule.t;
      case _i45.AutomationRun:
        return _i45.AutomationRun.t;
      case _i46.FirmwareArtifact:
        return _i46.FirmwareArtifact.t;
      case _i47.FirmwarePackage:
        return _i47.FirmwarePackage.t;
      case _i50.OtaCampaign:
        return _i50.OtaCampaign.t;
      case _i53.OtaDeviceJob:
        return _i53.OtaDeviceJob.t;
      case _i57.BomItem:
        return _i57.BomItem.t;
      case _i58.LineTransfer:
        return _i58.LineTransfer.t;
      case _i60.MaterialItem:
        return _i60.MaterialItem.t;
      case _i61.MaterialLot:
        return _i61.MaterialLot.t;
      case _i63.ProcessEvent:
        return _i63.ProcessEvent.t;
      case _i65.ProcessNode:
        return _i65.ProcessNode.t;
      case _i67.ProcessRoute:
        return _i67.ProcessRoute.t;
      case _i68.ProductDefinition:
        return _i68.ProductDefinition.t;
      case _i70.ProductUnit:
        return _i70.ProductUnit.t;
      case _i72.ProductionLine:
        return _i72.ProductionLine.t;
      case _i73.ProductionOrder:
        return _i73.ProductionOrder.t;
      case _i76.Workstation:
        return _i76.Workstation.t;
      case _i77.WorkstationAssignment:
        return _i77.WorkstationAssignment.t;
      case _i81.DeviceCertificate:
        return _i81.DeviceCertificate.t;
      case _i82.DeviceClaim:
        return _i82.DeviceClaim.t;
      case _i83.ProvisionedDevice:
        return _i83.ProvisionedDevice.t;
      case _i85.Site:
        return _i85.Site.t;
      case _i86.Measurement:
        return _i86.Measurement.t;
      case _i88.WorkOrder:
        return _i88.WorkOrder.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'pod_app_v1';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
