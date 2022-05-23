import 'package:cross_file/cross_file.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/shared/logger/log.dart';
import 'package:lgpdjus/features/quiz/data/datasource.dart';
import 'package:lgpdjus/features/quiz/data/mapper.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';
import 'package:lgpdjus/features/quiz/domain/repository.dart';
import 'package:rxdart/rxdart.dart';

class QuizRepositoryImpl implements QuizRepository, Disposable {
  QuizRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._mapper,
  );

  final QuizLocalDataSource _localDataSource;
  final QuizRemoteDataSource _remoteDataSource;
  final QuizScreenMapper _mapper;

  late final Subject<QuizScreen> _subject = PublishSubject();

  @override
  Stream<QuizScreen> start() async* {
    final quizScreen = await _localDataSource.get().then(_emitScreen);
    if (quizScreen != null) yield quizScreen;
    yield* _subject.stream;
  }

  @override
  Future<void> close(String quizId) {
    return _remoteDataSource.close(quizId);
  }

  @override
  Future<void> startByTicketId(String id) async {
    await _remoteDataSource.startByTicketId(id).then(_emitScreen);
  }

  @override
  Future<String?> interact(String answer) async {
    final result = await _remoteDataSource.reply(answer);
    if ("${result["finished"]}" == "1")
      return result["end_screen"] == 'home'
          ? '/mainboard/'
          : result["end_screen"];
    _emitScreen(result);
  }

  QuizScreen? _emitScreen(Map<String, dynamic> data) {
    final QuizScreen? screen = _mapper.call(data);
    if (screen != null) _subject.add(screen);
    return screen;
  }

  @override
  void dispose() {
    _subject.close();
  }
}
