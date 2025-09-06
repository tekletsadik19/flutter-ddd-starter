import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import '../../domain/services/security_assessment_service.dart';

class PlatformSecurityDetectionService implements ISecurityDetectionService {
  const PlatformSecurityDetectionService(this._deviceInfo);

  final DeviceInfoPlugin _deviceInfo;

  @override
  Future<bool> isDeviceJailbroken() async {
    if (!Platform.isIOS) return false;
    
    try {
      return await JailbreakRootDetection.isJailBroken ?? false;
    } catch (e) {
      return await _fallbackJailbreakDetection();
    }
  }

  @override
  Future<bool> isDeviceRooted() async {
    if (!Platform.isAndroid) return false;
    
    try {
      return await JailbreakRootDetection.isRooted ?? false;
    } catch (e) {
      return await _fallbackRootDetection();
    }
  }

  @override
  Future<bool> isRunningOnEmulator() async {
    try {
      return await JailbreakRootDetection.isOnEmulator ?? false;
    } catch (e) {
      return await _fallbackEmulatorDetection();
    }
  }

  @override
  Future<bool> isDevelopmentModeEnabled() async {
    if (Platform.isAndroid) {
      try {
        return await JailbreakRootDetection.isDeveloperModeEnable ?? false;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  @override
  Future<bool> isDebuggingEnabled() async {
    if (Platform.isAndroid) {
      try {
        return await JailbreakRootDetection.isDebuggingEnable ?? false;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  @override
  Future<List<String>> detectTamperingAttempts() async {
    final attempts = <String>[];
    
    // Check for known hooking frameworks
    if (await _checkForHookingFrameworks()) {
      attempts.add('Hooking framework detected');
    }
    
    // Check for debugging tools
    if (await _checkForDebuggingTools()) {
      attempts.add('Debugging tools detected');
    }
    
    // Check for signature tampering
    if (await _checkSignatureIntegrity()) {
      attempts.add('App signature tampering detected');
    }
    
    return attempts;
  }

  Future<bool> _fallbackJailbreakDetection() async {
    if (!Platform.isIOS) return false;

    final jailbreakPaths = [
      '/Applications/Cydia.app',
      '/Library/MobileSubstrate/MobileSubstrate.dylib',
      '/bin/bash',
      '/usr/sbin/sshd',
      '/etc/apt',
      '/private/var/lib/apt/',
      '/private/var/lib/cydia',
      '/private/var/mobile/Library/SBSettings/Themes',
      '/Library/MobileSubstrate/DynamicLibraries/Veency.plist',
      '/private/var/stash',
      '/private/var/lib/package',
      '/System/Library/LaunchDaemons/com.ikey.bbot.plist',
      '/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist',
      '/private/var/tmp/cydia.log',
      '/Applications/Icy.app',
      '/Applications/MxTube.app',
      '/Applications/RockApp.app',
      '/Applications/blackra1n.app',
      '/Applications/SBSettings.app',
      '/Applications/FakeCarrier.app',
      '/Applications/WinterBoard.app',
      '/Applications/IntelliScreen.app',
    ];

    for (final path in jailbreakPaths) {
      try {
        if (await File(path).exists() || await Directory(path).exists()) {
          return true;
        }
      } catch (e) {
        // Ignore errors and continue checking
      }
    }

    return false;
  }

  Future<bool> _fallbackRootDetection() async {
    if (!Platform.isAndroid) return false;

    final rootPaths = [
      '/system/app/Superuser.apk',
      '/sbin/su',
      '/system/bin/su',
      '/system/xbin/su',
      '/data/local/xbin/su',
      '/data/local/bin/su',
      '/system/sd/xbin/su',
      '/system/bin/failsafe/su',
      '/data/local/su',
      '/su/bin/su',
      '/system/xbin/busybox',
      '/system/bin/busybox',
      '/data/local/xbin/busybox',
      '/data/local/bin/busybox',
      '/system/xbin/daemonsu',
      '/system/etc/init.d/',
      '/system/bin/.ext/',
      '/system/etc/security/cacerts_google',
      '/data/local/tmp/',
      '/dev/com.koushikdutta.superuser.daemon/',
      '/system/app/SuperSU/',
      '/system/xbin/ku.sud',
      '/system/xbin/supolicy',
      '/sbin/magisk',
      '/system/xbin/magisk',
    ];

    for (final path in rootPaths) {
      try {
        if (await File(path).exists() || await Directory(path).exists()) {
          return true;
        }
      } catch (e) {
        // Ignore errors and continue checking
      }
    }

    return false;
  }

  Future<bool> _fallbackEmulatorDetection() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        
        final emulatorIndicators = [
          androidInfo.brand.toLowerCase().contains('generic'),
          androidInfo.device.toLowerCase().contains('generic'),
          androidInfo.model.toLowerCase().contains('sdk'),
          androidInfo.model.toLowerCase().contains('emulator'),
          androidInfo.product.toLowerCase().contains('sdk'),
          androidInfo.product.toLowerCase().contains('google_sdk'),
          androidInfo.product.toLowerCase().contains('emulator'),
          androidInfo.manufacturer.toLowerCase().contains('genymotion'),
          androidInfo.fingerprint.toLowerCase().contains('generic'),
          androidInfo.fingerprint.toLowerCase().contains('test-keys'),
        ];

        return emulatorIndicators.any((indicator) => indicator);
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.isPhysicalDevice == false;
      }
    } catch (e) {
      return false;
    }
    
    return false;
  }

  Future<bool> _checkForHookingFrameworks() async {
    // Check for common hooking frameworks on different platforms
    if (Platform.isAndroid) {
      final hookingPaths = [
        '/data/local/tmp/frida-server',
        '/system/lib/libsubstrate.so',
        '/system/lib64/libsubstrate.so',
      ];
      
      for (final path in hookingPaths) {
        try {
          if (await File(path).exists()) return true;
        } catch (e) {
          // Continue checking
        }
      }
    } else if (Platform.isIOS) {
      final hookingPaths = [
        '/Library/MobileSubstrate/MobileSubstrate.dylib',
        '/usr/lib/libsubstrate.dylib',
        '/Library/Frameworks/CydiaSubstrate.framework',
      ];
      
      for (final path in hookingPaths) {
        try {
          if (await File(path).exists()) return true;
        } catch (e) {
          // Continue checking
        }
      }
    }
    
    return false;
  }

  Future<bool> _checkForDebuggingTools() async {
    // This is a placeholder - in a real implementation you would check for:
    // - Frida
    // - Xposed
    // - Cycript
    // - GDB
    // - LLDB
    return false;
  }

  Future<bool> _checkSignatureIntegrity() async {
    // This is a placeholder - in a real implementation you would:
    // - Verify app signature
    // - Check for code injection
    // - Validate app bundle integrity
    return false;
  }
}