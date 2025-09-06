import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/application/use_cases/base_use_case.dart';
import '../aggregates/security_assessment.dart';
import '../repositories/security_repository.dart';

class PerformSecurityAssessment extends NoParamsUseCase<SecurityAssessment> {
  const PerformSecurityAssessment(this._repository);

  final SecurityRepository _repository;

  @override
  Future<Either<Failure, SecurityAssessment>> execute() async {
    return await _repository.performSecurityAssessment();
  }
}