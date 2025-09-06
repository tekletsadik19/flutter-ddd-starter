import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Simple security service without excessive abstractions
class SecurityService {
  SecurityService._();
  static final instance = SecurityService._();
  
  final _detection = JailbreakRootDetection();
  
  /// Check if device is compromised (jailbroken/rooted)
  Future<bool> isDeviceCompromised() async {
    try {
      return await _detection.isJailBroken;
    } catch (e) {
      // Return false instead of throwing - graceful degradation
      return false;
    }
  }
  
  /// Check if running on emulator
  Future<bool> isEmulator() async {
    try {
      final isReal = await _detection.isRealDevice;
      return !isReal;
    } catch (e) {
      return false;
    }
  }
  
  /// Get basic device info
  Future<DeviceInfo> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return DeviceInfo(
        platform: 'Android',
        model: info.model,
        osVersion: info.version.release,
        appVersion: packageInfo.version,
        isPhysical: info.isPhysicalDevice,
      );
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return DeviceInfo(
        platform: 'iOS',
        model: info.model,
        osVersion: info.systemVersion,
        appVersion: packageInfo.version,
        isPhysical: info.isPhysicalDevice,
      );
    }
    
    return DeviceInfo(
      platform: Platform.operatingSystem,
      model: 'Unknown',
      osVersion: Platform.operatingSystemVersion,
      appVersion: packageInfo.version,
      isPhysical: true,
    );
  }
  
  /// Simple security check - returns true if app should continue
  Future<bool> shouldAllowAppAccess() async {
    final isCompromised = await isDeviceCompromised();
    final isEmu = await isEmulator();
    
    // Block only if both compromised AND on emulator
    return !(isCompromised && isEmu);
  }
}

/// Simple data class for device info
class DeviceInfo {
  const DeviceInfo({
    required this.platform,
    required this.model,
    required this.osVersion,
    required this.appVersion,
    required this.isPhysical,
  });
  
  final String platform;
  final String model;
  final String osVersion;
  final String appVersion;
  final bool isPhysical;
}