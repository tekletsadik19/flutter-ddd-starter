part of 'security_bloc.dart';

abstract class SecurityEvent extends Equatable {
  const SecurityEvent();
}

class CheckSecurityEvent extends SecurityEvent {
  const CheckSecurityEvent();

  @override
  List<Object?> get props => [];
}

class CheckUpdatesEvent extends SecurityEvent {
  const CheckUpdatesEvent();

  @override
  List<Object?> get props => [];
}

class DismissWarningEvent extends SecurityEvent {
  const DismissWarningEvent();

  @override
  List<Object?> get props => [];
}

class RetryCheckEvent extends SecurityEvent {
  const RetryCheckEvent();

  @override
  List<Object?> get props => [];
}
