import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';
import 'command_card.dart';

/// 設備控制命令完整歷史。以 cursor 分頁，每次載入 30 筆；接近列表底部
/// 時自動讀取下一頁，避免上百筆紀錄一次建立 Widget 或一次載入記憶體。
class CommandHistoryScreen extends ConsumerStatefulWidget {
  const CommandHistoryScreen({super.key, required this.deviceId});

  final int deviceId;

  @override
  ConsumerState<CommandHistoryScreen> createState() =>
      _CommandHistoryScreenState();
}

class _CommandHistoryScreenState extends ConsumerState<CommandHistoryScreen> {
  final _scrollController = ScrollController();
  final _items = <DeviceCommand>[];
  int? _nextCursorId;
  bool _loading = false;
  bool _initialLoaded = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _load(reset: true));
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 320 &&
        !_loading &&
        _nextCursorId != null) {
      _load();
    }
  }

  Future<void> _load({bool reset = false}) async {
    if (_loading) return;
    setState(() {
      _loading = true;
      _error = null;
      if (reset) {
        _items.clear();
        _nextCursorId = null;
        _initialLoaded = false;
      }
    });
    try {
      final result = await ref
          .read(clientProvider)
          .command
          .listCommands(
            widget.deviceId,
            limit: 30,
            cursorId: reset ? null : _nextCursorId,
          );
      if (!mounted) return;
      setState(() {
        _items.addAll(result.items);
        _nextCursorId = result.nextCursorId;
        _initialLoaded = true;
      });
    } catch (error) {
      if (mounted) setState(() => _error = '$error');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('控制命令紀錄'),
        actions: [
          IconButton(
            tooltip: '重新整理',
            onPressed: _loading ? null : () => _load(reset: true),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: !_initialLoaded && _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _load(reset: true),
              child: _items.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 180),
                        Center(child: Text('尚無控制命令紀錄')),
                      ],
                    )
                  : ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                      itemCount: _items.length + 1,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        if (index == _items.length) {
                          return _HistoryFooter(
                            loading: _loading,
                            hasMore: _nextCursorId != null,
                            error: _error,
                            onRetry: _load,
                          );
                        }
                        return _CommandHistoryTile(command: _items[index]);
                      },
                    ),
            ),
    );
  }
}

class _CommandHistoryTile extends StatelessWidget {
  const _CommandHistoryTile({required this.command});

  final DeviceCommand command;

  @override
  Widget build(BuildContext context) {
    final featureKey = command.payload['featureKey'];
    final value = command.payload['value'];
    final detail = command.commandType == 'setParam'
        ? '$featureKey → $value'
        : command.commandType;
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: const Icon(Icons.tune_rounded),
        title: Text(commandLabel(command.commandType)),
        subtitle: Text(
          '$detail\n${DateFormat('yyyy/MM/dd HH:mm:ss').format(command.createdAt.toLocal())}',
        ),
        isThreeLine: true,
        trailing: CommandStateChip(state: command.state),
      ),
    );
  }
}

class _HistoryFooter extends StatelessWidget {
  const _HistoryFooter({
    required this.loading,
    required this.hasMore,
    required this.error,
    required this.onRetry,
  });

  final bool loading;
  final bool hasMore;
  final String? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (error != null) {
      return Center(
        child: TextButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('載入失敗，重新嘗試'),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(child: Text(hasMore ? '繼續向下捲動載入' : '已顯示全部紀錄')),
    );
  }
}
