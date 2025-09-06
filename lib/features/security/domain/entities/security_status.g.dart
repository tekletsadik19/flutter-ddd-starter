// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityStatusImpl _$$SecurityStatusImplFromJson(Map<String, dynamic> json) =>
    _$SecurityStatusImpl(
      isJailbroken: json['isJailbroken'] as bool,
      isRooted: json['isRooted'] as bool,
      isEmulator: json['isEmulator'] as bool,
      isDevelopmentModeEnabled: json['isDevelopmentModeEnabled'] as bool,
      isDebuggingEnabled: json['isDebuggingEnabled'] as bool,
      threatLevel: $enumDecode(_$SecurityThreatLevelEnumMap, json['threatLevel']),
      detectedThreats: (json['detectedThreats'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$SecurityStatusImplToJson(_$SecurityStatusImpl instance) =>
    <String, dynamic>{
      'isJailbroken': instance.isJailbroken,
      'isRooted': instance.isRooted,
      'isEmulator': instance.isEmulator,
      'isDevelopmentModeEnabled': instance.isDevelopmentModeEnabled,
      'isDebuggingEnabled': instance.isDebuggingEnabled,
      'threatLevel': _$SecurityThreatLevelEnumMap[instance.threatLevel]!,
      'detectedThreats': instance.detectedThreats,
    };

const _$SecurityThreatLevelEnumMap = {
  SecurityThreatLevel.none: 'none',
  SecurityThreatLevel.low: 'low',
  SecurityThreatLevel.medium: 'medium',
  SecurityThreatLevel.high: 'high',
  SecurityThreatLevel.critical: 'critical',
};