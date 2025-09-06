import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../application/blocs/security_bloc.dart';
import '../domain/repositories/app_update_repository.dart';
import '../domain/repositories/security_repository.dart';
import '../domain/usecases/check_for_updates.dart';
import '../domain/usecases/check_security_status.dart';
import '../infrastructure/datasources/app_update_datasource.dart';
import '../infrastructure/datasources/security_datasource.dart';
import '../infrastructure/repositories/app_update_repository_impl.dart';
import '../infrastructure/repositories/security_repository_impl.dart';

@module
abstract class SecurityModule {
  @preResolve
  @singleton
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();

  @singleton
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();

  // Data Sources
  @LazySingleton(as: SecurityDataSource)
  SecurityDataSourceImpl securityDataSource(DeviceInfoPlugin deviceInfo) =>
      SecurityDataSourceImpl(deviceInfo);

  @LazySingleton(as: AppUpdateDataSource)
  AppUpdateDataSourceImpl appUpdateDataSource(Dio dio, PackageInfo packageInfo) =>
      AppUpdateDataSourceImpl(dio, packageInfo);

  // Repositories
  @LazySingleton(as: SecurityRepository)
  SecurityRepositoryImpl securityRepository(SecurityDataSource dataSource) =>
      SecurityRepositoryImpl(dataSource);

  @LazySingleton(as: AppUpdateRepository)
  AppUpdateRepositoryImpl appUpdateRepository(AppUpdateDataSource dataSource) =>
      AppUpdateRepositoryImpl(dataSource);

  // Use Cases
  @lazySingleton
  CheckSecurityStatus checkSecurityStatus(SecurityRepository repository) =>
      CheckSecurityStatus(repository);

  @lazySingleton
  CheckForUpdates checkForUpdates(AppUpdateRepository repository) =>
      CheckForUpdates(repository);

  // BLoC
  @factory
  SecurityBloc securityBloc(
    CheckSecurityStatus checkSecurityStatus,
    CheckForUpdates checkForUpdates,
  ) =>
      SecurityBloc(
        checkSecurityStatus: checkSecurityStatus,
        checkForUpdates: checkForUpdates,
      );
}