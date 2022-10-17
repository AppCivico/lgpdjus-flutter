import 'package:flutter/material.dart';
import 'package:lgpdjus/common/widgets/webview_page.dart';

class AboutAppPage extends WebViewPage {
  const AboutAppPage({Key? key})
      : super(
          key: key,
          title: 'Fale com a Encarregada',
          url: 'https://lgpdjus-api.appcivico.com/web/sobre',
        );
}
