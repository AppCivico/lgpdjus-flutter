import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';

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
  final AccountStatus status;
}

class MenuHeaderUnverified extends MenuHeader {
  MenuHeaderUnverified({
    required String title,
    required this.subtitle,
    required this.action,
    required AccountStatus status,
  }) : super(title: title, status: status);

  final String subtitle;
  final MenuAction action;
}

class MenuAction extends Actionable {
  MenuAction(this.name, this.action);

  final String name;

  @override
  final NavData action;
}
