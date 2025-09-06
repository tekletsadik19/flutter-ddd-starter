part of 'security_bloc.dart';

abstract class SecurityState extends Equatable {
  const SecurityState();
}

class SecurityInitial extends SecurityState {
  const SecurityInitial();
  
  @override
  List<Object?> get props => [];
}

class SecurityLoading extends SecurityState {
  const SecurityLoading();
  
  @override
  List<Object?> get props => [];
}

class SecurityLoaded extends SecurityState {
  const SecurityLoaded({
    required this.securityAssessment,
    required this.updatePolicy,
    this.warningDismissed = false,
    this.isCheckingUpdates = false,
    this.updateError,
  });

  final SecurityAssessment securityAssessment;
  final AppUpdatePolicy updatePolicy;
  final bool warningDismissed;
  final bool isCheckingUpdates;
  final String? updateError;

  SecurityLoaded copyWith({
    SecurityAssessment? securityAssessment,
    AppUpdatePolicy? updatePolicy,
    bool? warningDismissed,
    bool? isCheckingUpdates,
    String? updateError,
  }) {
    return SecurityLoaded(
      securityAssessment: securityAssessment ?? this.securityAssessment,
      updatePolicy: updatePolicy ?? this.updatePolicy,
      warningDismissed: warningDismissed ?? this.warningDismissed,
      isCheckingUpdates: isCheckingUpdates ?? this.isCheckingUpdates,
      updateError: updateError ?? this.updateError,
    );
  }
  
  @override
  List<Object?> get props => [
    securityAssessment,
    updatePolicy,
    warningDismissed,
    isCheckingUpdates,
    updateError,
  ];
}

class SecurityError extends SecurityState {
  const SecurityError(this.message);
  
  final String message;
  
  @override
  List<Object?> get props => [message];
}

class SecurityCriticalFailure extends SecurityState {
  const SecurityCriticalFailure(this.message);
  
  final String message;
  
  @override
  List<Object?> get props => [message];
}