import 'package:flutter_test/flutter_test.dart';
import 'package:lgpdjus/features/home/data/repository/app_manager_repository.dart';
import 'package:lgpdjus/features/home/domain/entity/release_notes.dart';
import 'package:lgpdjus/features/home/domain/usecases/get_release_notes.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

void main() {
  group('GetReleaseNotesUseCaseTest', () {
    late GetReleaseNotesUseCase sut;
    late IAppManagerRepository repository;

    setUp(() {
      repository = _AppManagerRepositoryMock();
      sut = GetReleaseNotesUseCase(repository: repository);
    });

    test(
      'when current version is already saved release notes should be null',
      () async {
        // arrange
        when(() => repository.getCurrentAppVersion())
            .thenAnswer((_) async => Version(1, 2, 3));
        when(() => repository.getSavedAppVersion())
            .thenAnswer((_) async => Version(1, 2, 3));

        // act
        final actualReleaseNotes = await sut();

        // assert
        expect(actualReleaseNotes, null);
      },
    );

    test(
      'when saved version is none all release notes should be returned',
      () async {
        // arrange
        const expectedReleaseNotes =
            'notes 1.2.3\nnew notes 2.0.0\nother notes 3.2.1';

        when(() => repository.getSavedAppVersion())
            .thenAnswer((_) async => Version.none);
        when(() => repository.getReleaseNotes()).thenAnswer((_) async => [
              ReleaseNote(version: '1.2.3', notes: 'notes 1.2.3'),
              ReleaseNote(version: '2.0.0', notes: 'new notes 2.0.0'),
              ReleaseNote(version: '3.2.1', notes: 'other notes 3.2.1'),
            ]);

        // act
        final actualReleaseNotes = await sut();

        // assert
        expect(actualReleaseNotes, expectedReleaseNotes);
      },
    );

    test(
      'when current version has not release notes should return null',
      () async {
        // arrange
        when(() => repository.getSavedAppVersion())
            .thenAnswer((_) async => Version(3, 2, 1));
        when(() => repository.getCurrentAppVersion())
            .thenAnswer((_) async => Version(4, 0, 0));
        when(() => repository.getReleaseNotes()).thenAnswer((_) async => [
              ReleaseNote(version: '1.2.3', notes: 'notes 1.2.3'),
              ReleaseNote(version: '2.0.0', notes: 'new notes 2.0.0'),
              ReleaseNote(version: '3.2.1', notes: 'other notes 3.2.1'),
            ]);

        // act
        final actualReleaseNotes = await sut();

        // assert
        expect(actualReleaseNotes, null);
      },
    );

    test(
      'when only previsous version has release note should return available release notes',
      () async {
        // arrange
        const expectedReleaseNote = 'other notes 3.2.1';

        when(() => repository.getSavedAppVersion())
            .thenAnswer((_) async => Version(2, 0, 0));
        when(() => repository.getCurrentAppVersion())
            .thenAnswer((_) async => Version(4, 0, 0));
        when(() => repository.getReleaseNotes()).thenAnswer((_) async => [
              ReleaseNote(version: '1.2.3', notes: 'notes 1.2.3'),
              ReleaseNote(version: '2.0.0', notes: 'new notes 2.0.0'),
              ReleaseNote(version: '3.2.1', notes: 'other notes 3.2.1'),
            ]);

        // act
        final actualReleaseNotes = await sut();

        // assert
        expect(actualReleaseNotes, expectedReleaseNote);
      },
    );

    test(
      'when current version has release note should return available release notes',
      () async {
        // arrange
        const expectedReleaseNote = 'new notes 2.0.0\nother notes 3.2.1';

        when(() => repository.getSavedAppVersion())
            .thenAnswer((_) async => Version(1, 2, 3));
        when(() => repository.getCurrentAppVersion())
            .thenAnswer((_) async => Version(3, 2, 1));
        when(() => repository.getReleaseNotes()).thenAnswer((_) async => [
              ReleaseNote(version: '1.2.3', notes: 'notes 1.2.3'),
              ReleaseNote(version: '2.0.0', notes: 'new notes 2.0.0'),
              ReleaseNote(version: '3.2.1', notes: 'other notes 3.2.1'),
            ]);

        // act
        final actualReleaseNotes = await sut();

        // assert
        expect(actualReleaseNotes, expectedReleaseNote);
      },
    );
  });
}

class _AppManagerRepositoryMock extends Mock implements IAppManagerRepository {}
