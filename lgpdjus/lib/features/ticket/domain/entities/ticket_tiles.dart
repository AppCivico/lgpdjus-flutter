import 'package:lgpdjus/common/domain/titles/entity.dart';

class HeaderTile extends Tile {
  final String text;

  HeaderTile({required this.text});

  @override
  List<Object?> get props => [text];
}

class TicketTile extends Tile implements Actionable {
  final String content;
  @override
  final NavData action;

  TicketTile({required this.content, required this.action});

  @override
  List<Object?> get props => [content, action];
}

class Questionnaires extends Tile {
  final List<Questionnaire> items;

  Questionnaires({required this.items});

  @override
  List<Object?> get props => [items];
}

class Questionnaire extends Tile implements Actionable {
  final String header;
  final String body;
  final Uri icon;
  @override
  final NavData action;

  Questionnaire({
    required this.header,
    required this.body,
    required this.icon,
    required this.action,
  });

  @override
  List<Object?> get props => [header, body, icon, action];
}
