import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:meta/meta.dart';

import 'map_validator_failure.dart';

@immutable
class Fullname extends Equatable with MapValidatorFailure {
  final Either<Failure, String> value;

  String get rawValue => value.getOrElse(() => "");
  bool get isValid => value.isRight();

  factory Fullname(String input) {
    return Fullname._(_validate(input));
  }

  Fullname._(this.value);

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  static Either<Failure, String> _validate(String input) {
    if (input == null || input.isEmpty) {
      return left(FullnameInvalidFailure());
    }

    return right(input.trim());
  }

  @override
  String get mapFailure => value.fold(
        (failure) => 'Nome inválido para o sistema',
        (r) => '',
      );
}
