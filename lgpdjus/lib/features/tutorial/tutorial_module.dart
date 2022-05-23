import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/shared/design_system/theme.dart';
import 'package:lgpdjus/core/di/feature_module.dart';
import 'package:lgpdjus/features/tutorial/presentation/lgpd/lgpd_tutorial_page.dart';
import 'package:lgpdjus/features/tutorial/presentation/tutorial_controller.dart';
import 'package:lgpdjus/features/tutorial/presentation/welcome/welcome_tutorial_page.dart';

class TutorialModule extends Module with FeatureModule {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/welcome',
          child: (context, _) => Theme(
            data: TutorialThemeFactory().of(context),
            child: WelcomeTutorialPage(),
          ),
        ),
        ChildRoute(
          '/lgpd',
          child: (context, _) => Theme(
            data: OrangeTutorialThemeFactory().of(context),
            child: LgpdTutorialPage(),
          ),
          transition: TransitionType.rightToLeft,
        ),
      ];

  @override
  List<Bind<Object>> get presentationBinds => [
        Bind.factory((i) => TutorialController()),
      ];
}
