import 'package:lgpdjus/features/ticket/domain/entities/ticket_reply.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_screen.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_session_entity.dart';

abstract class ITicketsRepository {
  Stream<TicketSessionEntity> available();

  Stream<TicketSessionEntity> mine();

  Future<TicketScreen> detail(String ticketId);

  Future<void> reply(TicketReply reply);
}