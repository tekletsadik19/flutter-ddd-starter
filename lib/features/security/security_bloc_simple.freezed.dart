// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_bloc_simple.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SecurityState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)
        secure,
    required TResult Function(String reason) blocked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)?
        secure,
    TResult? Function(String reason)? blocked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)?
        secure,
    TResult Function(String reason)? blocked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Secure value) secure,
    required TResult Function(_Blocked value) blocked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Secure value)? secure,
    TResult? Function(_Blocked value)? blocked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Secure value)? secure,
    TResult Function(_Blocked value)? blocked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityStateCopyWith<$Res> {
  factory $SecurityStateCopyWith(
          SecurityState value, $Res Function(SecurityState) then) =
      _$SecurityStateCopyWithImpl<$Res, SecurityState>;
}

/// @nodoc
class _$SecurityStateCopyWithImpl<$Res, $Val extends SecurityState>
    implements $SecurityStateCopyWith<$Res> {
  _$SecurityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SecurityState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)
        secure,
    required TResult Function(String reason) blocked,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)?
        secure,
    TResult? Function(String reason)? blocked,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)?
        secure,
    TResult Function(String reason)? blocked,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Secure value) secure,
    required TResult Function(_Blocked value) blocked,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Secure value)? secure,
    TResult? Function(_Blocked value)? blocked,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Secure value)? secure,
    TResult Function(_Blocked value)? blocked,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SecurityState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'SecurityState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)
        secure,
    required TResult Function(String reason) blocked,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)?
        secure,
    TResult? Function(String reason)? blocked,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)?
        secure,
    TResult Function(String reason)? blocked,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Secure value) secure,
    required TResult Function(_Blocked value) blocked,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult? Function(_Secure value)? secure,
    TResult? Function(_Blocked value)? blocked,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Secure value)? secure,
    TResult Function(_Blocked value)? blocked,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SecurityState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SecureImplCopyWith<$Res> {
  factory _$$SecureImplCopyWith(
          _$SecureImpl value, $Res Function(_$SecureImpl) then) =
      __$$SecureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DeviceInfo deviceInfo, bool isCompromised, bool isEmulator});
}

/// @nodoc
class __$$SecureImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$SecureImpl>
    implements _$$SecureImplCopyWith<$Res> {
  __$$SecureImplCopyWithImpl(
      _$SecureImpl _value, $Res Function(_$SecureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceInfo = null,
    Object? isCompromised = null,
    Object? isEmulator = null,
  }) {
    return _then(_$SecureImpl(
      deviceInfo: null == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as DeviceInfo,
      isCompromised: null == isCompromised
          ? _value.isCompromised
          : isCompromised // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmulator: null == isEmulator
          ? _value.isEmulator
          : isEmulator // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SecureImpl implements _Secure {
  const _$SecureImpl(
      {required this.deviceInfo,
      required this.isCompromised,
      required this.isEmulator});

  @override
  final DeviceInfo deviceInfo;
  @override
  final bool isCompromised;
  @override
  final bool isEmulator;

  @override
  String toString() {
    return 'SecurityState.secure(deviceInfo: $deviceInfo, isCompromised: $isCompromised, isEmulator: $isEmulator)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecureImpl &&
            (identical(other.deviceInfo, deviceInfo) ||
                other.deviceInfo == deviceInfo) &&
            (identical(other.isCompromised, isCompromised) ||
                other.isCompromised == isCompromised) &&
            (identical(other.isEmulator, isEmulator) ||
                other.isEmulator == isEmulator));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, deviceInfo, isCompromised, isEmulator);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SecureImplCopyWith<_$SecureImpl> get copyWith =>
      __$$SecureImplCopyWithImpl<_$SecureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)
        secure,
    required TResult Function(String reason) blocked,
  }) {
    return secure(deviceInfo, isCompromised, isEmulator);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)?
        secure,
    TResult? Function(String reason)? blocked,
  }) {
    return secure?.call(deviceInfo, isCompromised, isEmulator);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)?
        secure,
    TResult Function(String reason)? blocked,
    required TResult orElse(),
  }) {
    if (secure != null) {
      return secure(deviceInfo, isCompromised, isEmulator);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Secure value) secure,
    required TResult Function(_Blocked value) blocked,
  }) {
    return secure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Secure value)? secure,
    TResult? Function(_Blocked value)? blocked,
  }) {
    return secure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Secure value)? secure,
    TResult Function(_Blocked value)? blocked,
    required TResult orElse(),
  }) {
    if (secure != null) {
      return secure(this);
    }
    return orElse();
  }
}

abstract class _Secure implements SecurityState {
  const factory _Secure(
      {required final DeviceInfo deviceInfo,
      required final bool isCompromised,
      required final bool isEmulator}) = _$SecureImpl;

  DeviceInfo get deviceInfo;
  bool get isCompromised;
  bool get isEmulator;
  @JsonKey(ignore: true)
  _$$SecureImplCopyWith<_$SecureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlockedImplCopyWith<$Res> {
  factory _$$BlockedImplCopyWith(
          _$BlockedImpl value, $Res Function(_$BlockedImpl) then) =
      __$$BlockedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String reason});
}

/// @nodoc
class __$$BlockedImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$BlockedImpl>
    implements _$$BlockedImplCopyWith<$Res> {
  __$$BlockedImplCopyWithImpl(
      _$BlockedImpl _value, $Res Function(_$BlockedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_$BlockedImpl(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BlockedImpl implements _Blocked {
  const _$BlockedImpl({required this.reason});

  @override
  final String reason;

  @override
  String toString() {
    return 'SecurityState.blocked(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockedImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockedImplCopyWith<_$BlockedImpl> get copyWith =>
      __$$BlockedImplCopyWithImpl<_$BlockedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)
        secure,
    required TResult Function(String reason) blocked,
  }) {
    return blocked(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)?
        secure,
    TResult? Function(String reason)? blocked,
  }) {
    return blocked?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DeviceInfo deviceInfo, bool isCompromised, bool isEmulator)?
        secure,
    TResult Function(String reason)? blocked,
    required TResult orElse(),
  }) {
    if (blocked != null) {
      return blocked(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Secure value) secure,
    required TResult Function(_Blocked value) blocked,
  }) {
    return blocked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Secure value)? secure,
    TResult? Function(_Blocked value)? blocked,
  }) {
    return blocked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Secure value)? secure,
    TResult Function(_Blocked value)? blocked,
    required TResult orElse(),
  }) {
    if (blocked != null) {
      return blocked(this);
    }
    return orElse();
  }
}

abstract class _Blocked implements SecurityState {
  const factory _Blocked({required final String reason}) = _$BlockedImpl;

  String get reason;
  @JsonKey(ignore: true)
  _$$BlockedImplCopyWith<_$BlockedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SecurityEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkSecurity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkSecurity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkSecurity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckSecurity value) checkSecurity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckSecurity value)? checkSecurity,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckSecurity value)? checkSecurity,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityEventCopyWith<$Res> {
  factory $SecurityEventCopyWith(
          SecurityEvent value, $Res Function(SecurityEvent) then) =
      _$SecurityEventCopyWithImpl<$Res, SecurityEvent>;
}

/// @nodoc
class _$SecurityEventCopyWithImpl<$Res, $Val extends SecurityEvent>
    implements $SecurityEventCopyWith<$Res> {
  _$SecurityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CheckSecurityImplCopyWith<$Res> {
  factory _$$CheckSecurityImplCopyWith(
          _$CheckSecurityImpl value, $Res Function(_$CheckSecurityImpl) then) =
      __$$CheckSecurityImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckSecurityImplCopyWithImpl<$Res>
    extends _$SecurityEventCopyWithImpl<$Res, _$CheckSecurityImpl>
    implements _$$CheckSecurityImplCopyWith<$Res> {
  __$$CheckSecurityImplCopyWithImpl(
      _$CheckSecurityImpl _value, $Res Function(_$CheckSecurityImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CheckSecurityImpl implements _CheckSecurity {
  const _$CheckSecurityImpl();

  @override
  String toString() {
    return 'SecurityEvent.checkSecurity()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckSecurityImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkSecurity,
  }) {
    return checkSecurity();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkSecurity,
  }) {
    return checkSecurity?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkSecurity,
    required TResult orElse(),
  }) {
    if (checkSecurity != null) {
      return checkSecurity();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckSecurity value) checkSecurity,
  }) {
    return checkSecurity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckSecurity value)? checkSecurity,
  }) {
    return checkSecurity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckSecurity value)? checkSecurity,
    required TResult orElse(),
  }) {
    if (checkSecurity != null) {
      return checkSecurity(this);
    }
    return orElse();
  }
}

abstract class _CheckSecurity implements SecurityEvent {
  const factory _CheckSecurity() = _$CheckSecurityImpl;
}