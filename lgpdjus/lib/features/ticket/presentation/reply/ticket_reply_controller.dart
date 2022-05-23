import 'package:cross_file/cross_file.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:lgpdjus/features/ticket/domain/usecases/ticket_usecases.dart';
import 'package:lgpdjus/features/ticket/presentation/reply/ticket_reply_state.dart';
import 'package:mobx/mobx.dart';

part 'ticket_reply_controller.g.dart';

class TicketReplyController extends _TicketReplyController
    with _$TicketReplyController {
  TicketReplyController({
    required SendTicketReplyUseCase sendTicketReply,
  }) : super(sendTicketReply);
}

abstract class _TicketReplyController with Store, MapFailureMessage {
  _TicketReplyController(this.sendTicketReply);

  final SendTicketReplyUseCase sendTicketReply;

  @observable
  TicketReplyState state = TicketReplyState.initial();

  @observable
  TicketReplyReaction? reaction;

  @action
  Future<void> sendReply(XFile? picture, String information) async {
    state = TicketReplyState.loading();
    sendTicketReply.call(picture, information).then((value) {
      reaction = TicketReplyReaction.done();
    }).catchError(_onError);
  }

  _onError(exception, [StackTrace? stack]) {
    reaction =
        TicketReplyReaction.showError(mapFailureMessage(exception, stack));
    state = TicketReplyState.initial();
  }
}
