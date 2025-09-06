import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/app_version.dart';
import '../../domain/repositories/app_update_repository.dart';
import '../datasources/app_update_datasource.dart';

class AppUpdateRepositoryImpl implements AppUpdateRepository {
  const AppUpdateRepositoryImpl(this._dataSource);

  final AppUpdateDataSource _dataSource;

  @override
  Future<Either<Failure, AppVersion>> checkForUpdates() async {
    try {
      final result = await _dataSource.checkForUpdates();
      return Right(result.toDomain());
    } catch (e) {
      return Left(ServerFailure('Failed to check for updates: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> downloadUpdate(String url) async {
    try {
      await _dataSource.downloadUpdate(url);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to download update: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> installUpdate() async {
    try {
      // Installation logic would go here
      // For now, this is not implemented as it requires platform-specific code
      throw UnimplementedError('Install update functionality not implemented');
    } catch (e) {
      return Left(ServerFailure('Failed to install update: $e'));
    }
  }
}