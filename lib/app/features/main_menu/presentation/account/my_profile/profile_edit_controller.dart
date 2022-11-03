import 'package:dartz/dartz.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:lgpdjus/app/features/appstate/domain/entities/update_user_profile_entity.dart';
import 'package:lgpdjus/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/main_menu/domain/states/profile_edit_state.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_usecase.dart';
import 'package:mobx/mobx.dart';

part 'profile_edit_controller.g.dart';

class ProfileEditController extends _ProfileEditControllerBase
    with _$ProfileEditController {
  ProfileEditController(
    GetAccountUseCase getProfileUseCase,
    AppStateUseCase appStateUseCase,
  ) : super(getProfileUseCase, appStateUseCase);
}

abstract class _ProfileEditControllerBase with Store, MapFailureMessage {
  _ProfileEditControllerBase(this._getAccount, this._appStateUseCase) {
    loadProfile();
  }

  final GetAccountUseCase _getAccount;
  final AppStateUseCase _appStateUseCase;

  @observable
  ObservableFuture<Either<Failure, AppStateEntity>>? _progress;

  @observable
  ProfileEditState state = ProfileEditState.initial();

  @observable
  String updateError = "";

  @computed
  PageProgressState get progressState {
    return monitorProgress(_progress);
  }

  @action
  Future<void> retry() async {
    loadProfile();
  }

  @action
  Future<void> editNickName(String name) async {
    clearMessageError();
    final update = UpdateUserProfileEntity(nickName: name);
    updateProfile(update);
  }

  @action
  Future<void> updatedEmail(String email) async {
    clearMessageError();
    final update = UpdateUserProfileEntity(email: email);
    updateProfile(update);
  }
}

extension _PrivateMethod on _ProfileEditControllerBase {
  Future<void> loadProfile() async {
    _getAccount()
        .skipWhile((event) => event == null)
        .map<Account>((event) => event!)
        .listen(handleProfile, onError: handleLoadPageError);
  }

  Future<void> updateProfile(UpdateUserProfileEntity update) async {
    _progress = ObservableFuture(_appStateUseCase.update(update));

    final result = await _progress;

    result?.fold(
      (failure) => handleUpdateError(failure),
      (_) {},
    );
  }

  void handleProfile(Account profile) async {
    state = ProfileEditState.loaded(profile);
  }

  handleLoadPageError(Object failure, StackTrace? stack) {
    final message = mapFailureMessage(failure, stack);
    state = ProfileEditState.error(message);
  }

  void handleUpdateError(Failure failure) {
    final msg = mapFailureMessage(failure);
    setMessageError(msg);
  }

  void setMessageError(String message) {
    updateError = message;
  }

  void clearMessageError() {
    setMessageError('');
  }

  PageProgressState monitorProgress(ObservableFuture<Object>? observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }
}
