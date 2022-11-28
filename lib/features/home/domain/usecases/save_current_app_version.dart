import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/features/home/domain/repositories/app_manager_repository.dart';

class SaveCurrentAppVersion {
  SaveCurrentAppVersion({
    required IAppConfiguration appConfiguration,
    required IAppManagerRepository repository,
  })  : _repository = repository,
        _appConfiguration = appConfiguration;

  final IAppConfiguration _appConfiguration;
  final IAppManagerRepository _repository;

  Future<void> call() => _repository
      .saveCurrentAppVersion()
      .then((_) => _appConfiguration.removeFirstRunKey());
}
