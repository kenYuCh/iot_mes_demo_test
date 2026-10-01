import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../../ota/ota_device_fallback_service.dart';

class DeviceOtaFallbackRoute extends Route {
  DeviceOtaFallbackRoute({required this.allowDevelopmentToken})
    : super(methods: const {Method.get, Method.post});

  final bool allowDevelopmentToken;

  @override
  Future<Result> handleCall(Session session, Request request) async {
    final serial = request.headers['x-device-serial']?.firstOrNull?.trim();
    if (serial == null || serial.isEmpty) {
      return _json(400, {'error': 'serial missing'});
    }
    if (!_authorized(request, serial)) {
      return _json(401, {'error': 'unauthorized'});
    }

    if (request.method == Method.get) {
      return _json(
        200,
        await OtaDeviceFallbackService.pendingForDevice(session, serial),
      );
    }
    try {
      final decoded = jsonDecode(await request.readAsString(maxLength: 4096));
      if (decoded is! Map) return _json(400, {'error': 'invalid JSON'});
      await OtaDeviceFallbackService.ingestStatus(
        session,
        serial: serial,
        status: decoded.map((key, value) => MapEntry(key.toString(), value)),
      );
      return _json(200, {'accepted': true});
    } on FormatException {
      return _json(400, {'error': 'invalid JSON'});
    }
  }

  bool _authorized(Request request, String serial) {
    // Do not use Authorization here: Serverpod's user-auth middleware treats
    // it as a JWT before this device route runs and emits noisy invalid-JWT
    // errors. This token is scoped to the device channel only.
    final actual = request.headers['x-device-ota-token']?.firstOrNull;
    if (actual == null) return false;
    final configured = <String, String>{};
    for (final entry in (Platform.environment['DEVICE_OTA_TOKENS'] ?? '').split(
      ',',
    )) {
      final separator = entry.indexOf('=');
      if (separator > 0) {
        configured[entry.substring(0, separator).trim()] = entry
            .substring(separator + 1)
            .trim();
      }
    }
    final expected =
        configured[serial] ??
        (allowDevelopmentToken ? 'development-$serial' : null);
    if (expected == null || expected.length != actual.length) return false;
    var difference = 0;
    for (var index = 0; index < expected.length; index++) {
      difference |= expected.codeUnitAt(index) ^ actual.codeUnitAt(index);
    }
    return difference == 0;
  }

  Response _json(int statusCode, Object value) => Response(
    statusCode,
    body: Body.fromString(jsonEncode(value), mimeType: MimeType.json),
  );
}
