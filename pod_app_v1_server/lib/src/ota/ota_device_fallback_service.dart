import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Shared OTA device-channel logic used by MQTT and the HTTP fallback route.
class OtaDeviceFallbackService {
  static Future<Map<String, Object?>> pendingForDevice(
    Session session,
    String serial,
  ) async {
    final provisioned = await ProvisionedDevice.db.findFirstRow(
      session,
      where: (t) => t.serial.equals(serial),
    );
    if (provisioned == null ||
        (provisioned.linkedDeviceId == null &&
            provisioned.linkedGatewayId == null)) {
      return const {'pending': false};
    }

    final jobs = await OtaDeviceJob.db.find(
      session,
      where: (t) => provisioned.linkedDeviceId != null
          ? t.deviceId.equals(provisioned.linkedDeviceId)
          : t.gatewayId.equals(provisioned.linkedGatewayId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      limit: 20,
    );
    for (final job in jobs) {
      // A watchdog failure is terminal from the operator's perspective. Never
      // redeliver it after a device reboot; otherwise the App says "stopped"
      // while the ESP32 silently starts the same image again.
      if (job.state != OtaJobState.pending) continue;
      final campaign = await OtaCampaign.db.findById(session, job.campaignId);
      if (campaign == null || campaign.state != OtaCampaignState.running) {
        continue;
      }
      final firmware = await FirmwarePackage.db.findById(
        session,
        campaign.firmwarePackageId,
      );
      if (firmware == null || firmware.deletedAt != null) continue;
      final baseUrl =
          Platform.environment['FIRMWARE_PUBLIC_BASE_URL'] ??
          'http://localhost:8082';
      final relative = firmware.downloadUrl.startsWith('/')
          ? firmware.downloadUrl
          : '/firmware/${firmware.fileName ?? ''}';
      return {
        'pending': true,
        'schemaVersion': 1,
        'campaignId': campaign.id!,
        'version': firmware.version,
        'url': '$baseUrl$relative',
        'sha256': firmware.sha256,
        'sizeBytes': firmware.sizeBytes,
        'productKey': firmware.productKey,
        'chipFamily': firmware.chipFamily,
        'hardwareRevision': firmware.hardwareRevision,
      };
    }
    return const {'pending': false};
  }

  static Future<void> ingestStatus(
    Session session, {
    required String serial,
    required Map<String, Object?> status,
  }) async {
    final campaignId = status['campaignId'];
    final progress = status['progress'];
    final stateName = status['state']?.toString();
    if (campaignId is! int || progress is! num || stateName == null) return;
    final state = OtaJobState.values
        .where((value) => value.name == stateName)
        .firstOrNull;
    if (state == null) return;
    final provisioned = await ProvisionedDevice.db.findFirstRow(
      session,
      where: (t) => t.serial.equals(serial),
    );
    if (provisioned == null) return;
    final job = await OtaDeviceJob.db.findFirstRow(
      session,
      where: (t) {
        final campaign = t.campaignId.equals(campaignId);
        return provisioned.linkedDeviceId != null
            ? campaign & t.deviceId.equals(provisioned.linkedDeviceId)
            : campaign & t.gatewayId.equals(provisioned.linkedGatewayId);
      },
    );
    if (job == null) return;
    final watchdogFailure =
        job.state == OtaJobState.failed &&
        job.errorMessage?.contains('沒有收到新的 OTA 進度') == true;
    if ({
          OtaJobState.succeeded,
          OtaJobState.failed,
          OtaJobState.cancelled,
          OtaJobState.rolledBack,
        }.contains(job.state) &&
        !(watchdogFailure && state == OtaJobState.succeeded)) {
      return;
    }
    final updated = await OtaDeviceJob.db.updateRow(
      session,
      job.copyWith(
        state: state,
        progress: progress.toInt().clamp(0, 100),
        errorMessage: status['error']?.toString(),
        updatedAt: DateTime.now().toUtc(),
      ),
    );
    if (state == OtaJobState.succeeded && updated.deviceId != null) {
      final campaign = await OtaCampaign.db.findById(session, campaignId);
      final firmware = campaign == null
          ? null
          : await FirmwarePackage.db.findById(
              session,
              campaign.firmwarePackageId,
            );
      final device = await Device.db.findById(session, updated.deviceId!);
      if (firmware != null && device != null) {
        await Device.db.updateRow(
          session,
          device.copyWith(firmwareVersion: firmware.version),
        );
      }
    }
    if ({
      OtaJobState.succeeded,
      OtaJobState.failed,
      OtaJobState.rolledBack,
    }.contains(state)) {
      await finishCampaignIfTerminal(session, campaignId);
    }
  }

  static Future<void> finishCampaignIfTerminal(
    Session session,
    int campaignId,
  ) async {
    final campaign = await OtaCampaign.db.findById(session, campaignId);
    if (campaign == null) return;
    final jobs = await OtaDeviceJob.db.find(
      session,
      where: (t) => t.campaignId.equals(campaignId),
    );
    final succeeded = jobs
        .where((job) => job.state == OtaJobState.succeeded)
        .length;
    final failed = jobs
        .where(
          (job) =>
              job.state == OtaJobState.failed ||
              job.state == OtaJobState.rolledBack,
        )
        .length;
    if (succeeded + failed != jobs.length) return;
    await OtaCampaign.db.updateRow(
      session,
      campaign.copyWith(
        state: failed == 0
            ? OtaCampaignState.completed
            : OtaCampaignState.failed,
        succeededDevices: succeeded,
        failedDevices: failed,
        completedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
