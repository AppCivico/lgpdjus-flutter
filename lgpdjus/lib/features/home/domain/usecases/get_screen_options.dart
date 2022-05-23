import 'package:lgpdjus/features/home/domain/entities.dart';
import 'package:lgpdjus/features/home/domain/repositories/screen_options.dart';

class GetScreenOptionsUseCase {
  GetScreenOptionsUseCase(this.repository);

  final ScreenOptionsRepository repository;

  Future<Screen> call() => repository.get();
}
