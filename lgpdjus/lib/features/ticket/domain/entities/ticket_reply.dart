class TicketReply {
  TicketReply({
    required this.replyId,
    required this.ticketId,
    required this.information,
    this.pictureId,
  });

  final String replyId;
  final String ticketId;
  final String information;
  final String? pictureId;
}
