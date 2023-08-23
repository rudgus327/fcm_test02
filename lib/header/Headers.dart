import 'package:flutter/material.dart';

import '../body/ReceiveAgreement.dart';
import '../body/messagePage.dart';
import '../body/myHomePage.dart';
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
      {'icons':null,'title':homeTitle,'targetClass':null,'mainTitle': true}
      ,{'icons':Icon(Icons.home),'title':'Home','targetClass':MyHomePage()}
      ,{'icons':Icon(Icons.mark_as_unread_sharp),'title':'Message','targetClass':MessagePage()}
      ,{'icons':Icon(Icons.check_circle_outline),'title':'알림 수신 동의','targetClass':ReceiveAgreement()}
    ];

    return Column(
      children: makeListTiles(menuList,context)
    );
  }
}


