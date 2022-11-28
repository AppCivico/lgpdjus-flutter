import 'package:flutter_test/flutter_test.dart';
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/features/home/domain/repositories/app_manager_repository.dart';
import 'package:lgpdjus/features/home/domain/usecases/is_first_run.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

void main() {
  group('IsFirstRunUseCaseTest', () {
    late IsFirstRunUseCase sut;
    late IAppManagerRepository repository;
    late IAppConfiguration appConfiguration;

    setUp(() {
      repository = _AppManagerRepositoryMock();
      appConfiguration = _AppConfigurationMock();
      sut = IsFirstRunUseCase(
        repository: repository,
        appConfiguration: appConfiguration,
      );
    });

    test(
      'when appConfiguration.isFirstRun is false should return false',
      () async {
        // arrange
        when(() => appConfiguration.isFirstRun).thenAnswer((_) async => false);
        when(() => appConfiguration.removeFirstRunKey())
            .thenAnswer((_) async {});
        when(() => repository.saveCurrentAppVersion()).thenAnswer((_) async {});

        // act
        final actualIsFirstRun = await sut();

        // assert
        expect(actualIsFirstRun, false);
      },
    );

    test(
      'when saved version is none should return true',
      () async {
        // arrange
        when(() => appConfiguration.isFirstRun).thenAnswer((_) async => true);
        when(() => repository.getSavedAppVersion())
            .thenAnswer((_) async => Version.none);

        // act
        final actualIsFirstRun = await sut();

        // assert
        expect(actualIsFirstRun, true);
      },
    );

    test(
      'version is not none should return false',
      () async {
        // arrange
        when(() => appConfiguration.isFirstRun).thenAnswer((_) async => true);
        when(() => repository.getSavedAppVersion())
            .thenAnswer((_) async => Version(1, 2, 3));

        // act
        final actualIsFirstRun = await sut();

        // assert
        expect(actualIsFirstRun, false);
      },
    );
  });
}

class _AppConfigurationMock extends Mock implements IAppConfiguration {}

class _AppManagerRepositoryMock extends Mock implements IAppManagerRepository {}
