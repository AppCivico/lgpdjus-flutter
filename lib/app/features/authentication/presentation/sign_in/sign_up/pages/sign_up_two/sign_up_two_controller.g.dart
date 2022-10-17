// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_two_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpTwoController on _SignUpTwoControllerBase, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_SignUpTwoControllerBase.currentState'))
      .value;

  late final _$_progressAtom =
      Atom(name: '_SignUpTwoControllerBase._progress', context: context);

  @override
  ObservableFuture<dynamic>? get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<dynamic>? value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  late final _$warningNicknameAtom =
      Atom(name: '_SignUpTwoControllerBase.warningNickname', context: context);

  @override
  String get warningNickname {
    _$warningNicknameAtom.reportRead();
    return super.warningNickname;
  }

  @override
  set warningNickname(String value) {
    _$warningNicknameAtom.reportWrite(value, super.warningNickname, () {
      super.warningNickname = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_SignUpTwoControllerBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$nextStepPressedAsyncAction =
      AsyncAction('_SignUpTwoControllerBase.nextStepPressed', context: context);

  @override
  Future<void> nextStepPressed() {
    return _$nextStepPressedAsyncAction.run(() => super.nextStepPressed());
  }

  late final _$_SignUpTwoControllerBaseActionController =
      ActionController(name: '_SignUpTwoControllerBase', context: context);

  @override
  void setNickname(String name) {
    final _$actionInfo = _$_SignUpTwoControllerBaseActionController.startAction(
        name: '_SignUpTwoControllerBase.setNickname');
    try {
      return super.setNickname(name);
    } finally {
      _$_SignUpTwoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
warningNickname: ${warningNickname},
errorMessage: ${errorMessage},
currentState: ${currentState}
    ''';
  }
}
