import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'device_local_mqtt_store.dart';
import 'mqtt_config.dart';

/// 開發用假 ESP32 集線器：只有 App 配對簽發成功、本機寫入設備證後才連 MQTTS 發布。
///
/// 未綁定／無憑證 → 不連線。
/// 解除綁定 → 刪除本機證並斷線。
class Esp32MqttSimulator {
  Esp32MqttSimulator({this.interval = const Duration(seconds: 3)});

  final Duration interval;
  final _random = Random();
  final _sessions = <String, _DeviceSession>{};
  Timer? _scanTimer;
  bool _running = false;

  /// 全域實例，供 ProvisioningEndpoint 在簽發／撤銷時通知。
  static Esp32MqttSimulator? instance;

  Future<void> start() async {
    if (_running) return;
    if (!MqttConfig.credentialsReady) {
      stdout.writeln('[Esp32Sim] 略過：MQTT CA／backend 憑證尚未就緒');
      return;
    }
    _running = true;
    instance = this;
    stdout.writeln(
      '[Esp32Sim] 待命：等待 App 配對簽發憑證後才連 MQTTS'
      '（目錄 ${DeviceLocalMqttStore.root}/）',
    );
    await _syncFromDisk();
    _scanTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      unawaited(_syncFromDisk());
    });
  }

  void stop() {
    _scanTimer?.cancel();
    _scanTimer = null;
    for (final serial in _sessions.keys.toList()) {
      _stopSession(serial);
    }
    _running = false;
    if (identical(instance, this)) instance = null;
  }

  /// 配對完成：寫入本機證後立即連線發布。
  Future<void> onCertificateIssued(String serial) async {
    if (!_running) return;
    await _ensureSession(serial);
  }

  /// 解除綁定／撤銷：斷線並清除 session。
  void onCertificateRevoked(String serial) {
    _stopSession(serial);
  }

  Future<void> _syncFromDisk() async {
    final onDisk = DeviceLocalMqttStore.listSerials().toSet();
    for (final serial in onDisk) {
      if (!_sessions.containsKey(serial)) {
        await _ensureSession(serial);
      }
    }
    for (final serial in _sessions.keys.toList()) {
      if (!onDisk.contains(serial)) {
        _stopSession(serial);
      }
    }
  }

  Future<void> _ensureSession(String serial) async {
    if (_sessions.containsKey(serial)) return;
    if (DeviceLocalMqttStore.isPhysicalDevice(serial)) {
      stdout.writeln('[Esp32Sim] $serial 為實體設備，略過模擬連線');
      return;
    }
    if (!DeviceLocalMqttStore.hasIdentity(serial)) {
      stdout.writeln('[Esp32Sim] $serial 尚無本機憑證，跳過');
      return;
    }

    final client = MqttServerClient.withPort(
      MqttConfig.host,
      serial,
      MqttConfig.port,
    );
    client.secure = true;
    client.keepAlivePeriod = 30;
    client.autoReconnect = true;
    client.setProtocolV311();
    client.logging(on: false);
    client.securityContext = SecurityContext(withTrustedRoots: false)
      ..setTrustedCertificates(MqttConfig.caCert)
      ..useCertificateChain(DeviceLocalMqttStore.chainPath(serial))
      ..usePrivateKey(DeviceLocalMqttStore.keyPath(serial));
    client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(serial)
        .startClean();

    final session = _DeviceSession(serial: serial, client: client);
    _sessions[serial] = session;

    client.onConnected = () {
      stdout.writeln(
        '[Esp32Sim] $serial 憑證有效，已連 MQTTS，開始發布 telemetry',
      );
      session.timer?.cancel();
      session.timer = Timer.periodic(interval, (_) => _publish(session));
      _publish(session);
    };
    client.onDisconnected = () {
      stdout.writeln('[Esp32Sim] $serial 連線中斷');
      session.timer?.cancel();
    };

    try {
      await client.connect();
    } catch (e) {
      stdout.writeln('[Esp32Sim] $serial 連線失敗：$e');
      _stopSession(serial);
    }
  }

  void _stopSession(String serial) {
    final session = _sessions.remove(serial);
    if (session == null) return;
    session.timer?.cancel();
    try {
      session.client.disconnect();
    } catch (_) {}
    stdout.writeln('[Esp32Sim] $serial 已停止發布');
  }

  void _publish(_DeviceSession session) {
    final client = session.client;
    if (client.connectionStatus?.state != MqttConnectionState.connected) {
      return;
    }
    final phase = DateTime.now().millisecondsSinceEpoch / 60000 * 2 * pi;
    final payload = jsonEncode({
      'temperature': double.parse(
        (25 + 4 * sin(phase) + (_random.nextDouble() - 0.5)).toStringAsFixed(2),
      ),
      'humidity': double.parse(
        (55 + 10 * sin(phase / 3) + (_random.nextDouble() - 0.5) * 4)
            .toStringAsFixed(2),
      ),
    });
    final builder = MqttClientPayloadBuilder()..addString(payload);
    client.publishMessage(
      'devices/${session.serial}/telemetry',
      MqttQos.atLeastOnce,
      builder.payload!,
    );
  }
}

class _DeviceSession {
  _DeviceSession({required this.serial, required this.client});

  final String serial;
  final MqttServerClient client;
  Timer? timer;
}
