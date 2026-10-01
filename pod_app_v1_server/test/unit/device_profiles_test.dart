import 'package:pod_app_v1_server/src/device/device_profiles.dart';
import 'package:pod_app_v1_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  test('device profile ids and feature keys are unique', () {
    final profileIds = DeviceProfiles.all.map((profile) => profile.id).toSet();
    expect(profileIds.length, DeviceProfiles.all.length);

    for (final profile in DeviceProfiles.all) {
      final keys = profile.features.map((feature) => feature.key).toSet();
      expect(keys.length, profile.features.length, reason: profile.id);
      expect(
        profile.features.every(
          (feature) => feature.minValue <= feature.maxValue,
        ),
        isTrue,
        reason: profile.id,
      );
    }
  });

  test('mixed industrial profiles expose measurements and actuators', () {
    const mixedProfiles = {
      'air_quality_controller',
      'tank_process_controller',
      'conveyor_plc',
      'cold_chain_controller',
      'hydraulic_station',
    };

    for (final profileId in mixedProfiles) {
      final profile = DeviceProfiles.byId(profileId)!;
      expect(
        profile.features.any(
          (feature) => feature.kind == FeatureKind.measurement,
        ),
        isTrue,
      );
      expect(
        profile.features.any((feature) => feature.kind == FeatureKind.control),
        isTrue,
      );
    }
  });

  test('non-numeric controls define an appropriate presentation', () {
    final controls = DeviceProfiles.all
        .expand((profile) => profile.features)
        .where((feature) => feature.kind == FeatureKind.control);

    for (final control in controls) {
      if (control.dataType == FeatureDataType.boolean ||
          control.dataType == FeatureDataType.enumeration) {
        expect(control.controlPresentation, isNotNull, reason: control.key);
      }
      if (control.dataType == FeatureDataType.enumeration) {
        expect(control.enumOptions, isNotEmpty, reason: control.key);
      }
    }
  });

  test('physical ESP32 motor controller uses firmware MQTT keys', () {
    final profile = DeviceProfiles.byId('esp32_motor_sensor')!;
    expect(
      profile.features.map((feature) => feature.key),
      containsAll([
        'mt_1_ct_speed',
        'mt_1_speed',
        'mt_1_status',
        'mt_1_temp',
      ]),
    );
    expect(
      profile.features
          .singleWhere((feature) => feature.key == 'mt_1_ct_speed')
          .kind,
      FeatureKind.control,
    );
  });
}
