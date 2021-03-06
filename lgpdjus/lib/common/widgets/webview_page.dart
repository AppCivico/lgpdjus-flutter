import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({Key? key, required this.title, required this.url}) : super(key: key);

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: this.title,
      ),
      body: WebView(
        initialUrl: this.url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest nav) async {
          if (nav.url.startsWith('mailto')) {
            if (await canLaunch(nav.url)) {
              launch(nav.url);
            }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
