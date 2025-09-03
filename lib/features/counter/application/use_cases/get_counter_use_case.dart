import 'package:dartz/dartz.dart';
import 'package:ddd_flutter_app/core/errors/failures.dart';
import 'package:ddd_flutter_app/core/utils/logger.dart';
import 'package:ddd_flutter_app/features/counter/domain/entities/counter_entity.dart';
import 'package:ddd_flutter_app/features/counter/domain/repositories/counter_repository.dart';
import 'package:ddd_flutter_app/shared/application/use_cases/base_use_case.dart';
import 'package:injectable/injectable.dart';

/// Use case for getting current counter
@singleton
class GetCounterUseCase implements UseCase<CounterEntity, NoParams> {
  const GetCounterUseCase(this._counterRepository);

  final CounterRepository _counterRepository;

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    Logger.info('Executing GetCounterUseCase');

    try {
      final result = await _counterRepository.getCurrentCounter();

      return result.fold(
        (failure) {
          Logger.warning('Failed to get counter: ${failure.message}');
          return Left(failure);
        },
        (counter) {
          Logger.info('Counter retrieved successfully: ${counter.value}');
          return Right(counter);
        },
      );
    } catch (e, stackTrace) {
      Logger.error('Error in GetCounterUseCase', e, stackTrace);
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
