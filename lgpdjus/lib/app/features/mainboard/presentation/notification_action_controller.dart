import 'package:lgpdjus/app/core/auth/authentication.dart';
import 'package:lgpdjus/app/core/data/authorization_status.dart';
import 'package:lgpdjus/app/features/mainboard/presentation/notification_action_state.dart';
import 'package:mobx/mobx.dart';

part 'notification_action_controller.g.dart';

class NotificationActionController extends _NotificationActionController
    with _$NotificationActionController {
  NotificationActionController(AuthenticationObserver authenticationObserver)
      : super(authenticationObserver);
}

abstract class _NotificationActionController with Store {
  _NotificationActionController(this._authenticationObserver) {
    _start();
  }

  final AuthenticationObserver _authenticationObserver;

  @observable
  NotificationActionState state = NotificationActionState.anonymous();

  _start() {
    _authenticationObserver.observeWith((status) {
      state = status.isAuthenticated
          ? NotificationActionState.authenticated(0)
          : NotificationActionState.anonymous();
    });
  }
}
