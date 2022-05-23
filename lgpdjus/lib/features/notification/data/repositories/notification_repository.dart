import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:lgpdjus/app/core/auth/authentication.dart';
import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/core/network/api_client.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:lgpdjus/features/notification/data/models/notification_session_model.dart';
import 'package:lgpdjus/features/notification/domain/entities/notification_session_entity.dart';

abstract class INotificationRepository {
  Future<Either<Failure, ValidField>> unread();
  Stream<NotificationSessionEntity> notifications();
}

class NotificationRepository implements INotificationRepository {
  NotificationRepository({
    required IApiProvider apiProvider,
    required AuthenticationObserver authObserver,
  }) : this._apiProvider = apiProvider, this._authObserver = authObserver;

  final IApiProvider _apiProvider;
  final AuthenticationObserver _authObserver;

  @override
  Future<Either<Failure, ValidField>> unread() async {
    final endPoint = "/me/unread-notif-count";

    try {
      final bodyResponse = await _apiProvider.get(
        path: endPoint,
      );
      return right(parseUnread(bodyResponse));
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Stream<NotificationSessionEntity> notifications() {
    final endPoint = "/me/notifications";
    final Map<String, String> parameters = {
      'rows': '1000',
    };
    return _authObserver.status.asyncMap((auth) async {
      final bodyResponse = await _apiProvider.get(
        path: endPoint,
        parameters: parameters,
      );
      return parseNotifications(bodyResponse);
    });
  }
}

extension _ParsePrivate on NotificationRepository {
  ValidField parseUnread(String body) {
    final jsonData = jsonDecode(body) as Map<String, dynamic>;
    return ValidField(message: "${jsonData["count"] ?? 0}");
  }

  NotificationSessionEntity parseNotifications(String body) {
    final jsonData = jsonDecode(body) as Map<String, dynamic>;
    return NotificationSessionModel.fromJson(jsonData);
  }
}
