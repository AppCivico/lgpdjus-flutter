import 'package:lgpdjus/common/domain/titles/entity.dart';

class DetailsScreen {
  DetailsScreen({
    required this.items,
  });

  final List<Tile> items;
}

class HeaderTile extends Tile {
  HeaderTile({
    required this.introduction,
    required this.instruction,
  });

  final String introduction;
  final String instruction;

  @override
  List<Object?> get props => [introduction, instruction];
}

class CollapsedContentTile extends Tile {
  CollapsedContentTile({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  List<Object?> get props => [title, content];
}

class FooterTile extends Tile {
  FooterTile({required this.content});

  final String content;

  @override
  List<Object?> get props => [content];
}

class LinkButtonTile extends Actionable implements Tile {
  LinkButtonTile({
    required this.text,
    required this.action,
  });

  final String text;
  final ActionData? action;

  @override
  List<Object?> get props => [text, action];
}
