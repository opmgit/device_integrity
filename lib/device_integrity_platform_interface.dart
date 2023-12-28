import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'device_integrity_method_channel.dart';

abstract class DeviceIntegrityPlatform extends PlatformInterface {
  /// Constructs a DeviceIntegrityPlatform.
  DeviceIntegrityPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceIntegrityPlatform _instance = MethodChannelDeviceIntegrity();

  /// The default instance of [DeviceIntegrityPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeviceIntegrity].
  static DeviceIntegrityPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeviceIntegrityPlatform] when
  /// they register themselves.
  static set instance(DeviceIntegrityPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getToken({
    required int cloudProjectNumber,
    required String hash,
  }) {
    throw UnimplementedError('getToken() has not been implemented.');
  }
}
