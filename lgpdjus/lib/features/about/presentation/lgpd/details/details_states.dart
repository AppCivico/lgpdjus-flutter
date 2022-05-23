import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';

part 'details_states.freezed.dart';

@freezed
abstract class DetailsState with _$DetailsState {
  const factory DetailsState.loading() = _Loading;

  const factory DetailsState.loaded(DetailsScreen screen) = _Loaded;

  const factory DetailsState.failed(Object error) = _Failed;
}
