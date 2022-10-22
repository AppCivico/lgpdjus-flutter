import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/core/network/api_server_configure.dart';
import 'package:lgpdjus/app/core/network/interceptor/interceptor.dart';
import 'package:lgpdjus/app/core/network/network_info.dart';
import 'package:lgpdjus/app/core/storage/i_local_storage.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/privacy_policy/privacy_policy_page.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:lgpdjus/app/features/main_module.dart';
import 'package:lgpdjus/common/data/appstate/datasource.dart';
import 'package:lgpdjus/common/data/file_provider.dart';
import 'package:lgpdjus/common/di/widget_resolver.dart';
import 'package:lgpdjus/common/navigation/action_handler.dart';
import 'package:lgpdjus/core/di/module.dart' as di;
import 'package:lgpdjus/core/provider/file_provider.dart';
import 'package:lgpdjus/core/router/permission_guard.dart';
import 'package:lgpdjus/features/camera/module.dart';
import 'package:lgpdjus/features/quiz/quiz_module.dart';
import 'package:lgpdjus/features/splash/splash_module.dart';
import 'package:lgpdjus/features/tutorial/tutorial_module.dart';
import 'package:lgpdjus/features/user/user_module.dart';

import 'app_controller.dart';
import 'core/auth/authentication.dart';
import 'core/managers/modules_sevices.dart';
import 'core/network/api_client.dart';
import 'core/storage/local_storage_shared_preferences.dart';
import 'features/appstate/data/datasources/app_state_data_source.dart'
    as legacy;
import 'features/appstate/data/repositories/app_state_repository.dart';
import 'features/appstate/domain/repositories/i_app_state_repository.dart';
import 'features/appstate/domain/usecases/app_state_usecase.dart';
import 'features/authentication/domain/usecases/logout.dart';
import 'features/authentication/presentation/deleted_account/deleted_account_controller.dart';
import 'features/authentication/presentation/deleted_account/deleted_account_page.dart';
import 'features/authentication/presentation/sign_in/terms_of_use/terms_of_use_page.dart';
import 'features/main_menu/domain/repositories/user_profile_repository.dart';

class AppModule extends di.Module {
  final _authenticationStream = AuthenticationStream();

  @override
  List<Module> get modules => [
        AccountModule(),
      ];

  @override
  late final List<Bind> binds = [
    Bind.instance<AuthenticationObserver>(_authenticationStream),
    Bind.instance<AuthenticationSubject>(_authenticationStream),
    Bind.lazySingleton((i) => AppStateDataSource(i(), i())),
    Bind((i) => AppController()),
    Bind<IApiServerConfigure>(
      (i) => ApiServerConfigure(
        appConfiguration: i.get<IAppConfiguration>(),
      ),
    ),
    Bind.factory<List<HttpInterceptor>>(
      (i) => [
        FailureHandlerInterceptor(),
        ConnectionInterceptor(i()),
        UserAgentInterceptor(),
        AuthInterceptor(i()),
      ],
    ),
    Bind.lazySingleton<http.Client>(
      (i) => ApiClient(i.get<IAppConfiguration>().apiBaseUri, i()),
    ),
    Bind<INetworkInfo>(
      (i) => NetworkInfo(),
    ),
    Bind<IApiProvider>(
      (i) => ApiProvider(
        serverConfiguration: i.get<IApiServerConfigure>(),
        networkInfo: i.get<INetworkInfo>(),
      ),
      isSingleton: false,
    ),
    Bind<IUserProfileRepository>(
      (i) => UserProfileRepository(
        apiProvider: i.get<IApiProvider>(),
        serverConfiguration: i.get<IApiServerConfigure>(),
      ),
    ),
    Bind((i) => DeletedAccountController(
          profileRepository: i.get<IUserProfileRepository>(),
          appConfiguration: i.get<IAppConfiguration>(),
          sessionToken: i.args?.data,
        )),
    Bind<IAppConfiguration>(
      (i) => AppConfiguration(
        storage: i.get(),
        authenticationSubject: i.get(),
      ),
    ),
    Bind<IAppModulesServices>(
      (i) => AppModulesServices(
        storage: i.get<ILocalStorage>(),
      ),
    ),
    Bind<ILocalStorage>((i) => LocalStorageSharedPreferences()),
    Bind<AppStateUseCase>(
      (i) => AppStateUseCase(
          appStateRepository: i.get<IAppStateRepository>(),
          appModulesServices: i.get<IAppModulesServices>()),
    ),
    Bind<IAppStateRepository>(
      (i) => AppStateRepository(
        networkInfo: i.get<INetworkInfo>(),
        dataSource: i.get<legacy.IAppStateDataSource>(),
      ),
    ),
    Bind<legacy.IAppStateDataSource>(
      (i) => legacy.AppStateDataSource(
        apiClient: i.get<http.Client>(),
        dataSource: i(),
      ),
    ),
    Bind(
      (i) => LogoutUseCase(i.get()),
    ),
    Bind.factory<FileRepository>((i) => FileRepositoryImpl(i())),
    Bind.lazySingleton((i) => WidgetResolver()),
    Bind.lazySingleton<ActionHandler>((i) => DefaultActionHandler()),
  ];

  @override
  late final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute(
      '/authentication',
      module: SignInModule(),
      transition: TransitionType.rightToLeft,
    ),
    ModuleRoute('/mainboard', module: MainBoardModule()),
    ChildRoute('/account/verify', child: (_, args) => QuizModule()),
    ChildRoute('/quiz', child: (_, args) => QuizModule()),
    ChildRoute(
      '/quiz/:id',
      child: (_, args) => QuizModule(),
      transition: TransitionType.rightToLeft,
    ),
    ChildRoute(
      '/accountDeleted',
      child: (context, args) => DeletedAccountPage(),
      transition: TransitionType.rightToLeft,
    ),
    ChildRoute(
      '/terms_of_use',
      child: (_, args) => TermsOfUsePage(),
    ),
    ChildRoute(
      '/privacy_policy',
      child: (_, args) => PrivacyPolicyPage(),
    ),
    ModuleRoute(
      '/take_picture',
      guards: [CameraPermissionGuard()],
      module: CameraModule(),
    ),
    ModuleRoute('/tutorial', module: TutorialModule()),
  ];
}
