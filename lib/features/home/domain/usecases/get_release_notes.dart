import 'package:lgpdjus/features/home/domain/entity/release_notes.dart';
import 'package:lgpdjus/features/home/domain/repositories/app_manager_repository.dart';
import 'package:pub_semver/pub_semver.dart';

class GetReleaseNotesUseCase {
  GetReleaseNotesUseCase({
    required IAppManagerRepository repository,
  }) : _repository = repository;

  final IAppManagerRepository _repository;

  Future<String?> call() => _repository.getSavedAppVersion().then(
        (version) async => await _isCurrentVersionNotSaved(version)
            ? _getReleaseNotesAfterVersion(version)
            : null,
      );

  Future<bool> _isCurrentVersionNotSaved(Version saved) async =>
      saved == Version.none || saved < await _repository.getCurrentAppVersion();

  Future<String?> _getReleaseNotesAfterVersion(Version version) async {
    Iterable<ReleaseNote> releaseNotes = await _repository.getReleaseNotes();
    if (version != Version.none) {
      releaseNotes = releaseNotes.skipWhile((e) => e.version <= version);
    }
    return releaseNotes.isNotEmpty
        ? releaseNotes.map((e) => e.notes).join('\n')
        : null;
  }
}
