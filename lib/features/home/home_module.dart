import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/home/data/repository/app_manager_repository.dart';
import 'package:lgpdjus/features/home/data/repository/home_screen_options.dart';
import 'package:lgpdjus/features/home/domain/usecases/save_current_app_version.dart';
import 'package:lgpdjus/features/home/domain/usecases/get_release_notes.dart';
import 'package:lgpdjus/features/home/domain/usecases/get_screen_options.dart';
import 'package:lgpdjus/features/home/domain/usecases/is_first_run.dart';
import 'package:lgpdjus/features/home/presentation/home_controller.dart';
import 'package:lgpdjus/features/home/presentation/home_page.dart';

import 'domain/repositories/screen_options.dart';

class HomeModule extends ModularWidget {
  @override
  late final Widget view = const HomePage();

  @override
  List<Bind> get binds => [
        Bind.factory<HomeController>(
          (inject) => HomeController(
            getScreenOptions: inject(),
            isFirstRunUseCase: inject(),
            getReleaseNotes: inject(),
            saveCurrentAppVersion: inject(),
          ),
        ),
        Bind(
          (inject) => GetScreenOptionsUseCase(inject()),
        ),
        Bind(
          (inject) => IsFirstRunUseCase(
            appConfiguration: inject(),
            repository: inject(),
          ),
        ),
        Bind(
          (inject) => GetReleaseNotesUseCase(
            repository: inject(),
          ),
        ),
        Bind(
          (inject) => SaveCurrentAppVersion(
            repository: inject(),
          ),
        ),
        Bind<ScreenOptionsRepository>(
          (inject) => HomeScreenOptionsRepository(),
        ),
        Bind<IAppManagerRepository>(
          (inject) => AppManagerRepository(appConfiguration: inject()),
        ),
      ];
}
