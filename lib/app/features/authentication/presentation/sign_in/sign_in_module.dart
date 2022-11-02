import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:lgpdjus/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:lgpdjus/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_in_page.dart';

class SignInModule extends Module {
  @override
  List<Bind> get binds => [
        ..._interfaces,
        // Sign-In
        Bind(
          (i) => SignInController(
            i.get<IAuthenticationRepository>(),
            i.get<AppStateUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => SignInPage()),
      ];

  List<Bind> get _interfaces => [
        Bind<IAuthenticationRepository>(
          (i) => AuthenticationRepository(
            dataSource: i.get<IAuthenticationDataSource>(),
            appConfiguration: i.get<IAppConfiguration>(),
          ),
        ),
        Bind<IAuthenticationDataSource>(
          (i) => AuthenticationDataSource(
            apiClient: i.get<http.Client>(),
          ),
        ),
      ];
}
