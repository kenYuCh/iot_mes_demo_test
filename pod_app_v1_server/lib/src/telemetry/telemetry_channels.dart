/// Message Central 頻道命名（含租戶前綴，見 docs/backend/serverpod-architecture.md）。
class TelemetryChannels {
  static String siteStatus(int companyId, int siteId) =>
      'c:$companyId:site:$siteId:status';

  /// 單一裝置的控制命令狀態更新。
  static String deviceCommands(int companyId, int deviceId) =>
      'c:$companyId:device:$deviceId:commands';

  /// 全公司告警事件（觸發、確認、恢復）。
  static String companyAlerts(int companyId) => 'c:$companyId:alerts';
}
