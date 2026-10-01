import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

/// 本地推播：App 前景收到 CRITICAL 以上告警時彈出系統通知
/// （docs/product/enterprise-iot-platform-spec.md 雙軌推播的前景通道；
/// 背景 APNs 推播需實體機與 Apple 憑證，於上架階段接入）。
class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    await _plugin.initialize(
      settings: const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    _initialized = true;
  }

  static Future<bool> ensurePermissions() async {
    if (!_initialized) await init();
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios == null) return true;
    final current = await ios.checkPermissions();
    if (current?.isEnabled == true && current?.isAlertEnabled == true) {
      return true;
    }
    return await ios.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ) ??
        false;
  }

  /// 依規則設定彈出告警通知；重要等級使用時間敏感通知。
  static Future<void> showAlert({
    required int id,
    required String title,
    required String body,
    required AlertSeverity severity,
  }) async {
    if (!await ensurePermissions()) return;
    final timeSensitive =
        severity == AlertSeverity.critical ||
        severity == AlertSeverity.emergency;
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          // iOS 14+ uses banner/list presentation flags. presentAlert alone
          // is retained for older iOS versions but is insufficient on modern
          // devices while the app is in the foreground.
          presentBanner: true,
          presentList: true,
          presentBadge: true,
          presentSound: true,
          interruptionLevel: timeSensitive
              ? InterruptionLevel.timeSensitive
              : InterruptionLevel.active,
        ),
        android: AndroidNotificationDetails(
          'critical_alerts',
          '設備告警',
          importance: timeSensitive ? Importance.max : Importance.high,
          priority: timeSensitive ? Priority.max : Priority.high,
        ),
      ),
    );
  }
}
