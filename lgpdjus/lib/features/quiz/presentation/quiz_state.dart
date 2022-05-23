import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/common/widgets/dialog.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';

part 'quiz_state.freezed.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial() = _Initial;

  const factory QuizState.error(Object error) = _Error;

  const factory QuizState.loaded(QuizScreen screen) = _Loaded;
}

@freezed
class QuizReaction with _$QuizReaction {
  const factory QuizReaction.showError(Object error) = _ShowError;

  const factory QuizReaction.showDialog(DialogData dialog) = _ShowDialog;

  const factory QuizReaction.hideLoading() = _HideLoading;
}
