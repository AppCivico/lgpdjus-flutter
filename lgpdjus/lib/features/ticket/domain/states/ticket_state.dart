import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';

part 'ticket_state.freezed.dart';

@freezed
abstract class TicketState with _$TicketState {
  const factory TicketState.initial() = _Initial;
  const factory TicketState.loaded(List<Tile> tiles) = _Loaded;
  const factory TicketState.empty() = _Empty;
  const factory TicketState.error(String message) = _ErrorDetails;
}