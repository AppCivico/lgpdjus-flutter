import 'package:lgpdjus/app/core/extension/future.dart';
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/features/home/domain/entity/release_notes.dart';
import 'package:lgpdjus/features/home/domain/repositories/app_manager_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

export 'package:lgpdjus/features/home/domain/repositories/app_manager_repository.dart';

class AppManagerRepository implements IAppManagerRepository {
  AppManagerRepository({
    required IAppConfiguration appConfiguration,
    PackageInfo? packageInfo,
  })  : _appConfiguration = appConfiguration,
        _packageInfo = packageInfo;

  final IAppConfiguration _appConfiguration;
  PackageInfo? _packageInfo;

  @override
  Future<List<ReleaseNote>> getReleaseNotes() async => [
        ReleaseNote(
          version: '2.0.0',
          notes: '● Autenticação via gov.br\n● FAQ de acessibilidade',
        ),
      ];

  @override
  Future<Version> getSavedAppVersion() => _appConfiguration.savedAppVersion
      .whenNotNull(Version.parse)
      .whenNull(() => Version.none);

  @override
  Future<Version> getCurrentAppVersion() => _appVersion().then(Version.parse);

  @override
  Future<void> saveCurrentAppVersion() async {
    _appConfiguration.appVersion = await _appVersion();
  }

  Future<String> _appVersion() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!.version;
  }
}
