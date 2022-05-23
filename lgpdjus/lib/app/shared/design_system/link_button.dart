import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';

class LinkButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const LinkButton({
    Key? key,
    this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: kTextStyleFeedTweetShowReply,
      ),
    );
  }
}
