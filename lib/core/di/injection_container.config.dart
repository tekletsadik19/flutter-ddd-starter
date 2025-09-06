// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:shemanit/core/cache/cache_service.dart' as _i105;
import 'package:shemanit/core/di/injection_container.dart' as _i67;
import 'package:shemanit/core/theme/theme_cubit.dart' as _i819;
import 'package:shemanit/features/counter/application/use_cases/decrement_counter_use_case.dart'
    as _i112;
import 'package:shemanit/features/counter/application/use_cases/get_counter_use_case.dart'
    as _i820;
import 'package:shemanit/features/counter/application/use_cases/increment_counter_use_case.dart'
    as _i730;
import 'package:shemanit/features/counter/application/use_cases/reset_counter_use_case.dart'
    as _i387;
import 'package:shemanit/features/counter/domain/repositories/counter_repository.dart'
    as _i79;
import 'package:shemanit/features/counter/domain/services/counter_domain_service.dart'
    as _i345;
import 'package:shemanit/features/counter/infrastructure/datasources/counter_local_data_source.dart'
    as _i322;
import 'package:shemanit/features/counter/infrastructure/repositories/counter_repository_impl.dart'
    as _i476;
import 'package:shemanit/features/counter/presentation/cubits/counter_cubit.dart'
    as _i148;
import 'package:shemanit/shared/infrastructure/caching/cache_manager.dart'
    as _i93;
import 'package:shemanit/shared/infrastructure/monitoring/analytics_service.dart'
    as _i63;
import 'package:shemanit/shared/infrastructure/monitoring/performance_monitor.dart'
    as _i363;
import 'package:shemanit/shared/infrastructure/network/api_client.dart'
    as _i491;
import 'package:shemanit/shared/infrastructure/security/encryption_service.dart'
    as _i649;
import 'package:shemanit/shared/infrastructure/security/secure_storage.dart'
    as _i24;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i345.CounterDomainService>(
        () => _i345.CounterDomainService());
    gh.singleton<_i649.EncryptionService>(() => _i649.EncryptionService());
    gh.singleton<_i649.HiveEncryptionManager>(
        () => _i649.HiveEncryptionManager());
    gh.factory<_i819.ThemeCubit>(
        () => _i819.ThemeCubit(gh<_i460.SharedPreferences>()));
    gh.singleton<_i105.CacheService>(() => _i105.HiveCacheService());
    gh.singleton<_i491.ApiClient>(() => _i491.ApiClient(gh<_i361.Dio>()));
    gh.singleton<_i63.AnalyticsService>(() => _i63.AnalyticsServiceImpl());
    gh.singleton<_i93.CacheManager>(
        () => _i93.CacheManagerImpl(gh<_i649.HiveEncryptionManager>()));
    gh.singleton<_i24.SecureStorage>(
        () => _i24.SecureStorageImpl(gh<_i649.HiveEncryptionManager>()));
    gh.singleton<_i322.CounterLocalDataSource>(() =>
        _i322.CounterLocalDataSourceImpl(gh<_i649.HiveEncryptionManager>()));
    gh.singleton<_i79.CounterRepository>(
        () => _i476.CounterRepositoryImpl(gh<_i322.CounterLocalDataSource>()));
    gh.singleton<_i820.GetCounterUseCase>(
        () => _i820.GetCounterUseCase(gh<_i79.CounterRepository>()));
    gh.singleton<_i387.ResetCounterUseCase>(
        () => _i387.ResetCounterUseCase(gh<_i79.CounterRepository>()));
    gh.singleton<_i730.IncrementCounterUseCase>(
        () => _i730.IncrementCounterUseCase(
              gh<_i79.CounterRepository>(),
              gh<_i345.CounterDomainService>(),
            ));
    gh.singleton<_i112.DecrementCounterUseCase>(
        () => _i112.DecrementCounterUseCase(
              gh<_i79.CounterRepository>(),
              gh<_i345.CounterDomainService>(),
            ));
    gh.singleton<_i363.PerformanceMonitor>(
        () => _i363.PerformanceMonitorImpl(gh<_i63.AnalyticsService>()));
    gh.singleton<_i148.CounterCubit>(() => _i148.CounterCubit(
          gh<_i820.GetCounterUseCase>(),
          gh<_i730.IncrementCounterUseCase>(),
          gh<_i112.DecrementCounterUseCase>(),
          gh<_i387.ResetCounterUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i67.RegisterModule {}
