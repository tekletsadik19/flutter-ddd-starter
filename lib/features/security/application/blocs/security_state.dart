part of 'security_bloc.dart';

@freezed
class SecurityState with _$SecurityState {
  const factory SecurityState.initial() = SecurityInitial;
  const factory SecurityState.loading() = SecurityLoading;
  const factory SecurityState.loaded({
    required SecurityStatus securityStatus,
    required AppVersion appVersion,
    @Default(false) bool warningDismissed,
    @Default(false) bool isCheckingUpdates,
    String? updateError,
  }) = SecurityLoaded;
  const factory SecurityState.error(String message) = SecurityError;
}