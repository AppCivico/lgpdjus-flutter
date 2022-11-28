import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lgpdjus/common/widgets/dialog.dart';
import 'package:lgpdjus/features/home/domain/entities.dart';

part 'home_states.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _Loading;

  const factory HomeState.loaded(Screen screen) = _Loaded;

  const factory HomeState.error(Error failure) = _Error;
}

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.showTutorial() = _ShowTutorial;

  const factory HomeEvent.showDialog(DialogData data) = _ShowDialog;
}
