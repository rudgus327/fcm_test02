import 'package:fcm_test02/body/webview/sendMessageWebView.dart';
import 'package:flutter/material.dart';

import '../db/db_servier.dart';
import '../db/message_model.dart';
import '../header/NavigatorUtil.dart';
import '../util/textFieldUtil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _formKey = GlobalKey<FormState>();

  late String title ="";
  late String body ="";
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width ,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        ),
        child:Column(
          children: [
            // Form(
            //     key: _formKey,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         children: [
            //
            //           TextFieldUtil().renderTextFormField(
            //               label: '제목',
            //               onSaved: (val){
            //                 setState(() {
            //                   this.title = val;
            //                 });},
            //               validator: (val){
            //                 if(val.isEmpty){
            //                   return '제목 필수사항입니다.';
            //                 }else{
            //                   return null;
            //                 }
            //               },
            //               originVal: ""
            //           ),//renderTextFormField
            //           TextFieldUtil().renderTextFormField(
            //               label: '내용',
            //               onSaved: (val){
            //                 setState(() {
            //                   this.body = val;
            //                 });
            //               },
            //               validator: (val){
            //                 if(val.isEmpty){
            //                   return '내용은 필수사항입니다.';
            //                 }
            //               },
            //               originVal: ""
            //
            //           ),//renderTextFormField
            //           SizedBox(height: 30.0,),
            //           Row(children: [
            //             const SizedBox(width: 100,),
            //             ElevatedButton(
            //               onPressed: (){
            //                 sendMessage();
            //               },
            //               child: const Row(children: [
            //                 Icon(Icons.send),
            //                 SizedBox(width: 10),
            //                 Text("푸시 알림 전송")
            //               ],),
            //             ),
            //
            //
            //           ],)
            //
            //
            //           // renderButton(item,type),
            //         ],
            //       ),
            //     )
            // ),
            const SizedBox(width: 100,height: 50,),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightBlue),),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GotoPage(targetClass: const WebViewPage()))
                );
              },
              child: const Text('웹뷰 호출'),
            ),
          ],
        )
      ),


    );
  }

  sendMessage() {
    DBService dbService = DBService();
    var sendData =FCMessage(title: this.title,body: this.body);
    dbService.sendServer(sendData,'/restFlutter/sendMsg');
  }
}