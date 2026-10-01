import 'package:pod_app_v1_client/pod_app_v1_client.dart';

/// 將傳輸層的 double 還原成設備特徵的使用者語意。
/// Server 以列舉索引儲存資料，例如 OFF=0、ON=1；UI 不應直接顯示索引。
String featureValueText(
  DeviceFeature feature,
  double? value, {
  bool includeUnit = false,
}) {
  if (value == null) return '--';

  final text = switch (feature.dataType ?? FeatureDataType.number) {
    FeatureDataType.enumeration => _enumText(feature, value),
    FeatureDataType.boolean => value >= 0.5 ? '開啟' : '關閉',
    FeatureDataType.number => value.toStringAsFixed(
      (feature.precision ?? 1).clamp(0, 6),
    ),
  };
  if (!includeUnit || feature.unit.trim().isEmpty) return text;
  return '$text ${feature.unit}';
}

String _enumText(DeviceFeature feature, double value) {
  final options = feature.enumOptions ?? const <String>[];
  final index = value.round();
  if (index >= 0 && index < options.length) return options[index];
  return index.toString();
}
