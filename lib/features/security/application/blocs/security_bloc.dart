import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shemanit/shared/application/use_cases/base_use_case.dart';
import 'package:shemanit/features/security/domain/entities/security_status.dart';
import 'package:shemanit/features/security/domain/entities/app_version.dart';
import 'package:shemanit/features/security/domain/usecases/check_security_status.dart';
import 'package:shemanit/features/security/domain/usecases/check_for_updates.dart';

part 'security_event.dart';
part 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc({
    required PerformSecurityAssessment performSecurityAssessment,
    required EvaluateUpdatePolicy evaluateUpdatePolicy,
  })  : _performSecurityAssessment = performSecurityAssessment,
        _evaluateUpdatePolicy = evaluateUpdatePolicy,
        super(const SecurityInitial()) {
    on<CheckSecurityEvent>((event, emit) => _onCheckSecurity(emit));
    on<CheckUpdatesEvent>((event, emit) => _onCheckUpdates(emit));
    on<DismissWarningEvent>((event, emit) => _onDismissWarning(emit));
    on<RetryCheckEvent>((event, emit) => _onRetryCheck(emit));
  }

  final PerformSecurityAssessment _performSecurityAssessment;
  final EvaluateUpdatePolicy _evaluateUpdatePolicy;

  Future<void> _onCheckSecurity(Emitter<SecurityState> emit) async {
    emit(const SecurityLoading());

    final securityResult = await _performSecurityAssessment(const NoParams());
    final updateResult = await _evaluateUpdatePolicy(const NoParams());

    securityResult.fold(
      (failure) {
        // For critical security failures, emit a specific error state
        if (failure.message.contains('CRITICAL SECURITY FAILURE')) {
          emit(SecurityCriticalFailure(failure.message));
        } else {
          emit(SecurityError(failure.message));
        }
      },
      (securityAssessment) {
        updateResult.fold(
          (failure) => emit(SecurityError(failure.message)),
          (updatePolicy) => emit(
            SecurityLoaded(
              securityAssessment: securityAssessment,
              updatePolicy: updatePolicy,
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

    final result = await _evaluateUpdatePolicy(const NoParams());

    result.fold(
      (failure) => emit(
        currentState.copyWith(
          isCheckingUpdates: false,
          updateError: failure.message,
        ),
      ),
      (updatePolicy) => emit(
        currentState.copyWith(
          isCheckingUpdates: false,
          updatePolicy: updatePolicy,
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
    add(const CheckSecurityEvent());
  }
}
