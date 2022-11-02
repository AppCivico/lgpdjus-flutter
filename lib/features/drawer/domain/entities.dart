import 'package:lgpdjus/common/domain/titles/entity.dart';

class Menu {
  Menu({required this.sections});

  List<MenuSection> sections;
}

abstract class MenuSection {}

class MenuItem extends Actionable implements MenuSection {
  MenuItem({required this.title, required this.action});

  final String title;
  final ActionData action;
}

class MenuHeader extends MenuSection {
  MenuHeader({
    required this.title,
    required this.status,
  });

  final String title;
  final String status;
}

class MenuAction extends Actionable {
  MenuAction(this.name, this.action);

  final String name;

  @override
  final NavData action;
}
