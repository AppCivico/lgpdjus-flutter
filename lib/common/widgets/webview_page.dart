import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';
import 'package:lgpdjus/core/config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(title: title),
      body: WebView(
        initialUrl: Uri.parse(kApiBaseUrl).resolve(url).toString(),
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest nav) async {
          if (nav.url.startsWith('mailto')) {
            final url = Uri.parse(nav.url);
            if (await canLaunchUrl(url)) {
              launchUrl(url);
              return NavigationDecision.prevent;
            }
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
