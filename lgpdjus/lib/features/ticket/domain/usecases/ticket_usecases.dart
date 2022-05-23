import 'package:cross_file/cross_file.dart';
import 'package:lgpdjus/core/provider/file_provider.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_reply.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_screen.dart';
import 'package:lgpdjus/features/ticket/domain/entities/ticket_session_entity.dart';
import 'package:lgpdjus/features/ticket/domain/repository/ticket_repository.dart';

abstract class GetTicketListUseCase {
  Stream<TicketSessionEntity> call();
}

class GetAvailableTicketsUseCase extends GetTicketListUseCase {
  GetAvailableTicketsUseCase(this._repository);

  final ITicketsRepository _repository;

  @override
  Stream<TicketSessionEntity> call() => _repository.available();
}

class GetMineTicketsUseCase extends GetTicketListUseCase {
  GetMineTicketsUseCase(this._repository);

  final ITicketsRepository _repository;

  @override
  Stream<TicketSessionEntity> call() => _repository.mine();
}

class GetTicketUseCase {
  GetTicketUseCase(this._repository);

  final ITicketsRepository _repository;

  Future<TicketScreen> call(String ticketId) => _repository.detail(ticketId);
}

class SendTicketReplyUseCase {
  SendTicketReplyUseCase({
    required ITicketsRepository repository,
    required FileRepository fileRepository,
    required String ticketId,
    required String replyId,
  })  : this._repository = repository,
        this._fileRepository = fileRepository,
        this._ticketId = ticketId,
        this._replyId = replyId;

  final ITicketsRepository _repository;
  final FileRepository _fileRepository;

  final String _ticketId;
  final String _replyId;

  Future<void> call(XFile? picture, String information) async {
    String? pictureId;
    if (picture != null) {
      pictureId = await _fileRepository.upload('quiz', picture);
    }
    final reply = TicketReply(
      ticketId: _ticketId,
      replyId: _replyId,
      information: information,
      pictureId: pictureId,
    );
    await _repository.reply(reply);
  }
}
