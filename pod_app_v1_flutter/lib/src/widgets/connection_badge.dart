import 'package:flutter/material.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart';

/// 依 docs/product/enterprise-iot-platform-spec.md 6.1 色彩語意顯示連線狀態。
class ConnectionBadge extends StatelessWidget {
  const ConnectionBadge({super.key, required this.state});

  final DeviceConnectionState state;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (state) {
      DeviceConnectionState.online => (Colors.green, '在線'),
      DeviceConnectionState.stale => (Colors.orange, '過期'),
      DeviceConnectionState.offline => (Colors.red, '離線'),
      DeviceConnectionState.maintenance => (Colors.blueGrey, '維護'),
      DeviceConnectionState.disabled => (Colors.grey, '停用'),
      DeviceConnectionState.unknown => (Colors.grey, '未知'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
