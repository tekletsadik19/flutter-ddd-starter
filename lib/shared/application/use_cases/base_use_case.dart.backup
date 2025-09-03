import 'package:dartz/dartz.dart';
import 'package:ddd_flutter_app/core/errors/failures.dart';
import 'package:equatable/equatable.dart';

/// Base class for all use cases
abstract class UseCase<Type, Params> {
  /// Execute the use case
  Future<Either<Failure, Type>> call(Params params);
}

/// Base class for use cases that don't require parameters
abstract class NoParamsUseCase<Type> {
  /// Execute the use case
  Future<Either<Failure, Type>> call();
}

/// Base class for use case parameters
abstract class UseCaseParams extends Equatable {
  const UseCaseParams();
}

/// No parameters class for use cases that don't need parameters
class NoParams extends UseCaseParams {
  const NoParams();

  @override
  List<Object?> get props => [];
}
