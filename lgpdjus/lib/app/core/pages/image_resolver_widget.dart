import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageResolverWidget extends StatelessWidget {
  ImageResolverWidget(
    this.uri, {
    this.color,
    this.height,
    this.width,
  });

  final Uri uri;
  final Color? color;
  final double? height;
  final double? width;

  Widget placeholder(BuildContext context) {
    return SvgPicture.asset('assets/images/svg/placeholder.svg');
  }

  Widget errorPlaceholder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return placeholder(context);
  }

  Widget build(BuildContext context) {
    final isRemote = uri.isScheme('https');
    final extension = uri.path.split('.').last;

    if (extension == 'svg') {
      return isRemote
          ? SvgPicture.network(
              uri.toString(),
              placeholderBuilder: placeholder,
              color: this.color,
              height: this.height,
              width: this.width,
            )
          : SvgPicture.asset(
              uri.path,
              placeholderBuilder: placeholder,
              color: this.color,
              height: this.height,
              width: this.width,
            );
    }

    return isRemote
        ? Image.network(
            uri.toString(),
            errorBuilder: errorPlaceholder,
            color: this.color,
            height: this.height,
            width: this.width,
          )
        : Image.asset(
            uri.path,
            errorBuilder: errorPlaceholder,
            color: this.color,
            height: this.height,
            width: this.width,
          );
  }
}
