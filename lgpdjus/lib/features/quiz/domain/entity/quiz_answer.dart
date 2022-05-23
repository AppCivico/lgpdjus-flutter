import 'package:equatable/equatable.dart';

abstract class QuizAnswer extends Equatable {
  const QuizAnswer(this.label);

  final String label;

  bool get isValid => true;
}

abstract class ButtonQuizAnswer extends QuizAnswer {
  const ButtonQuizAnswer(String label, this.style) : super(label);

  final ButtonQuizAnswerStyle style;

  @override
  List<Object?> get props => [label, style];
}

class StartQuizAnswer extends ButtonQuizAnswer {
  const StartQuizAnswer({
    required this.id,
    required String label,
  }) : super(label, ButtonQuizAnswerStyle.secondary);

  final String id;

  @override
  List<Object?> get props => [id, ...super.props];
}

class CloseQuizAnswer extends QuizAnswer {
  const CloseQuizAnswer({this.id = "", this.mustCancel = false})
      : super("Fechar");

  final String id;
  final bool mustCancel;

  bool get closeIsVisible => mustCancel || id.isEmpty;

  @override
  List<Object?> get props => [id, mustCancel];
}

class InputQuizAnswer extends ButtonQuizAnswer {
  const InputQuizAnswer({
    required this.value,
    required String label,
    ButtonQuizAnswerStyle style: ButtonQuizAnswerStyle.secondary,
  }) : super(label, style);

  final String value;

  @override
  bool get isValid => value.isNotEmpty;

  @override
  List<Object?> get props => [value, ...super.props];

  InputQuizAnswer copyWith({
    String? value,
    String? label,
    ButtonQuizAnswerStyle? style,
  }) =>
      InputQuizAnswer(
        value: value ?? this.value,
        label: label ?? this.label,
        style: style ?? this.style,
      );
}

class SendPictureQuizAnswer extends ButtonQuizAnswer {
  SendPictureQuizAnswer({
    required String label,
    required this.lensDirection,
    ButtonQuizAnswerStyle style: ButtonQuizAnswerStyle.secondary,
  }) : super(label, style);

  final LensDirection lensDirection;

  @override
  List<Object?> get props => [lensDirection, ...super.props];
}
enum ButtonQuizAnswerStyle { secondary, primary }

enum LensDirection { back, front }
