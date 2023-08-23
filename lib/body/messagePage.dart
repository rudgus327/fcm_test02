import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {

  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child:Container(
            margin: const EdgeInsets.all(50),
            child: const Column(
              children: [
                Text('Messages'
                    ,style: TextStyle(color: Colors.lightBlue,fontSize: 50)),
                SizedBox(height: 15.0),
                Text('메세지 쌓이도록 해야함'
                  ,style: TextStyle(fontSize: 20),)
              ],
            ),
          )

      )

    );
  }
}
final _textController = TextEditingController();