import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_action_state.freezed.dart';

@freezed
abstract class NotificationActionState with _$NotificationActionState {
  const factory NotificationActionState.anonymous() = _Anonymous;

  const factory NotificationActionState.authenticated(
    int notificationCounter,
  ) = _Authenticated;
}
