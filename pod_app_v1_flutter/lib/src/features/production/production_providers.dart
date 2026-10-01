import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

import '../../core/providers.dart';

final productionSummaryProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(clientProvider).production.getSummary(),
);
final materialsProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(clientProvider).production.listMaterials(),
);
final materialLotsProvider = FutureProvider.autoDispose
    .family<List<MaterialLot>, int?>(
      (ref, materialId) => ref
          .watch(clientProvider)
          .production
          .listMaterialLots(materialId: materialId),
    );
final productsProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(clientProvider).production.listProducts(),
);
final bomProvider = FutureProvider.autoDispose.family<List<BomItem>, int>(
  (ref, productId) => ref.watch(clientProvider).production.listBom(productId),
);
final processRoutesProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(clientProvider).production.listRoutes(),
);
final workstationsProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(clientProvider).production.listWorkstations(),
);
final productionLinesProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(clientProvider).production.listProductionLines(),
);
final myPendingTransfersProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(clientProvider).production.listMyPendingTransfers(),
);
final myWorkstationsProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(clientProvider).production.listMyWorkstations(),
);
final workstationAssignmentsProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(clientProvider).production.listWorkstationAssignments(),
);
final processNodesProvider = FutureProvider.autoDispose
    .family<List<ProcessNode>, int>(
      (ref, routeId) =>
          ref.watch(clientProvider).production.listProcessNodes(routeId),
    );
final productionOrdersProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(clientProvider).production.listProductionOrders(),
);
final productUnitsProvider = FutureProvider.autoDispose
    .family<List<ProductUnit>, int?>(
      (ref, orderId) => ref
          .watch(clientProvider)
          .production
          .listProductUnits(orderId: orderId),
    );

void invalidateProduction(WidgetRef ref) {
  ref.invalidate(productionSummaryProvider);
  ref.invalidate(materialsProvider);
  ref.invalidate(materialLotsProvider);
  ref.invalidate(productsProvider);
  ref.invalidate(bomProvider);
  ref.invalidate(processRoutesProvider);
  ref.invalidate(workstationsProvider);
  ref.invalidate(productionLinesProvider);
  ref.invalidate(myPendingTransfersProvider);
  ref.invalidate(myWorkstationsProvider);
  ref.invalidate(workstationAssignmentsProvider);
  ref.invalidate(processNodesProvider);
  ref.invalidate(productionOrdersProvider);
  ref.invalidate(productUnitsProvider);
}
