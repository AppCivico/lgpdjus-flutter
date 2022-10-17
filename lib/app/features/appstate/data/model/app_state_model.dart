import 'dart:convert';

import 'package:lgpdjus/app/core/extension/iterable.dart';
import 'package:lgpdjus/app/features/appstate/domain/entities/app_state_entity.dart';

class AppStateModel extends AppStateEntity {
  AppStateModel(
    QuizSessionEntity? quizSession,
    AppStateModeEntity? appMode,
    List<AppStateModuleEntity>? modules,
  ) : super(
          quizSession: quizSession,
          appMode: appMode,
          modules: modules,
        );

  factory AppStateModel.fromJson(Map<String, dynamic> jsonData) {
    final appMode = AppStateModeEntity(
      hasActivedGuardian: false,
    );

    final quizSession = _parseQuizSession(jsonData['quiz_session']);
    final modules = _parseAppModules(jsonData['modules']);
    return AppStateModel(quizSession, appMode, modules);
  }

  static QuizSessionEntity? _parseQuizSession(Map<String, dynamic>? session) {
    if (session == null || session.isEmpty) {
      return null;
    }

    return QuizSessionEntity(
      currentMessage: [],
      sessionId: "${session['session_id']}",
      isFinished: session['finished'] == 1,
      endScreen: session['end_screen'] == 'home'
          ? '/mainboard/'
          : session['end_screen'],
      canDelete: session['can_delete'] == 1,
    );
  }

  static List<AppStateModuleEntity>? _parseAppModules(List<dynamic>? data) {
    if (data == null || data.isEmpty) {
      return null;
    }

    List<AppStateModuleEntity> result =
        data.mapNotNull<AppStateModuleEntity>((e) => _buildModule(e)).toList();

    return result;
  }

  static AppStateModuleEntity? _buildModule(Map<String, dynamic>? message) {
    if (message == null || message.isEmpty) {
      return null;
    }

    String code = message['code'];
    if (message['code'] == null || message['code'].toString().isEmpty) {
      return null;
    }

    String meta = message['meta'] == null ? '{}' : jsonEncode(message['meta']);
    return AppStateModuleEntity(code: code, meta: meta);
  }
}
