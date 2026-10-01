import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../design/factory_theme.dart';
import '../alerts/alerts_providers.dart';
import 'dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardProvider);
    ref.listen(alertUpdatesProvider, (_, next) {
      if (next.hasValue) ref.invalidate(dashboardProvider);
    });

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: summary.when(
          loading: () => const _DashboardLoading(),
          error: (error, _) => _DashboardError(
            message: '$error',
            onRetry: () => ref.invalidate(dashboardProvider),
          ),
          data: (view) => RefreshIndicator.adaptive(
            onRefresh: () => ref.refresh(dashboardProvider.future),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
                  sliver: SliverList.list(
                    children: [
                      const _TopBar(),
                      const SizedBox(height: 18),
                      if (view.fromCache) ...[
                        _CacheNotice(syncedAt: view.syncedAt),
                        const SizedBox(height: 12),
                      ],
                      _SystemHero(data: view.summary),
                      const SizedBox(height: 14),
                      _KpiGrid(data: view.summary),
                      const SizedBox(height: 22),
                      const _SectionHeader(title: '生產效能', caption: '近 8 小時'),
                      const SizedBox(height: 10),
                      const _OeeCard(),
                      const SizedBox(height: 22),
                      const _SectionHeader(title: '快速控制', caption: '常用工作流程'),
                      const SizedBox(height: 10),
                      const _QuickActions(),
                      const SizedBox(height: 22),
                      _SectionHeader(
                        title: '場域脈動',
                        caption: '${view.summary.siteCount} 個場域',
                      ),
                      const SizedBox(height: 10),
                      if (view.summary.sites.isEmpty)
                        const _EmptySites()
                      else
                        for (final site in view.summary.sites)
                          _SiteCard(site: site),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final openAlertCount =
        ref.watch(openAlertsProvider).value?.items.length ?? 0;
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? '早安'
        : hour < 18
        ? '午安'
        : '晚安';
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'NEXUS FACTORY OS',
                style: TextStyle(
                  color: FactoryColors.blue,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.8,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '$greeting，控制中心',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
            ],
          ),
        ),
        _RoundButton(icon: CupertinoIcons.search, onTap: () {}),
        const SizedBox(width: 8),
        Stack(
          clipBehavior: Clip.none,
          children: [
            _RoundButton(
              icon: CupertinoIcons.bell,
              onTap: () => context.go('/alerts'),
            ),
            if (openAlertCount > 0)
              Positioned(
                right: 1,
                top: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: FactoryColors.red,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Theme.of(context).colorScheme.surface,
                        width: 2,
                      ),
                    ),
                  ),
                  child: const SizedBox(width: 10, height: 10),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Theme.of(context).colorScheme.surface,
    shape: CircleBorder(
      side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
    ),
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: SizedBox(
        width: 43,
        height: 43,
        child: Icon(
          icon,
          size: 19,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    ),
  );
}

class _SystemHero extends StatelessWidget {
  const _SystemHero({required this.data});
  final DashboardSummary data;

  @override
  Widget build(BuildContext context) {
    final rate = data.deviceCount == 0
        ? 0.0
        : data.onlineCount / data.deviceCount;
    final healthy = rate >= .9 && data.openAlertCount == 0;
    return Container(
      height: 218,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Color(0xFF101B36), Color(0xFF142E57), Color(0xFF134E71)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x30123355),
            blurRadius: 28,
            offset: Offset(0, 13),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(painter: _TechGridPainter()),
          ),
          Positioned(
            right: -36,
            top: -64,
            child: Container(
              width: 190,
              height: 190,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x5536C5F0), Color(0x001F8AB5)],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 7,
                            color: healthy
                                ? const Color(0xFF55F5AF)
                                : FactoryColors.orange,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            healthy ? 'SYSTEM NOMINAL' : 'ATTENTION REQUIRED',
                            style: const TextStyle(
                              color: Color(0xFFD8E8F5),
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: .8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      CupertinoIcons.waveform_path_ecg,
                      color: Color(0xFF6DD8FF),
                      size: 22,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 102,
                      height: 102,
                      child: CustomPaint(
                        painter: _HealthRingPainter(value: rate),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${(rate * 100).toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -1,
                                ),
                              ),
                              const Text(
                                'DEVICE UPTIME',
                                style: TextStyle(
                                  color: Color(0xFF91A8BF),
                                  fontSize: 7,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: .7,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '工廠即時健康度',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '在線 ${data.onlineCount}  ·  過期 ${data.staleCount}  ·  離線 ${data.offlineCount}',
                              style: const TextStyle(
                                color: Color(0xFFAFC3D6),
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _MiniStatus(
                                  icon: CupertinoIcons
                                      .antenna_radiowaves_left_right,
                                  value: '${data.gatewayCount}',
                                  label: 'Gateway',
                                ),
                                const SizedBox(width: 16),
                                _MiniStatus(
                                  icon: CupertinoIcons.exclamationmark_triangle,
                                  value: '${data.openAlertCount}',
                                  label: '告警',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatus extends StatelessWidget {
  const _MiniStatus({
    required this.icon,
    required this.value,
    required this.label,
  });
  final IconData icon;
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: const Color(0xFF55C9F5), size: 14),
      const SizedBox(width: 5),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(width: 3),
      Text(
        label,
        style: const TextStyle(color: Color(0xFF91A8BF), fontSize: 9),
      ),
    ],
  );
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.data});
  final DashboardSummary data;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: _KpiCard(
          label: '場域',
          value: '${data.siteCount}',
          delta: '全廠連線',
          icon: CupertinoIcons.building_2_fill,
          color: FactoryColors.blue,
        ),
      ),
      const SizedBox(width: 9),
      Expanded(
        child: _KpiCard(
          label: '設備資產',
          value: '${data.deviceCount}',
          delta: '${data.onlineCount} 運作中',
          icon: CupertinoIcons.cube_box_fill,
          color: FactoryColors.purple,
        ),
      ),
      const SizedBox(width: 9),
      Expanded(
        child: _KpiCard(
          label: '未結告警',
          value: '${data.openAlertCount}',
          delta: data.openAlertCount == 0 ? '狀態良好' : '需要處理',
          icon: CupertinoIcons.bolt_fill,
          color: data.openAlertCount == 0
              ? FactoryColors.green
              : FactoryColors.red,
        ),
      ),
    ],
  );
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.label,
    required this.value,
    required this.delta,
    required this.icon,
    required this.color,
  });
  final String label;
  final String value;
  final String delta;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: .08),
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, color: color, size: 15),
              ),
              const Spacer(),
              Icon(
                CupertinoIcons.arrow_up_right,
                color: color.withValues(alpha: .65),
                size: 13,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 25,
              height: 1,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            delta,
            maxLines: 1,
            style: TextStyle(
              color: color,
              fontSize: 8,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.caption});
  final String title;
  final String caption;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: -.3,
        ),
      ),
      const Spacer(),
      Text(
        caption,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

class _OeeCard extends ConsumerWidget {
  const _OeeCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) => ref
      .watch(oeeProvider)
      .when(
        loading: () => const Card(
          child: SizedBox(
            height: 145,
            child: Center(child: CupertinoActivityIndicator()),
          ),
        ),
        error: (error, _) => Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Text('OEE 無法取得：$error'),
          ),
        ),
        data: (data) {
          final color = data.oee >= .85
              ? FactoryColors.green
              : data.oee >= .6
              ? FactoryColors.orange
              : FactoryColors.red;
          return Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 94,
                  height: 94,
                  child: CustomPaint(
                    painter: _GaugePainter(value: data.oee, color: color),
                    child: Center(
                      child: Text(
                        '${(data.oee * 100).toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: color,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    children: [
                      _FactorBar(
                        label: '稼動率',
                        value: data.availability,
                        color: FactoryColors.blue,
                      ),
                      const SizedBox(height: 11),
                      _FactorBar(
                        label: '性能',
                        value: data.performance,
                        color: FactoryColors.purple,
                      ),
                      const SizedBox(height: 11),
                      _FactorBar(
                        label: '品質',
                        value: data.quality,
                        color: FactoryColors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}

class _FactorBar extends StatelessWidget {
  const _FactorBar({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final double value;
  final Color color;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 10,
            ),
          ),
          const Spacer(),
          Text(
            '${(value * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 5,
          color: color,
          backgroundColor: color.withValues(alpha: .1),
        ),
      ),
    ],
  );
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: _ActionButton(
          label: '設備配對',
          icon: CupertinoIcons.qrcode_viewfinder,
          color: FactoryColors.blue,
          onTap: () => context.go('/settings/provisioning'),
        ),
      ),
      const SizedBox(width: 9),
      Expanded(
        child: _ActionButton(
          label: 'OTA 更新',
          icon: CupertinoIcons.cloud_upload_fill,
          color: FactoryColors.purple,
          onTap: () => context.go('/settings/ota'),
        ),
      ),
      const SizedBox(width: 9),
      Expanded(
        child: _ActionButton(
          label: '新增工單',
          icon: CupertinoIcons.wrench_fill,
          color: FactoryColors.orange,
          onTap: () => context.go('/operations/workorders'),
        ),
      ),
      const SizedBox(width: 9),
      Expanded(
        child: _ActionButton(
          label: '設備中心',
          icon: CupertinoIcons.cube_box_fill,
          color: FactoryColors.green,
          onTap: () => context.go('/assets'),
        ),
      ),
    ],
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, color: color, size: 17),
            ),
            const SizedBox(height: 7),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _SiteCard extends StatelessWidget {
  const _SiteCard({required this.site});
  final SiteSummary site;

  @override
  Widget build(BuildContext context) {
    final rate = site.deviceCount == 0
        ? 0.0
        : site.onlineCount / site.deviceCount;
    final (color, label) = site.openAlertCount > 0
        ? (FactoryColors.red, 'ALERT')
        : rate >= .95
        ? (FactoryColors.green, 'NOMINAL')
        : (FactoryColors.orange, 'DEGRADED');
    return Card(
      key: ValueKey(site.siteId),
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => context.go('/assets/${site.siteId}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      value: rate,
                      strokeWidth: 4,
                      color: color,
                      backgroundColor: color.withValues(alpha: .1),
                    ),
                  ),
                  Icon(CupertinoIcons.building_2_fill, color: color, size: 19),
                ],
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      site.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '在線 ${site.onlineCount}/${site.deviceCount}  ·  告警 ${site.openAlertCount}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .5,
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Icon(
                CupertinoIcons.chevron_right,
                size: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechGridPainter extends CustomPainter {
  const _TechGridPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: .035)
      ..strokeWidth = .7;
    for (double x = 0; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HealthRingPainter extends CustomPainter {
  const _HealthRingPainter({required this.value});
  final double value;
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawArc(
      rect.deflate(5),
      -math.pi / 2,
      math.pi * 2,
      false,
      Paint()
        ..color = Colors.white.withValues(alpha: .09)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7,
    );
    canvas.drawArc(
      rect.deflate(5),
      -math.pi / 2,
      math.pi * 2 * value,
      false,
      Paint()
        ..shader = const SweepGradient(
          colors: [Color(0xFF3FCDF4), Color(0xFF55F5AF)],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 7,
    );
  }

  @override
  bool shouldRepaint(_HealthRingPainter oldDelegate) =>
      oldDelegate.value != value;
}

class _GaugePainter extends CustomPainter {
  const _GaugePainter({required this.value, required this.color});
  final double value;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final bg = Paint()
      ..color = color.withValues(alpha: .1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    final fg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;
    canvas.drawArc(rect.deflate(7), -math.pi / 2, math.pi * 2, false, bg);
    canvas.drawArc(
      rect.deflate(7),
      -math.pi / 2,
      math.pi * 2 * value,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) =>
      oldDelegate.value != value || oldDelegate.color != color;
}

class _CacheNotice extends StatelessWidget {
  const _CacheNotice({required this.syncedAt});
  final DateTime syncedAt;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    decoration: BoxDecoration(
      color: FactoryColors.orange.withValues(alpha: .1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        const Icon(CupertinoIcons.clock, size: 15, color: FactoryColors.orange),
        const SizedBox(width: 7),
        Text(
          '離線快取 · ${DateFormat('MM/dd HH:mm').format(syncedAt.toLocal())}',
          style: const TextStyle(
            color: FactoryColors.orange,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class _EmptySites extends StatelessWidget {
  const _EmptySites();
  @override
  Widget build(BuildContext context) => const Card(
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Center(child: Text('尚未建立場域')),
    ),
  );
}

class _DashboardLoading extends StatelessWidget {
  const _DashboardLoading();
  @override
  Widget build(BuildContext context) =>
      const Center(child: CupertinoActivityIndicator(radius: 14));
}

class _DashboardError extends StatelessWidget {
  const _DashboardError({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            CupertinoIcons.exclamationmark_triangle,
            color: FactoryColors.orange,
            size: 34,
          ),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 14),
          FilledButton(onPressed: onRetry, child: const Text('重新連線')),
        ],
      ),
    ),
  );
}
