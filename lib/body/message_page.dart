import 'package:fcm_test02/db/db_helper/message_helper.dart';
import 'package:fcm_test02/db/message_model.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  _MessagePageState createState() => _MessagePageState();

}

class _MessagePageState extends State<MessagePage>{
  late Future<List<FCMessage>> futureMessageList;

  @override
  Widget build(BuildContext context) {

    futureMessageList = FCMDBHelper().getAllLists();

    return Scaffold(
      body: FutureBuilder(
        future: futureMessageList,
        builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot) {
          var cnt = 0;
          dynamic snapshotItem;
          if(snapshot.hasData){
            cnt = snapshot.data.length;
            snapshotItem = snapshot.data;
          }
          return ListView.builder(
            itemCount: cnt,
            itemBuilder: (BuildContext context, int index){
              FCMessage item = snapshotItem?[index];
              return GestureDetector( // 제스처 기능 추가
                onTap: (){
                  print("message_id:${item.messageId}");
                  showPopup(context,item);
                },

                child: Card(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100,
                        height: 100,
                        child: Icon(Icons.message),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(item.title, style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.blueGrey),
                            ),
                            const SizedBox(height: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(item.body,style: TextStyle(fontSize: 15,color: Colors.grey[500]),),
                            )
                          ],
                        ),
                      )
                    ],
                  ) ,
                ),

              );

            },

          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              print('refresh button');
              setState(() {
                futureMessageList = FCMDBHelper().getAllLists();
              });
            },
          ),
        ],
      ),
    );
  }

  showPopup(BuildContext context, FCMessage item) {
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(item.title,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.lightBlue),),
                  Padding(padding: const EdgeInsets.all(8),
                    child: Text(
                      item.body
                      ,maxLines: 3
                      ,style: TextStyle(fontSize: 15,color: Colors.grey[500]
                    ),
                      textAlign: TextAlign.center,
                    ),),
                  SizedBox(height: 30,),

                  ElevatedButton.icon(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close)
                      , label: const Text('close')
                  ),ElevatedButton.icon(onPressed: (){
                    var res = FCMDBHelper().deleteList(item.messageId as int);
                    setState(() {
                      futureMessageList = FCMDBHelper().getAllLists();
                      Navigator.pop(context);
                    });

                  }, icon: const Icon(Icons.delete)
                      , label: const Text('delete')
                  )

                ],
              ),
            ),
          );
        });
  }
}


