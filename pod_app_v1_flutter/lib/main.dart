import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'src/core/notification_service.dart';
import 'src/core/theme_mode_controller.dart';
import 'src/design/factory_theme.dart';
import 'src/router.dart';

/// 全域 Serverpod Client。Widget 層請透過 `clientProvider` 取得，
/// 不要直接 import 本變數（見 docs/frontend/flutter-ios.md）。
late final Client client;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // iOS Simulator 直接連 http://localhost:8080/；
  // 實體機請以 --dart-define=SERVER_URL=http://<開發機區網IP>:8080/ 指定。
  final serverUrl = await getServerUrl();
  debugPrint('[Bootstrap] Serverpod URL: $serverUrl');

  final authStorage = kDebugMode ? _DebugAuthStorage() : null;
  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager(storage: authStorage);

  // Development-only test gate. Simulator integration tests can enter the app
  // without repeatedly typing the seeded account. Release builds never use it.
  if (kDebugMode &&
      const bool.fromEnvironment('AUTO_LOGIN', defaultValue: true)) {
    await _tryDebugAutoLogin();
  }

  // Do not start session restoration concurrently with the email login flow.
  // On iOS this can race secure-storage writes and leave the login button in a
  // permanent loading state. The active login updates and persists the session;
  // restoration can be reintroduced behind a dedicated startup gate.

  // 前景重大告警通知（背景 APNs 於實機階段接入）。
  await NotificationService.init();
  final initialThemeMode = await loadSavedThemeMode();

  runApp(
    ProviderScope(
      overrides: [initialThemeModeProvider.overrideWithValue(initialThemeMode)],
      child: const IotApp(),
    ),
  );
}

Future<void> _tryDebugAutoLogin() async {
  const email = String.fromEnvironment(
    'AUTO_LOGIN_EMAIL',
    defaultValue: 'dev@demo.local',
  );
  const password = String.fromEnvironment(
    'AUTO_LOGIN_PASSWORD',
    defaultValue: 'demo12345',
  );
  for (var attempt = 1; attempt <= 5; attempt++) {
    try {
      final authSuccess = await client.emailIdp.login(
        email: email,
        password: password,
      );
      await client.auth.updateSignedInUser(authSuccess);
      debugPrint('[Bootstrap] Debug auto-login succeeded: $email');
      return;
    } catch (error) {
      debugPrint(
        '[Bootstrap] Debug auto-login attempt $attempt failed: $error',
      );
      if (attempt < 5) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }
    }
  }
}

/// Simulator/debug builds avoid an iOS Keychain plug-in stall observed during
/// email login. Release builds continue using encrypted Keychain storage.
class _DebugAuthStorage implements ClientAuthSuccessStorage {
  AuthSuccess? _value;

  @override
  Future<AuthSuccess?> get() async => _value;

  @override
  Future<void> set(AuthSuccess? data) async => _value = data;
}

class IotApp extends ConsumerWidget {
  const IotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'IoT 智慧工廠',
      theme: buildFactoryTheme(),
      darkTheme: buildFactoryTheme(brightness: Brightness.dark),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
