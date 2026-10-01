import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';

/// 出廠設備登錄列表（Device Registry）。
final provisionedDevicesProvider =
    FutureProvider.autoDispose<List<ProvisionedDevice>>((ref) {
      final client = ref.watch(clientProvider);
      return client.provisioning.listDevices();
    });

/// 已配對且尚未掛入設備庫的實體（建檔頁序號下拉）。
final unlinkedDevicesProvider =
    FutureProvider.autoDispose<List<ProvisionedDevice>>((ref) {
      final client = ref.watch(clientProvider);
      return client.provisioning.listUnlinkedDevices();
    });

/// 單一設備的憑證歷史（新到舊）。
final deviceCertificatesProvider = FutureProvider.autoDispose
    .family<List<DeviceCertificate>, String>((ref, serial) {
      final client = ref.watch(clientProvider);
      return client.provisioning.listCertificates(serial);
    });
