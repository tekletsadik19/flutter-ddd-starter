import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../aggregates/app_update_policy.dart';
import '../value_objects/app_version.dart';

abstract class AppUpdateRepository {
  Future<Either<Failure, AppUpdatePolicy>> getUpdatePolicy();
  Future<Either<Failure, AppVersion>> getCurrentAppVersion();
  Future<Either<Failure, void>> initiateUpdate(String downloadUrl);
}