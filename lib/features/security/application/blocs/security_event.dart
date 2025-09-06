part of 'security_bloc.dart';

@freezed
class SecurityEvent with _$SecurityEvent {
  const factory SecurityEvent.checkSecurity() = CheckSecurityEvent;
  const factory SecurityEvent.checkUpdates() = CheckUpdatesEvent;
  const factory SecurityEvent.dismissWarning() = DismissWarningEvent;
  const factory SecurityEvent.retryCheck() = RetryCheckEvent;
}