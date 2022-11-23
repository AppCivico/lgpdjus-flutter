import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_session_entity.dart';
import 'package:lgpdjus/features/ticket/domain/states/ticket_state.dart';
import 'package:lgpdjus/features/ticket/domain/usecases/ticket_usecases.dart';
import 'package:mobx/mobx.dart';

part 'tickets_controller.g.dart';

class TicketsController extends _TicketControllerBase with _$TicketsController {
  TicketsController({required GetTicketListUseCase getTicketList})
      : super(getTicketList);
}

abstract class _TicketControllerBase with Store, MapFailureMessage, Disposable {
  _TicketControllerBase(this._getTickets) {
    setup();
  }

  final GetTicketListUseCase _getTickets;
  StreamSubscription? _subscription;

  @observable
  TicketState state = TicketState.initial();

  @action
  Future<void> retry() async {
    state = TicketState.initial();
    loadData();
  }

  Future<void> navigate(Actionable actionable) async {
    final action = actionable.action;
    if (action is NavData) {
      AppNavigator.pushNamedIfExists(
        action.route,
        args: action.data,
      );
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
  }
}

extension _PrivateMethod on _TicketControllerBase {
  Future<void> setup() async {
    loadData();
  }

  Future<void> loadData() async {
    _subscription?.cancel();
    _subscription =
        _getTickets.call().listen(handleSession, onError: handleStateError);
  }

  void handleSession(TicketSessionEntity session) {
    if (session.tiles.isEmpty) {
      state = TicketState.empty();
    } else {
      state = TicketState.loaded(session.tiles);
    }
  }

  void handleStateError(Object f, StackTrace? stack) {
    state = TicketState.error(mapFailureMessage(f, stack));
  }
}
