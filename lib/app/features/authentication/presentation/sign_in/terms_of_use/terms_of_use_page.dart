import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: "Termos de Uso",
      ),
      body: WebView(
        initialUrl: 'https://lgpdjus-api.appcivico.com/web/termos-de-uso',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
