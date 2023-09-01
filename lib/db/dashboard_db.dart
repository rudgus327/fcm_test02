import 'package:flutter/cupertino.dart';

class DashboardContents{
  final int? id;
  final String title;
  final String content;
  final String createUser;
  final String? createDate;
  final String? updateDate;

  DashboardContents({
    this.id
    ,required this.title
    ,required this.content
    ,required this.createUser
    ,this.createDate
    ,this.updateDate});

  Map<String,dynamic> toJson()=>{
    'id':id,
    'title':title,
    'content':content,
    'createUser':createUser,
    'createDate':createDate,
    'updateDate':updateDate,
  };

}