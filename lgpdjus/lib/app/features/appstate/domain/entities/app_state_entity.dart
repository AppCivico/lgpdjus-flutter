import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:meta/meta.dart';

enum QuizMessageType {
  from,
  text,
  button,
  yesno,
  displayText,
  showStealthTutorial,
  showHelpTutorial,
  forceReload,
  multipleChoices,
  displayTextResponse,
  singleChoice,
}

extension QuizMessageTypeExtension on QuizMessageType {
  operator [](String key) {
    var type = QuizMessageType.displayText;
    switch (key.toLowerCase()) {
      case 'text':
        type = QuizMessageType.text;
        break;
      case 'button':
        type = QuizMessageType.button;
        break;
      case 'show_tutorial':
        type = QuizMessageType.showStealthTutorial;
        break;
      case 'yesno':
        type = QuizMessageType.yesno;
        break;
      case 'displaytext':
        type = QuizMessageType.displayText;
        break;
      case 'display_response':
        type = QuizMessageType.displayTextResponse;
        break;
      case 'multiplechoices':
        type = QuizMessageType.multipleChoices;
        break;
      case 'onlychoice':
        type = QuizMessageType.singleChoice;
        break;
      default:
        var message = "Unsupported quiz message type '$key'";
        FirebaseCrashlytics.instance.log(message);
        print(message);
    }

    return type;
  }
}

@immutable
class AppStateEntity extends Equatable {
  final QuizSessionEntity? quizSession;
  final AppStateModeEntity? appMode;
  final List<AppStateModuleEntity>? modules;

  AppStateEntity({
    required this.quizSession,
    required this.appMode,
    required this.modules,
  });

  @override
  List<Object?> get props => [
        quizSession,
        appMode,
        modules,
      ];

  @override
  bool get stringify => true;
}

@immutable
class QuizSessionEntity extends Equatable {
  final List<QuizMessageEntity> currentMessage;
  final String sessionId;
  final bool isFinished;
  final String? endScreen;
  final bool canDelete;

  QuizSessionEntity({
    required this.currentMessage,
    required this.sessionId,
    required this.isFinished,
    required this.endScreen,
    this.canDelete = false,
  });

  @override
  List<Object?> get props => [currentMessage, sessionId, isFinished, endScreen];

  @override
  String toString() {
    return "QuizSessionEntity{currentMessage: ${currentMessage.toString()}, sessionId: $sessionId, endScreen: ${endScreen.toString()}, isFinished: ${isFinished.toString()} }";
  }
}

@immutable
class QuizMessageEntity extends Equatable {
  final String content;
  final QuizMessageType type;
  final String? ref;
  final String? style;
  final String? action;
  final String? buttonLabel;
  final List<QuizMessageMultiplechoicesOptions>? options;
  final String? yesLabel;
  final String? noLabel;

  QuizMessageEntity({
    required this.content,
    required this.type,
    this.ref,
    this.style,
    this.action,
    this.buttonLabel,
    this.options,
    this.yesLabel,
    this.noLabel,
  });

  @override
  List<Object?> get props => [
        content,
        style,
        action,
        type,
        ref,
        buttonLabel,
        options,
        yesLabel,
        noLabel,
      ];

  @override
  String toString() {
    return "QuizMessageEntity{content: ${content.toString()}, type: ${type.toString()}, style: ${style.toString()}, action: ${action.toString()}, ref: ${ref.toString()}}, buttonLabel: ${buttonLabel.toString()}, options: ${options.toString()}, yesLabel: ${yesLabel.toString()}, noLabel: ${noLabel.toString()}";
  }
}

class QuizMessageMultiplechoicesOptions extends Equatable {
  final String display;
  final String index;

  QuizMessageMultiplechoicesOptions({
    required this.display,
    required this.index,
  });

  @override
  List<Object?> get props => [display, index];

  @override
  String toString() {
    return "QuizMessageMultiplechoicesOptions{index: ${index.toString()}, display: ${display.toString()}}";
  }
}

@immutable
class AppStateModeEntity extends Equatable {
  final bool hasActivedGuardian;

  AppStateModeEntity({
    required this.hasActivedGuardian,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        hasActivedGuardian,
      ];

  Map<String, dynamic> toJson() => {
        'hasActivedGuardian': hasActivedGuardian,
      };
}

@immutable
class AppStateModuleEntity extends Equatable {
  final String code;
  final String meta;

  AppStateModuleEntity({
    required this.code,
    required this.meta,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [code, meta];
}
