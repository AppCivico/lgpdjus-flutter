// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileEditController on _ProfileEditControllerBase, Store {
  Computed<PageProgressState>? _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_ProfileEditControllerBase.progressState'))
      .value;

  late final _$_progressAtom =
      Atom(name: '_ProfileEditControllerBase._progress', context: context);

  @override
  ObservableFuture<Either<Failure, AppStateEntity>>? get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, AppStateEntity>>? value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_ProfileEditControllerBase.state', context: context);

  @override
  ProfileEditState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProfileEditState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$updateErrorAtom =
      Atom(name: '_ProfileEditControllerBase.updateError', context: context);

  @override
  String get updateError {
    _$updateErrorAtom.reportRead();
    return super.updateError;
  }

  @override
  set updateError(String value) {
    _$updateErrorAtom.reportWrite(value, super.updateError, () {
      super.updateError = value;
    });
  }

  late final _$retryAsyncAction =
      AsyncAction('_ProfileEditControllerBase.retry', context: context);

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  late final _$editNickNameAsyncAction =
      AsyncAction('_ProfileEditControllerBase.editNickName', context: context);

  @override
  Future<void> editNickName(String name) {
    return _$editNickNameAsyncAction.run(() => super.editNickName(name));
  }

  late final _$updatedEmailAsyncAction =
      AsyncAction('_ProfileEditControllerBase.updatedEmail', context: context);

  @override
  Future<void> updatedEmail(String email, String password) {
    return _$updatedEmailAsyncAction
        .run(() => super.updatedEmail(email, password));
  }

  late final _$updatePasswordAsyncAction = AsyncAction(
      '_ProfileEditControllerBase.updatePassword',
      context: context);

  @override
  Future<void> updatePassword(String newPassword, String oldPassword) {
    return _$updatePasswordAsyncAction
        .run(() => super.updatePassword(newPassword, oldPassword));
  }

  @override
  String toString() {
    return '''
state: ${state},
updateError: ${updateError},
progressState: ${progressState}
    ''';
  }
}
