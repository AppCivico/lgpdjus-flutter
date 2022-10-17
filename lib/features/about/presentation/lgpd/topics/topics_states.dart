import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';

part 'topics_states.freezed.dart';

@freezed
abstract class TopicsState with _$TopicsState {
  const factory TopicsState.loading() = _Loading;

  const factory TopicsState.loaded(TopicsScreen screen) = _Loaded;

  const factory TopicsState.failed(Object error) = _Failed;
}