import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lgpdjus/features/drawer/domain/entities.dart';

part 'drawer_states.freezed.dart';

@freezed
abstract class DrawerState with _$DrawerState {
  const factory DrawerState.loading() = _Loading;

  const factory DrawerState.loaded(Menu menu) = _Loaded;

  const factory DrawerState.error(Error failure) = _Error;
}
