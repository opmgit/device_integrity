import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'device_integrity_platform_interface.dart';

/// An implementation of [DeviceIntegrityPlatform] that uses method channels.
class MethodChannelDeviceIntegrity extends DeviceIntegrityPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('device_integrity');

  @override
  Future<String?> getToken({
    required int cloudProjectNumber,
    required String hash,
  }) async {
    try {
      final token = await methodChannel
          .invokeMethod<String>('getToken', <String, dynamic>{
        'cloud_project_number': cloudProjectNumber,
        'hash': hash,
      });
      return token;
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return null;
    }
  }
}
