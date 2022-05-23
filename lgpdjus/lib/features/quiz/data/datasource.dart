import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/core/extension/http.dart';
import 'package:lgpdjus/app/core/extension/iterable.dart';
import 'package:lgpdjus/app/shared/logger/log.dart';
import 'package:lgpdjus/common/data/appstate/datasource.dart';

abstract class QuizLocalDataSource {
  Future<Map<String, dynamic>> get();
}

abstract class QuizRemoteDataSource {
  Future<Map<String, dynamic>> startByTicketId(String id);

  Future<Map<String, dynamic>> reply(String answer);

  Future<void> close(String quizId);
}

class TicketQuizDataSource implements QuizLocalDataSource {
  TicketQuizDataSource(this._data);

  final Map<String, dynamic> _data;

  @override
  Future<Map<String, dynamic>> get() async {
    return _data;
  }
}

class QuizAppStateDataSource
    implements QuizRemoteDataSource, QuizLocalDataSource {
  QuizAppStateDataSource(this._appStateDataSource, this._apiClient);

  final AppStateDataSource _appStateDataSource;
  final http.Client _apiClient;

  @override
  Future<Map<String, dynamic>> get() async {
    final quiz =
        await _appStateDataSource.get().then((value) => value["quiz_session"]);
    if (quiz != null && "${quiz['finished']}" != '1') return quiz;
    return startByTicketId('verify_account');
  }

  @override
  Future<void> close(String quizId) async {
    final endPoint = Uri(path: '/me/quiz/cancel');
    await _apiClient
        .post(
          endPoint,
          headers: contentTypeFormUrlencoded,
          body: {
            'session_id': quizId,
          },
        )
        .catchError(
          catchErrorLogger,
          test: (error) => error is ServerSideFormFieldValidationFailure,
        )
        .then((_) => _appStateDataSource.refreshAndGet());
  }

  @override
  Future<Map<String, dynamic>> startByTicketId(String id) async {
    final httpRequest = Uri(
      path: '/me/quiz/start',
    );
    final response = _apiClient.post(
      httpRequest,
      headers: contentTypeFormUrlencoded +
          {
            'x-compact-quiz-responses': '1',
          },
      body: {'id': id},
    );
    return _appStateDataSource
        .refreshFromCall(response)
        .then((value) => value["quiz_session"]);
  }

  @override
  Future<Map<String, dynamic>> reply(String answer) async {
    final state = await _appStateDataSource.get();
    final quiz = state['quiz_session'];

    final httpRequest = Uri(
      path: '/me/quiz',
      queryParameters: {
        'session_id': "${quiz['session_id']}",
        quiz['current_msg']['ref']: answer,
      },
    );

    final response = _apiClient.post(
      httpRequest,
      headers: contentTypeFormUrlencoded +
          {
            'x-compact-quiz-responses': '1',
          },
    );

    return _appStateDataSource
        .refreshFromCall(response)
        .then((jsonData) => jsonData["quiz_session"]);
  }
}
