import 'package:flutter_test/flutter_test.dart';
import 'package:device_integrity/device_integrity.dart';
import 'package:device_integrity/device_integrity_platform_interface.dart';
import 'package:device_integrity/device_integrity_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceIntegrityPlatform
    with MockPlatformInterfaceMixin
    implements DeviceIntegrityPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DeviceIntegrityPlatform initialPlatform = DeviceIntegrityPlatform.instance;

  test('$MethodChannelDeviceIntegrity is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceIntegrity>());
  });

  test('getPlatformVersion', () async {
    DeviceIntegrity deviceIntegrityPlugin = DeviceIntegrity();
    MockDeviceIntegrityPlatform fakePlatform = MockDeviceIntegrityPlatform();
    DeviceIntegrityPlatform.instance = fakePlatform;

    expect(await deviceIntegrityPlugin.getPlatformVersion(), '42');
  });
}
