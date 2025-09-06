import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/application/use_cases/base_use_case.dart';
import '../entities/app_version.dart';
import '../repositories/app_update_repository.dart';

class CheckForUpdates extends NoParamsUseCase<AppVersion> {
  const CheckForUpdates(this._repository);

  final AppUpdateRepository _repository;

  @override
  Future<Either<Failure, AppVersion>> execute() async {
    return await _repository.checkForUpdates();
  }
}