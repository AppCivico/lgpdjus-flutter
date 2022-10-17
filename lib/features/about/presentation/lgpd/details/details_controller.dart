import 'package:lgpdjus/app/shared/logger/log.dart' as log;
import 'package:lgpdjus/common/extensions/mobx.dart';
import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';
import 'package:lgpdjus/features/about/domain/usecases/about_lgpd_usecases.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/details/details_states.dart';
import 'package:lgpdjus/features/about/presentation/lgpd/topics/topics_states.dart';
import 'package:mobx/mobx.dart';

part 'details_controller.g.dart';

class DetailsController extends _DetailsControllerBase
    with _$DetailsController {
  DetailsController(String topicId, GetDetailsUseCase getDetailsUseCase)
      : super(topicId, getDetailsUseCase);
}

abstract class _DetailsControllerBase with Store {
  _DetailsControllerBase(this.topicId, this._getDetails);

  final String topicId;
  final GetDetailsUseCase _getDetails;

  @observable
  late DetailsState state = _load();

  ObservableFuture? _loading;

  DetailsState _load() {
    if (_loading?.status != FutureStatus.pending) {
      _loading = _getDetails.call(topicId).observeWith(_onLoaded, _onFailure);
    }
    return DetailsState.loading();
  }

  retry() {
    state = _load();
  }

  _onLoaded(DetailsScreen screen) {
    state = DetailsState.loaded(screen);
  }

  _onFailure(Object error, StackTrace stackTrace) {
    log.error(error, stackTrace);
    state = DetailsState.failed(error);
  }
}
