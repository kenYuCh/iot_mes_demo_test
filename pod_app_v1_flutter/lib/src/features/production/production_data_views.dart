// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:flutter/material.dart' hide MaterialType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../widgets/tech_ui.dart';
import 'production_providers.dart';

class ProductionAsync<T> extends StatelessWidget {
  const ProductionAsync({super.key, required this.value, required this.data});
  final AsyncValue<T> value;
  final Widget Function(T) data;
  @override
  Widget build(BuildContext context) => value.when(
    data: data,
    loading: () => const Padding(
      padding: EdgeInsets.all(36),
      child: Center(child: CircularProgressIndicator()),
    ),
    error: (error, _) => TechEmptyState(
      icon: Icons.cloud_off_outlined,
      title: '無法載入製程資料',
      subtitle: '$error',
    ),
  );
}

class ProductionOverview extends ConsumerWidget {
  const ProductionOverview({super.key, required this.onScan});
  final VoidCallback onScan;
  @override
  Widget build(BuildContext context, WidgetRef ref) => ProductionAsync(
    value: ref.watch(productionSummaryProvider),
    data: (s) => Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _Metric('投入數量', s.totalUnits, Icons.login),
            _Metric('完工數量', s.completedUnits, Icons.task_alt),
            _Metric('在製品 WIP', s.inProgressUnits, Icons.pending_actions),
            _Metric('異常／返工', s.abnormalUnits, Icons.warning_amber),
          ],
        ),
        const SizedBox(height: 14),
        Card(
          child: ListTile(
            leading: const Icon(Icons.qr_code_scanner_rounded),
            title: const Text('掃描產品過站'),
            subtitle: Text('進行中工單：${s.activeOrders}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: onScan,
          ),
        ),
      ],
    ),
  );
}

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value, this.icon);
  final String label;
  final int value;
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
                Text(
                  '$value',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(label),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class MaterialsView extends ConsumerWidget {
  const MaterialsView({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context, WidgetRef ref) => ProductionAsync(
    value: ref.watch(materialsProvider),
    data: (rows) {
      final q = query.toLowerCase();
      final filtered = rows
          .where(
            (m) =>
                m.code.toLowerCase().contains(q) ||
                m.name.toLowerCase().contains(q) ||
                (m.supplier ?? '').toLowerCase().contains(q),
          )
          .toList();
      if (filtered.isEmpty) return _empty('尚無物料主檔');
      return Column(
        children: [
          for (final m in filtered)
            Card(
              child: ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text('${m.code}  ${m.name}'),
                subtitle: Text(
                  '${m.type.name} · ${m.unit} · 安全庫存 ${m.safetyStock}',
                ),
                onTap: () => showMaterialEditor(context, ref, current: m),
                trailing: PopupMenuButton<String>(
                  onSelected: (v) async {
                    if (v == 'lot') await showLotEditor(context, ref, m);
                    if (v == 'delete' && await confirmDelete(context, m.name)) {
                      await ref
                          .read(clientProvider)
                          .production
                          .deleteMaterial(m.id!);
                      invalidateProduction(ref);
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'lot', child: Text('新增批次')),
                    PopupMenuItem(value: 'delete', child: Text('刪除')),
                  ],
                ),
              ),
            ),
        ],
      );
    },
  );
}

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context, WidgetRef ref) => ProductionAsync(
    value: ref.watch(productsProvider),
    data: (rows) {
      final q = query.toLowerCase();
      final filtered = rows
          .where(
            (p) =>
                p.code.toLowerCase().contains(q) ||
                p.name.toLowerCase().contains(q),
          )
          .toList();
      if (filtered.isEmpty) return _empty('尚無產品定義');
      return Column(
        children: [
          for (final p in filtered)
            Card(
              child: ListTile(
                leading: const Icon(Icons.category_outlined),
                title: Text('${p.code}  ${p.name}'),
                subtitle: Text(
                  '${p.specification ?? '無規格'} · ${p.active ? '啟用' : '停用'}',
                ),
                onTap: () => showProductEditor(context, ref, current: p),
                trailing: PopupMenuButton<String>(
                  onSelected: (v) async {
                    if (v == 'bom') await showBomManager(context, ref, p);
                    if (v == 'delete' && await confirmDelete(context, p.name)) {
                      await ref
                          .read(clientProvider)
                          .production
                          .deleteProduct(p.id!);
                      invalidateProduction(ref);
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'bom', child: Text('管理 BOM')),
                    PopupMenuItem(value: 'delete', child: Text('刪除')),
                  ],
                ),
              ),
            ),
        ],
      );
    },
  );
}

class RoutesView extends ConsumerWidget {
  const RoutesView({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context, WidgetRef ref) => ProductionAsync(
    value: ref.watch(processRoutesProvider),
    data: (rows) {
      final q = query.toLowerCase();
      final filtered = rows
          .where(
            (r) =>
                r.code.toLowerCase().contains(q) ||
                r.name.toLowerCase().contains(q),
          )
          .toList();
      if (filtered.isEmpty) return _empty('尚無製程路線');
      return Column(
        children: [
          for (final r in filtered)
            Card(
              child: ListTile(
                leading: const Icon(Icons.account_tree_outlined),
                title: Text('${r.code}  ${r.name}'),
                subtitle: Text(
                  'Version ${r.version} · ${r.active ? '啟用' : '停用'}',
                ),
                onTap: () => showNodeManager(context, ref, r),
                trailing: PopupMenuButton<String>(
                  onSelected: (v) async {
                    if (v == 'edit')
                      await showRouteEditor(context, ref, current: r);
                    if (v == 'delete' && await confirmDelete(context, r.name)) {
                      await ref
                          .read(clientProvider)
                          .production
                          .deleteRoute(r.id!);
                      invalidateProduction(ref);
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('編輯路線')),
                    PopupMenuItem(value: 'delete', child: Text('刪除')),
                  ],
                ),
              ),
            ),
        ],
      );
    },
  );
}

class OrdersView extends ConsumerWidget {
  const OrdersView({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context, WidgetRef ref) => ProductionAsync(
    value: ref.watch(productionOrdersProvider),
    data: (rows) {
      final q = query.toLowerCase();
      final filtered = rows
          .where(
            (o) =>
                o.orderNumber.toLowerCase().contains(q) ||
                o.status.name.toLowerCase().contains(q),
          )
          .toList();
      if (filtered.isEmpty) return _empty('尚無生產工單');
      return Column(
        children: [
          for (final o in filtered)
            Card(
              child: ListTile(
                leading: const Icon(Icons.assignment_outlined),
                title: Text(o.orderNumber),
                subtitle: Text(
                  '${o.status.name} · ${o.completedQuantity}/${o.plannedQuantity} · 不良 ${o.rejectedQuantity}',
                ),
                onTap: () => showUnitManager(context, ref, o),
                trailing: PopupMenuButton<String>(
                  onSelected: (v) async {
                    if (v == 'release')
                      await ref
                          .read(clientProvider)
                          .production
                          .setProductionOrderStatus(
                            o.id!,
                            ProductionOrderStatus.released,
                          );
                    if (v == 'start')
                      await ref
                          .read(clientProvider)
                          .production
                          .setProductionOrderStatus(
                            o.id!,
                            ProductionOrderStatus.inProgress,
                          );
                    if (v == 'complete')
                      await ref
                          .read(clientProvider)
                          .production
                          .setProductionOrderStatus(
                            o.id!,
                            ProductionOrderStatus.completed,
                          );
                    if (v == 'delete' &&
                        await confirmDelete(context, o.orderNumber))
                      await ref
                          .read(clientProvider)
                          .production
                          .deleteProductionOrder(o.id!);
                    invalidateProduction(ref);
                  },
                  itemBuilder: (_) => [
                    if (o.status == ProductionOrderStatus.draft)
                      const PopupMenuItem(
                        value: 'release',
                        child: Text('發行工單'),
                      ),
                    if (o.status == ProductionOrderStatus.released)
                      const PopupMenuItem(value: 'start', child: Text('開始生產')),
                    if (o.status == ProductionOrderStatus.inProgress)
                      const PopupMenuItem(
                        value: 'complete',
                        child: Text('完成工單'),
                      ),
                    if (o.status == ProductionOrderStatus.draft)
                      const PopupMenuItem(value: 'delete', child: Text('刪除草稿')),
                  ],
                ),
              ),
            ),
        ],
      );
    },
  );
}

class TraceView extends ConsumerStatefulWidget {
  const TraceView({super.key, required this.query});
  final String query;
  @override
  ConsumerState<TraceView> createState() => _TraceViewState();
}

class _TraceViewState extends ConsumerState<TraceView> {
  ProductTrace? trace;
  Object? error;
  bool loading = false;
  Future<void> search() async {
    if (widget.query.isEmpty) return;
    setState(() {
      loading = true;
      error = null;
    });
    try {
      trace = await ref
          .read(clientProvider)
          .production
          .getProductTrace(widget.query);
    } catch (e) {
      error = e;
      trace = null;
    }
    if (mounted) setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      FilledButton.icon(
        onPressed: loading || widget.query.isEmpty ? null : search,
        icon: const Icon(Icons.search),
        label: const Text('查詢產品履歷'),
      ),
      if (loading) const LinearProgressIndicator(),
      if (error != null)
        ListTile(
          leading: const Icon(Icons.error_outline),
          title: Text('$error'),
        ),
      if (trace != null) ...[
        Card(
          child: ListTile(
            title: Text(trace!.unit.serialNumber),
            subtitle: Text(
              '${trace!.product.name} · ${trace!.order.orderNumber} · ${trace!.unit.status.name}',
            ),
          ),
        ),
        for (final e in trace!.events)
          ListTile(
            leading: const Icon(Icons.circle, size: 12),
            title: Text(
              '${e.stationCode} · ${e.eventType.name} · ${e.result.name}',
            ),
            subtitle: Text(e.occurredAt.toLocal().toString()),
          ),
      ] else if (!loading && error == null)
        _empty('輸入產品序號、QR Code 或 RFID EPC'),
    ],
  );
}

Widget _empty(String title) => TechEmptyState(
  icon: Icons.inbox_outlined,
  title: title,
  subtitle: '目前沒有符合條件的真實資料。',
);

Future<bool> confirmDelete(BuildContext context, String name) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('確認刪除'),
        content: Text('確定刪除「$name」？已被生產資料引用時 Server 會拒絕。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('刪除'),
          ),
        ],
      ),
    ) ??
    false;

Future<void> showMaterialEditor(
  BuildContext context,
  WidgetRef ref, {
  MaterialItem? current,
}) async {
  final code = TextEditingController(text: current?.code),
      name = TextEditingController(text: current?.name),
      unit = TextEditingController(text: current?.unit ?? '個'),
      stock = TextEditingController(text: '${current?.safetyStock ?? 0}');
  var type = current?.type ?? MaterialType.raw;
  await _formSheet(
    context,
    current == null ? '新增物料' : '編輯物料',
    (setState) => [
      _field(code, '料號'),
      _field(name, '名稱'),
      DropdownButtonFormField(
        value: type,
        items: MaterialType.values
            .map((v) => DropdownMenuItem(value: v, child: Text(v.name)))
            .toList(),
        onChanged: (v) => setState(() => type = v!),
        decoration: const InputDecoration(labelText: '類型'),
      ),
      _field(unit, '單位'),
      _field(stock, '安全庫存', number: true),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .saveMaterial(
          current?.id,
          code.text,
          name.text,
          type,
          unit.text,
          current?.specification,
          current?.supplier,
          double.tryParse(stock.text) ?? 0,
          current?.active ?? true,
        ),
  );
  invalidateProduction(ref);
}

Future<void> showProductEditor(
  BuildContext context,
  WidgetRef ref, {
  ProductDefinition? current,
}) async {
  final code = TextEditingController(text: current?.code),
      name = TextEditingController(text: current?.name),
      unit = TextEditingController(text: current?.unit ?? '個'),
      spec = TextEditingController(text: current?.specification);
  await _formSheet(
    context,
    current == null ? '新增產品' : '編輯產品',
    (_) => [
      _field(code, '產品代碼'),
      _field(name, '產品名稱'),
      _field(spec, '規格'),
      _field(unit, '單位'),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .saveProduct(
          current?.id,
          code.text,
          name.text,
          unit.text,
          spec.text,
          current?.active ?? true,
        ),
  );
  invalidateProduction(ref);
}

Future<void> showRouteEditor(
  BuildContext context,
  WidgetRef ref, {
  ProcessRoute? current,
}) async {
  final products = await ref.read(productsProvider.future);
  if (!context.mounted) return;
  if (products.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('請先建立產品')));
    return;
  }
  var productId = current?.productDefinitionId ?? products.first.id!;
  final code = TextEditingController(text: current?.code),
      name = TextEditingController(text: current?.name),
      version = TextEditingController(text: '${current?.version ?? 1}');
  await _formSheet(
    context,
    current == null ? '新增製程路線' : '編輯製程路線',
    (setState) => [
      DropdownButtonFormField(
        value: productId,
        items: products
            .map(
              (p) => DropdownMenuItem(
                value: p.id!,
                child: Text('${p.code} ${p.name}'),
              ),
            )
            .toList(),
        onChanged: (v) => setState(() => productId = v!),
        decoration: const InputDecoration(labelText: '產品'),
      ),
      _field(code, '路線代碼'),
      _field(name, '路線名稱'),
      _field(version, '版本', number: true),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .saveRoute(
          current?.id,
          productId,
          code.text,
          name.text,
          int.tryParse(version.text) ?? 1,
          current?.active ?? true,
        ),
  );
  invalidateProduction(ref);
}

Future<void> showOrderEditor(BuildContext context, WidgetRef ref) async {
  final products = await ref.read(productsProvider.future),
      routes = await ref.read(processRoutesProvider.future);
  if (!context.mounted) return;
  if (products.isEmpty || routes.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('請先建立產品與製程路線')));
    return;
  }
  var productId = products.first.id!;
  var available = routes
      .where((r) => r.productDefinitionId == productId)
      .toList();
  var routeId = available.isEmpty ? routes.first.id! : available.first.id!;
  final number = TextEditingController(
        text: 'MO-${DateTime.now().millisecondsSinceEpoch}',
      ),
      qty = TextEditingController(text: '1');
  await _formSheet(
    context,
    '建立生產工單',
    (setState) => [
      _field(number, '工單編號'),
      DropdownButtonFormField(
        value: productId,
        items: products
            .map((p) => DropdownMenuItem(value: p.id!, child: Text(p.name)))
            .toList(),
        onChanged: (v) => setState(() {
          productId = v!;
          available = routes
              .where((r) => r.productDefinitionId == productId)
              .toList();
          routeId = available.first.id!;
        }),
        decoration: const InputDecoration(labelText: '產品'),
      ),
      DropdownButtonFormField(
        value: routeId,
        items: available
            .map((r) => DropdownMenuItem(value: r.id!, child: Text(r.name)))
            .toList(),
        onChanged: (v) => setState(() => routeId = v!),
        decoration: const InputDecoration(labelText: '製程路線'),
      ),
      _field(qty, '預計數量', number: true),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .createProductionOrder(
          number.text,
          productId,
          routeId,
          int.tryParse(qty.text) ?? 1,
          null,
          null,
        ),
  );
  invalidateProduction(ref);
}

Widget _field(TextEditingController c, String label, {bool number = false}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: c,
        keyboardType: number ? TextInputType.number : null,
        decoration: InputDecoration(labelText: label),
        validator: (v) => v == null || v.trim().isEmpty ? '必填' : null,
      ),
    );

Future<void> _formSheet(
  BuildContext context,
  String title,
  List<Widget> Function(StateSetter) fields,
  Future<void> Function() save,
) async {
  final key = GlobalKey<FormState>();
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    constraints: const BoxConstraints(maxWidth: double.infinity),
    builder: (sheetContext) => FractionallySizedBox(
      widthFactor: 1,
      heightFactor: .78,
      child: StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Form(
            key: key,
            child: ListView(
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                ...fields(setState),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: () async {
                    if (!key.currentState!.validate()) return;
                    try {
                      await save();
                      if (sheetContext.mounted) Navigator.pop(sheetContext);
                    } catch (e) {
                      if (sheetContext.mounted)
                        ScaffoldMessenger.of(
                          sheetContext,
                        ).showSnackBar(SnackBar(content: Text('$e')));
                    }
                  },
                  child: const Text('儲存'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> showLotEditor(
  BuildContext context,
  WidgetRef ref,
  MaterialItem material,
) async {
  final lot = TextEditingController(),
      qty = TextEditingController(text: '0'),
      qr = TextEditingController(),
      rfid = TextEditingController();
  await _formSheet(
    context,
    '新增 ${material.name} 批次',
    (_) => [
      _field(lot, '批號'),
      _field(qty, '數量', number: true),
      _field(qr, 'QR Code'),
      _field(rfid, 'RFID EPC'),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .saveMaterialLot(
          null,
          material.id!,
          lot.text,
          double.tryParse(qty.text) ?? 0,
          DateTime.now(),
          null,
          null,
          qr.text,
          rfid.text,
        ),
  );
  invalidateProduction(ref);
}

Future<void> showBomManager(
  BuildContext context,
  WidgetRef ref,
  ProductDefinition product,
) async {
  final items = await ref.read(bomProvider(product.id!).future),
      materials = await ref.read(materialsProvider.future);
  if (!context.mounted) return;
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: double.infinity),
    builder: (context) => FractionallySizedBox(
      widthFactor: 1,
      heightFactor: .78,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              '${product.name} BOM',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            for (final item in items)
              ListTile(
                title: Text(
                  materials
                          .where((m) => m.id == item.materialId)
                          .map((m) => m.name)
                          .firstOrNull ??
                      '#${item.materialId}',
                ),
                subtitle: Text('${item.quantity} ${item.unit}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    await ref
                        .read(clientProvider)
                        .production
                        .deleteBomItem(item.id!);
                    if (context.mounted) Navigator.pop(context);
                    invalidateProduction(ref);
                  },
                ),
              ),
            FilledButton.icon(
              onPressed: materials.isEmpty
                  ? null
                  : () async {
                      Navigator.pop(context);
                      await showBomEditor(context, ref, product, materials);
                    },
              icon: const Icon(Icons.add),
              label: const Text('新增 BOM 項目'),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> showBomEditor(
  BuildContext context,
  WidgetRef ref,
  ProductDefinition product,
  List<MaterialItem> materials,
) async {
  var materialId = materials.first.id!;
  final qty = TextEditingController(text: '1'),
      unit = TextEditingController(text: materials.first.unit);
  await _formSheet(
    context,
    '新增 BOM 項目',
    (setState) => [
      DropdownButtonFormField(
        value: materialId,
        items: materials
            .map((m) => DropdownMenuItem(value: m.id!, child: Text(m.name)))
            .toList(),
        onChanged: (v) => setState(() => materialId = v!),
        decoration: const InputDecoration(labelText: '物料'),
      ),
      _field(qty, '用量', number: true),
      _field(unit, '單位'),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .saveBomItem(
          null,
          product.id!,
          materialId,
          double.tryParse(qty.text) ?? 1,
          unit.text,
          0,
          null,
        ),
  );
  invalidateProduction(ref);
}

Future<void> showNodeManager(
  BuildContext context,
  WidgetRef ref,
  ProcessRoute route,
) async {
  final nodes = await ref.read(processNodesProvider(route.id!).future);
  if (!context.mounted) return;
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: double.infinity),
    builder: (context) => FractionallySizedBox(
      widthFactor: 1,
      heightFactor: .78,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(route.name, style: Theme.of(context).textTheme.titleLarge),
            for (final n in nodes)
              ListTile(
                leading: CircleAvatar(child: Text('${n.sequence}')),
                title: Text(n.name),
                subtitle: Text('${n.stationCode} · ${n.standardSeconds}s'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    await ref
                        .read(clientProvider)
                        .production
                        .deleteProcessNode(n.id!);
                    if (context.mounted) Navigator.pop(context);
                    invalidateProduction(ref);
                  },
                ),
              ),
            FilledButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                await showNodeEditor(context, ref, route, nodes.length + 1);
              },
              icon: const Icon(Icons.add),
              label: const Text('新增製程節點'),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> showNodeEditor(
  BuildContext context,
  WidgetRef ref,
  ProcessRoute route,
  int sequence,
) async {
  final workstations = await ref.read(workstationsProvider.future);
  if (!context.mounted) return;
  if (workstations.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('請先建立工作站')),
    );
    return;
  }
  var stationCode = workstations.first.code;
  final code = TextEditingController(),
      name = TextEditingController(),
      seconds = TextEditingController(text: '60');
  await _formSheet(
    context,
    '新增製程節點',
    (setState) => [
      _field(code, '節點代碼'),
      _field(name, '節點名稱'),
      DropdownButtonFormField(
        value: stationCode,
        items: workstations
            .where((station) => station.active)
            .map(
              (station) => DropdownMenuItem(
                value: station.code,
                child: Text('${station.code} · ${station.name}'),
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => stationCode = value!),
        decoration: const InputDecoration(labelText: '工作站'),
      ),
      _field(seconds, '標準秒數', number: true),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .saveProcessNode(
          null,
          route.id!,
          sequence,
          code.text,
          name.text,
          stationCode,
          int.tryParse(seconds.text) ?? 60,
          'startComplete',
          false,
          true,
          null,
        ),
  );
  invalidateProduction(ref);
}

Future<void> showUnitManager(
  BuildContext context,
  WidgetRef ref,
  ProductionOrder order,
) async {
  final units = await ref.read(productUnitsProvider(order.id!).future);
  if (!context.mounted) return;
  final prefix = TextEditingController(text: order.orderNumber);
  final qty = TextEditingController(
    text: '${order.plannedQuantity - units.length}',
  );
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: double.infinity),
    builder: (context) => FractionallySizedBox(
      widthFactor: 1,
      heightFactor: .78,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              '${order.orderNumber} 產品序號',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            for (final u in units)
              ListTile(
                title: Text(u.serialNumber),
                subtitle: Text('${u.status.name} · ${u.qrCode}'),
              ),
            if (units.length < order.plannedQuantity) ...[
              _field(prefix, '序號前綴'),
              _field(qty, '產生數量', number: true),
              FilledButton(
                onPressed: () async {
                  await ref
                      .read(clientProvider)
                      .production
                      .generateProductUnits(
                        order.id!,
                        int.tryParse(qty.text) ?? 1,
                        prefix.text,
                      );
                  if (context.mounted) Navigator.pop(context);
                  invalidateProduction(ref);
                },
                child: const Text('產生產品序號'),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

Future<void> showStationEventSheet(BuildContext context, WidgetRef ref) async {
  final stations = await ref.read(myWorkstationsProvider.future);
  final transfers = await ref.read(myPendingTransfersProvider.future);
  final units = await ref.read(productUnitsProvider(null).future);
  if (!context.mounted) return;
  if (stations.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('您尚未被指派工作站，請聯絡管理者')));
    return;
  }
  var workstationId = stations.first.id!,
      type = ProcessEventType.completed,
      result = ProcessResult.pass;
  final identifier = TextEditingController();
  await _formSheet(
    context,
    '產品過站',
    (setState) => [
      if (transfers.isNotEmpty) ...[
        const Text('待處理跨產線交接'),
        const SizedBox(height: 8),
        for (final transfer in transfers)
          Card(
            child: ListTile(
              leading: Icon(
                transfer.status == LineTransferStatus.awaitingDispatch
                    ? Icons.outbox_outlined
                    : Icons.move_to_inbox_outlined,
              ),
              title: Text(
                units
                        .where((unit) => unit.id == transfer.productUnitId)
                        .map((unit) => unit.serialNumber)
                        .firstOrNull ??
                    '產品 #${transfer.productUnitId}',
              ),
              subtitle: Text(transfer.status.name),
              trailing: FilledButton.tonal(
                onPressed: () async {
                  if (transfer.status == LineTransferStatus.awaitingDispatch) {
                    await ref
                        .read(clientProvider)
                        .production
                        .dispatchLineTransfer(transfer.id!);
                  } else {
                    await ref
                        .read(clientProvider)
                        .production
                        .receiveLineTransfer(transfer.id!);
                  }
                  if (context.mounted) Navigator.pop(context);
                  invalidateProduction(ref);
                },
                child: Text(
                  transfer.status == LineTransferStatus.awaitingDispatch
                      ? '確認轉出'
                      : '確認接收',
                ),
              ),
            ),
          ),
        const Divider(height: 28),
      ],
      DropdownButtonFormField<int>(
        value: workstationId,
        items: stations
            .map(
              (station) => DropdownMenuItem(
                value: station.id!,
                child: Text('${station.code} · ${station.name}'),
              ),
            )
            .toList(),
        onChanged: (v) => setState(() => workstationId = v!),
        decoration: const InputDecoration(labelText: '我的工作站'),
      ),
      TextFormField(
        controller: identifier,
        decoration: InputDecoration(
          labelText: '產品序號／QR／RFID',
          suffixIcon: IconButton(
            tooltip: '開啟相機掃描 QR Code',
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () async {
              final value = await showProductQrScanner(context);
              if (value != null) {
                identifier.text = value;
                setState(() {});
              }
            },
          ),
        ),
        validator: (value) =>
            value == null || value.trim().isEmpty ? '請掃描或輸入產品識別碼' : null,
      ),
      DropdownButtonFormField(
        value: type,
        items: ProcessEventType.values
            .map((v) => DropdownMenuItem(value: v, child: Text(v.name)))
            .toList(),
        onChanged: (v) => setState(() => type = v!),
        decoration: const InputDecoration(labelText: '事件'),
      ),
      DropdownButtonFormField(
        value: result,
        items: ProcessResult.values
            .map((v) => DropdownMenuItem(value: v, child: Text(v.name)))
            .toList(),
        onChanged: (v) => setState(() => result = v!),
        decoration: const InputDecoration(labelText: '結果'),
      ),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .recordWorkstationEvent(
          '${DateTime.now().microsecondsSinceEpoch}',
          workstationId,
          identifier.text,
          type,
          result,
          DateTime.now(),
        ),
  );
  invalidateProduction(ref);
}

Future<String?> showProductQrScanner(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.black,
    constraints: const BoxConstraints(maxWidth: double.infinity),
    builder: (_) => const _ProductQrScannerSheet(),
  );
}

class _ProductQrScannerSheet extends StatefulWidget {
  const _ProductQrScannerSheet();

  @override
  State<_ProductQrScannerSheet> createState() => _ProductQrScannerSheetState();
}

class _ProductQrScannerSheetState extends State<_ProductQrScannerSheet> {
  final _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    formats: const [BarcodeFormat.qrCode],
  );
  bool _handled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue?.trim();
      if (value == null || value.isEmpty) continue;
      _handled = true;
      _controller.stop();
      Navigator.of(context).pop(value);
      return;
    }
  }

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
    widthFactor: 1,
    heightFactor: .82,
    child: Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: _controller,
          onDetect: _onDetect,
          errorBuilder: (context, error) => ColoredBox(
            color: Colors.black,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  '無法開啟相機：$error\n\n'
                  '請到 iPhone「設定 → 隱私與安全性 → 相機」允許此 App。\n'
                  'iOS Simulator 請改用手動輸入。',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: IgnorePointer(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.cyanAccent, width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          top: 12,
          child: Row(
            children: [
              IconButton.filledTonal(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
              const Expanded(
                child: Text(
                  '掃描產品 QR Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton.filledTonal(
                tooltip: '手電筒',
                onPressed: _controller.toggleTorch,
                icon: const Icon(Icons.flashlight_on_outlined),
              ),
            ],
          ),
        ),
        const Positioned(
          left: 24,
          right: 24,
          bottom: 26,
          child: Text(
            '將產品 QR Code 放入掃描框內\n讀取成功後會自動回到過站畫面',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

Future<void> showWorkstationManager(BuildContext context, WidgetRef ref) async {
  try {
    final lines = await ref.read(productionLinesProvider.future);
    final stations = await ref.read(workstationsProvider.future);
    final assignments = await ref.read(workstationAssignmentsProvider.future);
    final members = await ref.read(clientProvider).access.listMembers();
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      builder: (context) => FractionallySizedBox(
        widthFactor: 1,
        heightFactor: .86,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(
                '工作站與員工指派',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 6),
              const Text('員工只能在被指派的工作站過站；Server 會再驗證工單路線。'),
              const SizedBox(height: 12),
              Text('產線', style: Theme.of(context).textTheme.titleMedium),
              for (final line in lines)
                ListTile(
                  leading: const Icon(Icons.linear_scale),
                  title: Text('${line.code}  ${line.name}'),
                  subtitle: Text(line.active ? '啟用' : '停用'),
                ),
              OutlinedButton.icon(
                onPressed: () async {
                  Navigator.pop(context);
                  await showProductionLineEditor(context, ref);
                },
                icon: const Icon(Icons.add_road),
                label: const Text('新增產線'),
              ),
              const Divider(height: 28),
              Text('工作站', style: Theme.of(context).textTheme.titleMedium),
              for (final station in stations)
                Card(
                  child: ExpansionTile(
                    leading: const Icon(Icons.precision_manufacturing_outlined),
                    title: Text('${station.code}  ${station.name}'),
                    subtitle: Text(
                      '${lines.where((line) => line.id == station.productionLineId).map((line) => line.name).firstOrNull ?? '未知產線'} · ${station.active ? '啟用' : '停用'}',
                    ),
                    children: [
                      for (final detail in assignments.where(
                        (a) => a.workstation.id == station.id,
                      ))
                        ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: Text(
                            detail.memberDisplayName ?? detail.memberEmail,
                          ),
                          subtitle: Text(detail.memberEmail),
                          trailing: IconButton(
                            tooltip: '解除工位指派',
                            icon: const Icon(Icons.person_remove_outlined),
                            onPressed: () async {
                              await ref
                                  .read(clientProvider)
                                  .production
                                  .removeWorkstationAssignment(
                                    detail.assignment.id!,
                                  );
                              if (context.mounted) Navigator.pop(context);
                              invalidateProduction(ref);
                            },
                          ),
                        ),
                      ListTile(
                        leading: const Icon(Icons.person_add_alt),
                        title: const Text('指派員工'),
                        onTap: () async {
                          Navigator.pop(context);
                          await showAssignEmployee(
                            context,
                            ref,
                            station,
                            members,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              FilledButton.icon(
                onPressed: () async {
                  Navigator.pop(context);
                  await showWorkstationEditor(context, ref);
                },
                icon: const Icon(Icons.add),
                label: const Text('新增工作站'),
              ),
            ],
          ),
        ),
      ),
    );
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('只有管理者可管理工作站：$error')),
      );
    }
  }
}

Future<void> showWorkstationEditor(BuildContext context, WidgetRef ref) async {
  final lines = await ref.read(productionLinesProvider.future);
  if (!context.mounted) return;
  if (lines.where((line) => line.active).isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('請先建立產線')),
    );
    return;
  }
  var productionLineId = lines.where((line) => line.active).first.id!;
  final code = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();
  await _formSheet(
    context,
    '新增工作站',
    (setState) => [
      DropdownButtonFormField<int>(
        value: productionLineId,
        items: lines
            .where((line) => line.active)
            .map(
              (line) => DropdownMenuItem(
                value: line.id!,
                child: Text('${line.code} · ${line.name}'),
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => productionLineId = value!),
        decoration: const InputDecoration(labelText: '所屬產線'),
      ),
      _field(code, '工作站代碼（需與製程節點匹配）'),
      _field(name, '工作站名稱'),
      _field(description, '說明'),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .saveWorkstation(
          null,
          productionLineId,
          code.text,
          name.text,
          description.text,
          true,
        ),
  );
  invalidateProduction(ref);
}

Future<void> showProductionLineEditor(
  BuildContext context,
  WidgetRef ref,
) async {
  final code = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();
  await _formSheet(
    context,
    '新增產線',
    (_) => [
      _field(code, '產線代碼（例如 A-LINE）'),
      _field(name, '產線名稱'),
      _field(description, '說明'),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .saveProductionLine(null, code.text, name.text, description.text, true),
  );
  invalidateProduction(ref);
}

Future<void> showAssignEmployee(
  BuildContext context,
  WidgetRef ref,
  Workstation station,
  List<MemberAccessSummary> members,
) async {
  if (members.isEmpty) return;
  var membershipId = members.first.membershipId;
  await _formSheet(
    context,
    '指派員工至 ${station.name}',
    (setState) => [
      DropdownButtonFormField(
        value: membershipId,
        items: members
            .where((member) => member.isActive)
            .map(
              (member) => DropdownMenuItem(
                value: member.membershipId,
                child: Text(member.displayName ?? member.email),
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => membershipId = value!),
        decoration: const InputDecoration(labelText: '員工帳號'),
      ),
    ],
    () async => ref
        .read(clientProvider)
        .production
        .assignWorkstation(station.id!, membershipId),
  );
  invalidateProduction(ref);
}
