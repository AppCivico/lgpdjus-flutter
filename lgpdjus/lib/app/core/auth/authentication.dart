import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/core/data/authorization_status.dart';
import 'package:rxdart/rxdart.dart';

typedef void Subscriber(AuthorizationStatus status);

abstract class AuthenticationObserver {
  Stream<AuthorizationStatus> get status;

  void observeWith(Subscriber subscriber);
}

abstract class AuthenticationSubject {
  void add(AuthorizationStatus status);
}

class AuthenticationStream
    implements AuthenticationObserver, AuthenticationSubject, Disposable {
  final BehaviorSubject<AuthorizationStatus> _ctrl = BehaviorSubject();
  final List<StreamSubscription> subscriptions = [];

  @override
  Stream<AuthorizationStatus> get status => _ctrl.distinct();

  @override
  void observeWith(Subscriber subscriber) {
    subscriptions.add(
      status.listen(subscriber),
    );
  }

  @override
  void add(AuthorizationStatus status) {
    _ctrl.add(status);
  }

  @override
  void dispose() {
    subscriptions.forEach((element) {
      element.cancel();
    });
    subscriptions.clear();

    if (!_ctrl.isClosed) {
      _ctrl.close();
    }
  }
}
