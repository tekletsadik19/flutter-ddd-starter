import 'package:dartz/dartz.dart';
import 'package:ddd_flutter_app/core/errors/failures.dart';
import 'package:ddd_flutter_app/features/counter/domain/entities/counter_entity.dart';
import 'package:ddd_flutter_app/shared/domain/repositories/base_repository.dart';

/// Counter repository interface
abstract class CounterRepository extends BaseRepository<CounterEntity, String> {
  /// Get the current counter
  Future<Either<Failure, CounterEntity>> getCurrentCounter();

  /// Save counter state
  Future<Either<Failure, CounterEntity>> saveCounter(CounterEntity counter);

  /// Reset counter to initial state
  Future<Either<Failure, CounterEntity>> resetCounter(String counterId);

  /// Get counter history
  Future<Either<Failure, List<CounterEntity>>> getCounterHistory({
    int limit = 10,
  });
}
