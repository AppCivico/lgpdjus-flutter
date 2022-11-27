import 'package:lgpdjus/app/core/extension/future.dart';
import 'package:lgpdjus/app/shared/logger/log.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/common/widgets/dialog.dart';
import 'package:lgpdjus/features/home/domain/entities.dart';
import 'package:lgpdjus/features/home/domain/usecases/get_release_notes.dart';
import 'package:lgpdjus/features/home/domain/usecases/get_screen_options.dart';
import 'package:lgpdjus/features/home/presentation/home_states.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController extends _HomeControllerBase with _$HomeController {
  HomeController({
    required GetScreenOptionsUseCase getScreenOptions,
    required GetReleaseNotesUseCase getReleaseNotes,
  }) : super(getScreenOptions, getReleaseNotes);
}

abstract class _HomeControllerBase with Store {
  _HomeControllerBase(this._getScreenOptions, this._getReleaseNotes) {
    setup();
  }

  final GetScreenOptionsUseCase _getScreenOptions;
  final GetReleaseNotesUseCase _getReleaseNotes;

  @observable
  DialogData? dialog;

  @observable
  HomeState state = HomeState.loading();
}

extension _PrivateMethod on _HomeControllerBase {
  Future<void> setup() async {
    loadData();
  }

  Future<void> loadData() async {
    state = await _getScreenOptions().then(_onSuccess).catchError(_onError);

    dialog = await _getReleaseNotes()
        .whenNotNull(_maybeShowChangelogDialog)
        .catchError(catchErrorLogger);
  }

  HomeState _onSuccess(Screen screen) => HomeState.loaded(screen);

  HomeState _onError(Object error, stacktrace) =>
      HomeState.error(error as Error);

  DialogData? _maybeShowChangelogDialog(String changelog) => DialogData(
        'Novidades dessa versão',
        changelog,
        NamedAction('OK', null),
      );
}
