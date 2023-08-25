import 'package:fcm_test02/body/notification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'header/NavigatorUtil.dart';
import 'api/firebase_api.dart';
import 'body/myHomePage.dart';

final navigatorKey = GlobalKey<NavigatorState>(); //-> navigation purposes

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 초기화
  await Firebase.initializeApp();// -> main에 async 추가, import firebase_core
  await FirebaseApi().initNotifications(); // lib에 생성한 class 이용
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var homeTitle ='Flutter_demo';
    return MaterialApp(
      title: homeTitle,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      navigatorKey: navigatorKey,
      home:GotoPage(targetClass: MyHomePage()),
      routes: {
        NotificationScreen.route:(context)=>const NotificationScreen()
      },
    );
  }

}



