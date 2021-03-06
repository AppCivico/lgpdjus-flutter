import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ResetPasswordResponseEntity extends Equatable {
  final String message;
  final int digits;
  final int ttl;
  final int ttlRetry;

  ResetPasswordResponseEntity({
    required this.message,
    required this.digits,
    required this.ttl,
    required this.ttlRetry,
  });

  @override
  List<Object?> get props => [message, digits, ttl, ttlRetry];

  @override
  bool get stringify => true;
}
