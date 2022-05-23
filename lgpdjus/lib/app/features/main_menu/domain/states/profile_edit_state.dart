import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';

part 'profile_edit_state.freezed.dart';

@freezed
abstract class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial() = _Initial;

  const factory ProfileEditState.loaded(Account profile) = _Loaded;

  const factory ProfileEditState.error(String message) = _ErrorDetails;
}
