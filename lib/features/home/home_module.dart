import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/home/data/repository/home_screen_options.dart';
import 'package:lgpdjus/features/home/domain/usecases/get_release_notes.dart';
import 'package:lgpdjus/features/home/domain/usecases/get_screen_options.dart';
import 'package:lgpdjus/features/home/presentation/home_controller.dart';
import 'package:lgpdjus/features/home/presentation/home_page.dart';

import 'domain/repositories/screen_options.dart';

class HomeModule extends ModularWidget {
  @override
  late final Widget view = const HomePage();

  @override
  List<Bind> get binds => [
        Bind.factory<HomeController>(
          (i) => HomeController(
            getScreenOptions: i(),
            getReleaseNotes: i(),
          ),
        ),
        Bind((i) => GetScreenOptionsUseCase(i())),
        Bind((i) => GetReleaseNotesUseCase()),
        Bind<ScreenOptionsRepository>((i) => HomeScreenOptionsRepository()),
      ];
}
