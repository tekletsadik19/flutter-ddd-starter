import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/application/use_cases/base_use_case.dart';
import '../entities/security_status.dart';
import '../repositories/security_repository.dart';

class CheckSecurityStatus extends NoParamsUseCase<SecurityStatus> {
  const CheckSecurityStatus(this._repository);

  final SecurityRepository _repository;

  @override
  Future<Either<Failure, SecurityStatus>> execute() async {
    return await _repository.checkSecurityStatus();
  }
}