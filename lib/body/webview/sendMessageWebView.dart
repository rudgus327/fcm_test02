import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  late final WebViewController _controller;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          // 웹뷰로 사용할 url
          initialUrl: "http://172.30.1.98:9999/",
          // initialUrl: 'http://14.36.25.169:9999/',
          onWebViewCreated: (controller){
            _controller = controller;
          },
          onPageFinished: (url){
            // 앱에서 웹으로 데이터 전달
            String message = "FLUTTER MESSAGE";
            _controller.runJavascript('fromApptoWeb("$message")');
            print('플러터앱에서 웹으로 메세지 전송:$message');
          },
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: <JavascriptChannel>{
            JavascriptChannel(
              name: 'toApp',//
              onMessageReceived: (JavascriptMessage message){
                print('웹에서 플러터앱으로 메시지 전송: ${message.message}');
                Navigator.of(context).pop();
              }
            ),
          },
        ),
      ),
    );
  }
}


