// 各分頁畫面截圖（供文件與驗收用）。
// 執行：flutter drive --driver=test_driver/integration_test.dart \
//        --target=integration_test/screenshots_test.dart -d <simulator-id>
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pod_app_v1_flutter/main.dart' as app;

Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 250));
    if (finder.evaluate().isNotEmpty) return;
  }
  fail('等不到 $finder');
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('擷取各分頁畫面', (tester) async {
    await app.main();
    await tester.pump();

    // 等待自動登入（session 存於 Keychain）。
    await pumpUntilFound(tester, find.text('設備在線率'));
    await pumpUntilFound(tester, find.textContaining('整體設備效率 OEE'));
    await tester.pump(const Duration(seconds: 2));
    await binding.takeScreenshot('01_dashboard_oee');

    await tester.tap(find.byIcon(Icons.notifications_outlined));
    await pumpUntilFound(tester, find.text('告警中心'));
    await tester.pump(const Duration(seconds: 1));
    await binding.takeScreenshot('02_alerts_severity');

    await tester.tap(find.byIcon(Icons.assignment_outlined));
    await pumpUntilFound(tester, find.text('工單中心'));
    await tester.pump(const Duration(seconds: 1));
    await binding.takeScreenshot('03_work_orders');

    await tester.tap(find.byIcon(Icons.precision_manufacturing_outlined));
    await pumpUntilFound(tester, find.text('設備庫'));
    await tester.tap(find.text('台北一廠'));
    await pumpUntilFound(tester, find.text('廠房地圖'));
    await tester.pump(const Duration(seconds: 2));
    await binding.takeScreenshot('04_factory_map');
  });
}
