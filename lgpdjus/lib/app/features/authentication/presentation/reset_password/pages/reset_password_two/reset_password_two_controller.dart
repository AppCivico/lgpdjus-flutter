import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:mobx/mobx.dart';

part 'reset_password_two_controller.g.dart';

const String _WARNING_TOKEN = 'Precisa digitar o código enviado';

class ResetPasswordTwoController extends _ResetPasswordTwoControllerBase
    with _$ResetPasswordTwoController {
  ResetPasswordTwoController(IChangePasswordRepository repository,
      UserRegisterFormFieldModel userRegisterModel)
      : super(repository, userRegisterModel);
}

abstract class _ResetPasswordTwoControllerBase with Store, MapFailureMessage {
  final IChangePasswordRepository repository;
  final UserRegisterFormFieldModel _userRegisterModel;

  _ResetPasswordTwoControllerBase(this.repository, this._userRegisterModel);

  @observable
  ObservableFuture? _progress;

  @observable
  String errorMessage = '';

  @observable
  String warrningToken = '';

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
  Future<void> setToken(String token) async {
    _userRegisterModel.token = token.replaceAll(RegExp(r'\D'), '');
  }

  @action
  Future<void> nextStepPressed() async {
    _setErrorMessage('');
    if (_userRegisterModel.token == null ||
        _userRegisterModel.token.length < 6) {
      _setErrorMessage(_WARNING_TOKEN);
      return;
    }

    _progress = ObservableFuture(
      repository
          .validToken(
            emailAddress: _userRegisterModel.emailAddress,
            resetToken: _userRegisterModel.token,
          )
          .then((_) => _forwardToStep3())
          .catchError(_setErrorMessage),
    );

    await _progress;
  }

  void _setErrorMessage(Object failure) {
    errorMessage = mapFailureMessage(failure);
  }

  void _forwardToStep3() {
    Modular.to.pushNamed('/authentication/reset_password/step3',
        arguments: _userRegisterModel);
  }
}
