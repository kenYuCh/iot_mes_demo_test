import 'package:flutter/material.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

/// 告警等級的顯示樣式（規格書 13.1：INFO～EMERGENCY 五級）。
(Color, String) severityStyle(AlertSeverity severity) => switch (severity) {
  AlertSeverity.info => (Colors.blueGrey, 'INFO'),
  AlertSeverity.warning => (Colors.orange, 'WARNING'),
  AlertSeverity.major => (Colors.deepOrange, 'MAJOR'),
  AlertSeverity.critical => (Colors.red, 'CRITICAL'),
  AlertSeverity.emergency => (const Color(0xFF8E0000), 'EMERGENCY'),
};

/// 等級標籤。
class SeverityChip extends StatelessWidget {
  const SeverityChip({super.key, required this.severity});

  final AlertSeverity severity;

  @override
  Widget build(BuildContext context) {
    final (color, label) = severityStyle(severity);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
