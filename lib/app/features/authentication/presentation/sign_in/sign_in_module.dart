import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/core/network/api_server_configure.dart';
import 'package:lgpdjus/app/core/network/network_info.dart';
import 'package:lgpdjus/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:lgpdjus/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:lgpdjus/app/features/authentication/data/datasources/change_password_data_source.dart';
import 'package:lgpdjus/app/features/authentication/data/datasources/user_register_data_source.dart';
import 'package:lgpdjus/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:lgpdjus/app/features/authentication/data/repositories/change_password_repository.dart';
import 'package:lgpdjus/app/features/authentication/data/repositories/user_register_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_controller.dart';
import 'package:lgpdjus/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_page.dart';
import 'package:lgpdjus/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_controller.dart';
import 'package:lgpdjus/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_page.dart';
import 'package:lgpdjus/app/features/authentication/presentation/reset_password/reset_password_controller.dart';
import 'package:lgpdjus/app/features/authentication/presentation/reset_password/reset_password_page.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_in_page.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_three/sign_up_three_controller.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_three/sign_up_three_page.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_controller.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_page.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_up/sign_up_controller.dart';
import 'package:lgpdjus/app/features/authentication/presentation/sign_in/sign_up/sign_up_page.dart';
import 'package:lgpdjus/features/user/verification/user_verification_pending_page.dart';
import 'package:lgpdjus/features/user/verification/user_verification_page.dart';

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
        ..._signUp,
        ..._resetPassword,
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => SignInPage()),
        ChildRoute('/signup',
            child: (_, args) => SignUpPage(),
            transition: TransitionType.rightToLeft),
        ChildRoute(
          '/signup/step2',
          child: (_, args) => SignUpTwoPage(),
        ),
        ChildRoute(
          '/signup/step3',
          child: (_, args) => SignUpThreePage(),
        ),
        ChildRoute(
          '/reset_password',
          child: (_, args) => ResetPasswordPage(),
        ),
        ChildRoute(
          '/reset_password/step2',
          child: (_, args) => ResetPasswordTwoPage(),
        ),
        ChildRoute(
          '/reset_password/step3',
          child: (_, args) => ResetPasswordThreePage(),
        ),
        ChildRoute(
          '/verify_account',
          child: (_, args) => AccountVerificationPage(),
        ),
        ChildRoute(
          '/verification_in_progress',
          child: (_, args) => AccountPendingVerificationPage(),
        ),
      ];

  List<Bind> get _interfaces => [
        Bind<IResetPasswordRepository>(
          (i) => ChangePasswordRepository(
            changePasswordDataSource: i.get<IChangePasswordDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
        ),
        Bind<IChangePasswordDataSource>(
          (i) => ChangePasswordDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
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
        Bind<IUserRegisterRepository>(
          (i) => UserRegisterRepository(
            dataSource: i.get<IUserRegisterDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
            appConfiguration: i.get<IAppConfiguration>(),
          ),
        ),
        Bind<IUserRegisterDataSource>(
          (i) => UserRegisterDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind<PasswordValidator>((_) => PasswordValidator())
      ];

  List<Bind> get _signUp => [
        // Sign-Up
        Bind((i) => SignUpController(i.get<IUserRegisterRepository>()),
            isSingleton: false),
        Bind(
          (i) => SignUpTwoController(
            i.get<IUserRegisterRepository>(),
            i.args?.data,
          ),
        ),
        Bind(
          (i) => SignUpThreeController(
            i.get<IUserRegisterRepository>(),
            i.args?.data,
            i.get<PasswordValidator>(),
          ),
        ),
      ];

  List<Bind> get _resetPassword => [
        Bind((i) => ResetPasswordController(i.get<IResetPasswordRepository>())),
        Bind(
          (i) => ResetPasswordTwoController(
            i.get<IChangePasswordRepository>(),
            i.args?.data,
          ),
        ),
        Bind(
          (i) => ResetPasswordThreeController(
            i.get<IChangePasswordRepository>(),
            i.args?.data,
            i.get<PasswordValidator>(),
          ),
        ),
      ];
}
