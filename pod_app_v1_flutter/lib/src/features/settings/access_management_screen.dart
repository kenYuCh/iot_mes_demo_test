import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';

final myAccessProvider = FutureProvider.autoDispose<MemberAccessSummary>(
  (ref) => ref.watch(clientProvider).access.getMyAccess(),
);

class AccessManagementScreen extends ConsumerStatefulWidget {
  const AccessManagementScreen({super.key});

  @override
  ConsumerState<AccessManagementScreen> createState() =>
      _AccessManagementScreenState();
}

class _AccessManagementScreenState
    extends ConsumerState<AccessManagementScreen> {
  bool loading = true;
  String? error;
  List<MemberAccessSummary> members = const [];
  List<Device> devices = const [];

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    if (mounted) setState(() => loading = true);
    try {
      final client = ref.read(clientProvider);
      final results = await Future.wait([
        client.access.listMembers(),
        client.site.listSites(),
      ]);
      final sites = results[1] as List<Site>;
      final deviceGroups = await Future.wait([
        for (final site in sites) client.device.listBySite(site.id!),
      ]);
      if (!mounted) return;
      setState(() {
        members = results[0] as List<MemberAccessSummary>;
        devices = deviceGroups.expand((items) => items).toList();
        loading = false;
        error = null;
      });
    } catch (exception) {
      if (mounted) {
        setState(() {
          loading = false;
          error = '$exception';
        });
      }
    }
  }

  Future<void> _addMember() async {
    final result = await showDialog<_MemberDraft>(
      context: context,
      builder: (_) => const _MemberEditorDialog(),
    );
    if (result == null) return;
    try {
      await ref
          .read(clientProvider)
          .access
          .addMember(
            result.email,
            result.displayName,
            result.role,
            result.permissions.toList(),
          );
      await _reload();
    } catch (exception) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('新增失敗：$exception')),
        );
      }
    }
  }

  Future<void> _edit(MemberAccessSummary member) async {
    final result = await showDialog<_MemberDraft>(
      context: context,
      builder: (_) => _MemberEditorDialog(member: member, devices: devices),
    );
    if (result == null) return;
    final client = ref.read(clientProvider);
    try {
      await client.access.updateMember(
        member.membershipId,
        result.role,
        result.permissions.toList(),
        result.isActive,
      );
      for (final device in devices) {
        await client.access.setDeviceShare(
          device.id!,
          member.membershipId,
          result.readDevices.contains(device.id),
          result.writeDevices.contains(device.id),
        );
      }
      await _reload();
    } catch (exception) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('儲存失敗：$exception')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('帳戶權限與設備共享'),
      actions: [
        IconButton(onPressed: _reload, icon: const Icon(Icons.refresh)),
      ],
    ),
    floatingActionButton: FloatingActionButton.extended(
      onPressed: _addMember,
      icon: const Icon(Icons.person_add_alt_1_rounded),
      label: const Text('加入成員'),
    ),
    body: loading
        ? const Center(child: CircularProgressIndicator())
        : error != null
        ? Center(child: Text(error!))
        : ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            children: [
              Text('公司成員', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              const Text('設定模組讀寫權限，並將指定設備分享給個別帳戶。'),
              const SizedBox(height: 12),
              for (final member in members)
                Card(
                  child: ListTile(
                    onTap: () => _edit(member),
                    leading: CircleAvatar(
                      child: Text(
                        (member.displayName ?? member.email).characters.first
                            .toUpperCase(),
                      ),
                    ),
                    title: Text(member.displayName ?? member.email),
                    subtitle: Text(
                      '${_roleLabel(member.role)} · ${member.permissions.length} 項權限 · '
                      '共享 ${member.sharedDeviceIds.length} 台',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!member.isActive)
                          const Icon(Icons.block, color: Colors.red),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
            ],
          ),
  );
}

class _MemberEditorDialog extends StatefulWidget {
  const _MemberEditorDialog({this.member, this.devices = const []});
  final MemberAccessSummary? member;
  final List<Device> devices;

  @override
  State<_MemberEditorDialog> createState() => _MemberEditorDialogState();
}

class _MemberEditorDialogState extends State<_MemberEditorDialog> {
  late final TextEditingController email;
  late final TextEditingController name;
  late CompanyRole role;
  late Set<PlatformPermission> permissions;
  late Set<int> readDevices;
  late Set<int> writeDevices;
  late bool isActive;

  @override
  void initState() {
    super.initState();
    final member = widget.member;
    email = TextEditingController(text: member?.email ?? '');
    name = TextEditingController(text: member?.displayName ?? '');
    role = member?.role ?? CompanyRole.viewer;
    permissions = {...?member?.permissions};
    readDevices = {...?member?.sharedDeviceIds};
    writeDevices = {...?member?.writableDeviceIds};
    isActive = member?.isActive ?? true;
  }

  @override
  void dispose() {
    email.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.member == null ? '加入公司成員' : '編輯帳戶權限'),
    content: SizedBox(
      width: 520,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: email,
              enabled: widget.member == null,
              decoration: const InputDecoration(labelText: '已註冊 Email'),
            ),
            TextField(
              controller: name,
              enabled: widget.member == null,
              decoration: const InputDecoration(labelText: '顯示名稱（選填）'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<CompanyRole>(
              initialValue: role,
              decoration: const InputDecoration(labelText: '角色'),
              items: [
                for (final value in CompanyRole.values)
                  DropdownMenuItem(
                    value: value,
                    child: Text(_roleLabel(value)),
                  ),
              ],
              onChanged: (value) => setState(() => role = value!),
            ),
            const SizedBox(height: 12),
            const Text(
              '模組權限（未勾選即不可使用）',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            for (final permission in PlatformPermission.values)
              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                value: permissions.contains(permission),
                title: Text(_permissionLabel(permission)),
                onChanged: (value) => setState(
                  () => value == true
                      ? permissions.add(permission)
                      : permissions.remove(permission),
                ),
              ),
            if (widget.member != null && widget.devices.isNotEmpty) ...[
              const Divider(),
              const Text(
                '設備共享（讀取／控制）',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              for (final device in widget.devices)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(device.name),
                  subtitle: Text(device.model),
                  trailing: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'none', label: Text('無')),
                      ButtonSegment(value: 'read', label: Text('讀')),
                      ButtonSegment(value: 'write', label: Text('寫')),
                    ],
                    selected: {
                      writeDevices.contains(device.id)
                          ? 'write'
                          : readDevices.contains(device.id)
                          ? 'read'
                          : 'none',
                    },
                    onSelectionChanged: (values) => setState(() {
                      readDevices.remove(device.id);
                      writeDevices.remove(device.id);
                      if (values.first == 'read') readDevices.add(device.id!);
                      if (values.first == 'write') {
                        readDevices.add(device.id!);
                        writeDevices.add(device.id!);
                      }
                    }),
                  ),
                ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('帳戶啟用'),
                value: isActive,
                onChanged: widget.member!.isCurrentUser
                    ? null
                    : (value) => setState(() => isActive = value),
              ),
            ],
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('取消'),
      ),
      FilledButton(
        onPressed: () {
          if (email.text.trim().isEmpty) return;
          Navigator.pop(
            context,
            _MemberDraft(
              email: email.text.trim(),
              displayName: name.text.trim().isEmpty ? null : name.text.trim(),
              role: role,
              permissions: permissions,
              isActive: isActive,
              readDevices: readDevices,
              writeDevices: writeDevices,
            ),
          );
        },
        child: const Text('儲存'),
      ),
    ],
  );
}

class _MemberDraft {
  const _MemberDraft({
    required this.email,
    required this.displayName,
    required this.role,
    required this.permissions,
    required this.isActive,
    required this.readDevices,
    required this.writeDevices,
  });
  final String email;
  final String? displayName;
  final CompanyRole role;
  final Set<PlatformPermission> permissions;
  final bool isActive;
  final Set<int> readDevices;
  final Set<int> writeDevices;
}

String _roleLabel(CompanyRole role) => switch (role) {
  CompanyRole.admin => '管理者',
  CompanyRole.maintainer => '維護人員',
  CompanyRole.viewer => '檢視者',
};

String _permissionLabel(PlatformPermission value) => switch (value) {
  PlatformPermission.settingsRead => '設定：讀取',
  PlatformPermission.settingsWrite => '設定：新增、編輯、刪除',
  PlatformPermission.deviceRead => '所有設備：讀取',
  PlatformPermission.deviceControl => '所有設備：控制',
  PlatformPermission.deviceManage => '設備：建立、編輯與分享',
  PlatformPermission.otaManage => 'OTA 韌體與發布管理',
  PlatformPermission.automationManage => '自動化規則管理',
  PlatformPermission.auditRead => '操作稽核紀錄：讀取',
};
