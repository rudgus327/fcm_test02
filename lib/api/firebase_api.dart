import 'dart:convert';

import 'package:fcm_test02/main.dart';
import 'package:fcm_test02/body/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handlerBackgroundMessage(RemoteMessage message) async{
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}

class FirebaseApi{

  var firebaseMessaging = FirebaseMessaging.instance;
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notification',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message){

    if(message == null) return;

    navigatorKey.currentState?.pushNamed(
      NotificationScreen.route,
      arguments: {'title': '${message.notification?.body}',
        'body':'${message.notification?.body}',
        'data':'${message.data}',
      },
    );

  }
  Future initLocalNotifications() async{
    // const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async{
        final payload = details.payload ?? '';
        final message = RemoteMessage.fromMap(jsonDecode(payload));
        handleMessage(message);
      }
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }
  Future initPushNotifications() async{
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // handle message method when the app is opened from a notification
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessage.listen((message){

      final notification = message.notification;
      if(notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
            )
          ),
        payload: jsonEncode(message.toMap()),
      );
    });

    //onMessageOpenedApp : for background case_ want to execute the handle message method when the application is opened from background via notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onBackgroundMessage(handlerBackgroundMessage);

  }
  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken(); // device token -> 실사용에서는 토큰을 db저장
    print('token: $fcmToken'); // dcosHVO7Rtue-bXe8LTy1P:APA91bFwvcp25-Sv_381fDPFgMnj19BQPAMHQ0wDRjfkkvMFqmU_z53KyhG4GtkZ60FVbIKPPiWkvT-f9L-qhOlnVITIx8QNsBQhkczE87VPl18KZWUDM1w0u4cG4iIiScfdkdai9pEz
    initPushNotifications();
    initLocalNotifications();
  }
}