// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'quiz_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$QuizStateTearOff {
  const _$QuizStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _Error error(Object error) {
    return _Error(
      error,
    );
  }

  _Loaded loaded(QuizScreen screen) {
    return _Loaded(
      screen,
    );
  }
}

/// @nodoc
const $QuizState = _$QuizStateTearOff();

/// @nodoc
mixin _$QuizState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Object error) error,
    required TResult Function(QuizScreen screen) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Object error)? error,
    TResult Function(QuizScreen screen)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Object error)? error,
    TResult Function(QuizScreen screen)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizStateCopyWith<$Res> {
  factory $QuizStateCopyWith(QuizState value, $Res Function(QuizState) then) =
      _$QuizStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$QuizStateCopyWithImpl<$Res> implements $QuizStateCopyWith<$Res> {
  _$QuizStateCopyWithImpl(this._value, this._then);

  final QuizState _value;
  // ignore: unused_field
  final $Res Function(QuizState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$QuizStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'QuizState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Object error) error,
    required TResult Function(QuizScreen screen) loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Object error)? error,
    TResult Function(QuizScreen screen)? loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Object error)? error,
    TResult Function(QuizScreen screen)? loaded,
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
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements QuizState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  $Res call({Object error});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$QuizStateCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_Error(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Object,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.error);

  @override
  final Object error;

  @override
  String toString() {
    return 'QuizState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Error &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Object error) error,
    required TResult Function(QuizScreen screen) loaded,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Object error)? error,
    TResult Function(QuizScreen screen)? loaded,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Object error)? error,
    TResult Function(QuizScreen screen)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements QuizState {
  const factory _Error(Object error) = _$_Error;

  Object get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoadedCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) then) =
      __$LoadedCopyWithImpl<$Res>;
  $Res call({QuizScreen screen});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> extends _$QuizStateCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(_Loaded _value, $Res Function(_Loaded) _then)
      : super(_value, (v) => _then(v as _Loaded));

  @override
  _Loaded get _value => super._value as _Loaded;

  @override
  $Res call({
    Object? screen = freezed,
  }) {
    return _then(_Loaded(
      screen == freezed
          ? _value.screen
          : screen // ignore: cast_nullable_to_non_nullable
              as QuizScreen,
    ));
  }
}

/// @nodoc

class _$_Loaded implements _Loaded {
  const _$_Loaded(this.screen);

  @override
  final QuizScreen screen;

  @override
  String toString() {
    return 'QuizState.loaded(screen: $screen)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Loaded &&
            (identical(other.screen, screen) ||
                const DeepCollectionEquality().equals(other.screen, screen)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(screen);

  @JsonKey(ignore: true)
  @override
  _$LoadedCopyWith<_Loaded> get copyWith =>
      __$LoadedCopyWithImpl<_Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Object error) error,
    required TResult Function(QuizScreen screen) loaded,
  }) {
    return loaded(screen);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Object error)? error,
    TResult Function(QuizScreen screen)? loaded,
  }) {
    return loaded?.call(screen);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Object error)? error,
    TResult Function(QuizScreen screen)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(screen);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements QuizState {
  const factory _Loaded(QuizScreen screen) = _$_Loaded;

  QuizScreen get screen => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$LoadedCopyWith<_Loaded> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$QuizReactionTearOff {
  const _$QuizReactionTearOff();

  _ShowError showError(Object error) {
    return _ShowError(
      error,
    );
  }

  _ShowDialog showDialog(DialogData dialog) {
    return _ShowDialog(
      dialog,
    );
  }

  _HideLoading hideLoading() {
    return const _HideLoading();
  }
}

/// @nodoc
const $QuizReaction = _$QuizReactionTearOff();

/// @nodoc
mixin _$QuizReaction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) showError,
    required TResult Function(DialogData dialog) showDialog,
    required TResult Function() hideLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Object error)? showError,
    TResult Function(DialogData dialog)? showDialog,
    TResult Function()? hideLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? showError,
    TResult Function(DialogData dialog)? showDialog,
    TResult Function()? hideLoading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowError value) showError,
    required TResult Function(_ShowDialog value) showDialog,
    required TResult Function(_HideLoading value) hideLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_HideLoading value)? hideLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_HideLoading value)? hideLoading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizReactionCopyWith<$Res> {
  factory $QuizReactionCopyWith(
          QuizReaction value, $Res Function(QuizReaction) then) =
      _$QuizReactionCopyWithImpl<$Res>;
}

/// @nodoc
class _$QuizReactionCopyWithImpl<$Res> implements $QuizReactionCopyWith<$Res> {
  _$QuizReactionCopyWithImpl(this._value, this._then);

  final QuizReaction _value;
  // ignore: unused_field
  final $Res Function(QuizReaction) _then;
}

/// @nodoc
abstract class _$ShowErrorCopyWith<$Res> {
  factory _$ShowErrorCopyWith(
          _ShowError value, $Res Function(_ShowError) then) =
      __$ShowErrorCopyWithImpl<$Res>;
  $Res call({Object error});
}

/// @nodoc
class __$ShowErrorCopyWithImpl<$Res> extends _$QuizReactionCopyWithImpl<$Res>
    implements _$ShowErrorCopyWith<$Res> {
  __$ShowErrorCopyWithImpl(_ShowError _value, $Res Function(_ShowError) _then)
      : super(_value, (v) => _then(v as _ShowError));

  @override
  _ShowError get _value => super._value as _ShowError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_ShowError(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Object,
    ));
  }
}

/// @nodoc

class _$_ShowError implements _ShowError {
  const _$_ShowError(this.error);

  @override
  final Object error;

  @override
  String toString() {
    return 'QuizReaction.showError(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ShowError &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$ShowErrorCopyWith<_ShowError> get copyWith =>
      __$ShowErrorCopyWithImpl<_ShowError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) showError,
    required TResult Function(DialogData dialog) showDialog,
    required TResult Function() hideLoading,
  }) {
    return showError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Object error)? showError,
    TResult Function(DialogData dialog)? showDialog,
    TResult Function()? hideLoading,
  }) {
    return showError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? showError,
    TResult Function(DialogData dialog)? showDialog,
    TResult Function()? hideLoading,
    required TResult orElse(),
  }) {
    if (showError != null) {
      return showError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowError value) showError,
    required TResult Function(_ShowDialog value) showDialog,
    required TResult Function(_HideLoading value) hideLoading,
  }) {
    return showError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_HideLoading value)? hideLoading,
  }) {
    return showError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_HideLoading value)? hideLoading,
    required TResult orElse(),
  }) {
    if (showError != null) {
      return showError(this);
    }
    return orElse();
  }
}

abstract class _ShowError implements QuizReaction {
  const factory _ShowError(Object error) = _$_ShowError;

  Object get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ShowErrorCopyWith<_ShowError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ShowDialogCopyWith<$Res> {
  factory _$ShowDialogCopyWith(
          _ShowDialog value, $Res Function(_ShowDialog) then) =
      __$ShowDialogCopyWithImpl<$Res>;
  $Res call({DialogData dialog});
}

/// @nodoc
class __$ShowDialogCopyWithImpl<$Res> extends _$QuizReactionCopyWithImpl<$Res>
    implements _$ShowDialogCopyWith<$Res> {
  __$ShowDialogCopyWithImpl(
      _ShowDialog _value, $Res Function(_ShowDialog) _then)
      : super(_value, (v) => _then(v as _ShowDialog));

  @override
  _ShowDialog get _value => super._value as _ShowDialog;

  @override
  $Res call({
    Object? dialog = freezed,
  }) {
    return _then(_ShowDialog(
      dialog == freezed
          ? _value.dialog
          : dialog // ignore: cast_nullable_to_non_nullable
              as DialogData,
    ));
  }
}

/// @nodoc

class _$_ShowDialog implements _ShowDialog {
  const _$_ShowDialog(this.dialog);

  @override
  final DialogData dialog;

  @override
  String toString() {
    return 'QuizReaction.showDialog(dialog: $dialog)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ShowDialog &&
            (identical(other.dialog, dialog) ||
                const DeepCollectionEquality().equals(other.dialog, dialog)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(dialog);

  @JsonKey(ignore: true)
  @override
  _$ShowDialogCopyWith<_ShowDialog> get copyWith =>
      __$ShowDialogCopyWithImpl<_ShowDialog>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) showError,
    required TResult Function(DialogData dialog) showDialog,
    required TResult Function() hideLoading,
  }) {
    return showDialog(dialog);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Object error)? showError,
    TResult Function(DialogData dialog)? showDialog,
    TResult Function()? hideLoading,
  }) {
    return showDialog?.call(dialog);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? showError,
    TResult Function(DialogData dialog)? showDialog,
    TResult Function()? hideLoading,
    required TResult orElse(),
  }) {
    if (showDialog != null) {
      return showDialog(dialog);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowError value) showError,
    required TResult Function(_ShowDialog value) showDialog,
    required TResult Function(_HideLoading value) hideLoading,
  }) {
    return showDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_HideLoading value)? hideLoading,
  }) {
    return showDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_HideLoading value)? hideLoading,
    required TResult orElse(),
  }) {
    if (showDialog != null) {
      return showDialog(this);
    }
    return orElse();
  }
}

abstract class _ShowDialog implements QuizReaction {
  const factory _ShowDialog(DialogData dialog) = _$_ShowDialog;

  DialogData get dialog => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ShowDialogCopyWith<_ShowDialog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$HideLoadingCopyWith<$Res> {
  factory _$HideLoadingCopyWith(
          _HideLoading value, $Res Function(_HideLoading) then) =
      __$HideLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$HideLoadingCopyWithImpl<$Res> extends _$QuizReactionCopyWithImpl<$Res>
    implements _$HideLoadingCopyWith<$Res> {
  __$HideLoadingCopyWithImpl(
      _HideLoading _value, $Res Function(_HideLoading) _then)
      : super(_value, (v) => _then(v as _HideLoading));

  @override
  _HideLoading get _value => super._value as _HideLoading;
}

/// @nodoc

class _$_HideLoading implements _HideLoading {
  const _$_HideLoading();

  @override
  String toString() {
    return 'QuizReaction.hideLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _HideLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Object error) showError,
    required TResult Function(DialogData dialog) showDialog,
    required TResult Function() hideLoading,
  }) {
    return hideLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Object error)? showError,
    TResult Function(DialogData dialog)? showDialog,
    TResult Function()? hideLoading,
  }) {
    return hideLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Object error)? showError,
    TResult Function(DialogData dialog)? showDialog,
    TResult Function()? hideLoading,
    required TResult orElse(),
  }) {
    if (hideLoading != null) {
      return hideLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ShowError value) showError,
    required TResult Function(_ShowDialog value) showDialog,
    required TResult Function(_HideLoading value) hideLoading,
  }) {
    return hideLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_HideLoading value)? hideLoading,
  }) {
    return hideLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ShowError value)? showError,
    TResult Function(_ShowDialog value)? showDialog,
    TResult Function(_HideLoading value)? hideLoading,
    required TResult orElse(),
  }) {
    if (hideLoading != null) {
      return hideLoading(this);
    }
    return orElse();
  }
}

abstract class _HideLoading implements QuizReaction {
  const factory _HideLoading() = _$_HideLoading;
}
