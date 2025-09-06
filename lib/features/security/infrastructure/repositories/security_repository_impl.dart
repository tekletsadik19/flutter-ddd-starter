import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/security_status.dart';
import '../../domain/repositories/security_repository.dart';
import '../datasources/security_datasource.dart';

class SecurityRepositoryImpl implements SecurityRepository {
  const SecurityRepositoryImpl(this._dataSource);

  final SecurityDataSource _dataSource;

  @override
  Future<Either<Failure, SecurityStatus>> checkSecurityStatus() async {
    try {
      final result = await _dataSource.checkSecurityStatus();
      return Right(result.toDomain());
    } catch (e) {
      return Left(ServerFailure('Failed to check security status: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isJailbroken() async {
    try {
      final result = await _dataSource.isJailbroken();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Failed to check jailbreak status: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isRooted() async {
    try {
      final result = await _dataSource.isRooted();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Failed to check root status: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isEmulator() async {
    try {
      final result = await _dataSource.isEmulator();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Failed to check emulator status: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isDevelopmentModeEnabled() async {
    try {
      final result = await _dataSource.isDevelopmentModeEnabled();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Failed to check development mode status: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isDebuggingEnabled() async {
    try {
      final result = await _dataSource.isDebuggingEnabled();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Failed to check debugging status: $e'));
    }
  }
}