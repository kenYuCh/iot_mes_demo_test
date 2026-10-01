import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../widgets/connection_badge.dart';
import '../../widgets/feature_value_text.dart';
import '../site_detail/site_detail_providers.dart';
import '../ota/ota_providers.dart';
import '../work_orders/work_order_editor_dialog.dart';
import 'command_card.dart';
import 'control_panel_card.dart';
import 'device_detail_providers.dart';

/// 折線圖顯示的最大點數（手機層級，見 docs/frontend/flutter-iot-performance.md）。
const _maxChartPoints = 300;

enum _HistoryRange {
  oneHour('1h', Duration(hours: 1)),
  threeHours('3h', Duration(hours: 3)),
  sixHours('6h', Duration(hours: 6)),
  twelveHours('12h', Duration(hours: 12)),
  oneDay('1d', Duration(days: 1)),
  threeDays('3d', Duration(days: 3)),
  oneWeek('1w', Duration(days: 7)),
  twoWeeks('2w', Duration(days: 14)),
  fourWeeks('4w', Duration(days: 28)),
  custom('自訂', null);

  const _HistoryRange(this.label, this.duration);
  final String label;
  final Duration? duration;
}

/// 設備的量測通道（多通道設備有 2~6 個）。
List<DeviceFeature> measurementFeaturesOf(Device device) => [
  for (final f in device.features ?? const <DeviceFeature>[])
    if (f.kind == FeatureKind.measurement) f,
];

class DeviceDetailScreen extends ConsumerStatefulWidget {
  const DeviceDetailScreen({
    super.key,
    required this.siteId,
    required this.deviceId,
  });

  final int siteId;
  final int deviceId;

  @override
  ConsumerState<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends ConsumerState<DeviceDetailScreen> {
  /// 圖表資料點（時間升冪）。由歷史查詢初始化，之後隨即時狀態串流追加。
  final _points = <({DateTime time, double value})>[];
  bool _historyLoaded = false;
  DateTime? _lastAppendedAt;

  /// 趨勢圖目前顯示的量測通道；null 表示尚未初始化（取第一個通道）。
  String? _selectedKey;
  _HistoryRange _selectedRange = _HistoryRange.oneHour;
  late DateTime _rangeStart;
  late DateTime _rangeEnd;
  DateTime? _highlightedAt;

  @override
  void initState() {
    super.initState();
    _rangeEnd = DateTime.now();
    _rangeStart = _rangeEnd.subtract(const Duration(hours: 1));
  }

  void _resetHistory() {
    _points.clear();
    _historyLoaded = false;
    _lastAppendedAt = null;
    _highlightedAt = null;
  }

  void _selectFeature(String key) {
    if (key == _selectedKey) return;
    setState(() {
      _selectedKey = key;
      _resetHistory();
    });
  }

  void _selectRange(_HistoryRange range) {
    if (range == _HistoryRange.custom) {
      _selectCustomRange();
      return;
    }
    final end = DateTime.now();
    setState(() {
      _selectedRange = range;
      _rangeEnd = end;
      _rangeStart = end.subtract(range.duration!);
      _resetHistory();
    });
  }

  Future<void> _selectCustomRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      initialDateRange: DateTimeRange(
        start: _rangeStart.isBefore(DateTime(now.year - 5))
            ? DateTime(now.year - 5)
            : _rangeStart,
        end: _rangeEnd.isAfter(now) ? now : _rangeEnd,
      ),
      helpText: '選擇歷史資料範圍',
      cancelText: '取消',
      confirmText: '套用',
      saveText: '套用',
    );
    if (picked == null || !mounted) return;
    setState(() {
      _selectedRange = _HistoryRange.custom;
      _rangeStart = DateTime(
        picked.start.year,
        picked.start.month,
        picked.start.day,
      );
      final inclusiveEnd = DateTime(
        picked.end.year,
        picked.end.month,
        picked.end.day + 1,
      ).subtract(const Duration(milliseconds: 1));
      _rangeEnd = inclusiveEnd.isAfter(now) ? now : inclusiveEnd;
      _resetHistory();
    });
  }

  void _seedHistory(List<Measurement> newestFirst) {
    if (_historyLoaded) return;
    _historyLoaded = true;
    _points.insertAll(
      0,
      newestFirst.reversed.map((m) => (time: m.measuredAt, value: m.value)),
    );
    if (_points.isNotEmpty) {
      _lastAppendedAt = _points.last.time;
    }
    _trim();
  }

  void _appendLive(DeviceStatus status, String featureKey) {
    final value = status.latestValues[featureKey];
    final time = status.lastUpdatedAt;
    if (value == null || time == null) return;
    if (_lastAppendedAt != null && !time.isAfter(_lastAppendedAt!)) return;
    _lastAppendedAt = time;
    setState(() {
      _points.add((time: time, value: value));
      _trim();
    });
  }

  void _trim() {
    if (_points.length > _maxChartPoints) {
      _points.removeRange(0, _points.length - _maxChartPoints);
    }
  }

  @override
  Widget build(BuildContext context) {
    final device = ref.watch(deviceProvider(widget.deviceId));
    final statuses = ref.watch(siteStatusesProvider(widget.siteId));
    final firmwarePackages = ref.watch(firmwarePackagesProvider).value;

    final deviceData = device.value;
    final status = statuses.value?[widget.deviceId];
    final features = deviceData == null
        ? const <DeviceFeature>[]
        : measurementFeaturesOf(deviceData);
    final selectedKey =
        _selectedKey ?? (features.isEmpty ? null : features.first.key);
    final selectedFeature = features
        .where((f) => f.key == selectedKey)
        .firstOrNull;
    final compatibleFirmware = deviceData == null
        ? const <FirmwarePackage>[]
        : _compatibleFirmwarePackages(
            deviceData,
            firmwarePackages ?? const [],
          );
    final latestFirmware = compatibleFirmware.firstOrNull;

    // 選定通道的歷史資料到達時（本次 build 前）初始化圖表點。
    if (selectedKey != null) {
      ref
          .watch(
            measurementsProvider((
              deviceId: widget.deviceId,
              featureKey: selectedKey,
              startAt: _rangeStart,
              endAt: _rangeEnd,
            )),
          )
          .whenData((result) => _seedHistory(result.items));
    }

    // 即時串流更新透過 listener 追加（不可在 build 中 setState）。
    ref.listen(siteStatusesProvider(widget.siteId), (previous, next) {
      final liveStatus = next.value?[widget.deviceId];
      if (liveStatus != null && selectedKey != null) {
        _appendLive(liveStatus, selectedKey);
      }
    });

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          deviceData?.name ?? '設備',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
        actions: [
          if (deviceData != null)
            IconButton(
              tooltip: '開立工單',
              onPressed: () => _openWorkOrder(context, deviceData),
              icon: const Icon(Icons.build_outlined),
            ),
          const SizedBox(width: 4),
        ],
      ),
      bottomNavigationBar: deviceData == null
          ? null
          : _DeviceInfoBottomBar(
              onTap: () => _showDeviceInfo(
                context,
                deviceData,
                latestFirmware,
                compatibleFirmware,
              ),
            ),
      body: deviceData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _LiveValuesCard(
                  features: features,
                  status: status,
                  selectedKey: selectedKey,
                  onSelect: _selectFeature,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedFeature == null
                            ? '趨勢'
                            : '趨勢：${selectedFeature.label}'
                                  '${selectedFeature.unit.isEmpty ? '' : '（${selectedFeature.unit}）'}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    if (_highlightedAt != null)
                      Text(
                        DateFormat(
                          'yyyy-MM-dd HH:mm:ss',
                        ).format(_highlightedAt!.toLocal()),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final range in _HistoryRange.values)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: ChoiceChip(
                            label: Text(range.label),
                            selected: _selectedRange == range,
                            onSelected: (_) => _selectRange(range),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 8),
                  child: Text(
                    '${DateFormat('yyyy-MM-dd HH:mm:ss').format(_rangeStart.toLocal())} － '
                    '${DateFormat('yyyy-MM-dd HH:mm:ss').format(_rangeEnd.toLocal())}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(
                  height: 240,
                  child: _points.length < 2
                      ? const Center(child: Text('資料收集中…'))
                      : _TrendChart(
                          points: List.of(_points),
                          onHighlight: (time) {
                            if (_highlightedAt == time) return;
                            setState(() => _highlightedAt = time);
                          },
                        ),
                ),
                const SizedBox(height: 16),
                ControlPanelCard(device: deviceData, status: status),
                const SizedBox(height: 16),
                CommandCard(
                  device: deviceData,
                  status: status,
                ),
                const SizedBox(height: 24),
              ],
            ),
    );
  }

  void _openWorkOrder(BuildContext context, Device device) {
    showDialog<void>(
      context: context,
      builder: (context) => WorkOrderEditorDialog(
        presetSiteId: widget.siteId,
        presetDeviceId: widget.deviceId,
        presetDeviceName: device.name,
      ),
    );
  }

  void _showDeviceInfo(
    BuildContext context,
    Device device,
    FirmwarePackage? latestFirmware,
    List<FirmwarePackage> compatibleFirmware,
  ) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => _DeviceInfoSheet(
        device: device,
        latestFirmware: latestFirmware,
        compatibleFirmware: compatibleFirmware,
      ),
    );
  }
}

class _DeviceInfoBottomBar extends StatelessWidget {
  const _DeviceInfoBottomBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: ListTile(
          onTap: onTap,
          leading: Icon(Icons.info_outline_rounded, color: scheme.primary),
          title: const Text(
            '設備資訊',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: const Text('查看型號與 Firmware'),
          trailing: const Icon(Icons.keyboard_arrow_up_rounded),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
          minTileHeight: 56,
          shape: const Border(
            top: BorderSide(width: .5, color: Colors.white12),
          ),
        ),
      ),
    );
  }
}

class _DeviceInfoSheet extends ConsumerStatefulWidget {
  const _DeviceInfoSheet({
    required this.device,
    required this.latestFirmware,
    required this.compatibleFirmware,
  });

  final Device device;
  final FirmwarePackage? latestFirmware;
  final List<FirmwarePackage> compatibleFirmware;

  @override
  ConsumerState<_DeviceInfoSheet> createState() => _DeviceInfoSheetState();
}

class _DeviceInfoSheetState extends ConsumerState<_DeviceInfoSheet> {
  static const _otaStallTimeout = Duration(seconds: 30);
  int? campaignId;
  bool starting = false;
  bool loadingActive = true;
  String? error;
  Timer? refreshTimer;
  FirmwarePackage? selectedFirmware;
  late String? currentFirmwareVersion;
  String? _lastJobSignature;
  DateTime? _lastProgressChangedAt;
  bool _stoppingStalledJob = false;

  bool get canInstallSelected {
    final current = currentFirmwareVersion;
    final latest = selectedFirmware?.version;
    return current != null &&
        latest != null &&
        _compareFirmwareVersions(latest, current) != 0;
  }

  @override
  void initState() {
    super.initState();
    currentFirmwareVersion = widget.device.firmwareVersion;
    selectedFirmware = widget.latestFirmware;
    Future<void>.microtask(_restoreActiveCampaign);
  }

  Future<void> _restoreActiveCampaign() async {
    try {
      final detail = await ref
          .read(clientProvider)
          .ota
          .getActiveDeviceCampaign(widget.device.id!);
      if (!mounted) return;
      setState(() {
        campaignId = detail?.campaign.id;
        loadingActive = false;
      });
      if (campaignId != null) _startRefreshTimer();
    } catch (exception) {
      if (mounted) {
        setState(() {
          loadingActive = false;
          error = '無法讀取 OTA 狀態：$exception';
        });
      }
    }
  }

  void _startRefreshTimer() {
    refreshTimer?.cancel();
    refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
      final id = campaignId;
      if (id != null && mounted) {
        ref.invalidate(otaCampaignDetailProvider(id));
        try {
          final detail = await ref.read(otaCampaignDetailProvider(id).future);
          final job = detail.jobs.firstOrNull;
          if (job != null && mounted) await _observeProgress(job);
        } catch (_) {
          // 暫時讀取失敗不視為 OTA 無進度；網路恢復後繼續觀察。
        }
      }
    });
  }

  Future<void> _observeProgress(OtaDeviceJob job) async {
    final terminal = {
      OtaJobState.succeeded,
      OtaJobState.failed,
      OtaJobState.cancelled,
      OtaJobState.rolledBack,
    }.contains(job.state);
    if (terminal) {
      refreshTimer?.cancel();
      if (job.state == OtaJobState.succeeded && selectedFirmware != null) {
        currentFirmwareVersion = selectedFirmware!.version;
        ref.invalidate(deviceProvider(widget.device.id!));
        if (mounted) setState(() {});
      }
      return;
    }
    final signature = '${job.state.name}:${job.progress}';
    final now = DateTime.now();
    if (_lastJobSignature != signature) {
      _lastJobSignature = signature;
      _lastProgressChangedAt = now;
      return;
    }
    _lastProgressChangedAt ??= now;
    if (_stoppingStalledJob ||
        now.difference(_lastProgressChangedAt!) < _otaStallTimeout) {
      return;
    }
    _stoppingStalledJob = true;
    try {
      await ref
          .read(clientProvider)
          .ota
          .stopStalledCampaign(
            campaignId!,
            widget.device.id!,
            job.state,
            job.progress,
          );
      ref.invalidate(otaCampaignDetailProvider(campaignId!));
      refreshTimer?.cancel();
      if (mounted) {
        setState(() {
          error = 'OTA 連續 30 秒沒有新進度，已停止等待。設備仍可正常運行，請確認網路後再次更新。';
        });
      }
    } catch (exception) {
      if (mounted) setState(() => error = '停止逾時 OTA 失敗：$exception');
    } finally {
      _stoppingStalledJob = false;
    }
  }

  void _resetFailedUpdate() {
    refreshTimer?.cancel();
    setState(() {
      campaignId = null;
      error = null;
      _lastJobSignature = null;
      _lastProgressChangedAt = null;
      _stoppingStalledJob = false;
    });
  }

  Future<void> _retryFailedUpdate() async {
    _resetFailedUpdate();
    await startUpdate();
  }

  @override
  void dispose() {
    refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> startUpdate() async {
    final firmware = selectedFirmware;
    if (firmware == null || firmware.id == null || !canInstallSelected) return;
    final isRollbackTest =
        firmware.fileName?.toLowerCase().contains('rollback_test') == true;
    final confirmed = await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('開始 OTA 更新？'),
        content: Text(
          '${widget.device.name}\n'
          'v$currentFirmwareVersion → v${firmware.version}\n\n'
          '${isRollbackTest ? '注意：這是回滾測試版本，啟動後會故意退回上一版。\n\n' : ''}'
          '更新期間請保持設備連線及供電。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('開始更新'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() {
      starting = true;
      error = null;
    });
    try {
      final client = ref.read(clientProvider);
      final campaign = await client.ota.createTargetCampaign(
        firmware.id!,
        '${widget.device.name} 單機 OTA v${firmware.version}',
        OtaStrategy.immediate,
        ['device:${widget.device.id}'],
        null,
      );
      await client.ota.startCampaign(campaign.id!);
      if (!mounted) return;
      setState(() {
        campaignId = campaign.id;
        starting = false;
        _lastJobSignature = null;
        _lastProgressChangedAt = DateTime.now();
      });
      _startRefreshTimer();
    } catch (exception) {
      if (mounted) {
        setState(() {
          starting = false;
          error = '$exception';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = campaignId == null
        ? null
        : ref.watch(otaCampaignDetailProvider(campaignId!));
    final job = detail?.value?.jobs.firstOrNull;
    final finished =
        job != null &&
        {
          OtaJobState.succeeded,
          OtaJobState.failed,
          OtaJobState.cancelled,
          OtaJobState.rolledBack,
        }.contains(job.state);
    if (finished) refreshTimer?.cancel();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MetaCard(
              device: widget.device.copyWith(
                firmwareVersion: currentFirmwareVersion,
              ),
              latestFirmwareVersion: widget.latestFirmware?.version,
              embedded: true,
            ),
            if (widget.compatibleFirmware.isNotEmpty && campaignId == null) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: selectedFirmware?.id,
                decoration: const InputDecoration(
                  labelText: '選擇韌體版本',
                  prefixIcon: Icon(Icons.memory_rounded),
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (
                    var index = 0;
                    index < widget.compatibleFirmware.length;
                    index++
                  )
                    DropdownMenuItem(
                      value: widget.compatibleFirmware[index].id,
                      child: Text(
                        'v${widget.compatibleFirmware[index].version}'
                        '${index == 0 ? '（最新版）' : ''}',
                      ),
                    ),
                ],
                onChanged: starting || loadingActive
                    ? null
                    : (id) => setState(() {
                        selectedFirmware = widget.compatibleFirmware
                            .where((item) => item.id == id)
                            .firstOrNull;
                        error = null;
                      }),
              ),
              if (selectedFirmware?.releaseNotes?.trim().isNotEmpty ==
                  true) ...[
                const SizedBox(height: 8),
                Text(
                  selectedFirmware!.releaseNotes!.trim(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
            if (loadingActive) ...[
              const SizedBox(height: 8),
              const LinearProgressIndicator(),
              const SizedBox(height: 6),
              const Text('正在確認既有 OTA 任務…'),
            ],
            if (campaignId == null && canInstallSelected) ...[
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: starting || loadingActive ? null : startUpdate,
                icon: starting
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.system_update_alt_rounded),
                label: Text(
                  starting
                      ? '正在建立更新任務…'
                      : '${_compareFirmwareVersions(selectedFirmware!.version, currentFirmwareVersion ?? '0') < 0 ? '降版至' : '更新至'} v${selectedFirmware!.version}',
                ),
              ),
            ],
            if (campaignId == null &&
                selectedFirmware != null &&
                !canInstallSelected) ...[
              const SizedBox(height: 8),
              const Text(
                '此設備目前已是所選版本。',
                textAlign: TextAlign.center,
              ),
            ],
            if (campaignId != null) ...[
              const SizedBox(height: 12),
              _InlineOtaProgress(job: job, loading: detail?.isLoading == true),
            ],
            if (finished &&
                job.state != OtaJobState.succeeded &&
                selectedFirmware != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _resetFailedUpdate,
                      icon: const Icon(Icons.swap_horiz_rounded),
                      label: const Text('重新選擇版本'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _retryFailedUpdate,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('再次更新'),
                    ),
                  ),
                ],
              ),
            ],
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(
                error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InlineOtaProgress extends StatelessWidget {
  const _InlineOtaProgress({required this.job, required this.loading});

  final OtaDeviceJob? job;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final progress = job?.progress ?? 0;
    final state = job?.state;
    final color = switch (state) {
      OtaJobState.succeeded => Colors.green,
      OtaJobState.failed ||
      OtaJobState.rolledBack => Theme.of(context).colorScheme.error,
      _ => Theme.of(context).colorScheme.primary,
    };
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.system_update_rounded, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  state == null ? '等待設備回應' : _otaJobLabel(state),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Text('$progress%'),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: state == null && loading ? null : progress / 100,
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
          if (job?.errorMessage?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(job!.errorMessage!, style: TextStyle(color: color)),
          ],
        ],
      ),
    );
  }
}

String _otaJobLabel(OtaJobState state) => switch (state) {
  OtaJobState.pending => '等待設備接收更新',
  OtaJobState.downloading => '正在下載韌體',
  OtaJobState.installing => '正在安裝韌體',
  OtaJobState.verifying => '重啟並確認版本',
  OtaJobState.succeeded => '更新完成',
  OtaJobState.failed => '更新失敗',
  OtaJobState.cancelled => '更新已取消',
  OtaJobState.rolledBack => '更新失敗，已回滾',
};

/// 多通道即時值：每個量測通道一格，點擊切換趨勢圖。
class _LiveValuesCard extends StatelessWidget {
  const _LiveValuesCard({
    required this.features,
    required this.status,
    required this.selectedKey,
    required this.onSelect,
  });

  final List<DeviceFeature> features;
  final DeviceStatus? status;
  final String? selectedKey;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final updatedAt = status?.lastUpdatedAt?.toLocal();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('即時數值', style: Theme.of(context).textTheme.titleMedium),
                ConnectionBadge(
                  state:
                      status?.connectionState ?? DeviceConnectionState.unknown,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final feature in features)
                  _ValueTile(
                    feature: feature,
                    value: status?.latestValues[feature.key],
                    selected: feature.key == selectedKey,
                    onTap: () => onSelect(feature.key),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              updatedAt == null
                  ? '尚無資料'
                  : '最後更新 ${DateFormat('HH:mm:ss').format(updatedAt)}'
                        '${features.length > 1 ? '．點擊數值切換趨勢圖' : ''}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ValueTile extends StatelessWidget {
  const _ValueTile({
    required this.feature,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final DeviceFeature feature;
  final double? value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 104,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? scheme.primaryContainer
              : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: selected ? Border.all(color: scheme.primary) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feature.label,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              featureValueText(feature, value),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(feature.unit, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart({required this.points, required this.onHighlight});

  final List<({DateTime time, double value})> points;
  final ValueChanged<DateTime?> onHighlight;

  @override
  Widget build(BuildContext context) {
    final baseMs = points.first.time.millisecondsSinceEpoch;
    final spots = [
      for (final p in points)
        FlSpot((p.time.millisecondsSinceEpoch - baseMs) / 1000, p.value),
    ];
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: true,
          touchCallback: (event, response) {
            if (!event.isInterestedForInteractions ||
                response?.lineBarSpots?.isEmpty != false) {
              onHighlight(null);
              return;
            }
            final index = response!.lineBarSpots!.first.spotIndex;
            if (index >= 0 && index < points.length) {
              onHighlight(points[index].time);
            }
          },
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) => [
              for (final spot in spots)
                LineTooltipItem(
                  '${DateFormat('yyyy-MM-dd HH:mm:ss').format(points[spot.spotIndex].time.toLocal())}\n'
                  '${spot.y.toStringAsFixed(2)}',
                  TextStyle(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            dotData: const FlDotData(show: false),
            color: Theme.of(context).colorScheme.primary,
            barWidth: 2,
          ),
        ],
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
      ),
      duration: Duration.zero,
    );
  }
}

class _MetaCard extends StatelessWidget {
  const _MetaCard({
    required this.device,
    required this.latestFirmwareVersion,
    this.embedded = false,
  });

  final Device device;
  final String? latestFirmwareVersion;
  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final measurements = measurementFeaturesOf(device);
    final controls = [
      for (final f in device.features ?? const <DeviceFeature>[])
        if (f.kind == FeatureKind.control) f,
    ];
    final content = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('設備資訊', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _FirmwareVersionRow(
            currentVersion: device.firmwareVersion,
            latestVersion: latestFirmwareVersion,
          ),
          const Divider(height: 20),
          _row('型號', device.model),
          _row('類型', device.deviceType),
          _row(
            '量測通道',
            measurements.isEmpty
                ? '--'
                : measurements.map((f) => f.label).join('、'),
          ),
          if (controls.isNotEmpty)
            _row('控制參數', controls.map((f) => f.label).join('、')),
          _row('預期上報間隔', '${device.expectedIntervalSeconds} 秒'),
        ],
      ),
    );
    return embedded ? content : Card(child: content);
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 110, child: Text(label)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _FirmwareVersionRow extends StatelessWidget {
  const _FirmwareVersionRow({
    required this.currentVersion,
    required this.latestVersion,
  });

  final String? currentVersion;
  final String? latestVersion;

  @override
  Widget build(BuildContext context) {
    final current = currentVersion?.trim();
    final hasCurrent = current != null && current.isNotEmpty;
    final hasUpdate =
        hasCurrent &&
        latestVersion != null &&
        _compareFirmwareVersions(latestVersion!, current) > 0;
    final scheme = Theme.of(context).colorScheme;
    final color = hasUpdate ? scheme.tertiary : scheme.primary;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.memory_rounded, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '目前 Firmware',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  hasCurrent ? 'v$current' : '尚未回報',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          if (hasUpdate)
            Chip(
              avatar: const Icon(Icons.system_update_alt_rounded, size: 16),
              label: Text('最新 v$latestVersion'),
              visualDensity: VisualDensity.compact,
            )
          else if (hasCurrent && latestVersion == current)
            const Chip(
              avatar: Icon(Icons.check_circle_outline_rounded, size: 16),
              label: Text('已是最新'),
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }
}

List<FirmwarePackage> _compatibleFirmwarePackages(
  Device device,
  List<FirmwarePackage> packages,
) {
  final compatible =
      packages
          .where(
            (item) =>
                item.state == FirmwarePackageState.ready &&
                item.targetDeviceType == device.deviceType &&
                (item.hardwareRevision == null ||
                    item.hardwareRevision == device.hardwareRevision),
          )
          .toList()
        ..sort(
          (a, b) => _compareFirmwareVersions(b.version, a.version),
        );
  return compatible;
}

int _compareFirmwareVersions(String a, String b) {
  final left = a.split(RegExp(r'[+-]')).first.split('.');
  final right = b.split(RegExp(r'[+-]')).first.split('.');
  for (var index = 0; index < 3; index++) {
    final comparison = (int.tryParse(left.elementAtOrNull(index) ?? '') ?? 0)
        .compareTo(
          int.tryParse(right.elementAtOrNull(index) ?? '') ?? 0,
        );
    if (comparison != 0) return comparison;
  }
  return 0;
}
