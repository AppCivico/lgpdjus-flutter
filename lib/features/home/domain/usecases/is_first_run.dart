import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/features/home/domain/repositories/app_manager_repository.dart';
import 'package:pub_semver/pub_semver.dart';

class IsFirstRunUseCase {
  IsFirstRunUseCase({
    required IAppConfiguration appConfiguration,
    required IAppManagerRepository repository,
  })  : _appConfiguration = appConfiguration,
        _repository = repository;

  final IAppConfiguration _appConfiguration;
  final IAppManagerRepository _repository;

  Future<bool> call() async {
    // legacy first run verification
    final isNotFirstRun = !await _appConfiguration.isFirstRun;
    if (isNotFirstRun) {
      await Future.wait([
        _repository.saveCurrentAppVersion(),
        _appConfiguration.removeFirstRunKey()
      ]);
      return false;
    }

    final savedAppVersion = await _repository.getSavedAppVersion();
    return savedAppVersion == Version.none;
  }
}
