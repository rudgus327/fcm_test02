import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Headers.dart';

/*
 App bar 메인 설정
 */
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  CustomAppbar( {super.key});

  final double header_height = 60; // 헤더 높이

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Text(MainCommon().homeTitle),
      leading: GestureDetector(
        onTap: (){},
        child: Icon(Icons.menu),
      ),

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(header_height);
}

/*
 메뉴 네비게이터 리스트
 */
class NavigationDrawSet extends StatelessWidget {
  const NavigationDrawSet({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container();

  Widget buildMenuItems(BuildContext context) => MainCommon();
}
/*
  헤더리스트 위젯 동적 생성 리턴
 */
List<Widget> makeListTiles (List<Map<String,dynamic>> lists,BuildContext context){
  List<Widget> tiles =[] ;
  for(int i =0; i < lists.length ; i++){
    Map<String,dynamic> listMap = lists[i];
    tiles.add(
      ListTile(
      leading: listMap['icons'] ,
      iconColor: Colors.grey,
      focusColor: Colors.blue,
      title: Text(listMap['title']),
      onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context)=> GotoPage(targetClass: listMap['targetClass'])
      )
      ),trailing: listMap.containsKey('mainTitle') == true ? null: const Icon(Icons.navigate_next) ,

    ));
  }
  return tiles;
}

/*
 페이지 리턴(헤더+바디)
 */
class GotoPage extends StatelessWidget {
  var targetClass;
  GotoPage({super.key,this.targetClass});

  @override
  Widget build(BuildContext context) {
    var targetClass = this.targetClass;
    return Scaffold(
      appBar: CustomAppbar(),
      body: targetClass,
      drawer:NavigationDrawSet(),
    );
  }
}