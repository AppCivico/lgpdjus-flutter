import 'package:lgpdjus/features/home/domain/entities.dart';
import 'package:lgpdjus/features/home/domain/usecases/get_screen_options.dart';
import 'package:lgpdjus/features/home/presentation/home_states.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController extends _HomeControllerBase with _$HomeController {
  HomeController(GetScreenOptionsUseCase getScreenOptions)
      : super(getScreenOptions);
}

abstract class _HomeControllerBase with Store {
  _HomeControllerBase(this.getScreenOptions) {
    setup();
  }

  final GetScreenOptionsUseCase getScreenOptions;

  @observable
  HomeState state = HomeState.loading();
}

extension _PrivateMethod on _HomeControllerBase {
  Future<void> setup() async {
    loadData();
  }

  Future<void> loadData() async {
    state = await getScreenOptions().then(_onSuccess).catchError(_onError);
  }

  HomeState _onSuccess(Screen screen) => HomeState.loaded(screen);

  HomeState _onError(Object error, stacktrace) =>
      HomeState.error(error as Error);
}
