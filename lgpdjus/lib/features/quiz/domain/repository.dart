import 'package:cross_file/cross_file.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';

abstract class QuizRepository {
  Stream<QuizScreen> start();

  Future<void> close(String quizId);

  Future<void> startByTicketId(String id);

  Future<String?> interact(String answer);
}
