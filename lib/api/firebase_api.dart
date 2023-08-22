import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../main.dart';

Future<void> handlerBackgroundMessage(RemoteMessage message) async{
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}

class FirebaseApi{

  var firebaseMessaging = FirebaseMessaging.instance;
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken(); // device token -> 실사용에서는 토큰을 db저장
    print('token: $fcmToken'); // dcosHVO7Rtue-bXe8LTy1P:APA91bFwvcp25-Sv_381fDPFgMnj19BQPAMHQ0wDRjfkkvMFqmU_z53KyhG4GtkZ60FVbIKPPiWkvT-f9L-qhOlnVITIx8QNsBQhkczE87VPl18KZWUDM1w0u4cG4iIiScfdkdai9pEz
    FirebaseMessaging.onBackgroundMessage(handlerBackgroundMessage); // onBackgroundMessage() : static메소드
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   if(message.notification != null){
    //     print('Notification Title : ${message.notification?.title}');
    //     print('Notification Body : ${message.notification?.body}');
    //   }
    // });
  }
}