import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/api/firebase_api.dart';
import '/db/db_servier.dart';
import '/db/user_model.dart';

class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child:Container(
          margin: const EdgeInsets.all(50),
            child: const Column(
              children:  [
                Text('Home'
                    ,style: TextStyle(fontSize: 50)),
                SizedBox(height: 15.0),
                Text('※수신동의 페이지에서 아이디와 함께 동의 체크※'
                  ,style: TextStyle(color: Colors.red,fontSize: 20),)
              ],
            ),
        )
      )

    );
  }
}
final _textController = TextEditingController();