import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import '../../design/factory_theme.dart';
import '../../widgets/tech_ui.dart';
import '../dashboard/dashboard_providers.dart';
import 'site_editor_dialog.dart';
import 'sites_providers.dart';

/// 設備庫：場域列表與場域 CRUD 入口。
class SitesScreen extends ConsumerWidget {
  const SitesScreen({super.key});

  Future<void> _deleteSite(
    BuildContext context,
    WidgetRef ref,
    Site site,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('刪除場域「${site.name}」？'),
        content: const Text('場域內仍有閘道器或設備時將無法刪除。'),
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
    if (confirmed != true) return;

    try {
      await ref.read(clientProvider).site.deleteSite(site.id!);
      ref.invalidate(sitesProvider);
      ref.invalidate(dashboardProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e is ValidationException ? e.message : '$e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sites = ref.watch(sitesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('設備庫')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const SiteEditorDialog(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('新增場域'),
      ),
      body: sites.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorRetry(
          message: '$error',
          onRetry: () => ref.invalidate(sitesProvider),
        ),
        data: (items) => RefreshIndicator(
          onRefresh: () => ref.refresh(sitesProvider.future),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
            children: [
              TechHero(
                eyebrow: 'ASSET TOPOLOGY',
                title: '${items.length} 個生產場域',
                subtitle: '集中管理產線、閘道器與多元感測設備',
                icon: Icons.account_tree_outlined,
              ),
              TechSectionLabel(
                '場域拓撲',
                detail: items.isEmpty ? '尚未建置' : '${items.length} SITES',
              ),
              if (items.isEmpty)
                const SizedBox(
                  height: 300,
                  child: TechEmptyState(
                    icon: Icons.factory_outlined,
                    title: '建立第一個場域',
                    subtitle: '點選右下角新增，開始建立工廠與設備拓撲。',
                  ),
                )
              else
                for (final site in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      key: ValueKey(site.id),
                      child: ListTile(
                        minTileHeight: 76,
                        leading: const TechIcon(icon: Icons.factory_outlined),
                        title: Text(site.name),
                        subtitle: Text(
                          site.description ?? '智慧製造場域 · 即時監控',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PopupMenuButton<String>(
                              tooltip: '場域操作',
                              onSelected: (action) {
                                if (action == 'edit') {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        SiteEditorDialog(site: site),
                                  );
                                } else if (action == 'delete') {
                                  _deleteSite(context, ref, site);
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
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: FactoryColors.secondary,
                            ),
                          ],
                        ),
                        onTap: () => context.go('/assets/${site.id}'),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text('重試')),
          ],
        ),
      ),
    );
  }
}
