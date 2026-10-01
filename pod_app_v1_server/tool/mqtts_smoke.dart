// MQTTS 煙霧測試：驗證 backend mTLS 可連線並訂閱。
// 設備上行需先在 App 完成配對（產生 certs/mqtt/devices/{serial}/）。
// 執行：dart run tool/mqtts_smoke.dart（於 pod_app_v1_server）
import 'dart:async';
import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

Future<void> main() async {
  const host = 'localhost';
  const port = 8883;

  final ca = File('certs/ca/root-ca.crt');
  final backendChain = File('certs/mqtt/backend/client-chain.crt');
  final backendKey = File('certs/mqtt/backend/client.key');

  for (final f in [ca, backendChain, backendKey]) {
    if (!f.existsSync()) {
      stderr.writeln('缺少 ${f.path}，請先執行 ./tool/setup_mqtts.sh');
      exit(1);
    }
  }

  final backend =
      MqttServerClient.withPort(host, 'backend-service-smoke', port);
  backend.secure = true;
  backend.setProtocolV311();
  backend.keepAlivePeriod = 20;
  backend.securityContext = SecurityContext(withTrustedRoots: false)
    ..setTrustedCertificates(ca.path)
    ..useCertificateChain(backendChain.path)
    ..usePrivateKey(backendKey.path);
  backend.connectionMessage = MqttConnectMessage()
      .withClientIdentifier('backend-service-smoke')
      .startClean();

  await backend.connect();
  if (backend.connectionStatus?.state != MqttConnectionState.connected) {
    stderr.writeln('FAIL  backend 連線失敗：${backend.connectionStatus}');
    exit(1);
  }
  stdout.writeln('PASS  backend mTLS 連線');
  backend.subscribe('devices/+/telemetry', MqttQos.atLeastOnce);

  final devicesRoot = Directory('certs/mqtt/devices');
  Directory? deviceDir;
  if (devicesRoot.existsSync()) {
    for (final e in devicesRoot.listSync()) {
      if (e is Directory &&
          File('${e.path}/client-chain.crt').existsSync() &&
          File('${e.path}/client.key').existsSync()) {
        deviceDir = e;
        break;
      }
    }
  }

  if (deviceDir == null) {
    stdout.writeln(
      'SKIP  尚無已配對設備憑證（certs/mqtt/devices/）。'
      '請先在 iOS App 完成配對，再重跑以驗證設備上行。',
    );
    backend.disconnect();
    stdout.writeln('MQTTS_SMOKE_OK（backend only）');
    return;
  }

  final serial = deviceDir.uri.pathSegments.lastWhere((s) => s.isNotEmpty);
  final got = Completer<String>();
  backend.updates!.listen((messages) {
    for (final m in messages) {
      final rec = m.payload;
      if (rec is! MqttPublishMessage) continue;
      final body =
          MqttPublishPayload.bytesToStringAsString(rec.payload.message);
      if (!got.isCompleted) got.complete('${m.topic} $body');
    }
  });

  // 若 Esp32Sim 已在發布，等一筆即可；否則用剛配對的證發一筆。
  try {
    final received = await got.future.timeout(const Duration(seconds: 8));
    stdout.writeln('PASS  收到設備上行：$received');
  } on TimeoutException {
    final device = MqttServerClient.withPort(host, '$serial-smoke', port);
    device.secure = true;
    device.setProtocolV311();
    device.securityContext = SecurityContext(withTrustedRoots: false)
      ..setTrustedCertificates(ca.path)
      ..useCertificateChain('${deviceDir.path}/client-chain.crt')
      ..usePrivateKey('${deviceDir.path}/client.key');
    device.connectionMessage =
        MqttConnectMessage().withClientIdentifier('$serial-smoke').startClean();
    await device.connect();
    if (device.connectionStatus?.state != MqttConnectionState.connected) {
      stderr.writeln('FAIL  device 連線失敗');
      exit(1);
    }
    stdout.writeln('PASS  device mTLS 連線（CN=$serial，配對後憑證）');
    final builder = MqttClientPayloadBuilder()
      ..addString('{"temperature":26.5,"humidity":55}');
    device.publishMessage(
      'devices/$serial/telemetry',
      MqttQos.atLeastOnce,
      builder.payload!,
    );
    final received = await got.future.timeout(const Duration(seconds: 5));
    stdout.writeln('PASS  backend 收到上行：$received');
    device.disconnect();
  }

  backend.disconnect();
  stdout.writeln('MQTTS_SMOKE_OK');
}
