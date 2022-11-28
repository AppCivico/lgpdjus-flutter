import 'package:lgpdjus/features/home/domain/repositories/app_manager_repository.dart';

class SaveCurrentAppVersion {
  SaveCurrentAppVersion({
    required IAppManagerRepository repository,
  }) : _repository = repository;

  final IAppManagerRepository _repository;

  Future<void> call() => _repository.saveCurrentAppVersion();
}
