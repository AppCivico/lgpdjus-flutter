import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/nickname.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:mobx/mobx.dart';

part 'sign_up_two_controller.g.dart';

class MenuItemModel {
  final String display;
  final String value;

  MenuItemModel(this.display, this.value);
}

class SignUpTwoController extends _SignUpTwoControllerBase
    with _$SignUpTwoController {
  SignUpTwoController(IUserRegisterRepository repository,
      UserRegisterFormFieldModel userFormFieldModel)
      : super(repository, userFormFieldModel);
}

abstract class _SignUpTwoControllerBase with Store, MapFailureMessage {
  final IUserRegisterRepository repository;
  final UserRegisterFormFieldModel _userRegisterModel;

  _SignUpTwoControllerBase(this.repository, this._userRegisterModel);

  @observable
  ObservableFuture? _progress;

  @observable
  String warningNickname = '';

  @observable
  String errorMessage = '';

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
  void setNickname(String name) {
    _userRegisterModel.nickname = Nickname(name);

    warningNickname =
        name.length == 0 ? '' : _userRegisterModel.validateNickname;
  }

  @action
  Future<void> nextStepPressed() async {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      repository
          .checkField(
            cpf: _userRegisterModel.cpf,
            fullname: _userRegisterModel.fullname,
            nickName: _userRegisterModel.nickname,
          )
          .then((_) => _forwardToStep3())
          .catchError(_setErrorMessage),
    );

    await _progress;
  }

  void _forwardToStep3() {
    Modular.to.pushNamed('/authentication/signup/step3',
        arguments: _userRegisterModel);
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.validateNickname.isNotEmpty) {
      isValid = false;
      warningNickname = _userRegisterModel.validateNickname;
    }

    return isValid;
  }

  void _setErrorMessage(Object failure) {
    errorMessage = mapFailureMessage(failure);
  }
}
