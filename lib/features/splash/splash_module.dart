import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:lgpdjus/features/splash/presentation/splash_controller.dart';
import 'package:lgpdjus/features/splash/presentation/splash_page.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => SplashController(
            appConfiguration: i.get<IAppConfiguration>(),
            appStateUseCase: i.get<AppStateUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => SplashPage()),
      ];
}
