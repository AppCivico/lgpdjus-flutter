import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/features/notification/data/repositories/notification_repository.dart';
import 'package:lgpdjus/features/notification/domain/entities/notification_session_entity.dart';
import 'package:lgpdjus/features/notification/domain/states/notification_state.dart';
import 'package:mobx/mobx.dart';

part 'notification_controller.g.dart';

class NotificationController extends _NotificationControllerBase
    with _$NotificationController {
  NotificationController(
      {required INotificationRepository notificationRepository})
      : super(notificationRepository);
}

abstract class _NotificationControllerBase with Store, MapFailureMessage, Disposable {
  _NotificationControllerBase(this._repository) {
    setup();
  }

  final INotificationRepository _repository;
  StreamSubscription? _subscription;

  @observable
  String errorMessage = "";

  @observable
  NotificationState state = NotificationState.initial();

  @action
  Future<void> retry() async {
    loadNotification();
  }

  @override
  void dispose() {
    onDestroy();
  }
}

extension _PrivateMethod on _NotificationControllerBase {
  Future<void> setup() async {
    loadNotification();
  }

  Future<void> loadNotification() async {
    setErrorMessage('');
    _subscription?.cancel();
    _subscription =
        _repository.notifications().listen(handleSession, onError: handleStateError);
  }

  void handleSession(NotificationSessionEntity session) {
    if (session.notifications.isEmpty) {
      state = NotificationState.empty();
    } else {
      state = NotificationState.loaded(session.notifications);
    }
  }

  void handleStateError(Object f) {
    state = NotificationState.error(mapFailureMessage(f));
  }

  void setErrorMessage(String msg) {
    errorMessage = msg;
  }

  void onDestroy() {
    _subscription?.cancel();
  }
}
