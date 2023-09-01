import 'package:flutter/material.dart';

import '../body/ReceiveAgreement.dart';
import '../body/dashboard.dart';
import '../body/message_page.dart';
import '../body/myHomePage.dart';
import '../body/sendMessagePage.dart';
import '../body/webviewNaverPage.dart';
import 'NavigatorUtil.dart';

class MainTitle{
  var appTitle = 'Flutter Demo';
}

class MainCommon extends StatelessWidget {
  var homeTitle = 'Flutter demo';
  MainCommon({super.key});

  @override
  Widget build(BuildContext context) {

    List<Map<String,dynamic>> menuList = [
      {'icons':null,'title':homeTitle,'targetClass':const MyHomePage(),'mainTitle': true}
      ,{'icons':const Icon(Icons.home),'title':'Home','targetClass':const MyHomePage()}
      ,{'icons':const Icon(Icons.check_circle_outline),'title':'수신 동의','targetClass':const ReceiveAgreement()}
      ,{'icons':const Icon(Icons.mark_as_unread_sharp),'title':'Message List','targetClass':const MessagePage()}
      ,{'icons':const Icon(Icons.send),'title':'Send Message','targetClass':const MainPage()}
      ,{'icons':const Icon(Icons.web),'title':'Web View to Naver','targetClass':const WebviewNaverPage()}
      ,{'icons':const Icon(Icons.developer_board),'title':'게시판','targetClass':const CRUDDashboard()}


    ];

    return Column(
      children: makeListTiles(menuList,context)
    );
  }
}



