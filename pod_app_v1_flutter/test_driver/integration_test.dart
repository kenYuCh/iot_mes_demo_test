import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

/// 收集 integration_test 產生的截圖（flutter drive 用）。
Future<void> main() => integrationDriver(
  onScreenshot: (name, bytes, [args]) async {
    final file = File('screenshots/$name.png')..createSync(recursive: true);
    file.writeAsBytesSync(bytes);
    return true;
  },
);
