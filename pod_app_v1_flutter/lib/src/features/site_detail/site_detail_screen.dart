import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../widgets/connection_badge.dart';
import '../../widgets/feature_value_text.dart';
import '../../widgets/destructive_reauth_dialog.dart';
import '../dashboard/dashboard_providers.dart';
import '../sites/site_editor_dialog.dart';
import '../sites/sites_providers.dart';
import 'factory_map_card.dart';
import 'gateway_editor_dialog.dart';
import 'site_detail_providers.dart';

class SiteDetailScreen extends ConsumerWidget {
  const SiteDetailScreen({super.key, required this.siteId});

  final int siteId;

  Future<void> _deleteSite(
    BuildContext context,
    WidgetRef ref,
    Site site,
  ) async {
    final confirmed = await _confirmDelete(context, '刪除場域「${site.name}」？');
    if (confirmed != true) return;
    try {
      await ref.read(clientProvider).site.deleteSite(site.id!);
      ref.invalidate(sitesProvider);
      ref.invalidate(dashboardProvider);
      if (context.mounted) context.go('/assets');
    } catch (e) {
      if (context.mounted) _showError(context, e);
    }
  }

  Future<void> _deleteGateway(
    BuildContext context,
    WidgetRef ref,
    Gateway gateway,
  ) async {
    final confirmed = await _confirmDelete(
      context,
      '刪除閘道器「${gateway.name}」？',
    );
    if (confirmed != true) return;
    try {
      await ref.read(clientProvider).gateway.deleteGateway(gateway.id!);
      ref.invalidate(gatewaysProvider(siteId));
      ref.invalidate(dashboardProvider);
    } catch (e) {
      if (context.mounted) _showError(context, e);
    }
  }

  Future<void> _deleteDevice(
    BuildContext context,
    WidgetRef ref,
    Device device,
  ) async {
    final confirmed = await _confirmDelete(
      context,
      '刪除設備「${device.name}」？',
      detail: '設備的歷史量測、命令與告警將一併刪除。',
    );
    if (confirmed != true) return;
    if (!context.mounted) return;
    final credentials = await showDestructiveReauthDialog(
      context,
      resourceName: device.name,
    );
    if (credentials == null) return;
    try {
      await ref
          .read(clientProvider)
          .device
          .deleteDevice(
            device.id!,
            credentials.email,
            credentials.password,
          );
      ref.invalidate(devicesProvider(siteId));
      ref.invalidate(dashboardProvider);
    } catch (e) {
      if (context.mounted) _showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final site = ref.watch(siteProvider(siteId));
    final gateways = ref.watch(gatewaysProvider(siteId));
    final devices = ref.watch(devicesProvider(siteId));
    final statuses = ref.watch(siteStatusesProvider(siteId));

    return Scaffold(
      appBar: AppBar(
        title: Text(site.value?.name ?? '場域'),
        actions: [
          PopupMenuButton<String>(
            tooltip: '場域操作',
            onSelected: (action) {
              final siteData = site.value;
              if (siteData == null) return;
              if (action == 'edit') {
                showDialog(
                  context: context,
                  builder: (context) => SiteEditorDialog(site: siteData),
                );
              } else if (action == 'delete') {
                _deleteSite(context, ref, siteData);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('編輯場域')),
              PopupMenuItem(value: 'delete', child: Text('刪除場域')),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const _SectionHeader('廠房地圖'),
          SliverToBoxAdapter(
            child: devices.when(
              loading: () => const SizedBox.shrink(),
              error: (e, _) => const SizedBox.shrink(),
              data: (items) => items.isEmpty
                  ? const SizedBox.shrink()
                  : FactoryMapCard(
                      devices: items,
                      statuses: statuses.value ?? const {},
                      onDeviceTap: (device) => context.go(
                        '/assets/$siteId/devices/${device.id}',
                      ),
                      onPositionChanged: (device, x, y) async {
                        try {
                          await ref
                              .read(clientProvider)
                              .device
                              .updateMapPosition(device.id!, x, y);
                          ref.invalidate(devicesProvider(siteId));
                        } catch (error) {
                          if (context.mounted) _showError(context, error);
                          rethrow;
                        }
                      },
                    ),
            ),
          ),
          _SectionHeader(
            '閘道器',
            actionLabel: '註冊',
            onAction: () => showDialog(
              context: context,
              builder: (context) => GatewayEditorDialog(siteId: siteId),
            ),
          ),
          gateways.when(
            loading: () => const _SliverLoading(),
            error: (e, _) => _SliverMessage('$e'),
            data: (items) => items.isEmpty
                ? const _SliverMessage('尚無閘道器，點「註冊」新增')
                : SliverList.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final gateway = items[index];
                      return ListTile(
                        key: ValueKey('gw-${gateway.id}'),
                        leading: const Icon(Icons.router_outlined),
                        title: Text(gateway.name),
                        subtitle: Text(gateway.serialNumber),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConnectionBadge(state: gateway.connectionState),
                            PopupMenuButton<String>(
                              tooltip: '閘道器操作',
                              onSelected: (action) {
                                if (action == 'edit') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => GatewayEditorDialog(
                                      siteId: siteId,
                                      gateway: gateway,
                                    ),
                                  );
                                } else if (action == 'delete') {
                                  _deleteGateway(context, ref, gateway);
                                }
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('編輯'),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text('刪除'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          _SectionHeader(
            '設備',
            actionLabel: '註冊',
            onAction: () {
              final gatewayList = gateways.value ?? const <Gateway>[];
              if (gatewayList.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('請先註冊閘道器')),
                );
                return;
              }
              context.push('/assets/device-form?siteId=$siteId');
            },
          ),
          devices.when(
            loading: () => const _SliverLoading(),
            error: (e, _) => _SliverMessage('$e'),
            data: (items) => items.isEmpty
                ? const _SliverMessage('尚無設備，點「註冊」新增')
                : SliverList.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final device = items[index];
                      final status = statuses.value?[device.id];
                      return _DeviceTile(
                        key: ValueKey('dev-${device.id}'),
                        device: device,
                        status: status,
                        onTap: () => context.go(
                          '/assets/$siteId/devices/${device.id}',
                        ),
                        onEdit: () => context.push(
                          '/assets/device-form?siteId=$siteId'
                          '&deviceId=${device.id}',
                        ),
                        onDelete: () => _deleteDevice(context, ref, device),
                      );
                    },
                  ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
        ],
      ),
    );
  }
}

Future<bool?> _confirmDelete(
  BuildContext context,
  String title, {
  String? detail,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: detail == null ? null : Text(detail),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('刪除'),
        ),
      ],
    ),
  );
}

void _showError(BuildContext context, Object error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error is ValidationException ? error.message : '$error'),
    ),
  );
}

class _DeviceTile extends StatelessWidget {
  const _DeviceTile({
    super.key,
    required this.device,
    required this.status,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Device device;
  final DeviceStatus? status;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    // 多通道設備顯示第一個量測通道，其餘以 +N 表示。
    final measurements = [
      for (final f in device.features ?? const <DeviceFeature>[])
        if (f.kind == FeatureKind.measurement) f,
    ];
    final primary = measurements.firstOrNull;
    final value = primary == null
        ? status?.latestValues[device.deviceType]
        : status?.latestValues[primary.key];
    final unit = primary?.unit ?? _unitFor(device.deviceType);
    final extraChannels = measurements.length - 1;

    return ListTile(
      leading: Icon(_iconFor(device.deviceType)),
      title: Text(device.name),
      subtitle: Text(
        '${device.model}'
        '${extraChannels > 0 ? '．${measurements.length} 通道' : ''}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                '${primary == null ? '$value $unit' : featureValueText(primary, value, includeUnit: true)}'
                '${extraChannels > 0 ? ' +$extraChannels' : ''}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ConnectionBadge(
            state: status?.connectionState ?? DeviceConnectionState.unknown,
          ),
          PopupMenuButton<String>(
            tooltip: '設備操作',
            onSelected: (action) {
              if (action == 'edit') onEdit();
              if (action == 'delete') onDelete();
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('編輯')),
              PopupMenuItem(value: 'delete', child: Text('刪除')),
            ],
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

IconData _iconFor(String deviceType) => switch (deviceType) {
  'temperature' => Icons.thermostat,
  'humidity' => Icons.water_drop_outlined,
  'power' => Icons.bolt,
  'vibration' => Icons.vibration,
  'env_multi' => Icons.air,
  'motor_drive' => Icons.precision_manufacturing,
  'power_meter' => Icons.electric_meter,
  _ => Icons.sensors,
};

String _unitFor(String deviceType) => switch (deviceType) {
  'temperature' => '°C',
  'humidity' => '%',
  'power' => 'kW',
  'vibration' => 'mm/s',
  _ => '',
};

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {this.actionLabel, this.onAction});

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            if (actionLabel != null)
              TextButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add, size: 18),
                label: Text(actionLabel!),
              ),
          ],
        ),
      ),
    );
  }
}

class _SliverLoading extends StatelessWidget {
  const _SliverLoading();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _SliverMessage extends StatelessWidget {
  const _SliverMessage(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(child: Text(message)),
      ),
    );
  }
}
