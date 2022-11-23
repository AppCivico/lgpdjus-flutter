import 'package:dartz/dartz.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:lgpdjus/app/features/main_menu/domain/entities/account_preference_entity.dart';
import 'package:lgpdjus/app/features/main_menu/domain/repositories/user_profile_repository.dart';
import 'package:lgpdjus/app/features/main_menu/domain/states/account_preference_state.dart';
import 'package:mobx/mobx.dart';

part 'account_preference_controller.g.dart';

class AccountPreferenceController extends _AccountPreferenceControllerBase
    with _$AccountPreferenceController {
  AccountPreferenceController(
      {required IUserProfileRepository profileRepository})
      : super(profileRepository);
}

abstract class _AccountPreferenceControllerBase with Store, MapFailureMessage {
  final IUserProfileRepository _userProfileRepository;

  _AccountPreferenceControllerBase(this._userProfileRepository) {
    loadPage();
  }

  @observable
  ObservableFuture<Either<Failure, AccountPreferenceSessionEntity>>? _progress;

  @observable
  AccountPreferenceState state = AccountPreferenceState.initial();

  @observable
  String messageError = "";

  @computed
  PageProgressState get progress {
    return monitorProgress(_progress);
  }

  @action
  Future<void> retry() async {
    loadPage();
  }

  @action
  Future<void> update(String key, bool status) async {
    setMessageErro("");
    _progress = ObservableFuture(
      _userProfileRepository.updatePreferences(key: key, status: status),
    );

    final result = await _progress;

    result?.fold(
      (failure) => handleUpdateError(failure, StackTrace.current),
      (session) => handleSession(session),
    );
  }
}

extension _MethodPrivate on _AccountPreferenceControllerBase {
  Future<void> loadPage() async {
    final result = await _userProfileRepository.preferences();

    result.fold(
      (failure) => handleError(failure, StackTrace.current),
      (session) => handleSession(session),
    );
  }

  void handleSession(AccountPreferenceSessionEntity session) {
    state = AccountPreferenceState.loaded(session.preferences);
  }

  void handleError(Failure failure, StackTrace? stack) {
    final message = mapFailureMessage(failure, stack);
    state = AccountPreferenceState.error(message);
  }

  void handleUpdateError(Failure failure, StackTrace? stack) {
    final message = mapFailureMessage(failure, stack);
    setMessageErro(message);
  }

  void setMessageErro(String message) {
    messageError = message;
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
