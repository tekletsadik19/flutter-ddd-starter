import 'package:equatable/equatable.dart';

class SecurityStatus extends Equatable {
  const SecurityStatus({
    required this.isJailbroken,
    required this.isRooted,
    required this.isEmulator,
    required this.isDevelopmentModeEnabled,
    required this.isDebuggingEnabled,
    required this.threatLevel,
    required this.detectedThreats,
  });

  final bool isJailbroken;
  final bool isRooted;
  final bool isEmulator;
  final bool isDevelopmentModeEnabled;
  final bool isDebuggingEnabled;
  final SecurityThreatLevel threatLevel;
  final List<String> detectedThreats;

  factory SecurityStatus.fromJson(Map<String, dynamic> json) {
    return SecurityStatus(
      isJailbroken: json['isJailbroken'] as bool,
      isRooted: json['isRooted'] as bool,
      isEmulator: json['isEmulator'] as bool,
      isDevelopmentModeEnabled: json['isDevelopmentModeEnabled'] as bool,
      isDebuggingEnabled: json['isDebuggingEnabled'] as bool,
      threatLevel: SecurityThreatLevel.values.firstWhere(
        (e) => e.name == json['threatLevel'],
        orElse: () => SecurityThreatLevel.none,
      ),
      detectedThreats: List<String>.from(json['detectedThreats'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isJailbroken': isJailbroken,
      'isRooted': isRooted,
      'isEmulator': isEmulator,
      'isDevelopmentModeEnabled': isDevelopmentModeEnabled,
      'isDebuggingEnabled': isDebuggingEnabled,
      'threatLevel': threatLevel.name,
      'detectedThreats': detectedThreats,
    };
  }

  SecurityStatus copyWith({
    bool? isJailbroken,
    bool? isRooted,
    bool? isEmulator,
    bool? isDevelopmentModeEnabled,
    bool? isDebuggingEnabled,
    SecurityThreatLevel? threatLevel,
    List<String>? detectedThreats,
  }) {
    return SecurityStatus(
      isJailbroken: isJailbroken ?? this.isJailbroken,
      isRooted: isRooted ?? this.isRooted,
      isEmulator: isEmulator ?? this.isEmulator,
      isDevelopmentModeEnabled: isDevelopmentModeEnabled ?? this.isDevelopmentModeEnabled,
      isDebuggingEnabled: isDebuggingEnabled ?? this.isDebuggingEnabled,
      threatLevel: threatLevel ?? this.threatLevel,
      detectedThreats: detectedThreats ?? this.detectedThreats,
    );
  }

  @override
  List<Object?> get props => [
        isJailbroken,
        isRooted,
        isEmulator,
        isDevelopmentModeEnabled,
        isDebuggingEnabled,
        threatLevel,
        detectedThreats,
      ];
}

enum SecurityThreatLevel {
  @JsonValue('none')
  none,
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

extension SecurityThreatLevelExtension on SecurityThreatLevel {
  bool get isSecure => this == SecurityThreatLevel.none;
  bool get requiresAction => index >= SecurityThreatLevel.medium.index;
  bool get shouldBlockApp => index >= SecurityThreatLevel.high.index;
  
  String get displayName {
    switch (this) {
      case SecurityThreatLevel.none:
        return 'Secure';
      case SecurityThreatLevel.low:
        return 'Low Risk';
      case SecurityThreatLevel.medium:
        return 'Medium Risk';
      case SecurityThreatLevel.high:
        return 'High Risk';
      case SecurityThreatLevel.critical:
        return 'Critical Risk';
    }
  }
}