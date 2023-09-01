import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewNaverPage extends StatelessWidget {
  const WebviewNaverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  WebView(
        initialUrl: 'https://m.naver.com/',
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        userAgent: "random",
      ),
    );
  }
}
