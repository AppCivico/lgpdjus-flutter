// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TicketsController on _TicketControllerBase, Store {
  late final _$stateAtom =
      Atom(name: '_TicketControllerBase.state', context: context);

  @override
  TicketState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(TicketState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$retryAsyncAction =
      AsyncAction('_TicketControllerBase.retry', context: context);

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
