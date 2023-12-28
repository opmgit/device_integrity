import 'device_integrity_platform_interface.dart';

class DeviceIntegrity {
  Future<String?> getToken({
    required int cloudProjectNumber,
    required String hash,
  }) {
    return DeviceIntegrityPlatform.instance
        .getToken(cloudProjectNumber: cloudProjectNumber, hash: hash);
  }
}
