// 垂直切片 UI 整合測試（需先啟動本機 Server 與 Demo 資料）。
// 執行：flutter test integration_test -d <simulator-id>
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pod_app_v1_flutter/main.dart' as app;

/// 反覆 pump 直到 finder 出現（即時串流會持續觸發重繪，
/// 不能依賴 pumpAndSettle）。
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
  final texts = find
      .byType(Text)
      .evaluate()
      .map((e) => (e.widget as Text).data)
      .whereType<String>()
      .toList();
  fail('等不到 $finder；目前畫面文字：$texts');
}

/// 反覆 pump 直到 finder 消失。
Future<void> pumpUntilGone(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 250));
    if (finder.evaluate().isEmpty) return;
  }
  fail('$finder 仍存在於畫面');
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('登入 → 總覽(OEE) → 場域 CRUD → 地圖 → 設備 → 命令 → 警報 → 工單', (
    tester,
  ) async {
    await app.main();
    await tester.pump();

    // 先等待自動登入完成（session 存於 Keychain，可跨重裝保留）；
    // 逾時仍未進入主畫面才走登入流程。
    var signedIn = false;
    final autoLoginDeadline = DateTime.now().add(const Duration(seconds: 8));
    while (DateTime.now().isBefore(autoLoginDeadline)) {
      await tester.pump(const Duration(milliseconds: 250));
      if (find.text('總覽').evaluate().isNotEmpty) {
        signedIn = true;
        break;
      }
    }

    if (!signedIn) {
      // 登入頁預設為註冊模式，切到登入
      await pumpUntilFound(tester, find.text('Sign in'));
      await tester.tap(find.text('Sign in'));
      await pumpUntilFound(tester, find.text('Sign In with email'));

      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), 'dev@demo.local');
      await tester.pump();
      await tester.enterText(fields.at(1), 'demo12345');
      await tester.pump();
      await tester.tap(find.text('Sign in'));
    }

    // 總覽儀表板：KPI、OEE 卡片與場域狀態卡片
    await pumpUntilFound(tester, find.text('設備在線率'));
    await pumpUntilFound(tester, find.textContaining('整體設備效率 OEE'));
    await pumpUntilFound(tester, find.text('稼動率'));
    expect(find.text('場域狀態'), findsOneWidget);
    await pumpUntilFound(tester, find.text('台北一廠'));

    // 設備庫分頁
    await tester.tap(find.byIcon(Icons.precision_manufacturing_outlined));
    await pumpUntilFound(tester, find.text('設備庫'));
    await pumpUntilFound(tester, find.text('台北一廠'));

    // 先清掉先前測試失敗殘留的場域，讓測試可重複執行。
    await tester.pump(const Duration(seconds: 1));
    while (find.text('UI 測試場域').evaluate().isNotEmpty) {
      final leftoverCard = find
          .ancestor(
            of: find.text('UI 測試場域').first,
            matching: find.byType(Card),
          )
          .first;
      await tester.tap(
        find.descendant(
          of: leftoverCard,
          matching: find.byType(PopupMenuButton<String>),
        ),
      );
      await pumpUntilFound(tester, find.text('刪除'));
      await tester.tap(find.text('刪除'));
      await pumpUntilFound(tester, find.textContaining('刪除場域「UI 測試場域」'));
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('刪除'),
        ),
      );
      await pumpUntilGone(tester, find.textContaining('刪除場域「'));
      await tester.pump(const Duration(seconds: 1));
    }

    // 場域 CRUD：建立 → 出現在列表 → 刪除
    await tester.tap(find.text('新增場域'));
    await pumpUntilFound(tester, find.text('名稱'));
    await tester.enterText(find.byType(TextField).first, 'UI 測試場域');
    await tester.pump();
    await tester.tap(find.text('建立'));
    await pumpUntilFound(tester, find.text('UI 測試場域'));

    final newSiteCard = find.ancestor(
      of: find.text('UI 測試場域'),
      matching: find.byType(Card),
    );
    await tester.tap(
      find.descendant(
        of: newSiteCard,
        matching: find.byType(PopupMenuButton<String>),
      ),
    );
    await pumpUntilFound(tester, find.text('刪除'));
    await tester.tap(find.text('刪除'));
    await pumpUntilFound(tester, find.textContaining('刪除場域「UI 測試場域」'));
    // 選單項目可能仍在淡出動畫中，確認按鈕限定在對話框內查找。
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('刪除'),
      ),
    );
    await pumpUntilGone(tester, find.text('UI 測試場域'));

    // 場域詳細：2D 廠房地圖、Gateway 與設備
    await tester.tap(find.text('台北一廠'));
    await pumpUntilFound(tester, find.text('廠房地圖'));
    await pumpUntilFound(tester, find.text('GW-TPE-001'));
    expect(find.text('閘道器'), findsOneWidget);
    await pumpUntilFound(tester, find.text('沖壓機溫度計 T-01'));

    // 設備列表應出現即時連線狀態徽章（模擬器 2 秒推一次）
    await pumpUntilFound(tester, find.text('在線'));

    // 設備詳細：即時數值與趨勢圖（地圖標記也有設備名，鎖定列表項）
    await tester.tap(
      find.descendant(
        of: find.byType(ListTile),
        matching: find.text('沖壓機溫度計 T-01'),
      ),
    );
    await pumpUntilFound(tester, find.text('即時數值'));
    await pumpUntilFound(tester, find.textContaining('°C'));
    await pumpUntilFound(tester, find.textContaining('最後更新'));

    // 控制命令：下發後由模擬器推進狀態機至完成
    await tester.dragUntilVisible(
      find.text('控制命令'),
      find.byType(ListView),
      const Offset(0, -120),
    );
    await tester.tap(find.text('重新啟動'));
    await pumpUntilFound(tester, find.text('已建立'));
    await pumpUntilFound(
      tester,
      find.text('完成'),
      timeout: const Duration(seconds: 25),
    );

    // 設備資訊卡片在頁面底部，捲動到可見後驗證
    await tester.dragUntilVisible(
      find.text('設備資訊'),
      find.byType(ListView),
      const Offset(0, -120),
    );

    // 底部導覽直達警報中心
    await tester.tap(find.byIcon(Icons.notifications_outlined));
    await pumpUntilFound(tester, find.text('告警中心'));

    // 規則分頁應列出 Demo seed 的示範規則（含等級標籤）
    await tester.tap(find.text('規則'));
    await pumpUntilFound(tester, find.textContaining('高溫警報').first);
    await pumpUntilFound(tester, find.text('CRITICAL').first);

    // 工單中心：開立 → 開始處理 → 完成
    await tester.tap(find.byIcon(Icons.assignment_outlined));
    await pumpUntilFound(tester, find.text('工單中心'));

    // 標題帶時間戳，避免與先前執行殘留的工單重名。
    final woTitle = 'UI 巡檢 ${DateTime.now().millisecondsSinceEpoch % 100000}';
    await tester.tap(find.text('開立工單'));
    await pumpUntilFound(tester, find.text('標題'));
    // IndexedStack 會保留離屏分頁（總覽也有「場域」字樣），查找範圍限定對話框。
    final dialog = find.byType(AlertDialog);
    await tester.tap(
      find.descendant(of: dialog, matching: find.text('場域')),
    );
    await pumpUntilFound(tester, find.text('台北一廠').last);
    await tester.tap(find.text('台北一廠').last);
    await tester.pump();
    await tester.enterText(
      find.descendant(of: dialog, matching: find.byType(TextField)).first,
      woTitle,
    );
    await tester.pump();
    await tester.tap(
      find.descendant(of: dialog, matching: find.text('建立')),
    );
    await pumpUntilFound(tester, find.text(woTitle));

    // 狀態流轉：open → inProgress → done（點擊鎖定列表項，避開收合中的面板）
    final workOrderTile = find.descendant(
      of: find.byType(ListTile),
      matching: find.text(woTitle),
    );
    await tester.tap(workOrderTile);
    await pumpUntilFound(tester, find.text('開始處理'));
    await tester.tap(find.text('開始處理'));
    await pumpUntilGone(tester, find.text('開始處理'));

    await tester.tap(workOrderTile);
    await pumpUntilFound(tester, find.text('完成工單'));
    await tester.tap(find.text('完成工單'));
    await pumpUntilFound(tester, find.text('處理備註（選填）'));
    await tester.enterText(find.byType(TextField).last, '巡檢完成');
    await tester.pump();
    await tester.tap(find.text('確定'));
    await pumpUntilFound(tester, find.text('已完成').first);

    // 停留數秒觀察即時更新（外部截圖用）
    await tester.pump(const Duration(seconds: 3));
  });
}
