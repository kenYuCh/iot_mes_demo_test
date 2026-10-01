import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../sites/sites_providers.dart';

final firmwarePackagesProvider =
    FutureProvider.autoDispose<List<FirmwarePackage>>(
      (ref) => ref.watch(clientProvider).ota.listFirmwarePackages(),
    );

final canManageFirmwareProvider = FutureProvider.autoDispose<bool>(
  (ref) => ref.watch(clientProvider).ota.canManageFirmware(),
);

final firmwareReleasesProvider =
    FutureProvider.autoDispose<List<FirmwareReleaseDetail>>(
      (ref) => ref.watch(clientProvider).ota.listFirmwareReleases(),
    );

final otaCampaignsProvider = FutureProvider.autoDispose<List<OtaCampaign>>(
  (ref) => ref.watch(clientProvider).ota.listCampaigns(),
);

final otaTargetsProvider = FutureProvider.autoDispose<List<OtaTarget>>(
  (ref) => ref.watch(clientProvider).ota.listTargets(),
);

final otaCampaignDetailProvider = FutureProvider.autoDispose
    .family<OtaCampaignDetail, int>(
      (ref, campaignId) =>
          ref.watch(clientProvider).ota.getCampaign(campaignId),
    );

final otaDevicesProvider = FutureProvider.autoDispose<List<Device>>((
  ref,
) async {
  final client = ref.watch(clientProvider);
  final sites = await ref.watch(sitesProvider.future);
  final grouped = await Future.wait([
    for (final site in sites) client.device.listBySite(site.id!),
  ]);
  return [for (final devices in grouped) ...devices];
});
