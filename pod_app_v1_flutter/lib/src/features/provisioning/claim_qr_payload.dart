import 'dart:convert';

import '../../data/ble/device_claim_credentials.dart';

export '../../data/ble/device_claim_credentials.dart';

/// 解析公開出廠 QR。只要求序號；不再包含 Claim Code。
DeviceClaimCredentials? parseClaimQrPayload(String raw) {
  final text = raw.trim();
  if (text.isEmpty) return null;

  // JSON：{"serial":"...","model":"...","ble_name":"..."}
  if (text.startsWith('{')) {
    try {
      final decoded = jsonDecode(text);
      if (decoded is! Map) return null;
      final map = decoded.cast<String, dynamic>();
      final serial = '${map['serial'] ?? map['device_id'] ?? ''}'.trim();
      if (serial.isEmpty) return null;
      return DeviceClaimCredentials(
        serial: serial,
        provisioningProof: '',
        model: _optionalString(map['model']),
        bleName: _optionalString(map['ble_name'] ?? map['bleName']),
      );
    } catch (_) {
      return null;
    }
  }

  // 相容簡易標籤：serial 或 serial|model。
  if (text.contains('|')) {
    final parts = text.split('|');
    if (parts[0].trim().isNotEmpty) {
      return DeviceClaimCredentials(
        serial: parts[0].trim(),
        provisioningProof: '',
        model: parts.length >= 2 ? parts[1].trim() : null,
      );
    }
  }

  // ?serial=...&model=...
  final uri = Uri.tryParse(text.contains('://') ? text : 'claim://local?$text');
  if (uri != null && uri.queryParameters.isNotEmpty) {
    final q = uri.queryParameters;
    final serial = (q['serial'] ?? q['device_id'] ?? '').trim();
    if (serial.isNotEmpty) {
      return DeviceClaimCredentials(
        serial: serial,
        provisioningProof: '',
        model: q['model'],
        bleName: q['ble_name'] ?? q['bleName'],
      );
    }
  }

  if (RegExp(r'^[A-Za-z0-9][A-Za-z0-9_-]{5,63}$').hasMatch(text)) {
    return DeviceClaimCredentials(serial: text, provisioningProof: '');
  }

  return null;
}

String? _optionalString(Object? value) {
  if (value == null) return null;
  final s = '$value'.trim();
  return s.isEmpty ? null : s;
}
