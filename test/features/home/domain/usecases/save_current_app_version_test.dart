import 'package:flutter_test/flutter_test.dart';
import 'package:lgpdjus/features/home/domain/repositories/app_manager_repository.dart';
import 'package:lgpdjus/features/home/domain/usecases/save_current_app_version.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('SaveCurrentAppVersionTest', () {
    late SaveCurrentAppVersion sut;
    late IAppManagerRepository repository;

    setUp(() {
      repository = _AppManagerRepositoryMock();
      sut = SaveCurrentAppVersion(repository: repository);
    });

    test(
      'saveCurrentAppVersion should call repository.saveCurrentAppVersion',
      () async {
        when(() => repository.saveCurrentAppVersion()).thenAnswer((_) async {});

        await sut();
      },
    );
  });
}

class _AppManagerRepositoryMock extends Mock implements IAppManagerRepository {}
