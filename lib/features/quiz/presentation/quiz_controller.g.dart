// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuizController on _QuizControllerBase, Store {
  Computed<VoidCallback?>? _$sendAnswerComputed;

  @override
  VoidCallback? get sendAnswer =>
      (_$sendAnswerComputed ??= Computed<VoidCallback?>(() => super.sendAnswer,
              name: '_QuizControllerBase.sendAnswer'))
          .value;

  late final _$stateAtom =
      Atom(name: '_QuizControllerBase.state', context: context);

  @override
  QuizState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(QuizState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$reactionAtom =
      Atom(name: '_QuizControllerBase.reaction', context: context);

  @override
  QuizReaction? get reaction {
    _$reactionAtom.reportRead();
    return super.reaction;
  }

  @override
  set reaction(QuizReaction? value) {
    _$reactionAtom.reportWrite(value, super.reaction, () {
      super.reaction = value;
    });
  }

  late final _$answerAtom =
      Atom(name: '_QuizControllerBase.answer', context: context);

  @override
  QuizAnswer? get answer {
    _$answerAtom.reportRead();
    return super.answer;
  }

  @override
  set answer(QuizAnswer? value) {
    _$answerAtom.reportWrite(value, super.answer, () {
      super.answer = value;
    });
  }

  late final _$_replyingAtom =
      Atom(name: '_QuizControllerBase._replying', context: context);

  @override
  ObservableFuture<dynamic>? get _replying {
    _$_replyingAtom.reportRead();
    return super._replying;
  }

  @override
  set _replying(ObservableFuture<dynamic>? value) {
    _$_replyingAtom.reportWrite(value, super._replying, () {
      super._replying = value;
    });
  }

  late final _$_quitingAtom =
      Atom(name: '_QuizControllerBase._quiting', context: context);

  @override
  ObservableFuture<bool>? get _quiting {
    _$_quitingAtom.reportRead();
    return super._quiting;
  }

  @override
  set _quiting(ObservableFuture<bool>? value) {
    _$_quitingAtom.reportWrite(value, super._quiting, () {
      super._quiting = value;
    });
  }

  late final _$closeAsyncAction =
      AsyncAction('_QuizControllerBase.close', context: context);

  @override
  Future<bool> close() {
    return _$closeAsyncAction.run(() => super.close());
  }

  @override
  String toString() {
    return '''
state: ${state},
reaction: ${reaction},
answer: ${answer},
sendAnswer: ${sendAnswer}
    ''';
  }
}
