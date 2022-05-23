import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';

typedef OnEditAction = void Function();

class CardProfileHeaderEditPage extends StatelessWidget {
  final String title;
  final OnEditAction? onEditAction;
  const CardProfileHeaderEditPage({
    Key? key,
    required this.title,
    required this.onEditAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: cardTitleTextStyle),
          onEditAction == null
              ? Container()
              : IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/svg/profile/edit.svg',
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: onEditAction,
                ),
        ],
      ),
    );
  }
}

extension _TextStyle on CardProfileHeaderEditPage {
  TextStyle get cardTitleTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      );
}
