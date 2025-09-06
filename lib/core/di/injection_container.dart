import 'package:shemanit/core/di/injection_container.config.dart';
import 'package:shemanit/shared/infrastructure/security/encryption_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

/// Service locator instance
final GetIt sl = GetIt.instance;

/// Initialize dependency injection
@InjectableInit()
Future<void> configureDependencies() async {
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize and register encryption manager
  final encryptionManager = HiveEncryptionManager();
  encryptionManager.initialize();
  sl.registerSingleton<HiveEncryptionManager>(encryptionManager);
  
  // Initialize dependency injection
  sl.init();
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

