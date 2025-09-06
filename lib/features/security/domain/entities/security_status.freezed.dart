// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SecurityStatus _$SecurityStatusFromJson(Map<String, dynamic> json) {
  return _SecurityStatus.fromJson(json);
}

/// @nodoc
mixin _$SecurityStatus {
  bool get isJailbroken => throw _privateConstructorUsedError;
  bool get isRooted => throw _privateConstructorUsedError;
  bool get isEmulator => throw _privateConstructorUsedError;
  bool get isDevelopmentModeEnabled => throw _privateConstructorUsedError;
  bool get isDebuggingEnabled => throw _privateConstructorUsedError;
  SecurityThreatLevel get threatLevel => throw _privateConstructorUsedError;
  List<String> get detectedThreats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SecurityStatusCopyWith<SecurityStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityStatusCopyWith<$Res> {
  factory $SecurityStatusCopyWith(
          SecurityStatus value, $Res Function(SecurityStatus) then) =
      _$SecurityStatusCopyWithImpl<$Res, SecurityStatus>;
  @useResult
  $Res call(
      {bool isJailbroken,
      bool isRooted,
      bool isEmulator,
      bool isDevelopmentModeEnabled,
      bool isDebuggingEnabled,
      SecurityThreatLevel threatLevel,
      List<String> detectedThreats});
}

/// @nodoc
class _$SecurityStatusCopyWithImpl<$Res, $Val extends SecurityStatus>
    implements $SecurityStatusCopyWith<$Res> {
  _$SecurityStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isJailbroken = null,
    Object? isRooted = null,
    Object? isEmulator = null,
    Object? isDevelopmentModeEnabled = null,
    Object? isDebuggingEnabled = null,
    Object? threatLevel = null,
    Object? detectedThreats = null,
  }) {
    return _then(_value.copyWith(
      isJailbroken: null == isJailbroken
          ? _value.isJailbroken
          : isJailbroken // ignore: cast_nullable_to_non_nullable
              as bool,
      isRooted: null == isRooted
          ? _value.isRooted
          : isRooted // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmulator: null == isEmulator
          ? _value.isEmulator
          : isEmulator // ignore: cast_nullable_to_non_nullable
              as bool,
      isDevelopmentModeEnabled: null == isDevelopmentModeEnabled
          ? _value.isDevelopmentModeEnabled
          : isDevelopmentModeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isDebuggingEnabled: null == isDebuggingEnabled
          ? _value.isDebuggingEnabled
          : isDebuggingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      threatLevel: null == threatLevel
          ? _value.threatLevel
          : threatLevel // ignore: cast_nullable_to_non_nullable
              as SecurityThreatLevel,
      detectedThreats: null == detectedThreats
          ? _value.detectedThreats
          : detectedThreats // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SecurityStatusImplCopyWith<$Res>
    implements $SecurityStatusCopyWith<$Res> {
  factory _$$SecurityStatusImplCopyWith(_$SecurityStatusImpl value,
          $Res Function(_$SecurityStatusImpl) then) =
      __$$SecurityStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isJailbroken,
      bool isRooted,
      bool isEmulator,
      bool isDevelopmentModeEnabled,
      bool isDebuggingEnabled,
      SecurityThreatLevel threatLevel,
      List<String> detectedThreats});
}

/// @nodoc
class __$$SecurityStatusImplCopyWithImpl<$Res>
    extends _$SecurityStatusCopyWithImpl<$Res, _$SecurityStatusImpl>
    implements _$$SecurityStatusImplCopyWith<$Res> {
  __$$SecurityStatusImplCopyWithImpl(
      _$SecurityStatusImpl _value, $Res Function(_$SecurityStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isJailbroken = null,
    Object? isRooted = null,
    Object? isEmulator = null,
    Object? isDevelopmentModeEnabled = null,
    Object? isDebuggingEnabled = null,
    Object? threatLevel = null,
    Object? detectedThreats = null,
  }) {
    return _then(_$SecurityStatusImpl(
      isJailbroken: null == isJailbroken
          ? _value.isJailbroken
          : isJailbroken // ignore: cast_nullable_to_non_nullable
              as bool,
      isRooted: null == isRooted
          ? _value.isRooted
          : isRooted // ignore: cast_nullable_to_non_nullable
              as bool,
      isEmulator: null == isEmulator
          ? _value.isEmulator
          : isEmulator // ignore: cast_nullable_to_non_nullable
              as bool,
      isDevelopmentModeEnabled: null == isDevelopmentModeEnabled
          ? _value.isDevelopmentModeEnabled
          : isDevelopmentModeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isDebuggingEnabled: null == isDebuggingEnabled
          ? _value.isDebuggingEnabled
          : isDebuggingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      threatLevel: null == threatLevel
          ? _value.threatLevel
          : threatLevel // ignore: cast_nullable_to_non_nullable
              as SecurityThreatLevel,
      detectedThreats: null == detectedThreats
          ? _value._detectedThreats
          : detectedThreats // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecurityStatusImpl implements _SecurityStatus {
  const _$SecurityStatusImpl(
      {required this.isJailbroken,
      required this.isRooted,
      required this.isEmulator,
      required this.isDevelopmentModeEnabled,
      required this.isDebuggingEnabled,
      required this.threatLevel,
      required final List<String> detectedThreats})
      : _detectedThreats = detectedThreats;

  factory _$SecurityStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecurityStatusImplFromJson(json);

  @override
  final bool isJailbroken;
  @override
  final bool isRooted;
  @override
  final bool isEmulator;
  @override
  final bool isDevelopmentModeEnabled;
  @override
  final bool isDebuggingEnabled;
  @override
  final SecurityThreatLevel threatLevel;
  final List<String> _detectedThreats;
  @override
  List<String> get detectedThreats {
    if (_detectedThreats is EqualUnmodifiableListView) return _detectedThreats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_detectedThreats);
  }

  @override
  String toString() {
    return 'SecurityStatus(isJailbroken: $isJailbroken, isRooted: $isRooted, isEmulator: $isEmulator, isDevelopmentModeEnabled: $isDevelopmentModeEnabled, isDebuggingEnabled: $isDebuggingEnabled, threatLevel: $threatLevel, detectedThreats: $detectedThreats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityStatusImpl &&
            (identical(other.isJailbroken, isJailbroken) ||
                other.isJailbroken == isJailbroken) &&
            (identical(other.isRooted, isRooted) ||
                other.isRooted == isRooted) &&
            (identical(other.isEmulator, isEmulator) ||
                other.isEmulator == isEmulator) &&
            (identical(other.isDevelopmentModeEnabled, isDevelopmentModeEnabled) ||
                other.isDevelopmentModeEnabled == isDevelopmentModeEnabled) &&
            (identical(other.isDebuggingEnabled, isDebuggingEnabled) ||
                other.isDebuggingEnabled == isDebuggingEnabled) &&
            (identical(other.threatLevel, threatLevel) ||
                other.threatLevel == threatLevel) &&
            const DeepCollectionEquality()
                .equals(other._detectedThreats, _detectedThreats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isJailbroken,
      isRooted,
      isEmulator,
      isDevelopmentModeEnabled,
      isDebuggingEnabled,
      threatLevel,
      const DeepCollectionEquality().hash(_detectedThreats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityStatusImplCopyWith<_$SecurityStatusImpl> get copyWith =>
      __$$SecurityStatusImplCopyWithImpl<_$SecurityStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecurityStatusImplToJson(
      this,
    );
  }
}

abstract class _SecurityStatus implements SecurityStatus {
  const factory _SecurityStatus(
      {required final bool isJailbroken,
      required final bool isRooted,
      required final bool isEmulator,
      required final bool isDevelopmentModeEnabled,
      required final bool isDebuggingEnabled,
      required final SecurityThreatLevel threatLevel,
      required final List<String> detectedThreats}) = _$SecurityStatusImpl;

  factory _SecurityStatus.fromJson(Map<String, dynamic> json) =
      _$SecurityStatusImpl.fromJson;

  @override
  bool get isJailbroken;
  @override
  bool get isRooted;
  @override
  bool get isEmulator;
  @override
  bool get isDevelopmentModeEnabled;
  @override
  bool get isDebuggingEnabled;
  @override
  SecurityThreatLevel get threatLevel;
  @override
  List<String> get detectedThreats;
  @override
  @JsonKey(ignore: true)
  _$$SecurityStatusImplCopyWith<_$SecurityStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}