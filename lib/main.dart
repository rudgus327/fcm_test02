

import 'package:fcm_test02/db/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'api/firebase_api.dart';
import 'package:intl/intl.dart';

import 'db/db_servier.dart';

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
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to AppBar'),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
          actions: [
            IconButton(icon: Icon(Icons.image), onPressed: (){
              // 화면전환 에러
              //Navigator.push(cntx, MaterialPageRoute(builder: (context) => const SendForm()),);
            }),
            IconButton(icon: Icon(Icons.navigate_next), onPressed: null),
          ],
        ),
        body: Center(
          child:Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text("ID"),
                )
                ,
                Flexible(child: TextField(
                  controller: _textController,

                ))
                ,Container(
                  child: ElevatedButton( // data 전송 test
                    onPressed: () async{
                      print("send Test!!!");
                      // await Firebase.initializeApp();// -> main에 async 추가, import firebase_core

                      var fcmToken = await FirebaseApi().firebaseMessaging.getToken(); // lib에 생성한 class 이용
                      var id = _textController.text;

                      DateTime now = DateTime.now();
                      DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var strToday = formatter.format(now);


                      var userdata = User(userId: id,createDate: strToday,fcmToken: fcmToken);

                      DBService dbService = DBService();
                      dbService.saveUser(userdata);

                    }
                    ,child: Text("알림 메세지 수신 동의"),),
                )

              ],
            ),
          )
          
        )
      ),
    );
  }


}

final _textController = TextEditingController();

