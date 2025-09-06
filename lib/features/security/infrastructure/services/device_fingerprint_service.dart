import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../domain/value_objects/device_fingerprint.dart';

class DeviceFingerprintService {
  const DeviceFingerprintService(this._deviceInfo, this._packageInfo);

  final DeviceInfoPlugin _deviceInfo;
  final PackageInfo _packageInfo;

  Future<DeviceFingerprint> generateFingerprint() async {
    if (Platform.isAndroid) {
      return await _generateAndroidFingerprint();
    } else if (Platform.isIOS) {
      return await _generateIOSFingerprint();
    } else {
      return await _generateGenericFingerprint();
    }
  }

  Future<DeviceFingerprint> _generateAndroidFingerprint() async {
    final androidInfo = await _deviceInfo.androidInfo;
    
    return DeviceFingerprint(
      deviceId: androidInfo.id,
      platform: 'Android',
      osVersion: androidInfo.version.release,
      appVersion: _packageInfo.version,
      isPhysicalDevice: androidInfo.isPhysicalDevice,
      manufacturer: androidInfo.manufacturer,
      model: androidInfo.model,
      buildFingerprint: androidInfo.fingerprint,
    );
  }

  Future<DeviceFingerprint> _generateIOSFingerprint() async {
    final iosInfo = await _deviceInfo.iosInfo;
    
    return DeviceFingerprint(
      deviceId: iosInfo.identifierForVendor ?? 'unknown',
      platform: 'iOS',
      osVersion: iosInfo.systemVersion,
      appVersion: _packageInfo.version,
      isPhysicalDevice: iosInfo.isPhysicalDevice,
      manufacturer: 'Apple',
      model: iosInfo.model,
      buildFingerprint: iosInfo.systemName,
    );
  }

  Future<DeviceFingerprint> _generateGenericFingerprint() async {
    return DeviceFingerprint(
      deviceId: 'unknown',
      platform: Platform.operatingSystem,
      osVersion: Platform.operatingSystemVersion,
      appVersion: _packageInfo.version,
      isPhysicalDevice: true, // Assume physical for other platforms
      manufacturer: null,
      model: null,
      buildFingerprint: null,
    );
  }
}