import 'package:equatable/equatable.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';

class TicketScreen {
  TicketScreen({required this.title, required this.items});

  final String title;
  final List<TicketItem> items;

  factory TicketScreen.fromJson(Map<String, dynamic> jsonData) {
    final responses = (jsonData['responses'] as List<dynamic>).map(
      (e) {
        if ("${e['meta']['can_reply']}" == '1') {
          return ActionTicketItem(
            content: e['body'],
            action: NavData(
              "/mainboard/tickets/${jsonData['id']}/reply/${e['id']}",
              data: TicketPendency(
                title: jsonData['meta']['header'],
                description: e['detail']['requested_information_text'] ?? '',
              ),
            ),
          );
        } else {
          return CardTicketItem(content: e['body']);
        }
      },
    );
    return TicketScreen(title: jsonData['meta']['header'], items: [
      ...responses,
      CardTicketItem(content: jsonData['body']),
    ]);
  }
}

abstract class TicketItem extends Equatable {
  TicketItem({required this.content});

  final String content;

  @override
  List<Object?> get props => [content];
}

class CardTicketItem extends TicketItem {
  CardTicketItem({required String content}) : super(content: content);
}

class ActionTicketItem extends TicketItem implements Actionable {
  ActionTicketItem({
    required String content,
    required this.action,
  }) : super(content: content);

  @override
  final ActionData action;

  @override
  List<Object?> get props => [action, ...super.props];
}

class TicketPendency {
  TicketPendency({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}
