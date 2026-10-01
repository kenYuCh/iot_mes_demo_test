import '../generated/protocol.dart';

/// 設備型別檔目錄。
///
/// 一台設備可有多個量測通道與控制參數（例如馬達驅動器 6 量測 + 3 控制）。
/// 量測值以 featureKey 寫入 Measurement / DeviceStatus.latestValues；
/// 控制參數經 setParam 命令下發，由裝置端（開發環境為模擬器）套用。
class DeviceProfiles {
  DeviceProfiles._();

  static DeviceFeature _m(
    String key,
    String label,
    String unit,
    double min,
    double max, {
    int precision = 1,
    String? description,
  }) => DeviceFeature(
    key: key,
    label: label,
    unit: unit,
    kind: FeatureKind.measurement,
    dataType: FeatureDataType.number,
    precision: precision,
    description: description,
    minValue: min,
    maxValue: max,
  );

  static DeviceFeature _c(
    String key,
    String label,
    String unit,
    double min,
    double max,
    double defaultValue, {
    ControlPresentation presentation = ControlPresentation.slider,
    int precision = 0,
    String? description,
  }) => DeviceFeature(
    key: key,
    label: label,
    unit: unit,
    kind: FeatureKind.control,
    dataType: FeatureDataType.number,
    controlPresentation: presentation,
    precision: precision,
    description: description,
    minValue: min,
    maxValue: max,
    defaultValue: defaultValue,
  );

  static DeviceFeature _toggle(
    String key,
    String label, {
    bool defaultValue = false,
    String? description,
  }) => DeviceFeature(
    key: key,
    label: label,
    unit: '',
    kind: FeatureKind.control,
    dataType: FeatureDataType.boolean,
    controlPresentation: ControlPresentation.toggle,
    precision: 0,
    description: description,
    minValue: 0,
    maxValue: 1,
    defaultValue: defaultValue ? 1 : 0,
  );

  static DeviceFeature _status(
    String key,
    String label,
    List<String> options, {
    String? description,
  }) => DeviceFeature(
    key: key,
    label: label,
    unit: '',
    kind: FeatureKind.measurement,
    dataType: FeatureDataType.enumeration,
    enumOptions: options,
    precision: 0,
    description: description,
    minValue: 0,
    maxValue: (options.length - 1).toDouble(),
  );

  static DeviceFeature _select(
    String key,
    String label,
    List<String> options, {
    int defaultIndex = 0,
  }) => DeviceFeature(
    key: key,
    label: label,
    unit: '',
    kind: FeatureKind.control,
    dataType: FeatureDataType.enumeration,
    controlPresentation: ControlPresentation.segmented,
    enumOptions: options,
    precision: 0,
    minValue: 0,
    maxValue: (options.length - 1).toDouble(),
    defaultValue: defaultIndex.toDouble(),
  );

  static DeviceFeature _momentary(
    String key,
    String label, {
    String? description,
  }) => DeviceFeature(
    key: key,
    label: label,
    unit: '',
    kind: FeatureKind.control,
    dataType: FeatureDataType.boolean,
    controlPresentation: ControlPresentation.momentary,
    precision: 0,
    description: description,
    minValue: 0,
    maxValue: 1,
    defaultValue: 0,
  );

  static final List<DeviceProfile> all = [
    DeviceProfile(
      id: 'esp32_motor_sensor',
      name: 'ESP32 直連馬達控制器',
      description: 'Wi-Fi/MQTTS 直連設備；回報轉速、運轉狀態與溫度，並接受目標轉速控制。',
      mcuFamily: 'ESP32',
      category: 'mixed',
      features: [
        _c('mt_1_ct_speed', '控制轉速', '%', 0, 100, 0),
        _m('mt_1_speed', '當下轉速', '%', 0, 100),
        _status('mt_1_status', '運轉狀態', [
          'OFF',
          'ON',
        ], description: '設備實際回報的唯讀狀態'),
        _m('mt_1_temp', '馬達溫度', '°C', -20, 150),
      ],
    ),
    DeviceProfile(
      id: 'temperature',
      name: '溫度感測器',
      description: '單通道溫度量測',
      features: [_m('temperature', '溫度', '°C', -20, 120)],
    ),
    DeviceProfile(
      id: 'humidity',
      name: '濕度感測器',
      description: '單通道濕度量測',
      features: [_m('humidity', '濕度', '%', 0, 100)],
    ),
    DeviceProfile(
      id: 'power',
      name: '電力感測器',
      description: '單通道功率量測',
      features: [_m('power', '功率', 'kW', 0, 500)],
    ),
    DeviceProfile(
      id: 'vibration',
      name: '震動感測器',
      description: '單通道震動量測',
      features: [_m('vibration', '震動', 'mm/s', 0, 10)],
    ),
    DeviceProfile(
      id: 'env_multi',
      name: '環境多合一感測器',
      description: '溫濕度、CO₂、照度 4 通道＋取樣/指示燈控制',
      features: [
        _m('temperature', '溫度', '°C', -20, 120),
        _m('humidity', '濕度', '%', 0, 100),
        _m('co2', 'CO₂ 濃度', 'ppm', 400, 5000),
        _m('lux', '照度', 'lx', 0, 2000),
        _c('samplingIntervalSec', '取樣間隔', '秒', 1, 60, 5),
        _c('ledBrightness', '指示燈亮度', '%', 0, 100, 50),
      ],
    ),
    DeviceProfile(
      id: 'motor_drive',
      name: '馬達驅動器',
      description: '轉速、溫度、震動、功率、電流、扭矩 6 通道＋3 控制參數',
      features: [
        _m('rpm', '馬達轉速', 'rpm', 0, 3000),
        _m('motorTemp', '馬達溫度', '°C', 0, 150),
        _m('vibration', '震動', 'mm/s', 0, 10),
        _m('power', '功率', 'kW', 0, 500),
        _m('current', '電流', 'A', 0, 200),
        _m('torque', '扭矩', 'N·m', 0, 500),
        _c('targetRpm', '目標轉速', 'rpm', 0, 3000, 1500),
        _c('torqueLimit', '扭矩限制', '%', 0, 100, 80),
        _c('coolingFan', '散熱風扇', '%', 0, 100, 40),
      ],
    ),
    DeviceProfile(
      id: 'power_meter',
      name: '電力監測器',
      description: '功率、電壓、電流 3 通道＋需量/取樣控制',
      features: [
        _m('power', '功率', 'kW', 0, 500),
        _m('voltage', '電壓', 'V', 0, 480),
        _m('current', '電流', 'A', 0, 200),
        _c('demandLimit', '需量上限', 'kW', 10, 500, 200),
        _c('samplingIntervalSec', '取樣間隔', '秒', 1, 60, 5),
      ],
    ),
    DeviceProfile(
      id: 'air_quality_controller',
      name: '空氣品質與排風控制器',
      description: '環境感測與排風致動混合設備',
      features: [
        _m('temperature', '溫度', '°C', -20, 100),
        _m('humidity', '濕度', '%', 0, 100),
        _m('co2', 'CO₂', 'ppm', 0, 10000, precision: 0),
        _m('pm25', 'PM2.5', 'µg/m³', 0, 1000),
        _m('voc', 'TVOC', 'ppb', 0, 60000, precision: 0),
        _toggle('exhaustFan', '排風扇'),
        _c('fanSpeed', '排風轉速', '%', 0, 100, 60),
        _select('operationMode', '運轉模式', ['手動', '自動', '節能'], defaultIndex: 1),
      ],
    ),
    DeviceProfile(
      id: 'tank_process_controller',
      name: '槽體製程控制器',
      description: '液位、壓力、流量與進排液閥門整合控制',
      features: [
        _m('level', '液位', '%', 0, 100),
        _m('pressure', '壓力', 'bar', 0, 25, precision: 2),
        _m('flow', '流量', 'L/min', 0, 1000),
        _m('liquidTemp', '液溫', '°C', -10, 150),
        _toggle('inletValve', '進液閥'),
        _toggle('outletValve', '排液閥'),
        _c('levelSetpoint', '目標液位', '%', 5, 95, 70),
        _momentary('emergencyStop', '緊急停止', description: '需二次確認後下發'),
      ],
    ),
    DeviceProfile(
      id: 'conveyor_plc',
      name: '輸送帶 PLC 控制器',
      description: '速度、負載、計數與啟停控制',
      features: [
        _m('beltSpeed', '帶速', 'm/min', 0, 120),
        _m('motorLoad', '馬達負載', '%', 0, 150),
        _m('itemCount', '產量計數', 'pcs', 0, 100000000, precision: 0),
        _m('jamSignal', '堵料訊號', '', 0, 1, precision: 0),
        _toggle('run', '輸送帶啟停'),
        _c('speedSetpoint', '目標帶速', 'm/min', 1, 120, 45),
        _select('direction', '運轉方向', ['正轉', '反轉']),
        _momentary('resetCounter', '重設計數'),
      ],
    ),
    DeviceProfile(
      id: 'cold_chain_controller',
      name: '冷鏈監控控制器',
      description: '多點溫度、門磁、除霜與壓縮機控制',
      features: [
        _m('supplyTemp', '送風溫度', '°C', -50, 30),
        _m('returnTemp', '回風溫度', '°C', -50, 30),
        _m('doorOpen', '門磁', '', 0, 1, precision: 0),
        _m('compressorCurrent', '壓縮機電流', 'A', 0, 100),
        _c('temperatureSetpoint', '溫度設定', '°C', -30, 10, -18),
        _toggle('compressorEnabled', '壓縮機允許', defaultValue: true),
        _momentary('manualDefrost', '手動除霜'),
      ],
    ),
    DeviceProfile(
      id: 'hydraulic_station',
      name: '液壓站監控器',
      description: '壓力、油溫、油位、濾芯壓差與泵浦控制',
      features: [
        _m('systemPressure', '系統壓力', 'bar', 0, 350),
        _m('oilTemp', '油溫', '°C', -10, 150),
        _m('oilLevel', '油位', '%', 0, 100),
        _m('filterDeltaP', '濾芯壓差', 'bar', 0, 10, precision: 2),
        _toggle('pumpEnabled', '主泵啟用'),
        _c('pressureSetpoint', '壓力設定', 'bar', 10, 300, 120),
        _select('pumpMode', '泵浦模式', ['停止', '手動', '自動'], defaultIndex: 2),
      ],
    ),
  ];

  static final Map<String, DeviceProfile> _byId = {
    for (final profile in all) profile.id: profile,
  };

  static DeviceProfile? byId(String id) => _byId[id];

  static DeviceProfile fromCustom(CustomDeviceProfile profile) => DeviceProfile(
    id: profile.profileKey,
    name: profile.name,
    description: profile.description,
    mcuFamily: profile.mcuFamily,
    category: profile.category,
    features: profile.features,
  );

  /// 設備的有效特徵清單：優先取設備自身的 features，
  /// 舊資料（features 為 null）依 deviceType 由目錄補齊。
  static List<DeviceFeature> featuresFor(Device device) =>
      device.features ??
      byId(device.deviceType)?.features ??
      [_m(device.deviceType, device.deviceType, '', 0, 100)];

  static List<DeviceFeature> measurementsOf(Device device) => [
    for (final f in featuresFor(device))
      if (f.kind == FeatureKind.measurement) f,
  ];

  static List<DeviceFeature> controlsOf(Device device) => [
    for (final f in featuresFor(device))
      if (f.kind == FeatureKind.control) f,
  ];
}
