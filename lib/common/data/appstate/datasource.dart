import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/auth/authentication.dart';
import 'package:lgpdjus/app/core/data/authorization_status.dart';
import 'package:lgpdjus/app/core/extension/http.dart';
import 'package:lgpdjus/app/shared/logger/log.dart';
import 'package:rxdart/rxdart.dart';

class AppStateDataSource extends Disposable {
  AppStateDataSource(
    this._apiClient,
    AuthenticationObserver authenticationObserver,
  ) {
    authenticationObserver.observeWith(_onAuthenticationChanged);
  }

  final http.Client _apiClient;
  late final BehaviorSubject<Map<String, dynamic>> _subject = BehaviorSubject();
  final Map<String, dynamic> _lastState = {};

  Stream<Map<String, dynamic>> get rawState => _subject.stream;

  Future<Map<String, dynamic>> get() async {
    return _subject.value ?? await refreshAndGet();
  }

  Stream<Map<String, dynamic>> observer() {
    if (!_subject.hasValue) refreshAndGet();
    return _subject;
  }

  Future<Map<String, dynamic>> refreshAndGet() => refreshFromCall(
        _apiClient.get(Uri(path: "/me"), headers: {
          'x-compact-quiz-responses': '1',
        }),
      );

  /// Use a call that returns a AppState json to refresh stream
  Future<Map<String, dynamic>> refreshFromCall(
    Future<http.Response> call,
  ) async {
    try {
      Map<String, dynamic> jsonResponse = (await call).bodyJson;

      _lastState.remove("quiz_session");
      _lastState.addAll(jsonResponse);

      _subject.add(_lastState);
    } catch (e, stack) {
      _subject.addError(e, stack);
      rethrow;
    }

    return _lastState;
  }

  /// Handle authentication changes
  /// When is authenticated the state is refreshed, otherwise clear state
  void _onAuthenticationChanged(AuthorizationStatus status) {
    if (!status.isAuthenticated) {
      _subject.add(_lastState..clear());
      return;
    }
    refreshAndGet().catchError(catchErrorLogger);
  }

  @override
  void dispose() {
    if (!_subject.isClosed) _subject.close();
  }
}
