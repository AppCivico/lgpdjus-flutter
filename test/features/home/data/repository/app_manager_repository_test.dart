import 'package:flutter_test/flutter_test.dart';
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/features/home/data/repository/app_manager_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

void main() {
  group('AppManagerRepositoryTest', () {
    late IAppManagerRepository sut;
    late IAppConfiguration appConfiguration;
    late PackageInfo packageInfo;

    setUp(() {
      appConfiguration = _AppConfigurationMock();
      packageInfo = _PackageInfo();
      sut = AppManagerRepository(
        appConfiguration: appConfiguration,
        packageInfo: packageInfo,
      );
    });

    test(
      'getCurrentAppVersion should get app version from PackageInfo',
      () async {
        // arrange
        const expectedAppVersion = '1.2.3';

        when(() => packageInfo.version).thenReturn(expectedAppVersion);

        // act
        final actualAppVersion = await sut.getCurrentAppVersion();

        // assert
        expect(actualAppVersion, Version(1, 2, 3));
      },
    );

    test(
      'getSavedAppVersion should get app version from appConfiguration',
      () async {
        // arrange
        const expectedAppVersion = '3.2.1';

        when(() => appConfiguration.savedAppVersion)
            .thenAnswer((_) async => expectedAppVersion);

        // act
        final actualAppVersion = await sut.getSavedAppVersion();

        // assert
        expect(actualAppVersion, Version(3, 2, 1));
      },
    );

    test(
      'saveCurrentAppVersion should save packageInfo.version to appConfiguration.version',
      () async {
        // arrange
        const expectedAppVersion = '9.87.654';

        when(() => packageInfo.version).thenReturn(expectedAppVersion);
        when(() => appConfiguration.appVersion = expectedAppVersion);

        // act
        await sut.saveCurrentAppVersion();

        // assert
        verify(() => appConfiguration.appVersion = expectedAppVersion)
            .called(1);
      },
    );
  });
}

class _AppConfigurationMock extends Mock implements IAppConfiguration {}

class _PackageInfo extends Mock implements PackageInfo {}
