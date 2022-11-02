import 'package:equatable/equatable.dart';

class Account extends Equatable {
  Account({
    required this.email,
    required this.fullName,
    required this.nickname,
    required this.status,
  });

  final String? email;
  final String fullName;
  final String nickname;
  final String status;

  @override
  List<Object?> get props => [email, fullName, nickname, status];
}
