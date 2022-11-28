import 'package:flutter/widgets.dart';
import 'package:lgpdjus/app/core/extension/future.dart';
import 'package:lgpdjus/app/shared/logger/log.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/common/widgets/dialog.dart';
import 'package:lgpdjus/features/home/domain/entities.dart';
import 'package:lgpdjus/features/home/domain/usecases/save_current_app_version.dart';
import 'package:lgpdjus/features/home/domain/usecases/get_release_notes.dart';
import 'package:lgpdjus/features/home/domain/usecases/get_screen_options.dart';
import 'package:lgpdjus/features/home/domain/usecases/is_first_run.dart';
import 'package:lgpdjus/features/home/presentation/home_states.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController extends _HomeControllerBase with _$HomeController {
  HomeController({
    required GetScreenOptionsUseCase getScreenOptions,
    required IsFirstRunUseCase isFirstRunUseCase,
    required GetReleaseNotesUseCase getReleaseNotes,
    required SaveCurrentAppVersion saveCurrentAppVersion,
  }) : super(
          getScreenOptions,
          isFirstRunUseCase,
          getReleaseNotes,
          saveCurrentAppVersion,
        );
}

abstract class _HomeControllerBase with Store {
  _HomeControllerBase(
    this._getScreenOptions,
    this._isFirstRun,
    this._getReleaseNotes,
    this._saveCurrentAppVersion,
  ) {
    setup();
  }

  final GetScreenOptionsUseCase _getScreenOptions;
  final IsFirstRunUseCase _isFirstRun;
  final GetReleaseNotesUseCase _getReleaseNotes;
  final SaveCurrentAppVersion _saveCurrentAppVersion;

  @observable
  HomeEvent? event;

  @observable
  HomeState state = HomeState.loading();

  void saveCurrentAppVersion() {
    _saveCurrentAppVersion().catchError(catchErrorLogger);
  }
}

extension _PrivateMethod on _HomeControllerBase {
  Future<void> setup() async {
    loadData();
  }

  Future<void> loadData() async {
    state = await _getScreenOptions().then(_onSuccess).catchError(_onError);
    event = await _loadInitialReaction().catchError(catchErrorLogger);
  }

  Future<HomeEvent?> _loadInitialReaction() async {
    if (await _isFirstRun()) {
      return HomeEvent.showTutorial();
    }
    return _getReleaseNotes()
        .whenNotNull(_toReleaseNotesDialog)
        .whenNotNull(HomeEvent.showDialog);
  }

  HomeState _onSuccess(Screen screen) => HomeState.loaded(screen);

  HomeState _onError(Object error, stacktrace) =>
      HomeState.error(error as Error);

  DialogData _toReleaseNotesDialog(String releaseNotes) => DialogData(
        title: 'Novidades dessa versão',
        content: releaseNotes,
        primaryAction: NamedAction('OK', Runnable(saveCurrentAppVersion)),
        contentAlign: TextAlign.left,
      );
}
