// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ddd_flutter_app/core/di/injection_container.dart' as _i382;
import 'package:ddd_flutter_app/features/counter/application/use_cases/decrement_counter_use_case.dart'
    as _i234;
import 'package:ddd_flutter_app/features/counter/application/use_cases/get_counter_use_case.dart'
    as _i851;
import 'package:ddd_flutter_app/features/counter/application/use_cases/increment_counter_use_case.dart'
    as _i654;
import 'package:ddd_flutter_app/features/counter/application/use_cases/reset_counter_use_case.dart'
    as _i172;
import 'package:ddd_flutter_app/features/counter/domain/repositories/counter_repository.dart'
    as _i547;
import 'package:ddd_flutter_app/features/counter/domain/services/counter_domain_service.dart'
    as _i839;
import 'package:ddd_flutter_app/features/counter/infrastructure/datasources/counter_local_data_source.dart'
    as _i820;
import 'package:ddd_flutter_app/features/counter/infrastructure/repositories/counter_repository_impl.dart'
    as _i239;
import 'package:ddd_flutter_app/features/counter/presentation/cubits/counter_cubit.dart'
    as _i722;
import 'package:ddd_flutter_app/shared/infrastructure/caching/cache_manager.dart'
    as _i1040;
import 'package:ddd_flutter_app/shared/infrastructure/monitoring/analytics_service.dart'
    as _i21;
import 'package:ddd_flutter_app/shared/infrastructure/monitoring/performance_monitor.dart'
    as _i1051;
import 'package:ddd_flutter_app/shared/infrastructure/network/api_client.dart'
    as _i700;
import 'package:ddd_flutter_app/shared/infrastructure/security/secure_storage.dart'
    as _i862;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i839.CounterDomainService>(
        () => _i839.CounterDomainService());
    gh.singleton<_i820.CounterLocalDataSource>(
        () => _i820.CounterLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.singleton<_i1040.CacheManager>(
        () => _i1040.CacheManagerImpl(gh<_i460.SharedPreferences>()));
    gh.singleton<_i862.SecureStorage>(
        () => _i862.SecureStorageImpl(gh<_i460.SharedPreferences>()));
    gh.singleton<_i700.ApiClient>(() => _i700.ApiClient(gh<_i361.Dio>()));
    gh.singleton<_i21.AnalyticsService>(() => _i21.AnalyticsServiceImpl());
    gh.singleton<_i547.CounterRepository>(
        () => _i239.CounterRepositoryImpl(gh<_i820.CounterLocalDataSource>()));
    gh.singleton<_i851.GetCounterUseCase>(
        () => _i851.GetCounterUseCase(gh<_i547.CounterRepository>()));
    gh.singleton<_i172.ResetCounterUseCase>(
        () => _i172.ResetCounterUseCase(gh<_i547.CounterRepository>()));
    gh.singleton<_i1051.PerformanceMonitor>(
        () => _i1051.PerformanceMonitorImpl(gh<_i21.AnalyticsService>()));
    gh.singleton<_i654.IncrementCounterUseCase>(
        () => _i654.IncrementCounterUseCase(
              gh<_i547.CounterRepository>(),
              gh<_i839.CounterDomainService>(),
            ));
    gh.singleton<_i234.DecrementCounterUseCase>(
        () => _i234.DecrementCounterUseCase(
              gh<_i547.CounterRepository>(),
              gh<_i839.CounterDomainService>(),
            ));
    gh.singleton<_i722.CounterCubit>(() => _i722.CounterCubit(
          gh<_i851.GetCounterUseCase>(),
          gh<_i654.IncrementCounterUseCase>(),
          gh<_i234.DecrementCounterUseCase>(),
          gh<_i172.ResetCounterUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i382.RegisterModule {}
