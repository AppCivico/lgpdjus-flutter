import 'package:dartz/dartz.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_up_password.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:mobx/mobx.dart';

part 'sign_up_three_controller.g.dart';

class SignUpThreeController extends _SignUpThreeControllerBase
    with _$SignUpThreeController {
  SignUpThreeController(
    IUserRegisterRepository repository,
    UserRegisterFormFieldModel userFormFielModel,
    PasswordValidator passwordValidator,
  ) : super(repository, userFormFielModel, passwordValidator);
}

abstract class _SignUpThreeControllerBase with Store, MapFailureMessage {
  final IUserRegisterRepository repository;
  final UserRegisterFormFieldModel _userRegisterModel;
  final PasswordValidator _passwordValidator;

  _SignUpThreeControllerBase(
      this.repository, this._userRegisterModel, this._passwordValidator);

  @observable
  ObservableFuture? _progress;

  @observable
  String warningEmail = '';

  @observable
  String warningPassword = '';

  @observable
  String warningConfirmationPassword = '';

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
  void setEmail(String email) {
    _userRegisterModel.emailAddress = EmailAddress(email);

    warningEmail =
        email.length == 0 ? '' : _userRegisterModel.validateEmailAddress;
  }

  @action
  void setPassword(String password) {
    _userRegisterModel.password = SignUpPassword(password, _passwordValidator);
    warningPassword = _userRegisterModel.password!.mapFailure;
    warningConfirmationPassword =
        _userRegisterModel.passwordConfirmation.isEmpty
            ? ''
            : _userRegisterModel.validatePasswordConfirmation;
  }

  @action
  void setConfirmationPassword(String password) {
    _userRegisterModel.passwordConfirmation = password;
    warningConfirmationPassword =
        _userRegisterModel.passwordConfirmation.isEmpty
            ? ''
            : _userRegisterModel.validatePasswordConfirmation;
  }

  @action
  Future<void> registerUserPress() async {
    _setErrorMessage('');
    if (!_isValidToProceed()) {
      return;
    }

    _progress = ObservableFuture(
      repository
          .signup(
            emailAddress: _userRegisterModel.emailAddress,
            password: _userRegisterModel.password!,
            cpf: _userRegisterModel.cpf,
            fullname: _userRegisterModel.fullname,
            nickName: _userRegisterModel.nickname,
          )
          .then((_) => _forwardToLogged())
          .catchError(_setErrorMessage),
    );

    await _progress;
  }

  void _setErrorMessage(Object failure) {
    errorMessage = mapFailureMessage(failure);
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.validateEmailAddress.isNotEmpty) {
      isValid = false;
      warningEmail = _userRegisterModel.validateEmailAddress;
    }

    isValid = _userRegisterModel.password?.isValid == true;

    if (!isValid) {
      warningPassword = _userRegisterModel.password!.mapFailure;
    }

    if (_userRegisterModel.validatePasswordConfirmation.isNotEmpty) {
      isValid = false;
      warningConfirmationPassword =
          _userRegisterModel.validatePasswordConfirmation;
    }

    return isValid;
  }

  _forwardToLogged() {
    AppNavigator.popAuthentication();
    AppNavigator.pushNamedIfExists('/authentication/verify_account');
  }
}
