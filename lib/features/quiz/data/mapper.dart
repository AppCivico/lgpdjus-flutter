import 'package:lgpdjus/app/core/extension/iterable.dart';
import 'package:lgpdjus/common/data/appstate/model.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';

abstract class QuizScreenConverter {
  bool canConvert(String type);

  QuizScreen convert(Map<String, dynamic> data);
}

class QuizScreenMapper {
  QuizScreenMapper(this._converters);

  List<QuizScreenConverter> _converters;

  QuizScreen? call(Map<String, dynamic> data) {
    final String? type = _getType(data);
    if (type == null) return null;

    final converter = _converters.firstWhereOrNull(
      (c) => c.canConvert(type),
    );

    if (converter == null) throw Exception("Invalid quiz type '$type'");

    return converter.convert(data);
  }

  String? _getType(Map<String, dynamic> data) {
    if (data.containsKey("current_msg")) {
      return data["current_msg"]["type"];
    } else {
      return data["type"];
    }
  }
}

abstract class AppStateConverter implements QuizScreenConverter {
  AppStateConverter([this.handledType]);

  final MessageType? handledType;
  bool hasRootScroll = false;

  @override
  bool canConvert(String type) => canTransform(MessageTypeParser.parse(type));

  @override
  QuizScreen convert(Map<String, dynamic> data) =>
      transform(QuizSession.fromJson(data));

  bool canTransform(MessageType type) => type == handledType;

  QuizScreen transform(QuizSession quiz) {
    return QuizScreen(
      title: quiz.appbarHeader,
      progress: quiz.progress,
      hasRootScroll: hasRootScroll,
      rows: listOfNotNull([
        intro(quiz),
        BoxTile.shadowed(
          rows: listOfNotNull([
            TextTile(text: quiz.currentMessage.content),
            options(quiz),
          ]),
        ),
        editText(quiz),
        appendix(quiz),
      ]),
      reply: reply(quiz),
      close: CloseQuizAnswer(
        id: quiz.id,
        mustCancel: quiz.canDelete,
      ),
    );
  }

  Tile? intro(QuizSession quiz) {
    final intro = quiz.currentMessage.intro;
    if (intro == null) return null;
    return BoxTile.bordered(
      rows: [TextTile(text: intro)],
    );
  }

  Tile? appendix(QuizSession quiz) {
    final appendix = quiz.currentMessage.appendix;
    if (appendix == null) return null;
    return BoxTile.bordered(
      rows: [TextTile(text: appendix)],
    );
  }

  Tile? options(QuizSession quiz) => null;

  Tile? editText(QuizSession quiz) => null;

  ButtonQuizAnswer reply(QuizSession quiz) => InputQuizAnswer(
      label: quiz.currentMessage.label ?? "Continuar", value: "");
}

class QuestionnaireConverter implements QuizScreenConverter {
  @override
  bool canConvert(String type) => type == "questionnaire";

  @override
  QuizScreen convert(Map<String, dynamic> data) {
    Map<String, dynamic> screenData = data["confirmation_screen"];
    return QuizScreen(
      title: data["appbar_header"],
      progress: 0.02,
      rows: listOfNotNull([
        BoxTile.shadowed(
          rows: [
            TextTile(text: screenData["title"]),
          ],
        ),
        screenData["legal_info"].isNotEmpty
            ? TextTile(text: screenData["legal_info"])
            : null,
        BoxTile.bordered(
          rows: [
            TextTile(text: screenData["body"]),
          ],
        ),
      ]),
      reply: StartQuizAnswer(label: screenData["button"], id: "${data['id']}"),
    );
  }
}

class ConfirmationConverter extends AppStateConverter {
  ConfirmationConverter() : super(MessageType.button);

  @override
  ButtonQuizAnswer reply(QuizSession quiz) {
    final buttonStyle = quiz.canDelete
        ? ButtonQuizAnswerStyle.secondary
        : ButtonQuizAnswerStyle.primary;
    return InputQuizAnswer(
      label: quiz.currentMessage.label!,
      value: "1",
      style: buttonStyle,
    );
  }
}

class EditTextConverter extends AppStateConverter {
  EditTextConverter({MessageType messageType: MessageType.text}) : super(messageType);

  @override
  bool hasRootScroll = true;

  @override
  Tile? editText(QuizSession quiz) {
    return EditTextTile(reference: quiz.currentMessage.reference);
  }
}

class CpfEditTextConverter extends EditTextConverter {
  CpfEditTextConverter() : super(messageType: MessageType.cpf);

  @override
  Tile? editText(QuizSession quiz) {
    return CpfEditTextTile(reference: quiz.currentMessage.reference);
  }
}

class BirthdayEditTextConverter extends EditTextConverter {
  BirthdayEditTextConverter() : super(messageType: MessageType.birthday);

  @override
  Tile? editText(QuizSession quiz) {
    return BirthdayEditTextTile(reference: quiz.currentMessage.reference);
  }
}

class SingleChoiceConverter extends AppStateConverter {
  SingleChoiceConverter() : super(MessageType.singleChoice);

  @override
  Tile? options(QuizSession quiz) {
    return RadioTile(
      reference: quiz.currentMessage.reference,
      options: _mapOptions(quiz.currentMessage.options),
    );
  }
}

class MultiChoicesConverter extends AppStateConverter {
  MultiChoicesConverter() : super(MessageType.multipleChoices);

  @override
  Tile? options(QuizSession quiz) {
    return CheckboxTile(
      reference: quiz.currentMessage.reference,
      options: _mapOptions(quiz.currentMessage.options),
    );
  }
}

class TakePictureConverter extends AppStateConverter {
  TakePictureConverter() : super(MessageType.takePicture);

  @override
  ButtonQuizAnswer reply(QuizSession quiz) {
    return SendPictureQuizAnswer(
      label: quiz.currentMessage.label ?? 'Fotografar',
      lensDirection: _LensDirection.parse(quiz.currentMessage.lensDirection),
    );
  }
}

List<Option> _mapOptions(List<MessageOption> options) {
  return options
      .map<Option>((e) => Option(label: e.display, value: e.index))
      .toList();
}

extension _LensDirection on LensDirection {
  static LensDirection parse(String? value) {
    switch (value) {
      case 'back':
        return LensDirection.back;
      case 'front':
        return LensDirection.front;
      default:
        throw Exception("invalid lens_direction=$value");
    }
  }
}
