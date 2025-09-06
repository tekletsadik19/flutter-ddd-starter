import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/security_status.dart';

abstract class SecurityRepository {
  Future<Either<Failure, SecurityStatus>> checkSecurityStatus();
  Future<Either<Failure, bool>> isJailbroken();
  Future<Either<Failure, bool>> isRooted();
  Future<Either<Failure, bool>> isEmulator();
  Future<Either<Failure, bool>> isDevelopmentModeEnabled();
  Future<Either<Failure, bool>> isDebuggingEnabled();
}