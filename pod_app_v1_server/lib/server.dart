import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/mqtt/mqtt_bridge.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/device_ota_fallback_route.dart';
import 'src/web/routes/root.dart';

/// 讓 SecureSocket（Redis requireSsl）信任內部 Root CA。
/// Postgres 的 requireSsl 使用 SslMode.require（不驗憑證），Redis 會驗。
void _trustLocalRootCa() {
  const path = 'certs/ca/root-ca.crt';
  if (!File(path).existsSync()) return;
  try {
    SecurityContext.defaultContext.setTrustedCertificates(path);
  } on TlsException catch (e) {
    // 重載／熱重啟時可能已加入。
    if (!e.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
      stderr.writeln('[TLS] 載入 Root CA 失敗：$e');
    }
  }
}

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  _trustLocalRootCa();

  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
  );

  // Setup a default page at the web root.
  // These are used by the default page.
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  final firmwareRoot = Directory(
    Platform.environment['FIRMWARE_STORAGE_PATH'] ?? 'storage/firmware',
  ).absolute;
  await firmwareRoot.create(recursive: true);
  pod.webServer.addRoute(
    StaticRoute.directory(firmwareRoot),
    '/firmware',
  );
  pod.webServer.addRoute(
    DeviceOtaFallbackRoute(
      allowDevelopmentToken: pod.runMode == ServerpodRunMode.development,
    ),
    '/device-ota',
  );
  // Catch-all static route must be registered after the firmware route.
  final root = Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));

  // Setup the app config route.
  // We build this configuration based on the servers api url and serve it to
  // the flutter app.
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  // Checks if the flutter web app has been built and serves it if it has.
  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    // Serve the flutter web app under the /app path.
    pod.webServer.addRoute(
      FlutterRoute(
        Directory(
          Uri(path: 'web/app').toFilePath(),
        ),
      ),
      '/app',
    );
  } else {
    // If the flutter web app has not been built, serve the build app page.
    pod.webServer.addRoute(
      StaticRoute.file(
        File(
          Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
        ),
      ),
      '/app/**',
    );
  }

  // Start the server.
  await pod.start();

  // 開發環境也只接受真實 MQTT 上行；不再建立 demo 資料或啟動任何模擬器。
  if (pod.runMode == ServerpodRunMode.development) {
    mqttBridge = MqttBridge(pod);
    await mqttBridge!.start();
  }
}

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // NOTE: Here you call your mail service to send the verification code to
  // the user. For testing, we will just log the verification code.
  session.log('[EmailIdp] Registration code ($email): $verificationCode');
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // NOTE: Here you call your mail service to send the verification code to
  // the user. For testing, we will just log the verification code.
  session.log('[EmailIdp] Password reset code ($email): $verificationCode');
}
