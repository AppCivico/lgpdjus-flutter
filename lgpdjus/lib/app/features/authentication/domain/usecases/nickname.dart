import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:meta/meta.dart';

import 'map_validator_failure.dart';

@immutable
class Nickname extends Equatable with MapValidatorFailure {
  final Either<Failure, String> value;

  String get rawValue => value.getOrElse(() => "");
  bool get isValid => value.isRight();

  factory Nickname(String input) {
    return Nickname._(_validate(input));
  }

  Nickname._(this.value);

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(NicknameInvalidFailure());
    }

    return right(input.trim());
  }

  @override
  String get mapFailure => value.fold(
        (failure) => 'Apelido inválido para o sistema',
        (r) => '',
      );
}
