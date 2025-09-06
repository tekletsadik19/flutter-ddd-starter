import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../application/blocs/security_bloc.dart';
import '../domain/repositories/app_update_repository.dart';
import '../domain/repositories/security_repository.dart';
import '../domain/services/app_update_service.dart';
import '../domain/services/security_assessment_service.dart';
import '../domain/usecases/check_for_updates.dart';
import '../domain/usecases/check_security_status.dart';
import '../infrastructure/repositories/app_update_repository_impl.dart';
import '../infrastructure/repositories/security_repository_impl.dart';
import '../infrastructure/services/app_version_service.dart';
import '../infrastructure/services/device_fingerprint_service.dart';
import '../infrastructure/services/platform_security_detection_service.dart';

@module
abstract class SecurityModule {
  @preResolve
  @singleton
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();

  @singleton
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();

  // Infrastructure Services
  @LazySingleton(as: ISecurityDetectionService)
  PlatformSecurityDetectionService securityDetectionService(DeviceInfoPlugin deviceInfo) =>
      PlatformSecurityDetectionService(deviceInfo);

  @LazySingleton(as: IAppVersionRepository)
  AppVersionService appVersionService(Dio dio, PackageInfo packageInfo) =>
      AppVersionService(dio, packageInfo);

  @lazySingleton
  DeviceFingerprintService deviceFingerprintService(
    DeviceInfoPlugin deviceInfo,
    PackageInfo packageInfo,
  ) =>
      DeviceFingerprintService(deviceInfo, packageInfo);

  // Domain Services
  @lazySingleton
  SecurityAssessmentService securityAssessmentService(
    ISecurityDetectionService detectionService,
  ) =>
      SecurityAssessmentService(detectionService);

  @lazySingleton
  AppUpdateService appUpdateService(IAppVersionRepository versionRepository) =>
      AppUpdateService(versionRepository);

  // Repositories
  @LazySingleton(as: SecurityRepository)
  SecurityRepositoryImpl securityRepository(
    SecurityAssessmentService assessmentService,
    DeviceFingerprintService fingerprintService,
  ) =>
      SecurityRepositoryImpl(assessmentService, fingerprintService);

  @LazySingleton(as: AppUpdateRepository)
  AppUpdateRepositoryImpl appUpdateRepository(AppUpdateService updateService) =>
      AppUpdateRepositoryImpl(updateService);

  // Use Cases
  @lazySingleton
  PerformSecurityAssessment performSecurityAssessment(SecurityRepository repository) =>
      PerformSecurityAssessment(repository);

  @lazySingleton
  EvaluateUpdatePolicy evaluateUpdatePolicy(AppUpdateRepository repository) =>
      EvaluateUpdatePolicy(repository);

  // BLoC
  @factory
  SecurityBloc securityBloc(
    PerformSecurityAssessment performSecurityAssessment,
    EvaluateUpdatePolicy evaluateUpdatePolicy,
  ) =>
      SecurityBloc(
        performSecurityAssessment: performSecurityAssessment,
        evaluateUpdatePolicy: evaluateUpdatePolicy,
      );
}