// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_reply_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TicketReplyController on _TicketReplyController, Store {
  late final _$stateAtom =
      Atom(name: '_TicketReplyController.state', context: context);

  @override
  TicketReplyState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(TicketReplyState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$reactionAtom =
      Atom(name: '_TicketReplyController.reaction', context: context);

  @override
  TicketReplyReaction? get reaction {
    _$reactionAtom.reportRead();
    return super.reaction;
  }

  @override
  set reaction(TicketReplyReaction? value) {
    _$reactionAtom.reportWrite(value, super.reaction, () {
      super.reaction = value;
    });
  }

  late final _$sendReplyAsyncAction =
      AsyncAction('_TicketReplyController.sendReply', context: context);

  @override
  Future<void> sendReply(XFile? picture, String information) {
    return _$sendReplyAsyncAction
        .run(() => super.sendReply(picture, information));
  }

  @override
  String toString() {
    return '''
state: ${state},
reaction: ${reaction}
    ''';
  }
}
