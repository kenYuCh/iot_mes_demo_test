import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../design/factory_theme.dart';
import 'ota_providers.dart';

class OtaScreen extends ConsumerStatefulWidget {
  const OtaScreen({super.key});

  @override
  ConsumerState<OtaScreen> createState() => _OtaScreenState();
}

class _OtaScreenState extends ConsumerState<OtaScreen> {
  int _section = 0;

  @override
  Widget build(BuildContext context) {
    final packages = ref.watch(firmwarePackagesProvider);
    final releases = ref.watch(firmwareReleasesProvider);
    final campaigns = ref.watch(otaCampaignsProvider);
    final canManage = ref.watch(canManageFirmwareProvider).value ?? false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTA 中心'),
        actions: [
          if (canManage && _section == 1)
            IconButton(
              tooltip: '上傳韌體版本',
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (_) => const _FirmwareSheet(),
              ),
              icon: const Icon(CupertinoIcons.add_circled_solid),
            ),
        ],
      ),
      floatingActionButton: _section == 2
          ? FloatingActionButton.extended(
              onPressed: packages.value?.isNotEmpty == true
                  ? () => showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (_) => const _CampaignSheet(),
                    )
                  : null,
              icon: const Icon(CupertinoIcons.rocket_fill),
              label: const Text('指定設備更新'),
            )
          : null,
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref.invalidate(firmwarePackagesProvider);
          ref.invalidate(firmwareReleasesProvider);
          ref.invalidate(otaCampaignsProvider);
          await Future.wait([
            ref.read(firmwarePackagesProvider.future),
            ref.read(firmwareReleasesProvider.future),
            ref.read(otaCampaignsProvider.future),
          ]);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
          children: [
            _OtaOverview(campaigns: campaigns.value ?? const []),
            const SizedBox(height: 16),
            CupertinoSlidingSegmentedControl<int>(
              groupValue: _section,
              thumbColor: Colors.white,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              children: {
                0: _OtaTabLabel(label: '產品平台', selected: _section == 0),
                1: _OtaTabLabel(label: '版本資產', selected: _section == 1),
                2: _OtaTabLabel(
                  label: 'OTA 更新任務',
                  selected: _section == 2,
                ),
              },
              onValueChanged: (value) => setState(() => _section = value ?? 0),
            ),
            const SizedBox(height: 18),
            if (_section == 0)
              _ProductPlatformGrid(packages: packages.value ?? const []),
            if (_section == 2) ...[
              const _SectionTitle(title: 'OTA 更新任務', caption: '灰度發布與單機進度'),
              const SizedBox(height: 10),
              campaigns.when(
                loading: () => const _LoadingCard(),
                error: (error, _) => _ErrorCard(message: '$error'),
                data: (items) => items.isEmpty
                    ? const _EmptyCard(message: '尚未建立 OTA 更新任務')
                    : Column(
                        children: [
                          for (final item in items)
                            _CampaignCard(campaign: item),
                        ],
                      ),
              ),
            ],
            if (_section == 1) ...[
              _SectionTitle(
                title: '韌體資產庫',
                caption: canManage ? '管理者模式' : '唯讀模式',
              ),
              const SizedBox(height: 10),
              releases.when(
                loading: () => const _LoadingCard(),
                error: (error, _) => _ErrorCard(message: '$error'),
                data: (items) => items.isEmpty
                    ? const _EmptyCard(message: '先新增第一個韌體套件')
                    : _FirmwareLibrary(items: items, canManage: canManage),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _OtaTabLabel extends StatelessWidget {
  const _OtaTabLabel({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        label,
        style: TextStyle(
          color: selected
              ? Colors.black
              : Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }
}

class _ProductPlatformGrid extends StatelessWidget {
  const _ProductPlatformGrid({required this.packages});
  final List<FirmwarePackage> packages;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: '設備產品目錄', caption: '相容性由產品範本鎖定'),
        const SizedBox(height: 10),
        for (final template in _firmwareTemplates)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              child: ListTile(
                minTileHeight: 78,
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: template.color.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(template.icon, color: template.color),
                ),
                title: Text(template.label),
                subtitle: Text('${template.chip} · ${template.protocol}'),
                trailing: _Pill(
                  label:
                      '${packages.where((item) => item.productKey == template.key).length} 版本',
                  color: template.color,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _OtaOverview extends StatelessWidget {
  const _OtaOverview({required this.campaigns});
  final List<OtaCampaign> campaigns;

  @override
  Widget build(BuildContext context) {
    final active = campaigns
        .where((c) => c.state == OtaCampaignState.running)
        .length;
    final total = campaigns.fold<int>(
      0,
      (sum, item) => sum + item.totalDevices,
    );
    final success = campaigns.fold<int>(
      0,
      (sum, item) => sum + item.succeededDevices,
    );
    final rate = total == 0 ? 0 : success / total;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF493397), Color(0xFF7657D5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(CupertinoIcons.cloud_upload_fill, color: Colors.white),
              SizedBox(width: 9),
              Text(
                '韌體發布健康度',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _OverviewMetric(value: '$active', label: '進行中'),
              ),
              Expanded(
                child: _OverviewMetric(value: '$total', label: '累計設備'),
              ),
              Expanded(
                child: _OverviewMetric(
                  value: '${(rate * 100).toStringAsFixed(0)}%',
                  label: '成功率',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverviewMetric extends StatelessWidget {
  const _OverviewMetric({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.w800,
        ),
      ),
      Text(
        label,
        style: const TextStyle(color: Color(0xFFDCD3FF), fontSize: 11),
      ),
    ],
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.caption});
  final String title;
  final String caption;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      Text(caption, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
}

class _CampaignCard extends ConsumerWidget {
  const _CampaignCard({required this.campaign});
  final OtaCampaign campaign;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(otaCampaignDetailProvider(campaign.id!)).value;
    final jobs = detail?.jobs ?? const <OtaDeviceJob>[];
    final progress = jobs.isEmpty
        ? (campaign.totalDevices == 0
              ? 0.0
              : (campaign.succeededDevices + campaign.failedDevices) /
                    campaign.totalDevices)
        : jobs.fold<int>(0, (sum, job) => sum + job.progress) /
              (jobs.length * 100);
    final phase = jobs.isEmpty
        ? null
        : jobs.firstWhere(
            (job) =>
                job.state != OtaJobState.succeeded &&
                job.state != OtaJobState.failed,
            orElse: () => jobs.last,
          );
    final color = _campaignColor(campaign.state);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: null,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      CupertinoIcons.rocket_fill,
                      color: color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          campaign.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: FactoryColors.ink,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${_strategyLabel(campaign.strategy)} · ${campaign.totalDevices} 台設備'
                          '${phase == null ? '' : ' · ${_jobStateLabel(phase.state)} ${phase.progress}%'}',
                          style: const TextStyle(
                            color: FactoryColors.secondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _Pill(
                    label: _campaignStateLabel(campaign.state),
                    color: color,
                  ),
                ],
              ),
              const SizedBox(height: 13),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  color: color,
                  backgroundColor: color.withValues(alpha: 0.12),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '成功 ${campaign.succeededDevices} · 失敗 ${campaign.failedDevices}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: FactoryColors.secondary,
                    ),
                  ),
                  const Spacer(),
                  if (campaign.state == OtaCampaignState.draft ||
                      campaign.state == OtaCampaignState.paused)
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(44, 26),
                      onPressed: () async {
                        await ref
                            .read(clientProvider)
                            .ota
                            .startCampaign(campaign.id!);
                        ref.invalidate(otaCampaignsProvider);
                      },
                      child: const Text(
                        '開始發布',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FirmwareLibrary extends StatelessWidget {
  const _FirmwareLibrary({required this.items, required this.canManage});
  final List<FirmwareReleaseDetail> items;
  final bool canManage;

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<FirmwareReleaseDetail>>{};
    for (final item in items) {
      final key = item.release.productKey ?? item.release.targetDeviceType;
      grouped.putIfAbsent(key, () => []).add(item);
    }
    return Column(
      children: [
        for (final entry in grouped.entries) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.device_phone_portrait,
                  size: 15,
                  color: FactoryColors.purple,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: FactoryColors.ink,
                    ),
                  ),
                ),
                Text(
                  '${entry.value.length} 個版本',
                  style: const TextStyle(
                    fontSize: 11,
                    color: FactoryColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          for (final item in entry.value)
            _FirmwareCard(detail: item, canManage: canManage),
        ],
      ],
    );
  }
}

class _FirmwareCard extends ConsumerWidget {
  const _FirmwareCard({required this.detail, required this.canManage});
  final FirmwareReleaseDetail detail;
  final bool canManage;

  FirmwarePackage get item => detail.release;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('清除韌體檔案？'),
        content: Text(
          '將移除 ${item.fileName ?? '此版本的 .bin'}。若已有發布紀錄，版本 Metadata 仍會保留。',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: const Text('清除'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(clientProvider).ota.deleteFirmwareBinary(item.id!);
    ref.invalidate(firmwarePackagesProvider);
    ref.invalidate(firmwareReleasesProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFEDE8FF),
          borderRadius: BorderRadius.circular(13),
        ),
        child: const Icon(
          CupertinoIcons.cube_box_fill,
          color: FactoryColors.purple,
        ),
      ),
      title: Text(
        '${item.name}  v${item.version}',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item.chipFamily ?? item.targetDeviceType} · ${item.updateProtocol ?? 'legacy'} · ${_formatBytes(item.sizeBytes)}',
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 5,
            runSpacing: 4,
            children: [
              for (final artifact in detail.artifacts)
                _Pill(
                  label:
                      '${artifact.fileType.toUpperCase()}${artifact.isPrimary ? ' OTA' : ''}',
                  color: artifact.isPrimary
                      ? FactoryColors.blue
                      : FactoryColors.purple,
                ),
            ],
          ),
          const SizedBox(height: 4),
          if (item.releaseNotes?.trim().isNotEmpty == true) ...[
            Text(
              item.releaseNotes!.trim(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 4),
          ],
          Text(DateFormat('yyyy/MM/dd HH:mm').format(item.createdAt.toLocal())),
        ],
      ),
      isThreeLine: true,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Pill(
            label: item.state == FirmwarePackageState.ready
                ? (item.storagePath == null ? '外部檔案' : '可發布')
                : item.state == FirmwarePackageState.deprecated
                ? '已清除'
                : item.state.name,
            color: item.state == FirmwarePackageState.ready
                ? FactoryColors.green
                : FactoryColors.secondary,
          ),
          if (canManage) ...[
            const SizedBox(width: 4),
            CupertinoButton(
              padding: EdgeInsets.zero,
              minimumSize: const Size(32, 32),
              onPressed: () => _delete(context, ref),
              child: const Icon(
                CupertinoIcons.trash,
                size: 17,
                color: FactoryColors.red,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

class _FirmwareTemplate {
  const _FirmwareTemplate({
    required this.key,
    required this.label,
    required this.chip,
    required this.protocol,
    required this.icon,
    required this.color,
  });
  final String key;
  final String label;
  final String chip;
  final String protocol;
  final IconData icon;
  final Color color;
}

const _firmwareTemplates = [
  _FirmwareTemplate(
    // Must match Device.deviceType. Keep the existing database spelling until
    // a dedicated data migration can rename it without breaking OTA targets.
    key: 'esp32_motor_contoller',
    label: 'ESP32 馬達控制器',
    chip: 'esp32',
    protocol: 'esp_https_ota',
    icon: CupertinoIcons.antenna_radiowaves_left_right,
    color: FactoryColors.blue,
  ),
  _FirmwareTemplate(
    key: 'nrf52840_sensor',
    label: 'nRF52840 Sensor',
    chip: 'nrf52840',
    protocol: 'mcuboot',
    icon: CupertinoIcons.waveform_path_ecg,
    color: FactoryColors.green,
  ),
  _FirmwareTemplate(
    key: 'nrf5340_controller',
    label: 'nRF5340 Controller',
    chip: 'nrf5340',
    protocol: 'mcuboot',
    icon: CupertinoIcons.square_stack_3d_up_fill,
    color: FactoryColors.purple,
  ),
  _FirmwareTemplate(
    key: 'gateway_controller',
    label: 'Generic Cortex-M',
    chip: 'cortex_m',
    protocol: 'raw_binary',
    icon: Icons.memory_rounded,
    color: FactoryColors.orange,
  ),
];

class _FirmwareSheet extends ConsumerStatefulWidget {
  const _FirmwareSheet();
  @override
  ConsumerState<_FirmwareSheet> createState() => _FirmwareSheetState();
}

class _FirmwareSheetState extends ConsumerState<_FirmwareSheet> {
  final name = TextEditingController();
  final version = TextEditingController(text: '1.0.0');
  final product = TextEditingController(text: 'gateway_controller');
  final type = TextEditingController(text: 'gateway_controller');
  final chip = TextEditingController(text: 'cortex_m');
  final protocol = TextEditingController(text: 'raw_binary');
  final hardware = TextEditingController();
  final notes = TextEditingController();
  List<PlatformFile> selectedFiles = const [];
  int primaryFileIndex = 0;
  bool saving = false;
  String? error;
  String templateKey = 'gateway_controller';

  void _selectTemplate(String key) {
    final template = _firmwareTemplates.firstWhere((item) => item.key == key);
    setState(() {
      templateKey = key;
      product.text = key;
      type.text = key;
      chip.text = template.chip;
      protocol.text = template.protocol;
    });
  }

  @override
  void dispose() {
    for (final c in [
      name,
      version,
      product,
      type,
      chip,
      protocol,
      hardware,
      notes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: const ['bin', 'hex', 'zip', 'json', 'sig'],
      withData: true,
    );
    if (result == null || !mounted) return;
    final files = result.files.where((file) => file.bytes != null).toList();
    setState(() {
      selectedFiles = files;
      primaryFileIndex = 0;
      error = files.length == result.files.length ? null : '部分檔案無法讀取，請重新選擇';
      if (name.text.trim().isEmpty && files.isNotEmpty) {
        name.text = files.first.name.replaceFirst(RegExp(r'\.[^.]+$'), '');
      }
    });
  }

  Future<void> save() async {
    if (selectedFiles.isEmpty) {
      setState(() => error = '請先選擇要上傳的韌體檔案');
      return;
    }
    if (notes.text.trim().isEmpty) {
      setState(() => error = '請填寫此版本做了哪些更動');
      return;
    }
    setState(() {
      saving = true;
      error = null;
    });
    try {
      await ref
          .read(clientProvider)
          .ota
          .uploadFirmwareRelease(
            name.text,
            version.text,
            product.text,
            type.text,
            chip.text,
            protocol.text,
            hardware.text,
            notes.text,
            selectedFiles.map((file) => file.name).toList(),
            selectedFiles
                .map((file) => ByteData.sublistView(file.bytes!))
                .toList(),
            primaryFileIndex,
          );
      ref.invalidate(firmwarePackagesProvider);
      ref.invalidate(firmwareReleasesProvider);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          saving = false;
          error = '$e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => _SheetFrame(
    title: '上傳韌體版本',
    action: saving ? null : save,
    actionLabel: saving ? '上傳中' : '上傳並建立',
    children: [
      DropdownButtonFormField<String>(
        initialValue: templateKey,
        decoration: const InputDecoration(labelText: '設備產品範本'),
        items: [
          for (final template in _firmwareTemplates)
            DropdownMenuItem(
              value: template.key,
              child: Text(template.label),
            ),
        ],
        onChanged: (value) {
          if (value != null) _selectTemplate(value);
        },
      ),
      const SizedBox(height: 12),
      _field(name, '套件名稱'),
      _field(version, '版本（SemVer）'),
      Card(
        child: ListTile(
          leading: const Icon(CupertinoIcons.lock_shield_fill),
          title: Text(chip.text),
          subtitle: Text('${product.text} · ${protocol.text}'),
          trailing: const _Pill(label: '已鎖定', color: FactoryColors.green),
        ),
      ),
      const SizedBox(height: 12),
      _field(hardware, '硬體版次（選填）'),
      OutlinedButton.icon(
        onPressed: saving ? null : pickFiles,
        icon: const Icon(CupertinoIcons.folder_fill_badge_plus),
        label: Text(selectedFiles.isEmpty ? '選擇韌體檔案' : '重新選擇檔案'),
      ),
      const Padding(
        padding: EdgeInsets.only(top: 6, bottom: 10),
        child: Text(
          '支援 BIN、HEX、ZIP、JSON、SIG；ESP32 OTA 請將可開機的 .bin 設為主要檔案。',
          style: TextStyle(color: FactoryColors.secondary, fontSize: 12),
        ),
      ),
      if (selectedFiles.isNotEmpty)
        Card(
          child: Column(
            children: [
              for (var index = 0; index < selectedFiles.length; index++)
                ListTile(
                  onTap: saving
                      ? null
                      : () => setState(() => primaryFileIndex = index),
                  title: Text(selectedFiles[index].name),
                  subtitle: Text(
                    '${_formatBytes(selectedFiles[index].size)}${index == primaryFileIndex ? ' · 主要 OTA 檔案' : ''}',
                  ),
                  leading: Icon(
                    selectedFiles[index].extension?.toLowerCase() == 'bin'
                        ? CupertinoIcons.cube_box_fill
                        : CupertinoIcons.doc_fill,
                    color: index == primaryFileIndex
                        ? FactoryColors.blue
                        : FactoryColors.secondary,
                  ),
                  trailing: Icon(
                    index == primaryFileIndex
                        ? CupertinoIcons.check_mark_circled_solid
                        : CupertinoIcons.circle,
                    color: index == primaryFileIndex
                        ? FactoryColors.green
                        : FactoryColors.secondary,
                  ),
                ),
            ],
          ),
        ),
      const SizedBox(height: 8),
      _field(
        notes,
        '版本更新說明（必填）',
        lines: 4,
        hint: '例如：\n• 修正 OTA 後版本確認與回滾\n• 新增馬達溫度校正\n• 改善 MQTTS 斷線重連',
      ),
      if (error != null)
        Text(error!, style: const TextStyle(color: FactoryColors.red)),
    ],
  );
}

class _CampaignSheet extends ConsumerStatefulWidget {
  const _CampaignSheet();
  @override
  ConsumerState<_CampaignSheet> createState() => _CampaignSheetState();
}

class _CampaignSheetState extends ConsumerState<_CampaignSheet> {
  final name = TextEditingController();
  int? packageId;
  OtaStrategy strategy = OtaStrategy.canary;
  final selected = <String>{};
  bool saving = false;
  String? error;

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (packageId == null || selected.isEmpty) {
      setState(() => error = '請選擇韌體與至少一台相容設備');
      return;
    }
    setState(() {
      saving = true;
      error = null;
    });
    try {
      await ref
          .read(clientProvider)
          .ota
          .createTargetCampaign(
            packageId!,
            name.text,
            strategy,
            selected.toList(),
            null,
          );
      ref.invalidate(otaCampaignsProvider);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          saving = false;
          error = '$e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final packages =
        ref.watch(firmwarePackagesProvider).value ?? const <FirmwarePackage>[];
    final targets = ref.watch(otaTargetsProvider).value ?? const <OtaTarget>[];
    final selectedPackage = packages
        .where((p) => p.id == packageId)
        .firstOrNull;
    final selectedTargets = targets
        .where((target) => selected.contains(target.targetKey))
        .toList();
    final compatiblePackages = selectedTargets.isEmpty
        ? <FirmwarePackage>[]
        : packages
              .where(
                (release) => selectedTargets.every(
                  (target) => _isCompatibleTarget(target, release),
                ),
              )
              .toList();
    compatiblePackages.sort(
      (a, b) => _compareVersions(b.version, a.version),
    );
    final direction = selectedPackage == null || selectedTargets.isEmpty
        ? null
        : _versionDirection(
            selectedTargets.first.firmwareVersion,
            selectedPackage.version,
          );
    return _SheetFrame(
      title: '指定設備 OTA 更新',
      action: saving ? null : save,
      actionLabel: saving ? '建立中' : '建立草稿',
      children: [
        const _StepLabel(number: '1', title: '選擇實體設備'),
        const SizedBox(height: 8),
        for (final target in targets)
          CheckboxListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            value: selected.contains(target.targetKey),
            title: Text(target.name),
            subtitle: Text(
              '${target.serialNumber ?? target.model} · ${target.model} · '
              '目前 ${target.firmwareVersion ?? '版本未知'}',
            ),
            secondary: Icon(
              target.targetKind == 'gateway'
                  ? CupertinoIcons.antenna_radiowaves_left_right
                  : CupertinoIcons.cube_box_fill,
              color: FactoryColors.purple,
            ),
            onChanged: (value) => setState(() {
              value == true
                  ? selected.add(target.targetKey)
                  : selected.remove(target.targetKey);
              packageId = null;
            }),
          ),
        if (targets.isEmpty) const _EmptyCard(message: '目前沒有可執行 OTA 的設備'),
        const SizedBox(height: 12),
        const _StepLabel(number: '2', title: '選擇目標韌體版本'),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          initialValue: packageId,
          decoration: const InputDecoration(labelText: '相容版本'),
          items: [
            for (final release in compatiblePackages)
              DropdownMenuItem(
                value: release.id,
                child: Text(
                  'v${release.version} · ${_versionDirection(selectedTargets.first.firmwareVersion, release.version)}',
                ),
              ),
          ],
          onChanged: selected.isEmpty
              ? null
              : (value) => setState(() => packageId = value),
        ),
        if (selected.isNotEmpty && compatiblePackages.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              '沒有與所選設備相容的韌體，請先在「版本資產」建立對應產品版本。',
              style: TextStyle(color: FactoryColors.orange, fontSize: 12),
            ),
          ),
        if (selectedPackage != null)
          Card(
            color: direction == '降版'
                ? FactoryColors.orange.withValues(alpha: .08)
                : FactoryColors.green.withValues(alpha: .08),
            child: ListTile(
              leading: Icon(
                direction == '降版'
                    ? CupertinoIcons.arrow_down_circle_fill
                    : CupertinoIcons.arrow_up_circle_fill,
                color: direction == '降版'
                    ? FactoryColors.orange
                    : FactoryColors.green,
              ),
              title: Text('$direction至 v${selectedPackage.version}'),
              subtitle: Text(
                '${selectedPackage.chipFamily ?? selectedPackage.targetDeviceType} · '
                '${selectedPackage.updateProtocol ?? '標準 OTA'} · '
                '${selected.length} 台設備',
              ),
            ),
          ),
        const SizedBox(height: 12),
        const _StepLabel(number: '3', title: '設定執行方式'),
        const SizedBox(height: 8),
        _field(name, '任務名稱'),
        SegmentedButton<OtaStrategy>(
          segments: const [
            ButtonSegment(value: OtaStrategy.canary, label: Text('小批測試')),
            ButtonSegment(value: OtaStrategy.staged, label: Text('分批')),
            ButtonSegment(value: OtaStrategy.immediate, label: Text('立即')),
          ],
          selected: {strategy},
          onSelectionChanged: (value) => setState(() => strategy = value.first),
        ),
        if (direction == '降版')
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '降版可能造成設定或資料格式不相容，正式設備應確認 Bootloader 未啟用防降版限制。',
              style: TextStyle(color: FactoryColors.orange, fontSize: 12),
            ),
          ),
        if (error != null)
          Text(error!, style: const TextStyle(color: FactoryColors.red)),
      ],
    );
  }
}

class _StepLabel extends StatelessWidget {
  const _StepLabel({required this.number, required this.title});
  final String number;
  final String title;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      CircleAvatar(
        radius: 13,
        backgroundColor: FactoryColors.purple,
        child: Text(
          number,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      const SizedBox(width: 9),
      Text(title, style: Theme.of(context).textTheme.titleMedium),
    ],
  );
}

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({
    required this.title,
    required this.action,
    required this.actionLabel,
    required this.children,
  });
  final String title;
  final VoidCallback? action;
  final String actionLabel;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(
      20,
      12,
      20,
      MediaQuery.viewInsetsOf(context).bottom + 24,
    ),
    child: ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            CupertinoButton(onPressed: action, child: Text(actionLabel)),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _field(
  TextEditingController controller,
  String label, {
  int lines = 1,
  TextInputType? keyboard,
  String? hint,
}) => Padding(
  padding: const EdgeInsets.only(bottom: 12),
  child: TextField(
    controller: controller,
    maxLines: lines,
    keyboardType: keyboard,
    decoration: InputDecoration(labelText: label, hintText: hint),
  ),
);

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.11),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800),
    ),
  );
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();
  @override
  Widget build(BuildContext context) => const Card(
    child: SizedBox(
      height: 88,
      child: Center(child: CupertinoActivityIndicator()),
    ),
  );
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Center(child: Text(message)),
    ),
  );
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Text(message, style: const TextStyle(color: FactoryColors.red)),
    ),
  );
}

Color _campaignColor(OtaCampaignState state) => switch (state) {
  OtaCampaignState.completed => FactoryColors.green,
  OtaCampaignState.failed || OtaCampaignState.cancelled => FactoryColors.red,
  OtaCampaignState.running => FactoryColors.blue,
  _ => FactoryColors.purple,
};

String _campaignStateLabel(OtaCampaignState state) => switch (state) {
  OtaCampaignState.draft => '草稿',
  OtaCampaignState.scheduled => '已排程',
  OtaCampaignState.running => '發布中',
  OtaCampaignState.paused => '已暫停',
  OtaCampaignState.completed => '已完成',
  OtaCampaignState.failed => '失敗',
  OtaCampaignState.cancelled => '已取消',
};

String _strategyLabel(OtaStrategy strategy) => switch (strategy) {
  OtaStrategy.immediate => '立即發布',
  OtaStrategy.canary => '金絲雀發布',
  OtaStrategy.staged => '分批發布',
  OtaStrategy.scheduled => '排程發布',
};

String _jobStateLabel(OtaJobState state) => switch (state) {
  OtaJobState.pending => '等待下載',
  OtaJobState.downloading => '下載韌體',
  OtaJobState.installing => '寫入備援分區',
  OtaJobState.verifying => '驗證並重啟',
  OtaJobState.succeeded => '更新完成',
  OtaJobState.failed => '更新失敗',
  OtaJobState.cancelled => '已取消',
  OtaJobState.rolledBack => '已回滾',
};

bool _isCompatibleTarget(OtaTarget target, FirmwarePackage release) {
  final productMatches = target.targetKind == 'gateway'
      ? target.productKey == release.productKey
      : target.productKey == release.targetDeviceType;
  return productMatches &&
      (release.chipFamily == null ||
          target.chipFamily == null ||
          target.chipFamily == release.chipFamily) &&
      (release.updateProtocol == null ||
          target.updateProtocol == null ||
          target.updateProtocol == release.updateProtocol) &&
      (release.hardwareRevision == null ||
          target.hardwareRevision == release.hardwareRevision);
}

int _compareVersions(String left, String right) {
  List<int> parts(String value) => value
      .split(RegExp(r'[+-]'))
      .first
      .split('.')
      .map((part) => int.tryParse(part) ?? 0)
      .toList();
  final a = parts(left);
  final b = parts(right);
  for (var index = 0; index < 3; index++) {
    final result = (index < a.length ? a[index] : 0).compareTo(
      index < b.length ? b[index] : 0,
    );
    if (result != 0) return result;
  }
  return 0;
}

String _versionDirection(String? current, String target) {
  if (current == null || current.trim().isEmpty) return '首次安裝';
  final comparison = _compareVersions(target, current);
  if (comparison > 0) return '升級';
  if (comparison < 0) return '降版';
  return '重新安裝';
}

String _formatBytes(int bytes) => bytes < 1024 * 1024
    ? '${(bytes / 1024).toStringAsFixed(1)} KB'
    : '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
