import 'package:lgpdjus/features/home/domain/entity/release_notes.dart';
import 'package:pub_semver/pub_semver.dart';

abstract class IAppManagerRepository {
  Future<List<ReleaseNote>> getReleaseNotes();

  Future<Version> getCurrentAppVersion();

  Future<Version> getSavedAppVersion();

  Future<void> saveCurrentAppVersion();
}
