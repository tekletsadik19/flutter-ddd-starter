import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../shared/application/use_cases/base_use_case.dart';
import '../../domain/entities/security_status.dart';
import '../../domain/entities/app_version.dart';
import '../../domain/usecases/check_security_status.dart';
import '../../domain/usecases/check_for_updates.dart';

part 'security_event.dart';
part 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc({
    required CheckSecurityStatus checkSecurityStatus,
    required CheckForUpdates checkForUpdates,
  })  : _checkSecurityStatus = checkSecurityStatus,
        _checkForUpdates = checkForUpdates,
        super(const SecurityState.initial()) {
    on<SecurityEvent>(
      (event, emit) => event.when(
        checkSecurity: () => _onCheckSecurity(emit),
        checkUpdates: () => _onCheckUpdates(emit),
        dismissWarning: () => _onDismissWarning(emit),
        retryCheck: () => _onRetryCheck(emit),
      ),
    );
  }

  final CheckSecurityStatus _checkSecurityStatus;
  final CheckForUpdates _checkForUpdates;

  Future<void> _onCheckSecurity(Emitter<SecurityState> emit) async {
    emit(const SecurityState.loading());

    final securityResult = await _checkSecurityStatus(const NoParams());
    final updateResult = await _checkForUpdates(const NoParams());

    securityResult.fold(
      (failure) => emit(SecurityState.error(failure.message)),
      (securityStatus) {
        updateResult.fold(
          (failure) => emit(SecurityState.error(failure.message)),
          (appVersion) => emit(
            SecurityState.loaded(
              securityStatus: securityStatus,
              appVersion: appVersion,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onCheckUpdates(Emitter<SecurityState> emit) async {
    if (state is! SecurityLoaded) return;

    final currentState = state as SecurityLoaded;
    emit(currentState.copyWith(isCheckingUpdates: true));

    final result = await _checkForUpdates(const NoParams());

    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isCheckingUpdates: false,
          updateError: failure.message,
        ),
      ),
      (appVersion) => emit(
        currentState.copyWith(
          isCheckingUpdates: false,
          appVersion: appVersion,
          updateError: null,
        ),
      ),
    );
  }

  void _onDismissWarning(Emitter<SecurityState> emit) {
    if (state is SecurityLoaded) {
      final currentState = state as SecurityLoaded;
      emit(currentState.copyWith(warningDismissed: true));
    }
  }

  void _onRetryCheck(Emitter<SecurityState> emit) {
    add(const SecurityEvent.checkSecurity());
  }
}