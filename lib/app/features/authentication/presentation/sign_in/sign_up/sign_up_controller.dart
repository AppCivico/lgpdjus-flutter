import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/cpf.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/full_name.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/nickname.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:mobx/mobx.dart';

part 'sign_up_controller.g.dart';

class SignUpController extends _SignUpControllerBase with _$SignUpController {
  SignUpController(IUserRegisterRepository repository) : super(repository);
}

abstract class _SignUpControllerBase with Store, MapFailureMessage {
  final IUserRegisterRepository repository;
  UserRegisterFormFieldModel _userRegisterModel = UserRegisterFormFieldModel();

  _SignUpControllerBase(this.repository);

  @observable
  ObservableFuture? _progress;

  @observable
  String errorMessage = '';

  @observable
  String warningFullname = '';

  @observable
  String warningCpf = '';

  @observable
  String warningNickname = '';

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
  void setFullname(String fullname) {
    _userRegisterModel.fullname = Fullname(fullname);

    warningFullname =
        fullname.length == 0 ? '' : _userRegisterModel.validateFullName;
  }

  @action
  void setCpf(String cpf) {
    _userRegisterModel.cpf = Cpf(cpf);

    warningCpf = cpf.length == 0 ? '' : _userRegisterModel.validateCpf;
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
          .then((_) => _forwardToStep2())
          .catchError(_triggerMessageError),
    );

    await _progress;
  }

  void _forwardToStep2() {
    Modular.to.pushNamed('/authentication/signup/step3',
        arguments: _userRegisterModel);
  }

  bool _isValidToProceed() {
    bool isValid = true;

    if (_userRegisterModel.validateFullName.isNotEmpty) {
      isValid = false;
      warningFullname = _userRegisterModel.validateFullName;
    }

    if (_userRegisterModel.validateCpf.isNotEmpty) {
      isValid = false;
      warningCpf = _userRegisterModel.validateCpf;
    }

    if (_userRegisterModel.validateNickname.isNotEmpty) {
      isValid = false;
      warningNickname = _userRegisterModel.validateNickname;
    }

    return isValid;
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  void _triggerMessageError(Object failure) {
    if (failure is ServerSideFormFieldValidationFailure) {
      _setErrorMessage(_mapFailureToFields(failure));
    } else {
      _setErrorMessage(mapFailureMessage(failure));
    }
  }

  String _mapFailureToFields(ServerSideFormFieldValidationFailure failure) {
    String message = '';
    if (failure.field == 'nome_completo') {
      _mapToFullNameField(failure);
    } else if (failure.field == 'cpf') {
      _mapToCpfField(failure);
    } else {
      message = failure.message;
    }

    return message;
  }

  void _mapToFullNameField(ServerSideFormFieldValidationFailure failure) {
    String message = failure.message;
    if (failure.error == 'name_not_match') {
      message = 'Nome não confere com o CPF';
    }

    warningFullname = message;
  }

  void _mapToCpfField(ServerSideFormFieldValidationFailure failure) {
    String message = failure.message;

    warningCpf = message;
  }
}
