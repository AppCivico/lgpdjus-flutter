import 'package:lgpdjus/features/ticket/domain/usecases/ticket_usecases.dart';
import 'package:lgpdjus/features/ticket/presentation/detail/ticket_detail_state.dart';
import 'package:mobx/mobx.dart';

part 'ticket_detail_controller.g.dart';

class TicketDetailController extends _TicketDetailController
    with _$TicketDetailController {
  TicketDetailController({
    required String ticketId,
    required GetTicketUseCase getTicket,
  }) : super(ticketId, getTicket);
}

abstract class _TicketDetailController with Store {
  _TicketDetailController(this._ticketId, this._getTicket);

  final String _ticketId;
  final GetTicketUseCase _getTicket;

  @observable
  late TicketDetailState state = _start();

  TicketDetailState _start() {
    _getTicket(_ticketId)
        .then(
          (screen) => TicketDetailState.loaded(screen),
          onError: (error) => TicketDetailState.error(error),
        )
        .then((value) => state = value);
    return TicketDetailState.initial();
  }

  retry() {
    state = _start();
  }
}
