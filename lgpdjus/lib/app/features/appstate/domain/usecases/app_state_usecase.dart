import 'package:dartz/dartz.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/core/managers/modules_sevices.dart';
import 'package:lgpdjus/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:lgpdjus/app/features/appstate/domain/entities/update_user_profile_entity.dart';
import 'package:lgpdjus/app/features/appstate/domain/repositories/i_app_state_repository.dart';

class AppStateUseCase {
  final IAppStateRepository _appStateRepository;
  final IAppModulesServices _appModulesServices;

  AppStateUseCase({
    required IAppStateRepository appStateRepository,
    required IAppModulesServices appModulesServices,
  })  : this._appStateRepository = appStateRepository,
        this._appModulesServices = appModulesServices;

  Future<Either<Failure, AppStateEntity>> check() async {
    final currentState = await _appStateRepository.check();
    return currentState.fold(left, _processAppState);
  }

  Future<Either<Failure, AppStateEntity>> update(
      UpdateUserProfileEntity update) async {
    final currentState = await _appStateRepository.update(update);

    return currentState.fold(
      (failure) => left(failure),
      (appState) => _processAppState(appState),
    );
  }

  Future<Either<Failure, AppStateEntity>> _processAppState(
      AppStateEntity appStateEntity) async {
    if (appStateEntity.modules != null)
      await _appModulesServices.save(appStateEntity.modules!);
    return right(appStateEntity);
  }
}
