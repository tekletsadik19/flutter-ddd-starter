import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'security_service.dart';

part 'security_bloc_simple.freezed.dart';

/// Simple security state
@freezed
class SecurityState with _$SecurityState {
  const factory SecurityState.initial() = _Initial;
  const factory SecurityState.loading() = _Loading;
  const factory SecurityState.secure({
    required DeviceInfo deviceInfo,
    required bool isCompromised,
    required bool isEmulator,
  }) = _Secure;
  const factory SecurityState.blocked({
    required String reason,
  }) = _Blocked;
}

/// Simple security events
@freezed
class SecurityEvent with _$SecurityEvent {
  const factory SecurityEvent.checkSecurity() = _CheckSecurity;
}

/// Simplified security bloc
class SimpleSecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SimpleSecurityBloc() : super(const SecurityState.initial()) {
    on<SecurityEvent>(_onCheckSecurity);
  }
  
  Future<void> _onCheckSecurity(
    SecurityEvent event,
    Emitter<SecurityState> emit,
  ) async {
    emit(const SecurityState.loading());
    
    try {
      final security = SecurityService.instance;
      final deviceInfo = await security.getDeviceInfo();
      final isCompromised = await security.isDeviceCompromised();
      final isEmulator = await security.isEmulator();
      final shouldAllow = await security.shouldAllowAppAccess();
      
      if (shouldAllow) {
        emit(SecurityState.secure(
          deviceInfo: deviceInfo,
          isCompromised: isCompromised,
          isEmulator: isEmulator,
        ));
      } else {
        emit(const SecurityState.blocked(
          reason: 'App blocked due to security concerns',
        ));
      }
    } catch (e) {
      // Graceful fallback - allow access on error
      emit(const SecurityState.secure(
        deviceInfo: DeviceInfo(
          platform: 'Unknown',
          model: 'Unknown',
          osVersion: 'Unknown',
          appVersion: '1.0.0',
          isPhysical: true,
        ),
        isCompromised: false,
        isEmulator: false,
      ));
    }
  }
}