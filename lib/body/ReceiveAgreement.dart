import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/api/firebase_api.dart';
import '/db/db_servier.dart';
import '/db/user_model.dart';


class ReceiveAgreement extends StatelessWidget {
  const ReceiveAgreement({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
            child:Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),

              child:Row(
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
                        dbService.sendServer(userdata,'/restFlutter/save');

                      }
                      ,child: Text("알림 메세지 수신 동의"),),
                  )

                ],
              ),
            )

        )

    );
  }
}

final _textController = TextEditingController();