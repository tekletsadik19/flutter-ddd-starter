import 'package:equatable/equatable.dart';

class DeviceFingerprint extends Equatable {
  const DeviceFingerprint({
    required this.deviceId,
    required this.platform,
    required this.osVersion,
    required this.appVersion,
    required this.isPhysicalDevice,
    this.manufacturer,
    this.model,
    this.buildFingerprint,
  });

  final String deviceId;
  final String platform; // iOS, Android
  final String osVersion;
  final String appVersion;
  final bool isPhysicalDevice;
  final String? manufacturer;
  final String? model;
  final String? buildFingerprint;

  bool get isEmulator => !isPhysicalDevice;
  
  bool get isAndroid => platform.toLowerCase() == 'android';
  bool get isIOS => platform.toLowerCase() == 'ios';

  bool hasKnownEmulatorSignatures() {
    if (!isAndroid) return false;
    
    final emulatorIndicators = [
      manufacturer?.toLowerCase().contains('generic') ?? false,
      model?.toLowerCase().contains('sdk') ?? false,
      model?.toLowerCase().contains('emulator') ?? false,
      buildFingerprint?.toLowerCase().contains('generic') ?? false,
      buildFingerprint?.toLowerCase().contains('test-keys') ?? false,
    ];

    return emulatorIndicators.any((indicator) => indicator);
  }

  @override
  List<Object?> get props => [
    deviceId,
    platform,
    osVersion,
    appVersion,
    isPhysicalDevice,
    manufacturer,
    model,
    buildFingerprint,
  ];
}