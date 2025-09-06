import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../aggregates/security_assessment.dart';
import '../value_objects/device_fingerprint.dart';

abstract class SecurityRepository {
  Future<Either<Failure, SecurityAssessment>> performSecurityAssessment();
  Future<Either<Failure, DeviceFingerprint>> getDeviceFingerprint();
  Future<Either<Failure, void>> reportSecurityViolation(SecurityAssessment assessment);
}