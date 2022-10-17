import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_screen.dart';

part 'ticket_detail_state.freezed.dart';

@freezed
abstract class TicketDetailState with _$TicketDetailState {
  const factory TicketDetailState.initial() = _Initial;
  const factory TicketDetailState.loaded(TicketScreen screen) = _Loaded;
  const factory TicketDetailState.error(Object error) = _Error;
}