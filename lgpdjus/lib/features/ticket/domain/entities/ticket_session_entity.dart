import 'package:equatable/equatable.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';


class TicketSessionEntity extends Equatable {
  final bool hasMore;
  final String? nextPage;
  final List<Tile> tiles;

  TicketSessionEntity({
    required this.hasMore,
    required this.nextPage,
    required this.tiles,
  });

  @override
  List<Object?> get props => [hasMore, nextPage, tiles];

  @override
  bool get stringify => true;
}
