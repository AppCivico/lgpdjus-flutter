import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TutorialPageViewWidget extends StatelessWidget {
  final String _image;
  final TextSpan _content;

  const TutorialPageViewWidget({
    Key? key,
    required String image,
    required TextSpan content,
  })  : this._image = image,
        this._content = content,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildIllustration(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return AspectRatio(
      aspectRatio: 1.1,
      child: SvgPicture.asset(
        _image,
        fit: BoxFit.fitWidth,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: RichText(text: _content, textAlign: TextAlign.left),
    );
  }
}
