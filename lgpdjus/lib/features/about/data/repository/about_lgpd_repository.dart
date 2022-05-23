import 'package:lgpdjus/features/about/data/datasource/about_lgpd_datasource.dart';
import 'package:lgpdjus/features/about/data/mapper/about_lgpd_mapper.dart';
import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';
import 'package:lgpdjus/features/about/domain/repository/about_lgpd_repository.dart';

class AboutLgpdRepositoryImpl implements AboutLgpdRepository {
  AboutLgpdRepositoryImpl(this._dataSource, this._topicsScreenMapper, this._detailsScreenMapper);

  final AboutLgpdDataSource _dataSource;
  final TopicsScreenMapper _topicsScreenMapper;
  final DetailsScreenMapper _detailsScreenMapper;

  @override
  Future<TopicsScreen> topics() {
    return _dataSource.getTopics().then(_topicsScreenMapper);
  }

  @override
  Future<DetailsScreen> details(String topic) {
    return _dataSource.getDetails(topic).then(_detailsScreenMapper);
  }
}