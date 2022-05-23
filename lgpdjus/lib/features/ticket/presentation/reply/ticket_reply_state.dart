import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_reply_state.freezed.dart';

@freezed
abstract class TicketReplyState with _$TicketReplyState {
  const factory TicketReplyState.initial() = _Initial;
  const factory TicketReplyState.loading() = _Loading;
}

@freezed
class TicketReplyReaction with _$TicketReplyReaction {
  const factory TicketReplyReaction.showError(Object error) = _ShowError;
  const factory TicketReplyReaction.done() = _Done;
}