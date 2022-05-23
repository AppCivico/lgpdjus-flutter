class AppState {
  AppState({
    required this.quizSession,
  });

  final QuizSession quizSession;

  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      quizSession: QuizSession.fromJson(json['quiz_session'] ?? {}),
    );
  }
}

class QuizSession {
  QuizSession({
    required this.id,
    required this.appbarHeader,
    required this.canDelete,
    required this.progress,
    required this.currentMessage,
  });

  final String id;
  final String appbarHeader;
  final bool canDelete;
  final double progress;
  final QuizMessage currentMessage;

  factory QuizSession.fromJson(Map<String, dynamic> json) {
    return QuizSession(
      id: "${json['session_id'] ?? ''}",
      appbarHeader: json['appbar_header'] ?? "",
      canDelete: "${json["can_delete"]}" == "1",
      progress: int.parse("${json['progress_bar'] ?? 0}") / 100.0,
      currentMessage: QuizMessage.fromJson(json['current_msg'] ?? {}),
    );
  }
}

class QuizMessage {
  QuizMessage({
    required this.reference,
    required this.type,
    required this.appendix,
    required this.content,
    required this.intro,
    required this.label,
    required this.lensDirection,
    required this.options,
  });

  final String reference;
  final MessageType type;
  final String? appendix;
  final String content;
  final String? intro;
  final String? label;
  final String? lensDirection;
  final List<MessageOption> options;

  factory QuizMessage.fromJson(Map<String, dynamic> json) {
    final String? intro = json['intro'];
    final String? appendix = json['appendix'];
    return QuizMessage(
      reference: json['ref'] ?? '',
      type: MessageTypeParser.parse(json['type']),
      appendix: appendix?.isNotEmpty == true ? appendix : null,
      content: json['content'],
      intro: intro?.isNotEmpty == true ? intro : null,
      label: json['label'],
      lensDirection: json['lens_direction'],
      options: MessageOption.fromJsonList(json['options'] ?? []),
    );
  }
}

class MessageOption {
  MessageOption({
    required this.index,
    required this.display,
  });

  final String index;
  final String display;

  factory MessageOption.fromJson(Map<String, dynamic> json) {
    return MessageOption(
      index: "${json['index']}",
      display: json['display'],
    );
  }

  static List<MessageOption> fromJsonList(List<dynamic> json) {
    return json.map((e) => MessageOption.fromJson(e)).toList();
  }
}

enum MessageType {
  questionnaire,
  text,
  birthday,
  cpf,
  button,
  multipleChoices,
  singleChoice,
  takePicture
}

extension MessageTypeParser on MessageType {
  static parse(String key) {
    switch (key.toLowerCase()) {
      case 'questionnaire':
        return MessageType.questionnaire;
      case 'text':
        return MessageType.text;
      case 'birthday':
        return MessageType.birthday;
      case 'cpf':
        return MessageType.cpf;
      case 'button':
        return MessageType.button;
      case 'multiplechoices':
        return MessageType.multipleChoices;
      case 'onlychoice':
        return MessageType.singleChoice;
      case 'photo_attachment':
        return MessageType.takePicture;
      default:
        var message = "Unsupported quiz message type '$key'";
        throw UnsupportedError(message);
    }
  }
}
