/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// 設備配對狀態機（docs/product/ESP32_Server_mTLS_Provisioning_完整設計手冊.md §12）。
/// 開發環境省略 Wi-Fi 配網階段（需實體 ESP32 + BLE）。
enum ProvisioningState implements _i1.SerializableModel {
  /// 出廠已登錄，尚未被任何帳號綁定。
  unclaimed,

  /// 使用者掃碼後建立 Claim Session，等待設備回應。
  claimPending,

  /// 設備通過 Bootstrap 驗證並完成綁定。
  claimed,

  /// 正式 MQTT 憑證已簽發。
  certificateIssued,

  /// 設備啟用，可用正式憑證連線。
  active,

  /// 憑證已撤銷 / 設備停用。
  revoked;

  static ProvisioningState fromJson(String name) {
    switch (name) {
      case 'unclaimed':
        return ProvisioningState.unclaimed;
      case 'claimPending':
        return ProvisioningState.claimPending;
      case 'claimed':
        return ProvisioningState.claimed;
      case 'certificateIssued':
        return ProvisioningState.certificateIssued;
      case 'active':
        return ProvisioningState.active;
      case 'revoked':
        return ProvisioningState.revoked;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ProvisioningState"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
