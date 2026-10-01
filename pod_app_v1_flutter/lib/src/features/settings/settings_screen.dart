import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../core/providers.dart';
import '../../core/theme_mode_controller.dart';
import '../../design/factory_theme.dart';
import '../../widgets/tech_ui.dart';
import 'access_management_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(clientProvider);
    final themeMode = ref.watch(themeModeProvider);
    final permissions =
        ref.watch(myAccessProvider).value?.permissions ??
        const <PlatformPermission>[];
    final canWriteSettings = permissions.contains(
      PlatformPermission.settingsWrite,
    );
    final canManageDevices = permissions.contains(
      PlatformPermission.deviceManage,
    );
    final canManageOta = permissions.contains(PlatformPermission.otaManage);

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
        children: [
          TechHero(
            eyebrow: 'SYSTEM CONSOLE',
            title: '平台運作正常',
            subtitle: '安全連線、設備生命週期與版本發布控制',
            icon: Icons.hub_outlined,
            accent: FactoryColors.green,
          ),
          const TechSectionLabel('連線環境'),
          Card(
            child: ListTile(
              leading: const TechIcon(icon: Icons.dns_outlined),
              title: const Text('Serverpod API'),
              subtitle: Text(client.host),
              trailing: const _OnlineBadge(),
            ),
          ),
          const TechSectionLabel('外觀'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      TechIcon(
                        icon: Icons.brightness_6_outlined,
                        color: FactoryColors.purple,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('主題外觀'),
                            Text('切換整個 App 的明亮、深色或系統模式'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SegmentedButton<ThemeMode>(
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: Icon(Icons.settings_brightness_outlined),
                        label: Text('系統'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: Icon(Icons.light_mode_outlined),
                        label: Text('淺色'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: Icon(Icons.dark_mode_outlined),
                        label: Text('深色'),
                      ),
                    ],
                    selected: {themeMode},
                    onSelectionChanged: (selection) => ref
                        .read(themeModeProvider.notifier)
                        .setMode(selection.first),
                  ),
                ],
              ),
            ),
          ),
          const TechSectionLabel('設備與發布'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const TechIcon(
                    icon: Icons.schema_outlined,
                    color: FactoryColors.blue,
                  ),
                  title: const Text('設備特徵管理'),
                  subtitle: const Text('從特徵資料庫組合設備能力型別'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: canWriteSettings
                      ? () => context.go('/settings/device-profiles')
                      : null,
                ),
                const Divider(indent: 76),
                ListTile(
                  leading: const TechIcon(icon: Icons.qr_code_scanner),
                  title: const Text('設備配對與憑證'),
                  subtitle: const Text('掃碼綁定 ESP32、管理 mTLS 身分'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: canManageDevices
                      ? () => context.go('/settings/provisioning')
                      : null,
                ),
                const Divider(indent: 76),
                ListTile(
                  leading: const TechIcon(
                    icon: Icons.system_update_alt_rounded,
                    color: FactoryColors.purple,
                  ),
                  title: const Text('OTA 韌體更新'),
                  subtitle: const Text('韌體套件、灰度發布、進度與回滾'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: canManageOta
                      ? () => context.go('/settings/ota')
                      : null,
                ),
              ],
            ),
          ),
          const TechSectionLabel('帳號安全'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const TechIcon(
                    icon: Icons.manage_accounts_outlined,
                    color: FactoryColors.blue,
                  ),
                  title: const Text('帳戶權限與設備共享'),
                  subtitle: const Text('管理可讀可寫範圍與多人設備存取'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: canWriteSettings
                      ? () => context.go('/settings/access')
                      : null,
                ),
                const Divider(indent: 76),
                ListTile(
                  leading: const TechIcon(
                    icon: Icons.logout_rounded,
                    color: FactoryColors.red,
                  ),
                  title: const Text('登出此裝置'),
                  subtitle: const Text('清除本機工作階段與登入憑證'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('確認登出？'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('取消'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('登出'),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await client.auth.signOutDevice();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnlineBadge extends StatelessWidget {
  const _OnlineBadge();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: FactoryColors.green.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'ONLINE',
        style: TextStyle(
          color: FactoryColors.green,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: .7,
        ),
      ),
    );
  }
}
