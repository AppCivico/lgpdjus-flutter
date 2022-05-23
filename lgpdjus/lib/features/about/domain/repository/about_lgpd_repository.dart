import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';

abstract class AboutLgpdRepository {
  Future<TopicsScreen> topics();

  Future<DetailsScreen> details(String topic);
}
