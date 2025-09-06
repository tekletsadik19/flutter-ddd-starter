import 'package:equatable/equatable.dart';

class AppVersion extends Equatable {
  const AppVersion({
    required this.currentVersion,
    required this.latestVersion,
    required this.minimumSupportedVersion,
    required this.forceUpdate,
    required this.recommendUpdate,
    required this.updateMessage,
    required this.downloadUrl,
    required this.releaseNotes,
  });

  final String currentVersion;
  final String latestVersion;
  final String minimumSupportedVersion;
  final bool forceUpdate;
  final bool recommendUpdate;
  final String? updateMessage;
  final String? downloadUrl;
  final List<String> releaseNotes;

  factory AppVersion.fromJson(Map<String, dynamic> json) {
    return AppVersion(
      currentVersion: json['currentVersion'] as String,
      latestVersion: json['latestVersion'] as String,
      minimumSupportedVersion: json['minimumSupportedVersion'] as String,
      forceUpdate: json['forceUpdate'] as bool,
      recommendUpdate: json['recommendUpdate'] as bool,
      updateMessage: json['updateMessage'] as String?,
      downloadUrl: json['downloadUrl'] as String?,
      releaseNotes: List<String>.from(json['releaseNotes'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentVersion': currentVersion,
      'latestVersion': latestVersion,
      'minimumSupportedVersion': minimumSupportedVersion,
      'forceUpdate': forceUpdate,
      'recommendUpdate': recommendUpdate,
      'updateMessage': updateMessage,
      'downloadUrl': downloadUrl,
      'releaseNotes': releaseNotes,
    };
  }

  AppVersion copyWith({
    String? currentVersion,
    String? latestVersion,
    String? minimumSupportedVersion,
    bool? forceUpdate,
    bool? recommendUpdate,
    String? updateMessage,
    String? downloadUrl,
    List<String>? releaseNotes,
  }) {
    return AppVersion(
      currentVersion: currentVersion ?? this.currentVersion,
      latestVersion: latestVersion ?? this.latestVersion,
      minimumSupportedVersion: minimumSupportedVersion ?? this.minimumSupportedVersion,
      forceUpdate: forceUpdate ?? this.forceUpdate,
      recommendUpdate: recommendUpdate ?? this.recommendUpdate,
      updateMessage: updateMessage ?? this.updateMessage,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      releaseNotes: releaseNotes ?? this.releaseNotes,
    );
  }

  @override
  List<Object?> get props => [
        currentVersion,
        latestVersion,
        minimumSupportedVersion,
        forceUpdate,
        recommendUpdate,
        updateMessage,
        downloadUrl,
        releaseNotes,
      ];
}

extension AppVersionExtension on AppVersion {
  bool get needsUpdate => _compareVersions(currentVersion, latestVersion) < 0;
  
  bool get isSupported => 
      _compareVersions(currentVersion, minimumSupportedVersion) >= 0;
  
  bool get mustUpdate => forceUpdate || !isSupported;
  
  int _compareVersions(String version1, String version2) {
    final v1Parts = version1.split('.').map(int.parse).toList();
    final v2Parts = version2.split('.').map(int.parse).toList();
    
    final maxLength = v1Parts.length > v2Parts.length 
        ? v1Parts.length 
        : v2Parts.length;
    
    for (int i = 0; i < maxLength; i++) {
      final v1Part = i < v1Parts.length ? v1Parts[i] : 0;
      final v2Part = i < v2Parts.length ? v2Parts[i] : 0;
      
      if (v1Part < v2Part) return -1;
      if (v1Part > v2Part) return 1;
    }
    
    return 0;
  }
}