import 'package:lgpdjus/app/shared/logger/log.dart' as log;
import 'package:lgpdjus/common/extensions/mobx.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';
import 'package:lgpdjus/features/about/domain/usecases/about_lgpd_usecases.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/topics/topics_states.dart';
import 'package:mobx/mobx.dart';

part 'topics_controller.g.dart';

class TopicsController extends _TopicsControllerBase
    with _$TopicsController {
  TopicsController(GetTopicsUseCase getTopicsUseCase)
      : super(getTopicsUseCase);
}

abstract class _TopicsControllerBase with Store {
  _TopicsControllerBase(this._getTopics);

  final GetTopicsUseCase _getTopics;

  @observable
  late TopicsState state = _load();

  ObservableFuture? _loading;

  TopicsState _load() {
    if (_loading?.status != FutureStatus.pending) {
      _loading = _getTopics.call().observeWith(_onLoaded, _onFailure);
    }
    return TopicsState.loading();
  }

  retry() {
    state = _load();
  }

  _onLoaded(TopicsScreen screen) {
    state = TopicsState.loaded(screen);
  }

  _onFailure(Object error, StackTrace stackTrace) {
    log.error(error, stackTrace);
    state = TopicsState.failed(error);
  }
}
