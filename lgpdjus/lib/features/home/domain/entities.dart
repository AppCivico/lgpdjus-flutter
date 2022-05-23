import 'package:lgpdjus/app/shared/design_system/theme.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';

class Screen {
  Screen({required this.title, required this.options});

  final String title;
  final List<Option> options;
}

class Option extends Actionable {
  Option({
    required this.text,
    required this.action,
    required this.theme,
  });

  final String text;
  final ActionData action;
  final ThemeFactory theme;
}
