import 'package:equatable/equatable.dart';


class SessionEntity extends Equatable {
  final bool deletedScheduled;

  SessionEntity({
    required this.deletedScheduled,
  });

  @override
  List<Object?> get props => [deletedScheduled];

  @override
  bool get stringify => true;
}
