// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notification_action_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NotificationActionStateTearOff {
  const _$NotificationActionStateTearOff();

  _Anonymous anonymous() {
    return const _Anonymous();
  }

  _Authenticated authenticated(int notificationCounter) {
    return _Authenticated(
      notificationCounter,
    );
  }
}

/// @nodoc
const $NotificationActionState = _$NotificationActionStateTearOff();

/// @nodoc
mixin _$NotificationActionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() anonymous,
    required TResult Function(int notificationCounter) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? anonymous,
    TResult Function(int notificationCounter)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? anonymous,
    TResult Function(int notificationCounter)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Anonymous value) anonymous,
    required TResult Function(_Authenticated value) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Anonymous value)? anonymous,
    TResult Function(_Authenticated value)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Anonymous value)? anonymous,
    TResult Function(_Authenticated value)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationActionStateCopyWith<$Res> {
  factory $NotificationActionStateCopyWith(NotificationActionState value,
          $Res Function(NotificationActionState) then) =
      _$NotificationActionStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$NotificationActionStateCopyWithImpl<$Res>
    implements $NotificationActionStateCopyWith<$Res> {
  _$NotificationActionStateCopyWithImpl(this._value, this._then);

  final NotificationActionState _value;
  // ignore: unused_field
  final $Res Function(NotificationActionState) _then;
}

/// @nodoc
abstract class _$AnonymousCopyWith<$Res> {
  factory _$AnonymousCopyWith(
          _Anonymous value, $Res Function(_Anonymous) then) =
      __$AnonymousCopyWithImpl<$Res>;
}

/// @nodoc
class __$AnonymousCopyWithImpl<$Res>
    extends _$NotificationActionStateCopyWithImpl<$Res>
    implements _$AnonymousCopyWith<$Res> {
  __$AnonymousCopyWithImpl(_Anonymous _value, $Res Function(_Anonymous) _then)
      : super(_value, (v) => _then(v as _Anonymous));

  @override
  _Anonymous get _value => super._value as _Anonymous;
}

/// @nodoc

class _$_Anonymous implements _Anonymous {
  const _$_Anonymous();

  @override
  String toString() {
    return 'NotificationActionState.anonymous()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Anonymous);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() anonymous,
    required TResult Function(int notificationCounter) authenticated,
  }) {
    return anonymous();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? anonymous,
    TResult Function(int notificationCounter)? authenticated,
  }) {
    return anonymous?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? anonymous,
    TResult Function(int notificationCounter)? authenticated,
    required TResult orElse(),
  }) {
    if (anonymous != null) {
      return anonymous();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Anonymous value) anonymous,
    required TResult Function(_Authenticated value) authenticated,
  }) {
    return anonymous(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Anonymous value)? anonymous,
    TResult Function(_Authenticated value)? authenticated,
  }) {
    return anonymous?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Anonymous value)? anonymous,
    TResult Function(_Authenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (anonymous != null) {
      return anonymous(this);
    }
    return orElse();
  }
}

abstract class _Anonymous implements NotificationActionState {
  const factory _Anonymous() = _$_Anonymous;
}

/// @nodoc
abstract class _$AuthenticatedCopyWith<$Res> {
  factory _$AuthenticatedCopyWith(
          _Authenticated value, $Res Function(_Authenticated) then) =
      __$AuthenticatedCopyWithImpl<$Res>;
  $Res call({int notificationCounter});
}

/// @nodoc
class __$AuthenticatedCopyWithImpl<$Res>
    extends _$NotificationActionStateCopyWithImpl<$Res>
    implements _$AuthenticatedCopyWith<$Res> {
  __$AuthenticatedCopyWithImpl(
      _Authenticated _value, $Res Function(_Authenticated) _then)
      : super(_value, (v) => _then(v as _Authenticated));

  @override
  _Authenticated get _value => super._value as _Authenticated;

  @override
  $Res call({
    Object? notificationCounter = freezed,
  }) {
    return _then(_Authenticated(
      notificationCounter == freezed
          ? _value.notificationCounter
          : notificationCounter // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Authenticated implements _Authenticated {
  const _$_Authenticated(this.notificationCounter);

  @override
  final int notificationCounter;

  @override
  String toString() {
    return 'NotificationActionState.authenticated(notificationCounter: $notificationCounter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Authenticated &&
            (identical(other.notificationCounter, notificationCounter) ||
                const DeepCollectionEquality()
                    .equals(other.notificationCounter, notificationCounter)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(notificationCounter);

  @JsonKey(ignore: true)
  @override
  _$AuthenticatedCopyWith<_Authenticated> get copyWith =>
      __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() anonymous,
    required TResult Function(int notificationCounter) authenticated,
  }) {
    return authenticated(notificationCounter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? anonymous,
    TResult Function(int notificationCounter)? authenticated,
  }) {
    return authenticated?.call(notificationCounter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? anonymous,
    TResult Function(int notificationCounter)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(notificationCounter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Anonymous value) anonymous,
    required TResult Function(_Authenticated value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Anonymous value)? anonymous,
    TResult Function(_Authenticated value)? authenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Anonymous value)? anonymous,
    TResult Function(_Authenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements NotificationActionState {
  const factory _Authenticated(int notificationCounter) = _$_Authenticated;

  int get notificationCounter => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthenticatedCopyWith<_Authenticated> get copyWith =>
      throw _privateConstructorUsedError;
}
