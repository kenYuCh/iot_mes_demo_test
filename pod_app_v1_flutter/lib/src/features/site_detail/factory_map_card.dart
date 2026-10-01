import 'package:flutter/material.dart';
import 'package:pod_app_v1_client/pod_app_v1_client.dart' hide MaterialType;

/// 2D 廠房地圖（docs/product/enterprise-iot-platform-spec.md）：
/// 以正規化座標（mapX/mapY，0..1）將設備擺放在平面圖上，
/// 顏色代表連線狀態，點擊進入設備詳情。
class FactoryMapCard extends StatefulWidget {
  const FactoryMapCard({
    super.key,
    required this.devices,
    required this.statuses,
    required this.onDeviceTap,
    required this.onPositionChanged,
  });

  final List<Device> devices;
  final Map<int, DeviceStatus> statuses;
  final void Function(Device device) onDeviceTap;
  final Future<void> Function(Device device, double x, double y)
  onPositionChanged;

  @override
  State<FactoryMapCard> createState() => _FactoryMapCardState();
}

class _FactoryMapCardState extends State<FactoryMapCard> {
  bool _editing = false;
  int? _savingDeviceId;
  final Map<int, Offset> _draftPositions = {};

  @override
  Widget build(BuildContext context) {
    final placed = widget.devices
        .where((device) => device.mapX != null && device.mapY != null)
        .toList();
    final unplaced = widget.devices
        .where((device) => device.mapX == null || device.mapY == null)
        .toList();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Icon(
              _editing ? Icons.open_with_rounded : Icons.map_outlined,
            ),
            title: Text(_editing ? '編輯廠房佈置' : '廠房平面圖'),
            subtitle: Text(
              _editing ? '拖曳設備後會儲存真實座標' : '位置由 Server 儲存，不會隨排序改變',
            ),
            trailing: TextButton.icon(
              onPressed: () => setState(() {
                _editing = !_editing;
                _draftPositions.clear();
              }),
              icon: Icon(
                _editing ? Icons.lock_outline : Icons.edit_location_alt,
              ),
              label: Text(_editing ? '完成' : '編輯'),
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 10,
            child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _FloorPainter(
                        gridColor: Theme.of(
                          context,
                        ).colorScheme.outlineVariant.withValues(alpha: 0.4),
                        floorColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLow,
                      ),
                    ),
                  ),
                  for (final device in placed)
                    _DeviceMarker(
                      device: device,
                      status: widget.statuses[device.id],
                      left:
                          (_draftPositions[device.id]?.dx ?? device.mapX!) *
                          constraints.maxWidth,
                      top:
                          (_draftPositions[device.id]?.dy ?? device.mapY!) *
                          constraints.maxHeight,
                      editing: _editing,
                      saving: _savingDeviceId == device.id,
                      onTap: () => widget.onDeviceTap(device),
                      onDrag: (delta) => _move(
                        device,
                        delta,
                        constraints.biggest,
                      ),
                      onDragEnd: () => _save(device),
                    ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: _Legend(),
                  ),
                ],
              ),
            ),
          ),
          if (unplaced.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              color: Theme.of(context).colorScheme.surfaceContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '未配置設備（${unplaced.length}）',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _editing ? '點選設備後放到地圖中央，再拖曳定位。' : '這些設備尚未標記真實位置。',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: [
                      for (final device in unplaced)
                        ActionChip(
                          avatar: const Icon(Icons.sensors, size: 16),
                          label: Text(device.name),
                          onPressed: !_editing
                              ? () => widget.onDeviceTap(device)
                              : () => _placeAtCenter(device),
                        ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _move(Device device, Offset delta, Size size) {
    final current =
        _draftPositions[device.id] ??
        Offset(device.mapX ?? .5, device.mapY ?? .5);
    setState(() {
      _draftPositions[device.id!] = Offset(
        (current.dx + delta.dx / size.width).clamp(.04, .96),
        (current.dy + delta.dy / size.height).clamp(.06, .94),
      );
    });
  }

  Future<void> _save(Device device) async {
    final position = _draftPositions[device.id];
    if (position == null) return;
    setState(() => _savingDeviceId = device.id);
    try {
      await widget.onPositionChanged(device, position.dx, position.dy);
    } finally {
      if (mounted) setState(() => _savingDeviceId = null);
    }
  }

  Future<void> _placeAtCenter(Device device) async {
    setState(() {
      _draftPositions[device.id!] = const Offset(.5, .5);
      _savingDeviceId = device.id;
    });
    try {
      await widget.onPositionChanged(device, .5, .5);
    } finally {
      if (mounted) setState(() => _savingDeviceId = null);
    }
  }
}

class _DeviceMarker extends StatelessWidget {
  const _DeviceMarker({
    required this.device,
    required this.status,
    required this.left,
    required this.top,
    required this.editing,
    required this.saving,
    required this.onTap,
    required this.onDrag,
    required this.onDragEnd,
  });

  final Device device;
  final DeviceStatus? status;
  final double left;
  final double top;
  final bool editing;
  final bool saving;
  final VoidCallback onTap;
  final ValueChanged<Offset> onDrag;
  final VoidCallback onDragEnd;

  @override
  Widget build(BuildContext context) {
    final color = _stateColor(
      status?.connectionState ?? DeviceConnectionState.unknown,
    );

    // 觸控面積 > 48dp（無障礙觸控規範）。
    return Positioned(
      left: left - 28,
      top: top - 28,
      width: 56,
      height: 56,
      child: GestureDetector(
        key: ValueKey('map-dev-${device.id}'),
        onTap: editing ? null : onTap,
        onPanUpdate: editing ? (details) => onDrag(details.delta) : null,
        onPanEnd: editing ? (_) => onDragEnd() : null,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: editing ? null : onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: saving ? Colors.cyanAccent : color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.5),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  device.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color _stateColor(DeviceConnectionState state) => switch (state) {
  DeviceConnectionState.online => Colors.green,
  DeviceConnectionState.stale => Colors.orange,
  DeviceConnectionState.offline => Colors.red,
  DeviceConnectionState.maintenance => Colors.blueGrey,
  DeviceConnectionState.disabled ||
  DeviceConnectionState.unknown => Colors.grey,
};

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget dot(Color color, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 9, color: color),
        const SizedBox(width: 3),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          dot(Colors.green, '在線'),
          const SizedBox(width: 8),
          dot(Colors.orange, '過期'),
          const SizedBox(width: 8),
          dot(Colors.red, '離線'),
        ],
      ),
    );
  }
}

/// 廠房平面底圖：地板底色＋格線＋牆線。
class _FloorPainter extends CustomPainter {
  const _FloorPainter({required this.gridColor, required this.floorColor});

  final Color gridColor;
  final Color floorColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = floorColor);

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    const divisions = 8;
    for (var i = 1; i < divisions; i++) {
      final x = size.width * i / divisions;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (var i = 1; i < divisions * 10 ~/ 16; i++) {
      final y = size.height * i / (divisions * 10 / 16);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 外牆。
    final wallPaint = Paint()
      ..color = gridColor.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRect(
      Rect.fromLTWH(1.5, 1.5, size.width - 3, size.height - 3),
      wallPaint,
    );
  }

  @override
  bool shouldRepaint(_FloorPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor ||
      oldDelegate.floorColor != floorColor;
}
