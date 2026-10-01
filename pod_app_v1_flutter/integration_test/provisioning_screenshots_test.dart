// 設備配對流程截圖（供文件與驗收用）。
// 執行：flutter drive --driver=test_driver/integration_test.dart \
//        --target=integration_test/provisioning_screenshots_test.dart -d <simulator-id>
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

  testWidgets('設備配對與 mTLS 憑證簽發', (tester) async {
    await app.main();
    await tester.pump();

    // 自動登入後進設定分頁。
    await pumpUntilFound(tester, find.text('設備在線率'));
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await pumpUntilFound(tester, find.text('設備配對與憑證'));
    await tester.tap(find.text('設備配對與憑證'));
    await pumpUntilFound(tester, find.text('ESP32-00192837'));
    await tester.pump(const Duration(seconds: 1));
    await binding.takeScreenshot('05_provisioning_list');

    // 配對第一台出廠設備（Simulator 手動輸入 QR 內容）。
    await tester.tap(find.text('配對新設備'));
    await pumpUntilFound(tester, find.text('開始配對'));
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'ESP32-00192837');
    await tester.pump();
    await tester.enterText(fields.at(1), '7JPD-K8NQ-QZ51-39XT');
    await tester.pump();
    await tester.tap(find.text('開始配對'));

    // 等待模擬 ESP32 走完狀態機、CA 簽發完成。
    await pumpUntilFound(
      tester,
      find.text('配對完成'),
      timeout: const Duration(seconds: 30),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await binding.takeScreenshot('06_provisioning_done');

    await tester.tap(find.text('完成'));
    await pumpUntilFound(tester, find.text('已啟用'));
    await tester.pump(const Duration(seconds: 1));
    await binding.takeScreenshot('07_provisioning_active');
  });
}
