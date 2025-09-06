import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/app_version.dart';

part 'app_version_model.freezed.dart';
part 'app_version_model.g.dart';

@freezed
class AppVersionModel with _$AppVersionModel {
  const factory AppVersionModel({
    required String currentVersion,
    required String latestVersion,
    required String minimumSupportedVersion,
    required bool forceUpdate,
    required bool recommendUpdate,
    required String? updateMessage,
    required String? downloadUrl,
    required List<String> releaseNotes,
  }) = _AppVersionModel;

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionModelFromJson(json);
}

extension AppVersionModelExtension on AppVersionModel {
  AppVersion toDomain() {
    return AppVersion(
      currentVersion: currentVersion,
      latestVersion: latestVersion,
      minimumSupportedVersion: minimumSupportedVersion,
      forceUpdate: forceUpdate,
      recommendUpdate: recommendUpdate,
      updateMessage: updateMessage,
      downloadUrl: downloadUrl,
      releaseNotes: releaseNotes,
    );
  }
}

extension AppVersionExtension on AppVersion {
  AppVersionModel toModel() {
    return AppVersionModel(
      currentVersion: currentVersion,
      latestVersion: latestVersion,
      minimumSupportedVersion: minimumSupportedVersion,
      forceUpdate: forceUpdate,
      recommendUpdate: recommendUpdate,
      updateMessage: updateMessage,
      downloadUrl: downloadUrl,
      releaseNotes: releaseNotes,
    );
  }
}