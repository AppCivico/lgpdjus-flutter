import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';
import 'package:lgpdjus/features/about/domain/repository/about_lgpd_repository.dart';

class GetTopicsUseCase {
  GetTopicsUseCase(this._repository);

  final AboutLgpdRepository _repository;

  Future<TopicsScreen> call() => _repository.topics();
}

class GetDetailsUseCase {
  GetDetailsUseCase(this._repository);

  final AboutLgpdRepository _repository;

  Future<DetailsScreen> call(String topic) => _repository.details(topic);
}
