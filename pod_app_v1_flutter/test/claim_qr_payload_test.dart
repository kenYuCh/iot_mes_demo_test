import 'package:flutter_test/flutter_test.dart';
import 'package:pod_app_v1_flutter/src/features/provisioning/claim_qr_payload.dart';

void main() {
  test('parses public factory QR without a Claim Code', () {
    final cred = parseClaimQrPayload(
      '{"serial":"ESP32-00192839","model":"SENSOR-T02"}',
    );
    expect(cred?.serial, 'ESP32-00192839');
    expect(cred?.provisioningProof, isEmpty);
    expect(cred?.model, 'SENSOR-T02');
  });

  test('parses pipe-separated public factory QR', () {
    final cred = parseClaimQrPayload('ESP32-00192837|ESP32-MOTOR-01');
    expect(cred?.serial, 'ESP32-00192837');
    expect(cred?.model, 'ESP32-MOTOR-01');
  });
}
