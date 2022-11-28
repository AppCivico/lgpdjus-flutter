import 'package:flutter_test/flutter_test.dart';
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/features/home/domain/repositories/app_manager_repository.dart';
import 'package:lgpdjus/features/home/domain/usecases/save_current_app_version.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('SaveCurrentAppVersionTest', () {
    late SaveCurrentAppVersion sut;
    late IAppManagerRepository repository;
    late IAppConfiguration appConfiguration;

    setUp(() {
      appConfiguration = _AppConfigurationMock();
      repository = _AppManagerRepositoryMock();
      sut = SaveCurrentAppVersion(
        appConfiguration: appConfiguration,
        repository: repository,
      );
    });

    test(
      'saveCurrentAppVersion should call repository.saveCurrentAppVersion',
      () async {
        // arrange
        when(() => repository.saveCurrentAppVersion()).thenAnswer((_) async {});
        when(() => appConfiguration.removeFirstRunKey())
            .thenAnswer((_) async {});

        // act
        await sut();

        // assert
        verify(() => repository.saveCurrentAppVersion()).called(1);
      },
    );

    test(
      'saveCurrentAppVersion should call appConfiguration.saveCurrentAppVersion',
      () async {
        // arrange
        when(() => repository.saveCurrentAppVersion()).thenAnswer((_) async {});
        when(() => appConfiguration.removeFirstRunKey())
            .thenAnswer((_) async {});

        // act
        await sut();

        // assert
        verify(() => appConfiguration.removeFirstRunKey()).called(1);
      },
    );
  });
}

class _AppConfigurationMock extends Mock implements IAppConfiguration {}

class _AppManagerRepositoryMock extends Mock implements IAppManagerRepository {}
