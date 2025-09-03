import 'package:ddd_flutter_app/core/di/injection_container.config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service locator instance
final GetIt sl = GetIt.instance;

/// Initialize dependency injection
@InjectableInit()
Future<void> configureDependencies() async {
  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl
    ..registerSingleton<SharedPreferences>(sharedPreferences)
    ..init();
}

/// Register external dependencies that can't use @injectable
@module
abstract class RegisterModule {
  @singleton
  Dio get dio => Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      );
}
