import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/application/use_cases/base_use_case.dart';
import '../aggregates/app_update_policy.dart';
import '../repositories/app_update_repository.dart';

class EvaluateUpdatePolicy extends NoParamsUseCase<AppUpdatePolicy> {
  const EvaluateUpdatePolicy(this._repository);

  final AppUpdateRepository _repository;

  @override
  Future<Either<Failure, AppUpdatePolicy>> execute() async {
    return await _repository.getUpdatePolicy();
  }
}