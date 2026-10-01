import 'dart:io';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// 內部 CA（手冊 §8）：以 OpenSSL 建立
/// Root CA（離線保存概念，開發環境同機）→ Intermediate CA → 設備憑證。
///
/// 憑證簽發為真實流程（openssl req / x509 / verify）；
/// 只有 ESP32 裝置端以假數據模擬（docs/ota/paired.md）。
class CaService {
  /// CA 檔案存放目錄（相對於 server 專案根目錄）。
  /// 開發環境使用；正式環境 Root Key 應離線或交由 KMS/HSM。
  static const _caDir = 'certs/ca';

  static const rootCaKey = '$_caDir/root-ca.key';
  static const rootCaCert = '$_caDir/root-ca.crt';
  static const intermediateKey = '$_caDir/intermediate.key';
  static const intermediateCert = '$_caDir/intermediate.crt';

  /// 設備憑證效期（手冊 §11 建議 90 天～1 年）。
  static const deviceCertDays = 365;

  static Future<void> _run(
    List<String> args, {
    String? workingDirectory,
  }) async {
    final result = await Process.run(
      'openssl',
      args,
      workingDirectory: workingDirectory,
    );
    if (result.exitCode != 0) {
      final details = [result.stdout, result.stderr]
          .map((value) => value.toString().trim())
          .where((value) => value.isNotEmpty)
          .join('\n');
      throw StateError(
        'openssl ${args.first} 失敗（exit ${result.exitCode}）：$details',
      );
    }
  }

  /// 確保 CA 憑證鏈存在；不存在時建立（首次啟動）。
  static Future<void> ensureCa(Session session) async {
    if (File(rootCaCert).existsSync() && File(intermediateCert).existsSync()) {
      return;
    }
    Directory(_caDir).createSync(recursive: true);

    // Root CA：EC P-256，自簽 10 年，可簽中介（pathlen:1）。
    await _run([
      'ecparam',
      '-name',
      'prime256v1',
      '-genkey',
      '-noout',
      '-out',
      rootCaKey,
    ]);
    await _run([
      'req',
      '-x509',
      '-new',
      '-key',
      rootCaKey,
      '-sha256',
      '-days',
      '3650',
      '-subj',
      '/C=TW/O=IoT Smart Factory/CN=IoT Root CA',
      '-addext',
      'basicConstraints=critical,CA:TRUE,pathlen:1',
      '-addext',
      'keyUsage=critical,keyCertSign,cRLSign',
      '-out',
      rootCaCert,
    ]);

    // Intermediate CA：由 Root 簽發 5 年，只能簽終端憑證（pathlen:0）。
    const intermediateCsr = '$_caDir/intermediate.csr';
    await _run([
      'ecparam',
      '-name',
      'prime256v1',
      '-genkey',
      '-noout',
      '-out',
      intermediateKey,
    ]);
    await _run([
      'req',
      '-new',
      '-key',
      intermediateKey,
      '-sha256',
      '-subj',
      '/C=TW/O=IoT Smart Factory/CN=IoT Device Intermediate CA',
      '-out',
      intermediateCsr,
    ]);
    final extFile = File('$_caDir/intermediate.ext')
      ..writeAsStringSync(
        'basicConstraints=critical,CA:TRUE,pathlen:0\n'
        'keyUsage=critical,keyCertSign,cRLSign\n',
      );
    await _run([
      'x509',
      '-req',
      '-in',
      intermediateCsr,
      '-sha256',
      '-CA',
      rootCaCert,
      '-CAkey',
      rootCaKey,
      '-CAcreateserial',
      '-days',
      '1825',
      '-extfile',
      extFile.path,
      '-out',
      intermediateCert,
    ]);
    File(intermediateCsr).deleteSync();
    session.log('內部 CA 已建立：Root + Intermediate（$_caDir）');
  }

  /// 簽發設備憑證（手冊 §8）：驗證 CSR → 檢查 CN → Intermediate 簽發
  /// → openssl verify 驗證完整信任鏈。回傳 (憑證 PEM, 憑證序號 hex, 到期時間)。
  static Future<(String, String, DateTime)> signDeviceCsr(
    Session session, {
    required String csrPem,
    required String expectedCn,
  }) async {
    await ensureCa(session);
    final tmp = Directory.systemTemp.createTempSync('ca-sign-');
    try {
      final csrFile = File('${tmp.path}/device.csr')..writeAsStringSync(csrPem);

      // 1) 驗證 CSR 本身簽章合法。
      await _run(['req', '-in', csrFile.path, '-verify', '-noout']);

      // 2) CSR 的 CN 必須等於設備序號（避免設備冒用他人身分）。
      final subject = await Process.run('openssl', [
        'req',
        '-in',
        csrFile.path,
        '-noout',
        '-subject',
      ]);
      final subjectLine = (subject.stdout as String).trim();
      if (!subjectLine.contains('CN=$expectedCn') &&
          !subjectLine.contains('CN = $expectedCn')) {
        throw ValidationException(
          message: 'CSR CN 與設備序號不符：$subjectLine',
        );
      }

      // 3) 以 Intermediate CA 簽發，含 clientAuth 與 SAN。
      final certSerial = Random.secure()
          .nextInt(0x7fffffff)
          .toRadixString(16)
          .toUpperCase();
      final extFile = File('${tmp.path}/device.ext')
        ..writeAsStringSync(
          'basicConstraints=critical,CA:FALSE\n'
          'keyUsage=critical,digitalSignature\n'
          'extendedKeyUsage=clientAuth\n'
          // macOS LibreSSL rejects the former `urn:device:<serial>` SAN as
          // invalid URI syntax. A hierarchical URI is portable across
          // LibreSSL/OpenSSL and still binds the certificate to the serial.
          'subjectAltName=URI:spiffe://iot.local/device/$expectedCn\n',
        );
      final certFile = File('${tmp.path}/device.crt');
      await _run([
        'x509',
        '-req',
        '-in',
        csrFile.path,
        '-sha256',
        '-CA',
        intermediateCert,
        '-CAkey',
        intermediateKey,
        '-set_serial',
        '0x$certSerial',
        '-days',
        '$deviceCertDays',
        '-extfile',
        extFile.path,
        '-out',
        certFile.path,
      ]);

      // 4) 驗證完整信任鏈 Root → Intermediate → Device。
      await _run([
        'verify',
        '-CAfile',
        rootCaCert,
        '-untrusted',
        intermediateCert,
        certFile.path,
      ]);

      // 5) 取得到期時間。
      final endDate = await Process.run('openssl', [
        'x509',
        '-in',
        certFile.path,
        '-noout',
        '-enddate',
      ]);
      final expiresAt = _parseOpensslDate(
        (endDate.stdout as String).trim().replaceFirst('notAfter=', ''),
      );

      return (certFile.readAsStringSync(), certSerial, expiresAt);
    } finally {
      tmp.deleteSync(recursive: true);
    }
  }

  /// 驗證出廠憑證由公司 CA 簽發，且憑證 CN 與設備序號一致。
  /// 回傳標準化 SHA-256 指紋，供設備登錄表鎖定身分。
  static Future<String> verifyFactoryCertificate({
    required String certificatePem,
    required String expectedCn,
  }) async {
    final tmp = Directory.systemTemp.createTempSync('factory-verify-');
    try {
      final certFile = File('${tmp.path}/factory.crt')
        ..writeAsStringSync(certificatePem);
      await _run([
        'verify',
        '-CAfile',
        rootCaCert,
        '-untrusted',
        intermediateCert,
        certFile.path,
      ]);
      final details = await Process.run('openssl', [
        'x509',
        '-in',
        certFile.path,
        '-noout',
        '-subject',
        '-fingerprint',
        '-sha256',
      ]);
      if (details.exitCode != 0) {
        throw ValidationException(message: '無法讀取 Factory Certificate');
      }
      final output = details.stdout.toString();
      if (!output.contains('CN=$expectedCn') &&
          !output.contains('CN = $expectedCn')) {
        throw ValidationException(message: '出廠憑證 CN 與設備序號不符');
      }
      final match = RegExp(
        r'(?:sha256 Fingerprint|SHA256 Fingerprint)=([^\r\n]+)',
        caseSensitive: false,
      ).firstMatch(output);
      if (match == null) {
        throw ValidationException(message: '無法取得 Factory Certificate 指紋');
      }
      return match.group(1)!.replaceAll(':', '').trim().toUpperCase();
    } finally {
      tmp.deleteSync(recursive: true);
    }
  }

  /// 模擬 ESP32 裝置端：產生 ECDSA 私鑰與 CSR（CN=serial）。
  ///
  /// 回傳 `(keyPem, csrPem)`。正式產品私鑰永不離開設備；
  /// 開發環境由呼叫端選擇是否把 key 寫入本機模擬器用目錄
  /// （`certs/mqtt/devices/{serial}/`），Server 不會入庫私鑰。
  static Future<(String, String)> simulateDeviceKeyAndCsr(String serial) async {
    final tmp = Directory.systemTemp.createTempSync('esp32-sim-');
    try {
      final keyFile = '${tmp.path}/device.key';
      final csrFile = '${tmp.path}/device.csr';
      await _run([
        'ecparam',
        '-name',
        'prime256v1',
        '-genkey',
        '-noout',
        '-out',
        keyFile,
      ]);
      await _run([
        'req',
        '-new',
        '-key',
        keyFile,
        '-sha256',
        '-subj',
        '/O=IoT Smart Factory Device/CN=$serial',
        '-out',
        csrFile,
      ]);
      return (
        File(keyFile).readAsStringSync(),
        File(csrFile).readAsStringSync(),
      );
    } finally {
      tmp.deleteSync(recursive: true);
    }
  }

  /// @nodoc 相容舊呼叫：只回傳 CSR（私鑰立即銷毀）。
  static Future<String> simulateDeviceCsr(String serial) async {
    final (_, csr) = await simulateDeviceKeyAndCsr(serial);
    return csr;
  }

  static String readRootCa() => File(rootCaCert).readAsStringSync();

  static String readIntermediateCa() =>
      File(intermediateCert).readAsStringSync();

  /// 解析 openssl 的日期輸出，例如 "Aug  5 14:00:00 2027 GMT"。
  static DateTime _parseOpensslDate(String raw) {
    const months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };
    final parts = raw.split(RegExp(r'\s+'));
    final time = parts[2].split(':');
    return DateTime.utc(
      int.parse(parts[3]),
      months[parts[0]]!,
      int.parse(parts[1]),
      int.parse(time[0]),
      int.parse(time[1]),
      int.parse(time[2]),
    );
  }
}
