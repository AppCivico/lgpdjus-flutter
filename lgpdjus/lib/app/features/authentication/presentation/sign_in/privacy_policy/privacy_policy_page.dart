import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: "Política de privacidade",
      ),
      body: WebView(
        initialUrl:
            'https://lgpdjus-api.appcivico.com/web/politica-privacidade',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
