import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/common/widgets/dialog.dart';
import 'package:lgpdjus/core/di/bind.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';
import 'package:lgpdjus/features/quiz/domain/usecase.dart';
import 'package:lgpdjus/features/quiz/presentation/quiz_state.dart';
import 'package:mobx/mobx.dart';

part 'quiz_controller.g.dart';

class QuizController extends _QuizControllerBase with _$QuizController {
  QuizController({
    required StartQuizUseCase startQuizUseCase,
    required CloseQuizUseCase closeQuizUseCase,
  }) : super(startQuizUseCase, closeQuizUseCase);
}

abstract class _QuizControllerBase
    with Store, MapFailureMessage
    implements QuizReplyController, Disposable {
  _QuizControllerBase(this._startQuiz, this._stopQuiz);

  final StartQuizUseCase _startQuiz;
  final CloseQuizUseCase _stopQuiz;

  ReplyQuizUseCase<QuizAnswer> get _replyQuiz =>
      Modular.getBindTagged(answer.runtimeType);

  late VerifyAccountUseCase _verifyAccount = Modular.get();

  @observable
  late QuizState state = _start();

  @observable
  QuizReaction? reaction;

  @override
  @observable
  QuizAnswer? answer;

  @computed
  VoidCallback? get sendAnswer => answer?.isValid == true ? _reply : null;

  @observable
  ObservableFuture? _replying;

  @observable
  ObservableFuture<bool>? _quiting;

  late StreamSubscription _stateSubscription;

  QuizState _start() {
    _stateSubscription = _startQuiz().handleError((error) {
      state = QuizState.error(error);
    }).listen((event) {
      answer = event.reply;
      state = QuizState.loaded(event);
    });
    return QuizState.initial();
  }

  retry() {
    _stateSubscription.cancel();
    state = _start();
  }

  @action
  Future<bool> close() async {
    if (_quiting?.status == FutureStatus.pending) return await _quiting!;

    final canNavigateBack = state.when(
      initial: () => Future.value(false),
      error: (error) => Future.value(true),
      loaded: (screen) => _stopQuiz.call(screen.close),
    );

    final future = canNavigateBack.then((allowBack) async {
      if (allowBack) await AppNavigator.popOrNavigateToHome();
      return allowBack;
    }).catchError((error) {
      _onError(error);
      return false;
    });

    _quiting = ObservableFuture(future);
    return await _quiting!;
  }

  Future<void> _reply() async {
    if (_replying?.status == FutureStatus.pending) return;

    final future = state.maybeWhen(
      orElse: () async => null,
      loaded: (screen) {
        return _replyQuiz
            .call(answer!)
            .then(_onReplySuccess)
            .catchError(_onError);
      },
    );

    _replying = ObservableFuture(future);
    await _replying;
  }

  _onReplySuccess(String? navigateTo) {
    if (navigateTo != null) {
      AppNavigator.pushAndRemoveUntil(navigateTo, '/');
    }
    _hideLoading();
  }

  _onError(exception, [StackTrace? stack]) {
    if (exception is UnverifiedAccountFailure) {
      _emitDialogReaction(exception.message);
      return;
    }
    reaction = QuizReaction.showError(mapFailureMessage(exception, stack));
  }

  void _emitDialogReaction(String message) {
    final dialog = DialogData(
      "Validar conta",
      message,
      NamedAction("Continuar", Runnable(_verifyAccount)),
      NamedAction("Fazer mais tarde", null),
    );
    reaction = QuizReaction.showDialog(dialog);
  }

  _hideLoading() {
    reaction = QuizReaction.hideLoading();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
  }
}

abstract class QuizReplyController {
  abstract QuizAnswer? answer;
}

extension Answer on QuizReplyController {
  set answerValue(String value) {
    answer = (answer as InputQuizAnswer).copyWith(value: value);
  }
}
