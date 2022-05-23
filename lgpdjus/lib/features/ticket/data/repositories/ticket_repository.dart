import 'package:http/http.dart' as http;
import 'package:lgpdjus/app/core/auth/authentication.dart';
import 'package:lgpdjus/app/core/extension/http.dart';
import 'package:lgpdjus/features/ticket/data/models/ticket_session_model.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_reply.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_screen.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_session_entity.dart';
import 'package:lgpdjus/features/ticket/domain/repository/ticket_repository.dart';

class TicketsRepository implements ITicketsRepository {
  TicketsRepository({
    required http.Client httpClient,
    required AuthenticationObserver authObserver,
  })  : this._httpClient = httpClient,
        this._authObserver = authObserver;

  final http.Client _httpClient;
  final AuthenticationObserver _authObserver;

  @override
  Stream<TicketSessionEntity> available() {
    return _authObserver.status.asyncMap((auth) async {
      final bodyResponse = await _httpClient.get(
        Uri(path: '/available-tickets-timeline'),
      );
      return parseResponse(bodyResponse.bodyJson);
    });
  }

  @override
  Stream<TicketSessionEntity> mine() {
    return _authObserver.status.asyncMap((auth) async {
      final bodyResponse = await _httpClient.get(
        Uri(path: '/tickets-timeline'),
      );
      return parseResponse(bodyResponse.bodyJson);
    });
  }

  Future<TicketScreen> detail(String ticketId) async {
    final bodyResponse = await _httpClient.get(
      Uri(path: "/me/tickets/$ticketId"),
    );
    return TicketScreen.fromJson(bodyResponse.bodyJson);
  }

  @override
  Future<void> reply(TicketReply reply) async {
    await _httpClient.post(
      Uri(path: "/me/tickets/${reply.ticketId}/reply"),
      body: {
        'response_id': reply.replyId,
        if (reply.pictureId != null) 'media_id': reply.pictureId,
        'content': reply.information,
      },
    );
  }
}

extension _ParsePrivate on TicketsRepository {
  TicketSessionEntity parseResponse(Map<String, dynamic> body) {
    return TicketSessionModel.fromJson(body);
  }
}
