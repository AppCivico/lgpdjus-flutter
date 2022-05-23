import 'package:lgpdjus/common/domain/titles/entity.dart';

class TopicsScreen {
  TopicsScreen({
    required this.items,
  });

  final List<Tile> items;
}

class IntroductionTile extends Tile {
  IntroductionTile({
    required this.content,
  });

  final String content;

  @override
  List<Object?> get props => [content];
}

class SectionTitleTile extends Tile {
  SectionTitleTile({
    required this.content,
  });

  final String content;

  @override
  List<Object?> get props => [content];
}

class CardTile extends Tile implements Actionable {
  CardTile({
    required this.leading,
    required this.title,
    required this.description,
    required this.action,
  });

  final Uri leading;
  final String title;
  final String description;
  @override
  final ActionData action;

  @override
  List<Object?> get props => [leading, title, description];
}
