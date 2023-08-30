import 'package:fcm_test02/body/webViewPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const WebViewPage())
              );
            },
            child: const Text('웹뷰 호출'),
          ),
        ),
      ),

    );
  }
}