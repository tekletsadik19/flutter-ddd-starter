import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/app_version.dart';

abstract class AppUpdateRepository {
  Future<Either<Failure, AppVersion>> checkForUpdates();
  Future<Either<Failure, void>> downloadUpdate(String url);
  Future<Either<Failure, void>> installUpdate();
}