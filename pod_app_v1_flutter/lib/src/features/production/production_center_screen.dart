// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../design/factory_theme.dart';
import '../../widgets/tech_ui.dart';
import 'production_data_views.dart';

enum _ProductionSection {
  overview('總覽', Icons.monitor_heart_outlined),
  workOrders('工單／WIP', Icons.assignment_outlined),
  products('產品', Icons.qr_code_2_outlined),
  materials('物料／BOM', Icons.inventory_2_outlined),
  routes('製程路線', Icons.account_tree_outlined),
  trace('追溯', Icons.manage_search_outlined);

  const _ProductionSection(this.label, this.icon);
  final String label;
  final IconData icon;
}

/// QR／RFID 製程追蹤的主控頁。
///
/// 此頁刻意不放示範資料；正式資料將由工單、產品序號、物料批次及
/// append-only 製程事件產生，避免把 UI 假資料誤認為現場生產紀錄。
class ProductionCenterScreen extends ConsumerStatefulWidget {
  const ProductionCenterScreen({super.key});

  @override
  ConsumerState<ProductionCenterScreen> createState() =>
      _ProductionCenterScreenState();
}

class _ProductionCenterScreenState
    extends ConsumerState<ProductionCenterScreen> {
  _ProductionSection _section = _ProductionSection.overview;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('製程追蹤中心'),
        actions: [
          IconButton(
            tooltip: '工作站與員工指派',
            onPressed: () => showWorkstationManager(context, ref),
            icon: const Icon(Icons.badge_outlined),
          ),
          IconButton(
            tooltip: 'QR／RFID 過站',
            onPressed: () => showStationEventSheet(context, ref),
            icon: const Icon(Icons.qr_code_scanner_rounded),
          ),
          const SizedBox(width: 4),
        ],
      ),
      floatingActionButton:
          _section == _ProductionSection.overview ||
              _section == _ProductionSection.trace
          ? null
          : FloatingActionButton.extended(
              heroTag: 'production_create',
              onPressed: () => _showCreateSheet(context, ref, _section),
              icon: const Icon(Icons.add),
              label: Text(_createLabel(_section)),
            ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 110),
        children: [
          const TechHero(
            eyebrow: 'MANUFACTURING EXECUTION',
            title: '產品從投料到完工，全程可追溯',
            subtitle: 'QR／RFID 過站 · WIP · 物料批次 · 品質與 IoT 數據關聯',
            icon: Icons.precision_manufacturing_outlined,
            accent: FactoryColors.secondary,
          ),
          const SizedBox(height: 14),
          _SectionPicker(
            selected: _section,
            onSelected: (value) => setState(() {
              _section = value;
              _query = '';
            }),
          ),
          const SizedBox(height: 14),
          if (_section != _ProductionSection.overview)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SearchBar(
                leading: const Icon(Icons.search),
                hintText: _searchHint(_section),
                onChanged: (value) => setState(() => _query = value.trim()),
              ),
            ),
          switch (_section) {
            _ProductionSection.overview => ProductionOverview(
              onScan: () => showStationEventSheet(context, ref),
            ),
            _ProductionSection.workOrders => OrdersView(query: _query),
            _ProductionSection.products => ProductsView(query: _query),
            _ProductionSection.materials => MaterialsView(query: _query),
            _ProductionSection.routes => RoutesView(query: _query),
            _ProductionSection.trace => TraceView(query: _query),
          },
        ],
      ),
    );
  }
}

class _SectionPicker extends StatelessWidget {
  const _SectionPicker({required this.selected, required this.onSelected});
  final _ProductionSection selected;
  final ValueChanged<_ProductionSection> onSelected;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (final section in _ProductionSection.values)
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: ChoiceChip(
              avatar: Icon(section.icon, size: 17),
              label: Text(section.label),
              selected: selected == section,
              onSelected: (_) => onSelected(section),
            ),
          ),
      ],
    ),
  );
}

class _Overview extends StatelessWidget {
  const _Overview();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const TechSectionLabel('今日生產', detail: 'LIVE WIP'),
      const Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _MetricCard(label: '投入數量', value: '0', icon: Icons.login),
          _MetricCard(label: '完工數量', value: '0', icon: Icons.task_alt),
          _MetricCard(
            label: '在製品 WIP',
            value: '0',
            icon: Icons.pending_actions,
          ),
          _MetricCard(label: '異常／返工', value: '0', icon: Icons.warning_amber),
        ],
      ),
      const TechSectionLabel('現場操作', detail: 'SHOP FLOOR'),
      Card(
        child: Column(
          children: [
            ListTile(
              leading: const TechIcon(icon: Icons.qr_code_scanner_rounded),
              title: const Text('掃描產品過站'),
              subtitle: const Text('辨識產品、工作站與下一個合法製程動作'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showScanStationSheet(context),
            ),
            const Divider(indent: 76, height: 1),
            const ListTile(
              leading: TechIcon(
                icon: Icons.sensors_outlined,
                color: FactoryColors.green,
              ),
              title: Text('製程 IoT 關聯'),
              subtitle: Text('產品進站至離站期間的量測值將關聯到該次製程'),
              trailing: _StateBadge(label: '待建立工單'),
            ),
          ],
        ),
      ),
      const TechSectionLabel('異常洞察', detail: 'QUALITY SIGNALS'),
      const TechEmptyState(
        icon: Icons.query_stats_outlined,
        title: '尚無製程數據',
        subtitle: '開始過站後將分析漏站、重複過站、超時停留、良率、Cycle Time 與設備異常關聯。',
      ),
    ],
  );
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: (MediaQuery.sizeOf(context).width - 42) / 2,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: Theme.of(context).textTheme.headlineSmall),
                Text(label, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _EmptyModule extends StatelessWidget {
  const _EmptyModule({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.query,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final String query;

  @override
  Widget build(BuildContext context) => TechEmptyState(
    icon: icon,
    title: query.isEmpty ? title : '找不到「$query」',
    subtitle: query.isEmpty ? subtitle : '請更換產品、物料、批號或工單關鍵字。',
  );
}

class _RoutesEmpty extends StatelessWidget {
  const _RoutesEmpty({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (query.isEmpty)
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _FlowStep(label: '投料'),
                _FlowArrow(),
                _FlowStep(label: '加工'),
                _FlowArrow(),
                _FlowStep(label: '檢驗'),
                _FlowArrow(),
                _FlowStep(label: '完工'),
              ],
            ),
          ),
        ),
      _EmptyModule(
        icon: Icons.account_tree_outlined,
        title: '尚無製程路線',
        subtitle: '節點可設定標準工時、量測上下限、過站模式、物料需求、返工與授權跳站。',
        query: query,
      ),
    ],
  );
}

class _FlowStep extends StatelessWidget {
  const _FlowStep({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(label, style: Theme.of(context).textTheme.labelMedium),
    ),
  );
}

class _FlowArrow extends StatelessWidget {
  const _FlowArrow();
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 3),
    child: Icon(Icons.chevron_right, size: 17),
  );
}

class _TraceEmpty extends StatelessWidget {
  const _TraceEmpty({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Card(
        child: ListTile(
          leading: const TechIcon(icon: Icons.manage_search_outlined),
          title: const Text('單件產品完整履歷'),
          subtitle: const Text('輸入產品序號、QR Code、RFID EPC、物料批號或工單編號'),
          trailing: FilledButton.tonal(
            onPressed: query.isEmpty ? null : () {},
            child: const Text('查詢'),
          ),
        ),
      ),
      const TechEmptyState(
        icon: Icons.timeline_outlined,
        title: '尚無可顯示的產品履歷',
        subtitle: '過站事件採 append-only 保存，包含人員、工作站、設備、結果、物料批次與 IoT 數據區間。',
      ),
    ],
  );
}

class _StateBadge extends StatelessWidget {
  const _StateBadge({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.orange.withValues(alpha: .12),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 11, color: Colors.orange),
    ),
  );
}

void _showScanStationSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    useSafeArea: true,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: double.infinity),
    builder: (context) => _ProductionSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('產品過站', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          const Text('先選擇此手機所在的工作站，再掃描產品識別。Server 將驗證製程順序。'),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            items: const [],
            onChanged: null,
            decoration: const InputDecoration(
              labelText: '工作站',
              hintText: '請先建立製程路線與工作站',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text('掃描 QR Code'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.nfc),
                  label: const Text('讀取 RFID'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'QR 可使用手機相機；UHF RFID 需外接或固定式 Reader，iPhone NFC 僅適用相容的近距離 Tag。',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}

Future<void> _showCreateSheet(
  BuildContext context,
  WidgetRef ref,
  _ProductionSection section,
) async {
  switch (section) {
    case _ProductionSection.workOrders:
      await showOrderEditor(context, ref);
    case _ProductionSection.products:
      await showProductEditor(context, ref);
    case _ProductionSection.materials:
      await showMaterialEditor(context, ref);
    case _ProductionSection.routes:
      await showRouteEditor(context, ref);
    default:
      break;
  }
}

/// 製程模組共用的大型 Bottom Sheet。
///
/// 固定提供足夠的初始高度，並在鍵盤開啟時保留可滾動空間，避免內容少時
/// Sheet 只展開約一成畫面。
class _ProductionSheet extends StatelessWidget {
  const _ProductionSheet({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: .78,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20 + keyboard),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: child,
        ),
      ),
    );
  }
}

String _createLabel(_ProductionSection section) => switch (section) {
  _ProductionSection.workOrders => '建立工單',
  _ProductionSection.products => '新增產品',
  _ProductionSection.materials => '新增物料',
  _ProductionSection.routes => '新增路線',
  _ => '新增',
};

String _searchHint(_ProductionSection section) => switch (section) {
  _ProductionSection.workOrders => '搜尋工單、產品或狀態',
  _ProductionSection.products => '搜尋產品型號、序號、QR 或 RFID',
  _ProductionSection.materials => '搜尋料號、名稱、批號或供應商',
  _ProductionSection.routes => '搜尋路線、節點或工作站',
  _ProductionSection.trace => '產品序號、RFID EPC、物料批號或工單',
  _ => '搜尋',
};
