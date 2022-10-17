import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/core/di/feature_module.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/drawer/domain/repositories/menu_sections.dart';
import 'package:lgpdjus/features/drawer/domain/usecases/get_menu_sections.dart';
import 'package:lgpdjus/features/drawer/presentation/drawer_controller.dart';
import 'package:lgpdjus/features/drawer/presentation/drawer_page.dart';

import 'data/repositories/drawer_menu_sections.dart';

class DrawerModule extends ModularWidget with FeatureModule {
  @override
  late final Widget view = const DrawerPage();

  @override
  List<Bind<Object>> get presentationBinds => [
        Bind.factory<DrawerMenuController>(
          (i) => DrawerMenuController(i(), i()),
        ),
      ];

  @override
  List<Bind<Object>> get domainBinds => [
        Bind(
          (i) => GetMenuSectionsUseCase(i(), i()),
        ),
      ];

  @override
  List<Bind<Object>> get dataBinds => [
        Bind<MenuSectionsRepository>(
          (i) => DrawerMenuSectionsRepository(),
        ),
      ];
}
