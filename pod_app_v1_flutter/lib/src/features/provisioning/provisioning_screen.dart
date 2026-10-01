import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../design/factory_theme.dart';
import '../../widgets/tech_ui.dart';
import 'claim_device_sheet.dart';
import 'provisioning_providers.dart';

/// 開啟共用「設備建檔」頁（加入設備庫）。
void _openAttachForm(BuildContext context, ProvisionedDevice device) {
  context.push(
    '/assets/device-form?serial=${Uri.encodeQueryComponent(device.serial)}',
  );
}

void _openDeviceProfile(BuildContext context, ProvisionedDevice device) {
  final deviceId = device.linkedDeviceId;
  if (deviceId == null) return;
  context.push('/assets/device-form?deviceId=$deviceId');
}

Future<bool> _confirmReset(
  BuildContext context,
  ProvisionedDevice device,
) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('解除綁定並撤銷憑證？'),
          content: Text(
            '${device.serial} 將回到未綁定狀態，現有 mTLS 憑證會失效。'
            '已建立的場域設備基本資料會保留，但會解除實體序號關聯。',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('確認解除'),
            ),
          ],
        ),
      ) ??
      false;
}

/// 配對流程：完成後若選「加入設備庫」，接續開啟掛載表單。
Future<void> _openClaimFlow(
  BuildContext context,
  WidgetRef ref, {
  String? serial,
}) async {
  final result = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.92,
      child: ClaimDeviceSheet(presetSerial: serial),
    ),
  );
  ref.invalidate(provisionedDevicesProvider);
  if (result == null || !result.startsWith('attach:')) return;

  final attachSerial = result.substring('attach:'.length);
  final devices = await ref.read(provisionedDevicesProvider.future);
  ProvisionedDevice? device;
  for (final item in devices) {
    if (item.serial == attachSerial) device = item;
  }
  if (device != null && context.mounted) {
    _openAttachForm(context, device);
  }
}

/// 設備配對與憑證管理
/// （docs/product/ESP32_Server_mTLS_Provisioning_完整設計手冊.md）。
class ProvisioningScreen extends ConsumerWidget {
  const ProvisioningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(provisionedDevicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設備配對與憑證'),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/settings/provisioning/nordic-mesh'),
            icon: const Icon(Icons.hub_outlined),
            label: const Text('Nordic Mesh'),
          ),
          const SizedBox(width: 4),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'provisioning_fab',
        onPressed: () => _openClaimFlow(context, ref),
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('配對新設備'),
      ),
      body: devices.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (items) {
          return RefreshIndicator(
            onRefresh: () => ref.refresh(provisionedDevicesProvider.future),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
              children: [
                TechHero(
                  eyebrow: 'ZERO-TOUCH PROVISIONING',
                  title: '安全設備佈署',
                  subtitle: '${items.length} 台已登錄 · mTLS 憑證與裝置身分管理',
                  icon: Icons.verified_user_outlined,
                  accent: FactoryColors.green,
                ),
                TechSectionLabel(
                  '出廠設備',
                  detail: '${items.length} DEVICES',
                ),
                if (items.isEmpty)
                  const SizedBox(
                    height: 300,
                    child: TechEmptyState(
                      icon: Icons.qr_code_scanner,
                      title: '尚無已登錄設備',
                      subtitle: '掃描設備 QR Code，安全簽發憑證並加入設備庫。',
                    ),
                  )
                else
                  for (final device in items) _DeviceTile(device: device),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DeviceTile extends ConsumerWidget {
  const _DeviceTile({required this.device});

  final ProvisionedDevice device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final claimable =
        device.state == ProvisioningState.unclaimed ||
        device.state == ProvisioningState.claimPending;
    final linked =
        device.linkedGatewayId != null || device.linkedDeviceId != null;
    final attachable = device.state == ProvisioningState.active && !linked;

    return Card(
      key: ValueKey(device.serial),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        minTileHeight: 76,
        leading: TechIcon(
          icon: Icons.memory_rounded,
          color: switch (device.state) {
            ProvisioningState.active => Colors.green,
            ProvisioningState.revoked => Colors.red,
            ProvisioningState.unclaimed => FactoryColors.secondary,
            _ => Colors.orange,
          },
        ),
        title: Text(device.serial),
        subtitle: Text(
          '${device.model}'
          '${device.manufacturerVerified == true ? '．原廠驗證通過' : ''}'
          '${device.claimedAt != null ? '．綁定於 '
                    '${DateFormat('MM/dd HH:mm').format(device.claimedAt!.toLocal())}' : ''}'
          '${linked ? '．已加入設備庫' : ''}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProvisioningStateChip(state: device.state),
            PopupMenuButton<String>(
              tooltip: '設備操作',
              onSelected: (action) async {
                final client = ref.read(clientProvider);
                switch (action) {
                  case 'claim':
                    // 由列表發起配對時帶入序號。
                    await _openClaimFlow(context, ref, serial: device.serial);
                  case 'attach':
                    _openAttachForm(context, device);
                  case 'profile':
                    _openDeviceProfile(context, device);
                  case 'certs':
                    await showModalBottomSheet<void>(
                      context: context,
                      showDragHandle: true,
                      builder: (context) =>
                          _CertificateList(serial: device.serial),
                    );
                  case 'reset':
                    if (!await _confirmReset(context, device) ||
                        !context.mounted) {
                      return;
                    }
                    await client.provisioning.resetDevice(device.serial);
                    ref.invalidate(provisionedDevicesProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${device.serial} 已解除綁定，可重新配對'),
                        ),
                      );
                    }
                }
              },
              itemBuilder: (context) => [
                if (claimable)
                  const PopupMenuItem(value: 'claim', child: Text('配對')),
                if (attachable)
                  const PopupMenuItem(
                    value: 'attach',
                    child: Text('加入設備庫／建立基本資料'),
                  ),
                if (device.linkedDeviceId != null)
                  const PopupMenuItem(
                    value: 'profile',
                    child: Text('設備基本資料'),
                  ),
                const PopupMenuItem(value: 'certs', child: Text('憑證歷史')),
                if (!claimable)
                  const PopupMenuItem(
                    value: 'reset',
                    child: Text('解除綁定（撤銷憑證）'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CertificateList extends ConsumerWidget {
  const _CertificateList({required this.serial});

  final String serial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certs = ref.watch(deviceCertificatesProvider(serial));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: certs.when(
          loading: () => const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => Text('$error'),
          data: (items) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$serial 憑證歷史',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              if (items.isEmpty) const Text('尚未簽發憑證'),
              for (final cert in items)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    cert.revoked ? Icons.gpp_bad : Icons.verified_user,
                    color: cert.revoked ? Colors.red : Colors.green,
                  ),
                  title: Text('v${cert.version}．SN ${cert.certSerialNumber}'),
                  subtitle: Text(
                    '簽發 ${DateFormat('yyyy/MM/dd').format(cert.issuedAt.toLocal())}'
                    '．到期 ${DateFormat('yyyy/MM/dd').format(cert.expiresAt.toLocal())}'
                    '${cert.revoked ? '．已撤銷' : ''}',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 配對狀態標籤（手冊 §12 狀態機）。
class ProvisioningStateChip extends StatelessWidget {
  const ProvisioningStateChip({super.key, required this.state});

  final ProvisioningState state;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (state) {
      ProvisioningState.unclaimed => (Colors.grey, '未綁定'),
      ProvisioningState.claimPending => (Colors.orange, '等待設備'),
      ProvisioningState.claimed => (Colors.blue, '已綁定'),
      ProvisioningState.certificateIssued => (Colors.teal, '憑證已簽發'),
      ProvisioningState.active => (Colors.green, '已啟用'),
      ProvisioningState.revoked => (Colors.red, '已停用'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
