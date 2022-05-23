import 'package:camera/camera.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/core/provider/file_provider.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';
import 'package:lgpdjus/features/quiz/domain/repository.dart';

export 'package:lgpdjus/features/quiz/domain/repository.dart';

class StartQuizUseCase {
  StartQuizUseCase(this._repository);

  final QuizRepository _repository;

  Stream<QuizScreen> call() => _repository.start();
}

class CloseQuizUseCase {
  CloseQuizUseCase(this._repository);

  final QuizRepository _repository;

  Future<bool> call(CloseQuizAnswer answer) {
    if (!answer.closeIsVisible) return Future.value(false);
    if (answer.id.isEmpty) return Future.value(true);
    return _repository.close(answer.id).then((value) => true);
  }
}

class VerifyAccountUseCase {
  VerifyAccountUseCase(this._repository);

  final QuizRepository _repository;

  Future call() => _repository.startByTicketId('verify_account');
}

abstract class ReplyQuizUseCase<Answer extends QuizAnswer> {
  Future<String?> call(Answer answer);
}

class TicketReplyQuizUseCase implements ReplyQuizUseCase<StartQuizAnswer> {
  TicketReplyQuizUseCase(this._repository);

  final QuizRepository _repository;

  @override
  Future<String?> call(StartQuizAnswer answer) async {
    await _repository.startByTicketId(answer.id);
    return null;
  }
}

class InputReplyQuizUseCase implements ReplyQuizUseCase<InputQuizAnswer> {
  InputReplyQuizUseCase(this._repository);

  final QuizRepository _repository;

  @override
  Future<String?> call(InputQuizAnswer answer) =>
      _repository.interact(answer.value);
}

class SendPictureReplyQuizUseCase
    implements ReplyQuizUseCase<SendPictureQuizAnswer> {
  SendPictureReplyQuizUseCase(this._repository, this._fileRepository);

  final QuizRepository _repository;
  final FileRepository _fileRepository;

  @override
  Future<String?> call(SendPictureQuizAnswer answer) async {
    XFile? picture = await _fileRepository.getFromCamera(answer.lensDirection);

    if (picture == null)
      throw ServerSideFormFieldValidationFailure(
        message: 'Para continuar é necessário que uma foto seja enviada',
      );

    final id = await _fileRepository.upload("quiz", picture);

    return _repository.interact(id);
  }
}
