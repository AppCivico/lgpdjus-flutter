import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:mobx/mobx.dart';

part 'sign_in_controller.g.dart';

class SignInController extends _SignInControllerBase with _$SignInController {
  SignInController(
    IAuthenticationRepository repository,
    AppStateUseCase appStateUseCase,
  ) : super(repository, appStateUseCase);
}

abstract class _SignInControllerBase with Store, MapFailureMessage {
  final IAuthenticationRepository repository;
  final AppStateUseCase _appStateUseCase;

  _SignInControllerBase(
    this.repository,
    this._appStateUseCase,
  );

  @observable
  ObservableFuture? _progress;

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
  Future<void> login() async {
    _setErrorMessage('');

    _progress = ObservableFuture(
      repository
          .getLoginUrl()
          .then(_launchURL)
          .then(_forwardToLogged)
          .catchError((error, stack) => _setErrorMessage(error, stack)),
    );

    await _progress;
  }

  Future<SessionEntity> _launchURL(String url) async {
    try {
      await FlutterWebAuth.authenticate(
        url: url,
        callbackUrlScheme: "lgpdjus",
      );
    } catch (e) {
      if (e is PlatformException && e.code == 'CANCELED') {
        throw AuthenticationFailed();
      }
    }

    return await repository.authenticate();
  }

  Future<void> _forwardToLogged(SessionEntity session) async {
    if (session.deletedScheduled) {
      Modular.to.pushNamed('/accountDeleted');
    } else {
      await _appStateUseCase
          .check()
          .then((_) => AppNavigator.popAuthentication())
          .catchError(_setErrorMessage);
    }
  }

  void _setErrorMessage(Object failure, [StackTrace? stack]) {
    errorMessage = mapFailureMessage(failure, stack);
  }
}
