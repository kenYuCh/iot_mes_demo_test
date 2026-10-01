import 'dart:io';

/// MQTTS 連線設定（開發環境預設連本機 Docker Mosquitto）。
class MqttConfig {
  MqttConfig._();

  /// Broker 主機（App / 設備看到的對外名稱寫在 CertificateIssueResult）。
  static String get host => Platform.environment['MQTT_HOST'] ?? 'localhost';

  static int get port =>
      int.tryParse(Platform.environment['MQTT_PORT'] ?? '') ?? 8883;

  static const clientId = 'backend-service';

  static const caCert = 'certs/ca/root-ca.crt';
  static const clientCertChain = 'certs/mqtt/backend/client-chain.crt';
  static const clientKey = 'certs/mqtt/backend/client.key';

  /// 憑證齊全且 Broker 可連時才啟用 MQTT bridge。
  static bool get credentialsReady =>
      File(caCert).existsSync() &&
      File(clientCertChain).existsSync() &&
      File(clientKey).existsSync();
}
