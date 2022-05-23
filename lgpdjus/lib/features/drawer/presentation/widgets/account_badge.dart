import 'package:flutter/material.dart';
import 'package:lgpdjus/features/user/account/domain/user_account_entities.dart';

class AccountBadge extends StatelessWidget {
  AccountBadge(this.status);

  final AccountStatus status;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final badgeRadius = Radius.circular(10);

    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0x80FFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: badgeRadius,
          bottomLeft: badgeRadius,
          bottomRight: badgeRadius,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status.icon,
            size: 12,
            color: Color(0xBF3C3C3B),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            status.text,
            style: textTheme.caption?.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

extension AccountStatusUI on AccountStatus {
  IconData get icon {
    switch (this) {
      case AccountStatus.verified:
        return Icons.done_outlined;
      case AccountStatus.unverified:
        return Icons.cancel_outlined;
      case AccountStatus.processing:
        return Icons.hourglass_top_outlined;
    }
  }
  String get text {
    switch (this) {
      case AccountStatus.verified:
        return 'Verificado';
      case AccountStatus.unverified:
        return 'Não verificado';
      case AccountStatus.processing:
        return 'Em verificação';
    }
  }
}
