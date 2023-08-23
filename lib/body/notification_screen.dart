import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const route ='/notification-screen';

  @override
  Widget build(BuildContext context) {
    final messageArg = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICATION',style: TextStyle(color: Colors.pinkAccent)),
        backgroundColor: Colors.deepPurple,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('title:${messageArg['title']}'),
            Text('content:${messageArg['body']}'),
          ],
        )
      ),
    );
  }
}
