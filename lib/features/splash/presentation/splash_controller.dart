import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/core/data/authorization_status.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:lgpdjus/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/app/shared/navigation/route.dart';
import 'package:mobx/mobx.dart';

part 'splash_controller.g.dart';

class SplashController extends _SplashControllerBase with _$SplashController {
  SplashController({
    required IAppConfiguration appConfiguration,
    required AppStateUseCase appStateUseCase,
  }) : super(appConfiguration, appStateUseCase);
}

abstract class _SplashControllerBase with Store {
  final AppStateUseCase _appStateUseCase;
  final IAppConfiguration _appConfiguration;

  _SplashControllerBase(
    this._appConfiguration,
    this._appStateUseCase,
  ) {
    _init();
  }

  _init() async {
    final authorizationStatus = await _appConfiguration.authorizationStatus;
    switch (authorizationStatus) {
      case AuthorizationStatus.authenticated:
        await _validateAppStates();
        break;
      case AuthorizationStatus.anonymous:
        _forwardToMainBoard();
        break;
    }
  }

  Future<void> _validateAppStates() async {
    final appState = await _appStateUseCase.check();
    appState.fold(
      (failure) => _handleFailure(failure),
      (state) => _handleAppStates(state),
    );
  }

  void _forwardToMainBoard() {
    AppNavigator.popAndPush(AppRoute('/mainboard'));
    _appConfiguration.isFirstRun.then((value) {
      if (value) {
        AppNavigator.push(AppRoute('/tutorial/welcome')).then((value) {
          _appConfiguration.firstRun = false;
        });
      }
    });
  }

  void _forwardToAuthentication() {
    Modular.to.pushReplacementNamed('/authentication');
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerSideSessionFailed) {
      _forwardToAuthentication();
    } else {
      _forwardToMainBoard();
    }
  }

  void _handleAppStates(AppStateEntity session) {
    if (session.quizSession?.isFinished == false) {
      Modular.to.popAndPushNamed('/quiz', arguments: session.quizSession);
      return;
    }

    _forwardToMainBoard();
  }
}
