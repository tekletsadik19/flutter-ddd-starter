import 'package:shemanit/features/security/domain/entities/security_status.dart';

class SecurityStatusModel {
  const SecurityStatusModel({
    required this.isJailbroken,
    required this.isRooted,
    required this.isEmulator,
    required this.isDevelopmentModeEnabled,
    required this.isDebuggingEnabled,
    required this.threatLevel,
    required this.detectedThreats,
  });

  factory SecurityStatusModel.fromJson(Map<String, dynamic> json) {
    return SecurityStatusModel(
      isJailbroken: json['isJailbroken'] as bool,
      isRooted: json['isRooted'] as bool,
      isEmulator: json['isEmulator'] as bool,
      isDevelopmentModeEnabled: json['isDevelopmentModeEnabled'] as bool,
      isDebuggingEnabled: json['isDebuggingEnabled'] as bool,
      threatLevel: SecurityThreatLevelModel.values.firstWhere(
        (e) => e.name == json['threatLevel'],
        orElse: () => SecurityThreatLevelModel.none,
      ),
      detectedThreats: List<String>.from(json['detectedThreats'] as List),
    );
  }

  final bool isJailbroken;
  final bool isRooted;
  final bool isEmulator;
  final bool isDevelopmentModeEnabled;
  final bool isDebuggingEnabled;
  final SecurityThreatLevelModel threatLevel;
  final List<String> detectedThreats;
}

enum SecurityThreatLevelModel {
  none,
  low,
  medium,
  high,
  critical,
}

extension SecurityStatusModelExtension on SecurityStatusModel {
  SecurityStatus toDomain() {
    return SecurityStatus(
      isJailbroken: isJailbroken,
      isRooted: isRooted,
      isEmulator: isEmulator,
      isDevelopmentModeEnabled: isDevelopmentModeEnabled,
      isDebuggingEnabled: isDebuggingEnabled,
      threatLevel: threatLevel.toDomain(),
      detectedThreats: detectedThreats,
    );
  }
}

extension SecurityThreatLevelModelExtension on SecurityThreatLevelModel {
  SecurityThreatLevel toDomain() {
    switch (this) {
      case SecurityThreatLevelModel.none:
        return SecurityThreatLevel.none;
      case SecurityThreatLevelModel.low:
        return SecurityThreatLevel.low;
      case SecurityThreatLevelModel.medium:
        return SecurityThreatLevel.medium;
      case SecurityThreatLevelModel.high:
        return SecurityThreatLevel.high;
      case SecurityThreatLevelModel.critical:
        return SecurityThreatLevel.critical;
    }
  }
}
