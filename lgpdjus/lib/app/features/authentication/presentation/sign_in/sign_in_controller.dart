import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_in_password.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/core/config.dart';
import 'package:mobx/mobx.dart';

part 'sign_in_controller.g.dart';

class SignInController extends _SignInControllerBase with _$SignInController {
  SignInController(
    IAuthenticationRepository repository,
    PasswordValidator passwordValidator,
    AppStateUseCase appStateUseCase,
    Config config,
  ) : super(repository, passwordValidator, appStateUseCase, config.user);
}

abstract class _SignInControllerBase with Store, MapFailureMessage {
  final String _invalidFieldsToProceedLogin =
      'E-mail e senha precisam estarem corretos para continuar.';
  final IAuthenticationRepository repository;
  final PasswordValidator _passwordValidator;
  final AppStateUseCase _appStateUseCase;
  final Login login;
  late EmailAddress _emailAddress = EmailAddress(login.user ?? '');
  SignInPassword? _password;

  _SignInControllerBase(
    this.repository,
    this._passwordValidator,
    this._appStateUseCase,
    this.login,
  ) {
    _password = SignInPassword(login.password ?? '', _passwordValidator);
  }

  @observable
  ObservableFuture? _progress;

  @observable
  String warningEmail = "";

  @observable
  String warningPassword = "";

  @observable
  String errorMessage = "";

  @computed
  PageProgressState get currentState {
    if (_progress == null || _progress?.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _progress?.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  void setEmail(String address) {
    _emailAddress = EmailAddress(address);

    warningEmail = address.length == 0 ? '' : _emailAddress.mapFailure;
  }

  @action
  void setPassword(String password) {
    _password = SignInPassword(password, _passwordValidator);
    warningPassword = _password!.mapFailure;
  }

  @action
  Future<void> signInWithEmailAndPasswordPressed() async {
    _setErrorMessage('');

    if (!_emailAddress.isValid || _password?.isValid != true) {
      _setErrorMessage(_invalidFieldsToProceedLogin);
      return;
    }

    _progress = ObservableFuture(
      repository
          .signInWithEmailAndPassword(
            emailAddress: _emailAddress,
            password: _password!,
          )
          .then(_forwardToLogged)
          .catchError(_setErrorMessage),
    );

    await _progress;
  }

  @action
  Future<void> registerUserPressed() async {
    Modular.to.pushNamed('/authentication/signup');
  }

  @action
  Future<void> resetPasswordPressed() async {
    Modular.to.pushNamed('/authentication/reset_password');
  }

  Future<void> _forwardToLogged(SessionEntity session) async {
    if (session.deletedScheduled) {
      Modular.to.pushNamed('/accountDeleted', arguments: session.sessionToken);
    } else {
      await _appStateUseCase
          .check()
          .then((_) => AppNavigator.popAuthentication())
          .catchError(_setErrorMessage);
    }
  }

  void _setErrorMessage(Object failure) {
    errorMessage = mapFailureMessage(failure);
  }
}
