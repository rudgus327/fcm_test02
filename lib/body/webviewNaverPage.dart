import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebviewNaverPage extends StatelessWidget {
  const WebviewNaverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  WebView( ///3.0.4 이후에 WebView() 클래스
        initialUrl: 'https://www.naver.com/',
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        userAgent: "random",
      ),
    );
  }
}
