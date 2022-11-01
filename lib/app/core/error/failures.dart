import 'package:equatable/equatable.dart';
import 'package:lgpdjus/app/core/error/exceptions.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable implements Exception {
  String get message => "${this.runtimeType} :/";

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class ServerFailure extends Failure implements NetworkServerException {
  ServerFailure([this.cause]);

  @override
  String get message => "ServerFailure: ${cause?.toString()}";

  final Object? cause;
}

class AuthenticationFailed extends Failure implements ApiProviderSessionExpection {}

class ServerSideSessionFailed extends Failure implements ApiProviderSessionExpection {}

class InternetConnectionFailure extends Failure implements InternetConnectionException {}

class EmailAddressInvalidFailure extends Failure {}

class NicknameInvalidFailure extends Failure {}

class CepInvalidFailure extends Failure {}

class CpfInvalidFailure extends Failure {}

class BirthdayInvalidFailure extends Failure {}

class FullnameInvalidFailure extends Failure {}

class HumanRaceInvalidFailure extends Failure {}

class GuardianAlertGpsFailure extends Failure {}

class RequiredParameter extends Failure {}

class AudioDownloadFailure extends Failure {}

class FileSystemFailure extends Failure {}

class GpsFailure extends Failure {
  final String message;

  GpsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AddressFailure extends Failure {
  final String message;

  AddressFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UnverifiedAccountFailure extends Failure {
  UnverifiedAccountFailure(this.message);

  final String message;
}

@immutable
class ServerSideFormFieldValidationFailure extends Failure {
  final String? error;
  final String message;
  final String? field;
  final String? reason;

  ServerSideFormFieldValidationFailure({
    this.error,
    required this.message,
    this.field,
    this.reason,
  });

  @override
  List<Object?> get props => [error, message, field, reason];
}
