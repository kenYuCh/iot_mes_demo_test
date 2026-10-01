import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';

/// 工單列表（新到舊，取一頁）。
final workOrdersProvider = FutureProvider.autoDispose<WorkOrderListResult>((
  ref,
) {
  final client = ref.watch(clientProvider);
  return client.workOrder.listWorkOrders(openOnly: false, limit: 50);
});

/// 未結案工單數，供徽章計數。
final openWorkOrderCountProvider = FutureProvider.autoDispose<int>((ref) async {
  final client = ref.watch(clientProvider);
  final result = await client.workOrder.listWorkOrders(
    openOnly: true,
    limit: 100,
  );
  return result.items.length;
});
