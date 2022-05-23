import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_tiles.dart';

class HeaderModel extends HeaderTile {
  HeaderModel({required String text}) : super(text: text);

  factory HeaderModel.fromJson(Map<String, dynamic> jsonData) {
    return HeaderModel(text: jsonData['value']);
  }
}

class TicketModel extends TicketTile {
  TicketModel({required String content, required NavData action})
      : super(content: content, action: action);

  factory TicketModel.fromJson(Map<String, dynamic> jsonData) {
    return TicketModel(
      content: jsonData['content'],
      action: NavData('/mainboard/tickets/${jsonData['id']}', data: jsonData),
    );
  }
}

class QuestionnairesModel extends Questionnaires {
  QuestionnairesModel({required List<Questionnaire> items})
      : super(items: items);

  factory QuestionnairesModel.fromJson(Map<String, dynamic> jsonData) {
    return QuestionnairesModel(
      items: QuestionnaireModel.parseJsonList(jsonData['children']),
    );
  }
}

class QuestionnaireModel extends Questionnaire {
  QuestionnaireModel({
    required String header,
    required String body,
    required Uri icon,
    required NavData action,
  }) : super(header: header, body: body, icon: icon, action: action);

  factory QuestionnaireModel.fromJson(Map<String, dynamic> jsonData) {
    return QuestionnaireModel(
      header: jsonData['header'],
      body: jsonData['body'],
      icon: Uri.parse(jsonData['icon']),
      action: NavData('/quiz/${jsonData['id']}', data: jsonData),
    );
  }

  static parseJsonList(List<dynamic> questionnaires) {
    return questionnaires
        .where((item) => item['type'] == 'questionnaire')
        .map((item) => QuestionnaireModel.fromJson(item))
        .toList();
  }
}
