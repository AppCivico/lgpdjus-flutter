import 'package:lgpdjus/app/core/extension/iterable.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/ticket/data/models/tile_model.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_session_entity.dart';

class TicketSessionModel extends TicketSessionEntity {
  TicketSessionModel(bool hasMore, String? nextPage, List<Tile> tiles)
      : super(hasMore: hasMore, nextPage: nextPage, tiles: tiles);

  factory TicketSessionModel.fromJson(Map<String, dynamic> jsonData) {
    final hasMore = jsonData['has_more'] == 1;
    final nextPage = jsonData['next_page'];
    final tiles = _parseTiles(jsonData['rows']);

    return TicketSessionModel(hasMore, nextPage, tiles);
  }

  static List<Tile> _parseTiles(List<dynamic>? tiles) {
    if (tiles == null || tiles.isEmpty) {
      return [];
    }

    return tiles
        .mapNotNull((e) => _parseTile(e))
        .toList();
  }

  static Tile? _parseTile(Map<String, dynamic> json) {
    final type = json['type'];

    if (type == 'header') {
      return HeaderModel.fromJson(json);
    }

    if (type == 'ticket') {
      return TicketModel.fromJson(json);
    }

    if (type == 'questionnaire') {
      return QuestionnaireModel.fromJson(json);
    }

    if (type == 'questionnaires') {
      return QuestionnairesModel.fromJson(json);
    }

    return null;
  }
}
