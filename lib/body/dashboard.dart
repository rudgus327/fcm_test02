import 'package:flutter/material.dart';

import '../db/dashboard_db.dart';
import '../db/db_helper/dashboard_helper.dart';

import '../util/textFieldUtil.dart';

final _textController = TextEditingController();

class CRUDDashboard extends StatefulWidget {
  const CRUDDashboard({super.key});

  @override
  State<CRUDDashboard> createState() => _CRUDDashboardState();
}

class _CRUDDashboardState extends State<CRUDDashboard> {

  late Future<List<DashboardContents>> futureDashboardList;

  final _formKey = GlobalKey<FormState>();

  late String title;
  late String content;
  late String createUser;
  late String search = "";

  late String save ='저장';
  late String edit ='수정';

  @override
  Widget build(BuildContext context) {

    futureDashboardList = DashboardDBhelper().getList(search);

    return Scaffold(
      body: FutureBuilder(
        future: futureDashboardList,
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
              DashboardContents item = snapshotItem?[index];
              return GestureDetector( // 제스처 기능 추가
                onTap: (){
                  print("id:${item.id}");
                  showDetailPopup(context,item);
                },

                child: Card(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 80,
                        height: 100,
                        child: Icon(Icons.edit_note),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(item.title, style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.blueGrey),
                            ),
                            const SizedBox(height: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(item.createUser,style: TextStyle(fontSize: 15,color: Colors.grey[500]),),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 30,),
                      ElevatedButton(onPressed: (){
                        DashboardDBhelper().deleteList(item!.id);
                        setState(() {
                          search = "";
                          futureDashboardList = DashboardDBhelper().getList(search);
                        });
                      }, child: Text('삭제')),
                      const SizedBox(width: 10,),
                      ElevatedButton(onPressed: (){
                        // 서버로 전송 후 저장
                      }, child: Text('전송')),
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
            child: Icon(Icons.search),
            onPressed: () {
              print('search button');

              showSearchPopup(context);
            },
          ),
          SizedBox(height: 8.0),
          FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              print('refresh button');
              setState(() {
                search = "";
              });
            },
          ),
          SizedBox(height: 8.0),
          FloatingActionButton(
            child:Icon(Icons.add)
            ,onPressed: (){
            showCreatePopup(context);
          }
          )
        ],
      ),
    );
  }


  // update form
  showDetailPopup(BuildContext context, DashboardContents item) {
    showDialog(context: context,builder: (context){
      return showPopupForm(context,item,edit);
    });

  }

  // insert form
  showCreatePopup(BuildContext context) {
    showDialog(context: context, builder: (context){
      DashboardContents item = DashboardContents(title: "",content: "",createUser: "");
      return showPopupForm(context,item,save);
    });

  }

  // form pop up
  showPopupForm(BuildContext context, DashboardContents item,String type){

    return Dialog(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child:Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    TextFieldUtil().renderTextFormField(
                        label: '작성자',
                        onSaved: (val){
                          setState(() {
                            createUser = val;
                          });},
                        validator: (val){
                          if(val.isEmpty){
                            return '작성자는 필수사항입니다.';
                          }else{
                            return null;
                          }
                        },
                        originVal: item.createUser
                    ),//renderTextFormField
                    TextFieldUtil().renderTextFormField(
                        label: '제목',
                        onSaved: (val){
                          setState(() {
                            title = val;
                          });
                        },
                        validator: (val){
                          if(val.isEmpty){
                            return '제목은 필수사항입니다.';
                          }
                        },
                        originVal: item.title

                    ),//renderTextFormField
                    TextFieldUtil().renderTextFormMultiField(
                        label: '내용',
                        onSaved: (val){
                          setState(() {
                            content = val;
                          });
                        },
                        validator: (val){
                          if(val.isEmpty){
                            return '내용은 필수사항입니다.';
                          }
                        },
                        originVal: item.content
                    ),//renderTextFormField
                    SizedBox(height: 30.0,),

                    renderButton(item,type),
                  ],
                ),
              )
          )
      ),

    );
  }

  // button handler
  renderButton(DashboardContents item,String type){
    return ElevatedButton(
      onPressed: () async{
        bool isTrue = _formKey.currentState!.validate();
        print('validator:$isTrue');
        if(_formKey.currentState!.validate()){
          _formKey.currentState!.save();

          var title = this.title;
          var content = this.content;
          var createUser = this.createUser;

          print('title:$title,content:$content,createUser:$createUser');

          var board = DashboardContents(title: this.title,content: this.content,createUser: this.createUser,id: item?.id);
          if(type == save){
            print('저장');
            DashboardDBhelper().createData(board);
          }else{
            print('수정');
            DashboardDBhelper().updateData(board);
          }

        }
        setState(() {
          futureDashboardList = DashboardDBhelper().getAllList();
          Navigator.pop(context);
        });
      }
      , child: Text(type,style: const TextStyle(color: Colors.white),),

    );
  }

  //검색창
  showSearchPopup(BuildContext context) {
    showDialog(context: context, builder: (context){
      DashboardContents item = DashboardContents(title: "",content: "",createUser: "");
      _textController.text ="";
      return Dialog(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(11.0),
                  child: Text('제목'),
                ),
                Flexible(child: TextField(
                  controller: _textController,
                )),
                Container(
                  padding: const EdgeInsets.all(11.0),
                  child: ElevatedButton(
                    onPressed: (){
                      var title = _textController.text;
                      print("search:$title");
                      if(title.isEmpty) return;
                      setState(() {
                        search = title;
                        // futureDashboardList = DashboardDBhelper().getList(title);
                        Navigator.pop(context);
                      });
                    },
                    child: Text('검색'),
                  ),
                )
              ],
            )
        ),

      );
    });
  }
}


