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
import 'alert/alert.dart' as _i2;
import 'alert/alert_comparison.dart' as _i3;
import 'alert/alert_list_result.dart' as _i4;
import 'alert/alert_rule.dart' as _i5;
import 'alert/alert_severity.dart' as _i6;
import 'alert/alert_state.dart' as _i7;
import 'command/device_command.dart' as _i8;
import 'command/device_command_list_result.dart' as _i9;
import 'command/device_command_state.dart' as _i10;
import 'common/not_found_exception.dart' as _i11;
import 'common/validation_exception.dart' as _i12;
import 'company/company.dart' as _i13;
import 'company/company_membership.dart' as _i14;
import 'company/company_role.dart' as _i15;
import 'company/device_share.dart' as _i16;
import 'company/member_access_summary.dart' as _i17;
import 'company/platform_permission.dart' as _i18;
import 'dashboard/dashboard_summary.dart' as _i19;
import 'dashboard/site_summary.dart' as _i20;
import 'device/control_presentation.dart' as _i21;
import 'device/custom_device_profile.dart' as _i22;
import 'device/device.dart' as _i23;
import 'device/device_connection_state.dart' as _i24;
import 'device/device_feature.dart' as _i25;
import 'device/device_profile.dart' as _i26;
import 'device/device_status.dart' as _i27;
import 'device/feature_catalog_item.dart' as _i28;
import 'device/feature_data_type.dart' as _i29;
import 'device/feature_definition.dart' as _i30;
import 'device/feature_kind.dart' as _i31;
import 'gateway/gateway.dart' as _i32;
import 'greetings/greeting.dart' as _i33;
import 'oee/oee_site_summary.dart' as _i34;
import 'oee/oee_summary.dart' as _i35;
import 'oee/production_stat.dart' as _i36;
import 'operations/audit_log.dart' as _i37;
import 'operations/automation_action.dart' as _i38;
import 'operations/automation_branch.dart' as _i39;
import 'operations/automation_condition.dart' as _i40;
import 'operations/automation_rule.dart' as _i41;
import 'operations/automation_run.dart' as _i42;
import 'ota/firmware_artifact.dart' as _i43;
import 'ota/firmware_package.dart' as _i44;
import 'ota/firmware_package_state.dart' as _i45;
import 'ota/firmware_release_detail.dart' as _i46;
import 'ota/ota_campaign.dart' as _i47;
import 'ota/ota_campaign_detail.dart' as _i48;
import 'ota/ota_campaign_state.dart' as _i49;
import 'ota/ota_device_job.dart' as _i50;
import 'ota/ota_job_state.dart' as _i51;
import 'ota/ota_strategy.dart' as _i52;
import 'ota/ota_target.dart' as _i53;
import 'production/bom_item.dart' as _i54;
import 'production/line_transfer.dart' as _i55;
import 'production/line_transfer_status.dart' as _i56;
import 'production/material_item.dart' as _i57;
import 'production/material_lot.dart' as _i58;
import 'production/material_type.dart' as _i59;
import 'production/process_event.dart' as _i60;
import 'production/process_event_type.dart' as _i61;
import 'production/process_node.dart' as _i62;
import 'production/process_result.dart' as _i63;
import 'production/process_route.dart' as _i64;
import 'production/product_definition.dart' as _i65;
import 'production/product_trace.dart' as _i66;
import 'production/product_unit.dart' as _i67;
import 'production/product_unit_status.dart' as _i68;
import 'production/production_line.dart' as _i69;
import 'production/production_order.dart' as _i70;
import 'production/production_order_status.dart' as _i71;
import 'production/production_summary.dart' as _i72;
import 'production/workstation.dart' as _i73;
import 'production/workstation_assignment.dart' as _i74;
import 'production/workstation_assignment_detail.dart' as _i75;
import 'provisioning/certificate_issue_result.dart' as _i76;
import 'provisioning/claim_session_result.dart' as _i77;
import 'provisioning/device_certificate.dart' as _i78;
import 'provisioning/device_claim.dart' as _i79;
import 'provisioning/provisioned_device.dart' as _i80;
import 'provisioning/provisioning_state.dart' as _i81;
import 'site/site.dart' as _i82;
import 'telemetry/measurement.dart' as _i83;
import 'telemetry/measurement_list_result.dart' as _i84;
import 'workorder/work_order.dart' as _i85;
import 'workorder/work_order_list_result.dart' as _i86;
import 'workorder/work_order_priority.dart' as _i87;
import 'workorder/work_order_status.dart' as _i88;
import 'package:pod_app_v1_client/src/protocol/alert/alert_rule.dart' as _i89;
import 'package:pod_app_v1_client/src/protocol/company/member_access_summary.dart'
    as _i90;
import 'package:pod_app_v1_client/src/protocol/company/platform_permission.dart'
    as _i91;
import 'package:pod_app_v1_client/src/protocol/device/device_profile.dart'
    as _i92;
import 'package:pod_app_v1_client/src/protocol/device/feature_catalog_item.dart'
    as _i93;
import 'package:pod_app_v1_client/src/protocol/device/device_feature.dart'
    as _i94;
import 'package:pod_app_v1_client/src/protocol/device/device.dart' as _i95;
import 'package:pod_app_v1_client/src/protocol/gateway/gateway.dart' as _i96;
import 'package:pod_app_v1_client/src/protocol/operations/automation_rule.dart'
    as _i97;
import 'package:pod_app_v1_client/src/protocol/operations/automation_branch.dart'
    as _i98;
import 'package:pod_app_v1_client/src/protocol/operations/automation_run.dart'
    as _i99;
import 'package:pod_app_v1_client/src/protocol/operations/audit_log.dart'
    as _i100;
import 'package:pod_app_v1_client/src/protocol/ota/firmware_package.dart'
    as _i101;
import 'package:pod_app_v1_client/src/protocol/ota/firmware_release_detail.dart'
    as _i102;
import 'dart:typed_data' as _i103;
import 'package:pod_app_v1_client/src/protocol/ota/ota_campaign.dart' as _i104;
import 'package:pod_app_v1_client/src/protocol/ota/ota_target.dart' as _i105;
import 'package:pod_app_v1_client/src/protocol/production/material_item.dart'
    as _i106;
import 'package:pod_app_v1_client/src/protocol/production/material_lot.dart'
    as _i107;
import 'package:pod_app_v1_client/src/protocol/production/product_definition.dart'
    as _i108;
import 'package:pod_app_v1_client/src/protocol/production/bom_item.dart'
    as _i109;
import 'package:pod_app_v1_client/src/protocol/production/process_route.dart'
    as _i110;
import 'package:pod_app_v1_client/src/protocol/production/production_line.dart'
    as _i111;
import 'package:pod_app_v1_client/src/protocol/production/workstation.dart'
    as _i112;
import 'package:pod_app_v1_client/src/protocol/production/workstation_assignment_detail.dart'
    as _i113;
import 'package:pod_app_v1_client/src/protocol/production/line_transfer.dart'
    as _i114;
import 'package:pod_app_v1_client/src/protocol/production/process_node.dart'
    as _i115;
import 'package:pod_app_v1_client/src/protocol/production/production_order.dart'
    as _i116;
import 'package:pod_app_v1_client/src/protocol/production/product_unit.dart'
    as _i117;
import 'package:pod_app_v1_client/src/protocol/provisioning/provisioned_device.dart'
    as _i118;
import 'package:pod_app_v1_client/src/protocol/provisioning/device_certificate.dart'
    as _i119;
import 'package:pod_app_v1_client/src/protocol/site/site.dart' as _i120;
import 'package:pod_app_v1_client/src/protocol/device/device_status.dart'
    as _i121;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i122;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i123;
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.Alert) {
      return _i2.Alert.fromJson(data) as T;
    }
    if (t == _i3.AlertComparison) {
      return _i3.AlertComparison.fromJson(data) as T;
    }
    if (t == _i4.AlertListResult) {
      return _i4.AlertListResult.fromJson(data) as T;
    }
    if (t == _i5.AlertRule) {
      return _i5.AlertRule.fromJson(data) as T;
    }
    if (t == _i6.AlertSeverity) {
      return _i6.AlertSeverity.fromJson(data) as T;
    }
    if (t == _i7.AlertState) {
      return _i7.AlertState.fromJson(data) as T;
    }
    if (t == _i8.DeviceCommand) {
      return _i8.DeviceCommand.fromJson(data) as T;
    }
    if (t == _i9.DeviceCommandListResult) {
      return _i9.DeviceCommandListResult.fromJson(data) as T;
    }
    if (t == _i10.DeviceCommandState) {
      return _i10.DeviceCommandState.fromJson(data) as T;
    }
    if (t == _i11.NotFoundException) {
      return _i11.NotFoundException.fromJson(data) as T;
    }
    if (t == _i12.ValidationException) {
      return _i12.ValidationException.fromJson(data) as T;
    }
    if (t == _i13.Company) {
      return _i13.Company.fromJson(data) as T;
    }
    if (t == _i14.CompanyMembership) {
      return _i14.CompanyMembership.fromJson(data) as T;
    }
    if (t == _i15.CompanyRole) {
      return _i15.CompanyRole.fromJson(data) as T;
    }
    if (t == _i16.DeviceShare) {
      return _i16.DeviceShare.fromJson(data) as T;
    }
    if (t == _i17.MemberAccessSummary) {
      return _i17.MemberAccessSummary.fromJson(data) as T;
    }
    if (t == _i18.PlatformPermission) {
      return _i18.PlatformPermission.fromJson(data) as T;
    }
    if (t == _i19.DashboardSummary) {
      return _i19.DashboardSummary.fromJson(data) as T;
    }
    if (t == _i20.SiteSummary) {
      return _i20.SiteSummary.fromJson(data) as T;
    }
    if (t == _i21.ControlPresentation) {
      return _i21.ControlPresentation.fromJson(data) as T;
    }
    if (t == _i22.CustomDeviceProfile) {
      return _i22.CustomDeviceProfile.fromJson(data) as T;
    }
    if (t == _i23.Device) {
      return _i23.Device.fromJson(data) as T;
    }
    if (t == _i24.DeviceConnectionState) {
      return _i24.DeviceConnectionState.fromJson(data) as T;
    }
    if (t == _i25.DeviceFeature) {
      return _i25.DeviceFeature.fromJson(data) as T;
    }
    if (t == _i26.DeviceProfile) {
      return _i26.DeviceProfile.fromJson(data) as T;
    }
    if (t == _i27.DeviceStatus) {
      return _i27.DeviceStatus.fromJson(data) as T;
    }
    if (t == _i28.FeatureCatalogItem) {
      return _i28.FeatureCatalogItem.fromJson(data) as T;
    }
    if (t == _i29.FeatureDataType) {
      return _i29.FeatureDataType.fromJson(data) as T;
    }
    if (t == _i30.FeatureDefinition) {
      return _i30.FeatureDefinition.fromJson(data) as T;
    }
    if (t == _i31.FeatureKind) {
      return _i31.FeatureKind.fromJson(data) as T;
    }
    if (t == _i32.Gateway) {
      return _i32.Gateway.fromJson(data) as T;
    }
    if (t == _i33.Greeting) {
      return _i33.Greeting.fromJson(data) as T;
    }
    if (t == _i34.OeeSiteSummary) {
      return _i34.OeeSiteSummary.fromJson(data) as T;
    }
    if (t == _i35.OeeSummary) {
      return _i35.OeeSummary.fromJson(data) as T;
    }
    if (t == _i36.ProductionStat) {
      return _i36.ProductionStat.fromJson(data) as T;
    }
    if (t == _i37.AuditLog) {
      return _i37.AuditLog.fromJson(data) as T;
    }
    if (t == _i38.AutomationAction) {
      return _i38.AutomationAction.fromJson(data) as T;
    }
    if (t == _i39.AutomationBranch) {
      return _i39.AutomationBranch.fromJson(data) as T;
    }
    if (t == _i40.AutomationCondition) {
      return _i40.AutomationCondition.fromJson(data) as T;
    }
    if (t == _i41.AutomationRule) {
      return _i41.AutomationRule.fromJson(data) as T;
    }
    if (t == _i42.AutomationRun) {
      return _i42.AutomationRun.fromJson(data) as T;
    }
    if (t == _i43.FirmwareArtifact) {
      return _i43.FirmwareArtifact.fromJson(data) as T;
    }
    if (t == _i44.FirmwarePackage) {
      return _i44.FirmwarePackage.fromJson(data) as T;
    }
    if (t == _i45.FirmwarePackageState) {
      return _i45.FirmwarePackageState.fromJson(data) as T;
    }
    if (t == _i46.FirmwareReleaseDetail) {
      return _i46.FirmwareReleaseDetail.fromJson(data) as T;
    }
    if (t == _i47.OtaCampaign) {
      return _i47.OtaCampaign.fromJson(data) as T;
    }
    if (t == _i48.OtaCampaignDetail) {
      return _i48.OtaCampaignDetail.fromJson(data) as T;
    }
    if (t == _i49.OtaCampaignState) {
      return _i49.OtaCampaignState.fromJson(data) as T;
    }
    if (t == _i50.OtaDeviceJob) {
      return _i50.OtaDeviceJob.fromJson(data) as T;
    }
    if (t == _i51.OtaJobState) {
      return _i51.OtaJobState.fromJson(data) as T;
    }
    if (t == _i52.OtaStrategy) {
      return _i52.OtaStrategy.fromJson(data) as T;
    }
    if (t == _i53.OtaTarget) {
      return _i53.OtaTarget.fromJson(data) as T;
    }
    if (t == _i54.BomItem) {
      return _i54.BomItem.fromJson(data) as T;
    }
    if (t == _i55.LineTransfer) {
      return _i55.LineTransfer.fromJson(data) as T;
    }
    if (t == _i56.LineTransferStatus) {
      return _i56.LineTransferStatus.fromJson(data) as T;
    }
    if (t == _i57.MaterialItem) {
      return _i57.MaterialItem.fromJson(data) as T;
    }
    if (t == _i58.MaterialLot) {
      return _i58.MaterialLot.fromJson(data) as T;
    }
    if (t == _i59.MaterialType) {
      return _i59.MaterialType.fromJson(data) as T;
    }
    if (t == _i60.ProcessEvent) {
      return _i60.ProcessEvent.fromJson(data) as T;
    }
    if (t == _i61.ProcessEventType) {
      return _i61.ProcessEventType.fromJson(data) as T;
    }
    if (t == _i62.ProcessNode) {
      return _i62.ProcessNode.fromJson(data) as T;
    }
    if (t == _i63.ProcessResult) {
      return _i63.ProcessResult.fromJson(data) as T;
    }
    if (t == _i64.ProcessRoute) {
      return _i64.ProcessRoute.fromJson(data) as T;
    }
    if (t == _i65.ProductDefinition) {
      return _i65.ProductDefinition.fromJson(data) as T;
    }
    if (t == _i66.ProductTrace) {
      return _i66.ProductTrace.fromJson(data) as T;
    }
    if (t == _i67.ProductUnit) {
      return _i67.ProductUnit.fromJson(data) as T;
    }
    if (t == _i68.ProductUnitStatus) {
      return _i68.ProductUnitStatus.fromJson(data) as T;
    }
    if (t == _i69.ProductionLine) {
      return _i69.ProductionLine.fromJson(data) as T;
    }
    if (t == _i70.ProductionOrder) {
      return _i70.ProductionOrder.fromJson(data) as T;
    }
    if (t == _i71.ProductionOrderStatus) {
      return _i71.ProductionOrderStatus.fromJson(data) as T;
    }
    if (t == _i72.ProductionSummary) {
      return _i72.ProductionSummary.fromJson(data) as T;
    }
    if (t == _i73.Workstation) {
      return _i73.Workstation.fromJson(data) as T;
    }
    if (t == _i74.WorkstationAssignment) {
      return _i74.WorkstationAssignment.fromJson(data) as T;
    }
    if (t == _i75.WorkstationAssignmentDetail) {
      return _i75.WorkstationAssignmentDetail.fromJson(data) as T;
    }
    if (t == _i76.CertificateIssueResult) {
      return _i76.CertificateIssueResult.fromJson(data) as T;
    }
    if (t == _i77.ClaimSessionResult) {
      return _i77.ClaimSessionResult.fromJson(data) as T;
    }
    if (t == _i78.DeviceCertificate) {
      return _i78.DeviceCertificate.fromJson(data) as T;
    }
    if (t == _i79.DeviceClaim) {
      return _i79.DeviceClaim.fromJson(data) as T;
    }
    if (t == _i80.ProvisionedDevice) {
      return _i80.ProvisionedDevice.fromJson(data) as T;
    }
    if (t == _i81.ProvisioningState) {
      return _i81.ProvisioningState.fromJson(data) as T;
    }
    if (t == _i82.Site) {
      return _i82.Site.fromJson(data) as T;
    }
    if (t == _i83.Measurement) {
      return _i83.Measurement.fromJson(data) as T;
    }
    if (t == _i84.MeasurementListResult) {
      return _i84.MeasurementListResult.fromJson(data) as T;
    }
    if (t == _i85.WorkOrder) {
      return _i85.WorkOrder.fromJson(data) as T;
    }
    if (t == _i86.WorkOrderListResult) {
      return _i86.WorkOrderListResult.fromJson(data) as T;
    }
    if (t == _i87.WorkOrderPriority) {
      return _i87.WorkOrderPriority.fromJson(data) as T;
    }
    if (t == _i88.WorkOrderStatus) {
      return _i88.WorkOrderStatus.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Alert?>()) {
      return (data != null ? _i2.Alert.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AlertComparison?>()) {
      return (data != null ? _i3.AlertComparison.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AlertListResult?>()) {
      return (data != null ? _i4.AlertListResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AlertRule?>()) {
      return (data != null ? _i5.AlertRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AlertSeverity?>()) {
      return (data != null ? _i6.AlertSeverity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AlertState?>()) {
      return (data != null ? _i7.AlertState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DeviceCommand?>()) {
      return (data != null ? _i8.DeviceCommand.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DeviceCommandListResult?>()) {
      return (data != null ? _i9.DeviceCommandListResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.DeviceCommandState?>()) {
      return (data != null ? _i10.DeviceCommandState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.NotFoundException?>()) {
      return (data != null ? _i11.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ValidationException?>()) {
      return (data != null ? _i12.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.Company?>()) {
      return (data != null ? _i13.Company.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CompanyMembership?>()) {
      return (data != null ? _i14.CompanyMembership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.CompanyRole?>()) {
      return (data != null ? _i15.CompanyRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.DeviceShare?>()) {
      return (data != null ? _i16.DeviceShare.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.MemberAccessSummary?>()) {
      return (data != null ? _i17.MemberAccessSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.PlatformPermission?>()) {
      return (data != null ? _i18.PlatformPermission.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.DashboardSummary?>()) {
      return (data != null ? _i19.DashboardSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.SiteSummary?>()) {
      return (data != null ? _i20.SiteSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.ControlPresentation?>()) {
      return (data != null ? _i21.ControlPresentation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.CustomDeviceProfile?>()) {
      return (data != null ? _i22.CustomDeviceProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.Device?>()) {
      return (data != null ? _i23.Device.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.DeviceConnectionState?>()) {
      return (data != null ? _i24.DeviceConnectionState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.DeviceFeature?>()) {
      return (data != null ? _i25.DeviceFeature.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.DeviceProfile?>()) {
      return (data != null ? _i26.DeviceProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.DeviceStatus?>()) {
      return (data != null ? _i27.DeviceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.FeatureCatalogItem?>()) {
      return (data != null ? _i28.FeatureCatalogItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.FeatureDataType?>()) {
      return (data != null ? _i29.FeatureDataType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.FeatureDefinition?>()) {
      return (data != null ? _i30.FeatureDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.FeatureKind?>()) {
      return (data != null ? _i31.FeatureKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.Gateway?>()) {
      return (data != null ? _i32.Gateway.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.Greeting?>()) {
      return (data != null ? _i33.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.OeeSiteSummary?>()) {
      return (data != null ? _i34.OeeSiteSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.OeeSummary?>()) {
      return (data != null ? _i35.OeeSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.ProductionStat?>()) {
      return (data != null ? _i36.ProductionStat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.AuditLog?>()) {
      return (data != null ? _i37.AuditLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.AutomationAction?>()) {
      return (data != null ? _i38.AutomationAction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.AutomationBranch?>()) {
      return (data != null ? _i39.AutomationBranch.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.AutomationCondition?>()) {
      return (data != null ? _i40.AutomationCondition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.AutomationRule?>()) {
      return (data != null ? _i41.AutomationRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.AutomationRun?>()) {
      return (data != null ? _i42.AutomationRun.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.FirmwareArtifact?>()) {
      return (data != null ? _i43.FirmwareArtifact.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.FirmwarePackage?>()) {
      return (data != null ? _i44.FirmwarePackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.FirmwarePackageState?>()) {
      return (data != null ? _i45.FirmwarePackageState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.FirmwareReleaseDetail?>()) {
      return (data != null ? _i46.FirmwareReleaseDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.OtaCampaign?>()) {
      return (data != null ? _i47.OtaCampaign.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.OtaCampaignDetail?>()) {
      return (data != null ? _i48.OtaCampaignDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.OtaCampaignState?>()) {
      return (data != null ? _i49.OtaCampaignState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.OtaDeviceJob?>()) {
      return (data != null ? _i50.OtaDeviceJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.OtaJobState?>()) {
      return (data != null ? _i51.OtaJobState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.OtaStrategy?>()) {
      return (data != null ? _i52.OtaStrategy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.OtaTarget?>()) {
      return (data != null ? _i53.OtaTarget.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.BomItem?>()) {
      return (data != null ? _i54.BomItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.LineTransfer?>()) {
      return (data != null ? _i55.LineTransfer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.LineTransferStatus?>()) {
      return (data != null ? _i56.LineTransferStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.MaterialItem?>()) {
      return (data != null ? _i57.MaterialItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.MaterialLot?>()) {
      return (data != null ? _i58.MaterialLot.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.MaterialType?>()) {
      return (data != null ? _i59.MaterialType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.ProcessEvent?>()) {
      return (data != null ? _i60.ProcessEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.ProcessEventType?>()) {
      return (data != null ? _i61.ProcessEventType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.ProcessNode?>()) {
      return (data != null ? _i62.ProcessNode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.ProcessResult?>()) {
      return (data != null ? _i63.ProcessResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.ProcessRoute?>()) {
      return (data != null ? _i64.ProcessRoute.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.ProductDefinition?>()) {
      return (data != null ? _i65.ProductDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.ProductTrace?>()) {
      return (data != null ? _i66.ProductTrace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.ProductUnit?>()) {
      return (data != null ? _i67.ProductUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.ProductUnitStatus?>()) {
      return (data != null ? _i68.ProductUnitStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.ProductionLine?>()) {
      return (data != null ? _i69.ProductionLine.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.ProductionOrder?>()) {
      return (data != null ? _i70.ProductionOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.ProductionOrderStatus?>()) {
      return (data != null ? _i71.ProductionOrderStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i72.ProductionSummary?>()) {
      return (data != null ? _i72.ProductionSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.Workstation?>()) {
      return (data != null ? _i73.Workstation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.WorkstationAssignment?>()) {
      return (data != null ? _i74.WorkstationAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i75.WorkstationAssignmentDetail?>()) {
      return (data != null
              ? _i75.WorkstationAssignmentDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i76.CertificateIssueResult?>()) {
      return (data != null ? _i76.CertificateIssueResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i77.ClaimSessionResult?>()) {
      return (data != null ? _i77.ClaimSessionResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i78.DeviceCertificate?>()) {
      return (data != null ? _i78.DeviceCertificate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.DeviceClaim?>()) {
      return (data != null ? _i79.DeviceClaim.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.ProvisionedDevice?>()) {
      return (data != null ? _i80.ProvisionedDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.ProvisioningState?>()) {
      return (data != null ? _i81.ProvisioningState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.Site?>()) {
      return (data != null ? _i82.Site.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i83.Measurement?>()) {
      return (data != null ? _i83.Measurement.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.MeasurementListResult?>()) {
      return (data != null ? _i84.MeasurementListResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i85.WorkOrder?>()) {
      return (data != null ? _i85.WorkOrder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i86.WorkOrderListResult?>()) {
      return (data != null ? _i86.WorkOrderListResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i87.WorkOrderPriority?>()) {
      return (data != null ? _i87.WorkOrderPriority.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i88.WorkOrderStatus?>()) {
      return (data != null ? _i88.WorkOrderStatus.fromJson(data) : null) as T;
    }
    if (t == List<_i2.Alert>) {
      return (data as List).map((e) => deserialize<_i2.Alert>(e)).toList() as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i8.DeviceCommand>) {
      return (data as List)
              .map((e) => deserialize<_i8.DeviceCommand>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.PlatformPermission>) {
      return (data as List)
              .map((e) => deserialize<_i18.PlatformPermission>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i18.PlatformPermission>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i18.PlatformPermission>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i20.SiteSummary>) {
      return (data as List)
              .map((e) => deserialize<_i20.SiteSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.DeviceFeature>) {
      return (data as List)
              .map((e) => deserialize<_i25.DeviceFeature>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i25.DeviceFeature>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i25.DeviceFeature>(e))
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
    if (t == List<_i34.OeeSiteSummary>) {
      return (data as List)
              .map((e) => deserialize<_i34.OeeSiteSummary>(e))
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
    if (t == List<_i40.AutomationCondition>) {
      return (data as List)
              .map((e) => deserialize<_i40.AutomationCondition>(e))
              .toList()
          as T;
    }
    if (t == List<_i38.AutomationAction>) {
      return (data as List)
              .map((e) => deserialize<_i38.AutomationAction>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.AutomationBranch>) {
      return (data as List)
              .map((e) => deserialize<_i39.AutomationBranch>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i39.AutomationBranch>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i39.AutomationBranch>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i43.FirmwareArtifact>) {
      return (data as List)
              .map((e) => deserialize<_i43.FirmwareArtifact>(e))
              .toList()
          as T;
    }
    if (t == List<_i50.OtaDeviceJob>) {
      return (data as List)
              .map((e) => deserialize<_i50.OtaDeviceJob>(e))
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
    if (t == List<_i60.ProcessEvent>) {
      return (data as List)
              .map((e) => deserialize<_i60.ProcessEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i83.Measurement>) {
      return (data as List)
              .map((e) => deserialize<_i83.Measurement>(e))
              .toList()
          as T;
    }
    if (t == List<_i85.WorkOrder>) {
      return (data as List).map((e) => deserialize<_i85.WorkOrder>(e)).toList()
          as T;
    }
    if (t == List<_i89.AlertRule>) {
      return (data as List).map((e) => deserialize<_i89.AlertRule>(e)).toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i90.MemberAccessSummary>) {
      return (data as List)
              .map((e) => deserialize<_i90.MemberAccessSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i91.PlatformPermission>) {
      return (data as List)
              .map((e) => deserialize<_i91.PlatformPermission>(e))
              .toList()
          as T;
    }
    if (t == List<_i92.DeviceProfile>) {
      return (data as List)
              .map((e) => deserialize<_i92.DeviceProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i93.FeatureCatalogItem>) {
      return (data as List)
              .map((e) => deserialize<_i93.FeatureCatalogItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i94.DeviceFeature>) {
      return (data as List)
              .map((e) => deserialize<_i94.DeviceFeature>(e))
              .toList()
          as T;
    }
    if (t == List<_i95.Device>) {
      return (data as List).map((e) => deserialize<_i95.Device>(e)).toList()
          as T;
    }
    if (t == List<_i96.Gateway>) {
      return (data as List).map((e) => deserialize<_i96.Gateway>(e)).toList()
          as T;
    }
    if (t == List<_i97.AutomationRule>) {
      return (data as List)
              .map((e) => deserialize<_i97.AutomationRule>(e))
              .toList()
          as T;
    }
    if (t == List<_i98.AutomationBranch>) {
      return (data as List)
              .map((e) => deserialize<_i98.AutomationBranch>(e))
              .toList()
          as T;
    }
    if (t == List<_i99.AutomationRun>) {
      return (data as List)
              .map((e) => deserialize<_i99.AutomationRun>(e))
              .toList()
          as T;
    }
    if (t == List<_i100.AuditLog>) {
      return (data as List).map((e) => deserialize<_i100.AuditLog>(e)).toList()
          as T;
    }
    if (t == List<_i101.FirmwarePackage>) {
      return (data as List)
              .map((e) => deserialize<_i101.FirmwarePackage>(e))
              .toList()
          as T;
    }
    if (t == List<_i102.FirmwareReleaseDetail>) {
      return (data as List)
              .map((e) => deserialize<_i102.FirmwareReleaseDetail>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i103.ByteData>) {
      return (data as List).map((e) => deserialize<_i103.ByteData>(e)).toList()
          as T;
    }
    if (t == List<_i104.OtaCampaign>) {
      return (data as List)
              .map((e) => deserialize<_i104.OtaCampaign>(e))
              .toList()
          as T;
    }
    if (t == List<_i105.OtaTarget>) {
      return (data as List).map((e) => deserialize<_i105.OtaTarget>(e)).toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i106.MaterialItem>) {
      return (data as List)
              .map((e) => deserialize<_i106.MaterialItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i107.MaterialLot>) {
      return (data as List)
              .map((e) => deserialize<_i107.MaterialLot>(e))
              .toList()
          as T;
    }
    if (t == List<_i108.ProductDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i108.ProductDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i109.BomItem>) {
      return (data as List).map((e) => deserialize<_i109.BomItem>(e)).toList()
          as T;
    }
    if (t == List<_i110.ProcessRoute>) {
      return (data as List)
              .map((e) => deserialize<_i110.ProcessRoute>(e))
              .toList()
          as T;
    }
    if (t == List<_i111.ProductionLine>) {
      return (data as List)
              .map((e) => deserialize<_i111.ProductionLine>(e))
              .toList()
          as T;
    }
    if (t == List<_i112.Workstation>) {
      return (data as List)
              .map((e) => deserialize<_i112.Workstation>(e))
              .toList()
          as T;
    }
    if (t == List<_i113.WorkstationAssignmentDetail>) {
      return (data as List)
              .map((e) => deserialize<_i113.WorkstationAssignmentDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i114.LineTransfer>) {
      return (data as List)
              .map((e) => deserialize<_i114.LineTransfer>(e))
              .toList()
          as T;
    }
    if (t == List<_i115.ProcessNode>) {
      return (data as List)
              .map((e) => deserialize<_i115.ProcessNode>(e))
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
    if (t == List<_i116.ProductionOrder>) {
      return (data as List)
              .map((e) => deserialize<_i116.ProductionOrder>(e))
              .toList()
          as T;
    }
    if (t == List<_i117.ProductUnit>) {
      return (data as List)
              .map((e) => deserialize<_i117.ProductUnit>(e))
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
    if (t == List<_i118.ProvisionedDevice>) {
      return (data as List)
              .map((e) => deserialize<_i118.ProvisionedDevice>(e))
              .toList()
          as T;
    }
    if (t == List<_i119.DeviceCertificate>) {
      return (data as List)
              .map((e) => deserialize<_i119.DeviceCertificate>(e))
              .toList()
          as T;
    }
    if (t == List<_i120.Site>) {
      return (data as List).map((e) => deserialize<_i120.Site>(e)).toList()
          as T;
    }
    if (t == List<_i121.DeviceStatus>) {
      return (data as List)
              .map((e) => deserialize<_i121.DeviceStatus>(e))
              .toList()
          as T;
    }
    try {
      return _i122.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i123.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Alert => 'Alert',
      _i3.AlertComparison => 'AlertComparison',
      _i4.AlertListResult => 'AlertListResult',
      _i5.AlertRule => 'AlertRule',
      _i6.AlertSeverity => 'AlertSeverity',
      _i7.AlertState => 'AlertState',
      _i8.DeviceCommand => 'DeviceCommand',
      _i9.DeviceCommandListResult => 'DeviceCommandListResult',
      _i10.DeviceCommandState => 'DeviceCommandState',
      _i11.NotFoundException => 'NotFoundException',
      _i12.ValidationException => 'ValidationException',
      _i13.Company => 'Company',
      _i14.CompanyMembership => 'CompanyMembership',
      _i15.CompanyRole => 'CompanyRole',
      _i16.DeviceShare => 'DeviceShare',
      _i17.MemberAccessSummary => 'MemberAccessSummary',
      _i18.PlatformPermission => 'PlatformPermission',
      _i19.DashboardSummary => 'DashboardSummary',
      _i20.SiteSummary => 'SiteSummary',
      _i21.ControlPresentation => 'ControlPresentation',
      _i22.CustomDeviceProfile => 'CustomDeviceProfile',
      _i23.Device => 'Device',
      _i24.DeviceConnectionState => 'DeviceConnectionState',
      _i25.DeviceFeature => 'DeviceFeature',
      _i26.DeviceProfile => 'DeviceProfile',
      _i27.DeviceStatus => 'DeviceStatus',
      _i28.FeatureCatalogItem => 'FeatureCatalogItem',
      _i29.FeatureDataType => 'FeatureDataType',
      _i30.FeatureDefinition => 'FeatureDefinition',
      _i31.FeatureKind => 'FeatureKind',
      _i32.Gateway => 'Gateway',
      _i33.Greeting => 'Greeting',
      _i34.OeeSiteSummary => 'OeeSiteSummary',
      _i35.OeeSummary => 'OeeSummary',
      _i36.ProductionStat => 'ProductionStat',
      _i37.AuditLog => 'AuditLog',
      _i38.AutomationAction => 'AutomationAction',
      _i39.AutomationBranch => 'AutomationBranch',
      _i40.AutomationCondition => 'AutomationCondition',
      _i41.AutomationRule => 'AutomationRule',
      _i42.AutomationRun => 'AutomationRun',
      _i43.FirmwareArtifact => 'FirmwareArtifact',
      _i44.FirmwarePackage => 'FirmwarePackage',
      _i45.FirmwarePackageState => 'FirmwarePackageState',
      _i46.FirmwareReleaseDetail => 'FirmwareReleaseDetail',
      _i47.OtaCampaign => 'OtaCampaign',
      _i48.OtaCampaignDetail => 'OtaCampaignDetail',
      _i49.OtaCampaignState => 'OtaCampaignState',
      _i50.OtaDeviceJob => 'OtaDeviceJob',
      _i51.OtaJobState => 'OtaJobState',
      _i52.OtaStrategy => 'OtaStrategy',
      _i53.OtaTarget => 'OtaTarget',
      _i54.BomItem => 'BomItem',
      _i55.LineTransfer => 'LineTransfer',
      _i56.LineTransferStatus => 'LineTransferStatus',
      _i57.MaterialItem => 'MaterialItem',
      _i58.MaterialLot => 'MaterialLot',
      _i59.MaterialType => 'MaterialType',
      _i60.ProcessEvent => 'ProcessEvent',
      _i61.ProcessEventType => 'ProcessEventType',
      _i62.ProcessNode => 'ProcessNode',
      _i63.ProcessResult => 'ProcessResult',
      _i64.ProcessRoute => 'ProcessRoute',
      _i65.ProductDefinition => 'ProductDefinition',
      _i66.ProductTrace => 'ProductTrace',
      _i67.ProductUnit => 'ProductUnit',
      _i68.ProductUnitStatus => 'ProductUnitStatus',
      _i69.ProductionLine => 'ProductionLine',
      _i70.ProductionOrder => 'ProductionOrder',
      _i71.ProductionOrderStatus => 'ProductionOrderStatus',
      _i72.ProductionSummary => 'ProductionSummary',
      _i73.Workstation => 'Workstation',
      _i74.WorkstationAssignment => 'WorkstationAssignment',
      _i75.WorkstationAssignmentDetail => 'WorkstationAssignmentDetail',
      _i76.CertificateIssueResult => 'CertificateIssueResult',
      _i77.ClaimSessionResult => 'ClaimSessionResult',
      _i78.DeviceCertificate => 'DeviceCertificate',
      _i79.DeviceClaim => 'DeviceClaim',
      _i80.ProvisionedDevice => 'ProvisionedDevice',
      _i81.ProvisioningState => 'ProvisioningState',
      _i82.Site => 'Site',
      _i83.Measurement => 'Measurement',
      _i84.MeasurementListResult => 'MeasurementListResult',
      _i85.WorkOrder => 'WorkOrder',
      _i86.WorkOrderListResult => 'WorkOrderListResult',
      _i87.WorkOrderPriority => 'WorkOrderPriority',
      _i88.WorkOrderStatus => 'WorkOrderStatus',
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
      case _i2.Alert():
        return 'Alert';
      case _i3.AlertComparison():
        return 'AlertComparison';
      case _i4.AlertListResult():
        return 'AlertListResult';
      case _i5.AlertRule():
        return 'AlertRule';
      case _i6.AlertSeverity():
        return 'AlertSeverity';
      case _i7.AlertState():
        return 'AlertState';
      case _i8.DeviceCommand():
        return 'DeviceCommand';
      case _i9.DeviceCommandListResult():
        return 'DeviceCommandListResult';
      case _i10.DeviceCommandState():
        return 'DeviceCommandState';
      case _i11.NotFoundException():
        return 'NotFoundException';
      case _i12.ValidationException():
        return 'ValidationException';
      case _i13.Company():
        return 'Company';
      case _i14.CompanyMembership():
        return 'CompanyMembership';
      case _i15.CompanyRole():
        return 'CompanyRole';
      case _i16.DeviceShare():
        return 'DeviceShare';
      case _i17.MemberAccessSummary():
        return 'MemberAccessSummary';
      case _i18.PlatformPermission():
        return 'PlatformPermission';
      case _i19.DashboardSummary():
        return 'DashboardSummary';
      case _i20.SiteSummary():
        return 'SiteSummary';
      case _i21.ControlPresentation():
        return 'ControlPresentation';
      case _i22.CustomDeviceProfile():
        return 'CustomDeviceProfile';
      case _i23.Device():
        return 'Device';
      case _i24.DeviceConnectionState():
        return 'DeviceConnectionState';
      case _i25.DeviceFeature():
        return 'DeviceFeature';
      case _i26.DeviceProfile():
        return 'DeviceProfile';
      case _i27.DeviceStatus():
        return 'DeviceStatus';
      case _i28.FeatureCatalogItem():
        return 'FeatureCatalogItem';
      case _i29.FeatureDataType():
        return 'FeatureDataType';
      case _i30.FeatureDefinition():
        return 'FeatureDefinition';
      case _i31.FeatureKind():
        return 'FeatureKind';
      case _i32.Gateway():
        return 'Gateway';
      case _i33.Greeting():
        return 'Greeting';
      case _i34.OeeSiteSummary():
        return 'OeeSiteSummary';
      case _i35.OeeSummary():
        return 'OeeSummary';
      case _i36.ProductionStat():
        return 'ProductionStat';
      case _i37.AuditLog():
        return 'AuditLog';
      case _i38.AutomationAction():
        return 'AutomationAction';
      case _i39.AutomationBranch():
        return 'AutomationBranch';
      case _i40.AutomationCondition():
        return 'AutomationCondition';
      case _i41.AutomationRule():
        return 'AutomationRule';
      case _i42.AutomationRun():
        return 'AutomationRun';
      case _i43.FirmwareArtifact():
        return 'FirmwareArtifact';
      case _i44.FirmwarePackage():
        return 'FirmwarePackage';
      case _i45.FirmwarePackageState():
        return 'FirmwarePackageState';
      case _i46.FirmwareReleaseDetail():
        return 'FirmwareReleaseDetail';
      case _i47.OtaCampaign():
        return 'OtaCampaign';
      case _i48.OtaCampaignDetail():
        return 'OtaCampaignDetail';
      case _i49.OtaCampaignState():
        return 'OtaCampaignState';
      case _i50.OtaDeviceJob():
        return 'OtaDeviceJob';
      case _i51.OtaJobState():
        return 'OtaJobState';
      case _i52.OtaStrategy():
        return 'OtaStrategy';
      case _i53.OtaTarget():
        return 'OtaTarget';
      case _i54.BomItem():
        return 'BomItem';
      case _i55.LineTransfer():
        return 'LineTransfer';
      case _i56.LineTransferStatus():
        return 'LineTransferStatus';
      case _i57.MaterialItem():
        return 'MaterialItem';
      case _i58.MaterialLot():
        return 'MaterialLot';
      case _i59.MaterialType():
        return 'MaterialType';
      case _i60.ProcessEvent():
        return 'ProcessEvent';
      case _i61.ProcessEventType():
        return 'ProcessEventType';
      case _i62.ProcessNode():
        return 'ProcessNode';
      case _i63.ProcessResult():
        return 'ProcessResult';
      case _i64.ProcessRoute():
        return 'ProcessRoute';
      case _i65.ProductDefinition():
        return 'ProductDefinition';
      case _i66.ProductTrace():
        return 'ProductTrace';
      case _i67.ProductUnit():
        return 'ProductUnit';
      case _i68.ProductUnitStatus():
        return 'ProductUnitStatus';
      case _i69.ProductionLine():
        return 'ProductionLine';
      case _i70.ProductionOrder():
        return 'ProductionOrder';
      case _i71.ProductionOrderStatus():
        return 'ProductionOrderStatus';
      case _i72.ProductionSummary():
        return 'ProductionSummary';
      case _i73.Workstation():
        return 'Workstation';
      case _i74.WorkstationAssignment():
        return 'WorkstationAssignment';
      case _i75.WorkstationAssignmentDetail():
        return 'WorkstationAssignmentDetail';
      case _i76.CertificateIssueResult():
        return 'CertificateIssueResult';
      case _i77.ClaimSessionResult():
        return 'ClaimSessionResult';
      case _i78.DeviceCertificate():
        return 'DeviceCertificate';
      case _i79.DeviceClaim():
        return 'DeviceClaim';
      case _i80.ProvisionedDevice():
        return 'ProvisionedDevice';
      case _i81.ProvisioningState():
        return 'ProvisioningState';
      case _i82.Site():
        return 'Site';
      case _i83.Measurement():
        return 'Measurement';
      case _i84.MeasurementListResult():
        return 'MeasurementListResult';
      case _i85.WorkOrder():
        return 'WorkOrder';
      case _i86.WorkOrderListResult():
        return 'WorkOrderListResult';
      case _i87.WorkOrderPriority():
        return 'WorkOrderPriority';
      case _i88.WorkOrderStatus():
        return 'WorkOrderStatus';
    }
    className = _i122.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i123.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.Alert>(data['data']);
    }
    if (dataClassName == 'AlertComparison') {
      return deserialize<_i3.AlertComparison>(data['data']);
    }
    if (dataClassName == 'AlertListResult') {
      return deserialize<_i4.AlertListResult>(data['data']);
    }
    if (dataClassName == 'AlertRule') {
      return deserialize<_i5.AlertRule>(data['data']);
    }
    if (dataClassName == 'AlertSeverity') {
      return deserialize<_i6.AlertSeverity>(data['data']);
    }
    if (dataClassName == 'AlertState') {
      return deserialize<_i7.AlertState>(data['data']);
    }
    if (dataClassName == 'DeviceCommand') {
      return deserialize<_i8.DeviceCommand>(data['data']);
    }
    if (dataClassName == 'DeviceCommandListResult') {
      return deserialize<_i9.DeviceCommandListResult>(data['data']);
    }
    if (dataClassName == 'DeviceCommandState') {
      return deserialize<_i10.DeviceCommandState>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i11.NotFoundException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i12.ValidationException>(data['data']);
    }
    if (dataClassName == 'Company') {
      return deserialize<_i13.Company>(data['data']);
    }
    if (dataClassName == 'CompanyMembership') {
      return deserialize<_i14.CompanyMembership>(data['data']);
    }
    if (dataClassName == 'CompanyRole') {
      return deserialize<_i15.CompanyRole>(data['data']);
    }
    if (dataClassName == 'DeviceShare') {
      return deserialize<_i16.DeviceShare>(data['data']);
    }
    if (dataClassName == 'MemberAccessSummary') {
      return deserialize<_i17.MemberAccessSummary>(data['data']);
    }
    if (dataClassName == 'PlatformPermission') {
      return deserialize<_i18.PlatformPermission>(data['data']);
    }
    if (dataClassName == 'DashboardSummary') {
      return deserialize<_i19.DashboardSummary>(data['data']);
    }
    if (dataClassName == 'SiteSummary') {
      return deserialize<_i20.SiteSummary>(data['data']);
    }
    if (dataClassName == 'ControlPresentation') {
      return deserialize<_i21.ControlPresentation>(data['data']);
    }
    if (dataClassName == 'CustomDeviceProfile') {
      return deserialize<_i22.CustomDeviceProfile>(data['data']);
    }
    if (dataClassName == 'Device') {
      return deserialize<_i23.Device>(data['data']);
    }
    if (dataClassName == 'DeviceConnectionState') {
      return deserialize<_i24.DeviceConnectionState>(data['data']);
    }
    if (dataClassName == 'DeviceFeature') {
      return deserialize<_i25.DeviceFeature>(data['data']);
    }
    if (dataClassName == 'DeviceProfile') {
      return deserialize<_i26.DeviceProfile>(data['data']);
    }
    if (dataClassName == 'DeviceStatus') {
      return deserialize<_i27.DeviceStatus>(data['data']);
    }
    if (dataClassName == 'FeatureCatalogItem') {
      return deserialize<_i28.FeatureCatalogItem>(data['data']);
    }
    if (dataClassName == 'FeatureDataType') {
      return deserialize<_i29.FeatureDataType>(data['data']);
    }
    if (dataClassName == 'FeatureDefinition') {
      return deserialize<_i30.FeatureDefinition>(data['data']);
    }
    if (dataClassName == 'FeatureKind') {
      return deserialize<_i31.FeatureKind>(data['data']);
    }
    if (dataClassName == 'Gateway') {
      return deserialize<_i32.Gateway>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i33.Greeting>(data['data']);
    }
    if (dataClassName == 'OeeSiteSummary') {
      return deserialize<_i34.OeeSiteSummary>(data['data']);
    }
    if (dataClassName == 'OeeSummary') {
      return deserialize<_i35.OeeSummary>(data['data']);
    }
    if (dataClassName == 'ProductionStat') {
      return deserialize<_i36.ProductionStat>(data['data']);
    }
    if (dataClassName == 'AuditLog') {
      return deserialize<_i37.AuditLog>(data['data']);
    }
    if (dataClassName == 'AutomationAction') {
      return deserialize<_i38.AutomationAction>(data['data']);
    }
    if (dataClassName == 'AutomationBranch') {
      return deserialize<_i39.AutomationBranch>(data['data']);
    }
    if (dataClassName == 'AutomationCondition') {
      return deserialize<_i40.AutomationCondition>(data['data']);
    }
    if (dataClassName == 'AutomationRule') {
      return deserialize<_i41.AutomationRule>(data['data']);
    }
    if (dataClassName == 'AutomationRun') {
      return deserialize<_i42.AutomationRun>(data['data']);
    }
    if (dataClassName == 'FirmwareArtifact') {
      return deserialize<_i43.FirmwareArtifact>(data['data']);
    }
    if (dataClassName == 'FirmwarePackage') {
      return deserialize<_i44.FirmwarePackage>(data['data']);
    }
    if (dataClassName == 'FirmwarePackageState') {
      return deserialize<_i45.FirmwarePackageState>(data['data']);
    }
    if (dataClassName == 'FirmwareReleaseDetail') {
      return deserialize<_i46.FirmwareReleaseDetail>(data['data']);
    }
    if (dataClassName == 'OtaCampaign') {
      return deserialize<_i47.OtaCampaign>(data['data']);
    }
    if (dataClassName == 'OtaCampaignDetail') {
      return deserialize<_i48.OtaCampaignDetail>(data['data']);
    }
    if (dataClassName == 'OtaCampaignState') {
      return deserialize<_i49.OtaCampaignState>(data['data']);
    }
    if (dataClassName == 'OtaDeviceJob') {
      return deserialize<_i50.OtaDeviceJob>(data['data']);
    }
    if (dataClassName == 'OtaJobState') {
      return deserialize<_i51.OtaJobState>(data['data']);
    }
    if (dataClassName == 'OtaStrategy') {
      return deserialize<_i52.OtaStrategy>(data['data']);
    }
    if (dataClassName == 'OtaTarget') {
      return deserialize<_i53.OtaTarget>(data['data']);
    }
    if (dataClassName == 'BomItem') {
      return deserialize<_i54.BomItem>(data['data']);
    }
    if (dataClassName == 'LineTransfer') {
      return deserialize<_i55.LineTransfer>(data['data']);
    }
    if (dataClassName == 'LineTransferStatus') {
      return deserialize<_i56.LineTransferStatus>(data['data']);
    }
    if (dataClassName == 'MaterialItem') {
      return deserialize<_i57.MaterialItem>(data['data']);
    }
    if (dataClassName == 'MaterialLot') {
      return deserialize<_i58.MaterialLot>(data['data']);
    }
    if (dataClassName == 'MaterialType') {
      return deserialize<_i59.MaterialType>(data['data']);
    }
    if (dataClassName == 'ProcessEvent') {
      return deserialize<_i60.ProcessEvent>(data['data']);
    }
    if (dataClassName == 'ProcessEventType') {
      return deserialize<_i61.ProcessEventType>(data['data']);
    }
    if (dataClassName == 'ProcessNode') {
      return deserialize<_i62.ProcessNode>(data['data']);
    }
    if (dataClassName == 'ProcessResult') {
      return deserialize<_i63.ProcessResult>(data['data']);
    }
    if (dataClassName == 'ProcessRoute') {
      return deserialize<_i64.ProcessRoute>(data['data']);
    }
    if (dataClassName == 'ProductDefinition') {
      return deserialize<_i65.ProductDefinition>(data['data']);
    }
    if (dataClassName == 'ProductTrace') {
      return deserialize<_i66.ProductTrace>(data['data']);
    }
    if (dataClassName == 'ProductUnit') {
      return deserialize<_i67.ProductUnit>(data['data']);
    }
    if (dataClassName == 'ProductUnitStatus') {
      return deserialize<_i68.ProductUnitStatus>(data['data']);
    }
    if (dataClassName == 'ProductionLine') {
      return deserialize<_i69.ProductionLine>(data['data']);
    }
    if (dataClassName == 'ProductionOrder') {
      return deserialize<_i70.ProductionOrder>(data['data']);
    }
    if (dataClassName == 'ProductionOrderStatus') {
      return deserialize<_i71.ProductionOrderStatus>(data['data']);
    }
    if (dataClassName == 'ProductionSummary') {
      return deserialize<_i72.ProductionSummary>(data['data']);
    }
    if (dataClassName == 'Workstation') {
      return deserialize<_i73.Workstation>(data['data']);
    }
    if (dataClassName == 'WorkstationAssignment') {
      return deserialize<_i74.WorkstationAssignment>(data['data']);
    }
    if (dataClassName == 'WorkstationAssignmentDetail') {
      return deserialize<_i75.WorkstationAssignmentDetail>(data['data']);
    }
    if (dataClassName == 'CertificateIssueResult') {
      return deserialize<_i76.CertificateIssueResult>(data['data']);
    }
    if (dataClassName == 'ClaimSessionResult') {
      return deserialize<_i77.ClaimSessionResult>(data['data']);
    }
    if (dataClassName == 'DeviceCertificate') {
      return deserialize<_i78.DeviceCertificate>(data['data']);
    }
    if (dataClassName == 'DeviceClaim') {
      return deserialize<_i79.DeviceClaim>(data['data']);
    }
    if (dataClassName == 'ProvisionedDevice') {
      return deserialize<_i80.ProvisionedDevice>(data['data']);
    }
    if (dataClassName == 'ProvisioningState') {
      return deserialize<_i81.ProvisioningState>(data['data']);
    }
    if (dataClassName == 'Site') {
      return deserialize<_i82.Site>(data['data']);
    }
    if (dataClassName == 'Measurement') {
      return deserialize<_i83.Measurement>(data['data']);
    }
    if (dataClassName == 'MeasurementListResult') {
      return deserialize<_i84.MeasurementListResult>(data['data']);
    }
    if (dataClassName == 'WorkOrder') {
      return deserialize<_i85.WorkOrder>(data['data']);
    }
    if (dataClassName == 'WorkOrderListResult') {
      return deserialize<_i86.WorkOrderListResult>(data['data']);
    }
    if (dataClassName == 'WorkOrderPriority') {
      return deserialize<_i87.WorkOrderPriority>(data['data']);
    }
    if (dataClassName == 'WorkOrderStatus') {
      return deserialize<_i88.WorkOrderStatus>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i122.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i123.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

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
      return _i122.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i123.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
