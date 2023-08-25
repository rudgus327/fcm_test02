import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../message_model.dart';

final String TableName = 'FCMessages';

class FCMDBHelper{

  FCMDBHelper._();
  static final FCMDBHelper _db = FCMDBHelper._();
  factory FCMDBHelper() => _db;

  static Database? _database;

  Future<Database?> get database async {
    // Database를 가져오는 get
    // 없으면 initDB() 호출 있으면 database 리턴
    _database ??= await initDB();

    return _database;

  }

  initDB()async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'MyMessagesDB.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async{
          String createQuery = "CREATE TABLE "+TableName+"(message_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,body TEXT)";
          await db.execute(createQuery);
        },
        onUpgrade: (db, oldVersion,newVersion){}
    );

  }

  /*
  db insert
   */
  createData(FCMessage fcm) async{
    final db = await database;
    print('create data');
    var res = await db?.rawInsert('INSERT INTO $TableName(title,body) VALUES(?,?)',[fcm.title,fcm.body]);
    return res;
  }
  /*
  read
  */
  getList(int id) async{
    final db = await database;
    if(db == null) return;
    var res = await db.rawQuery('SELECT * FROM $TableName WHERE message_id = ?', [id]) as List<Map>;
    return res.isNotEmpty ? FCMessage(messageId: res.first['message_id'], title: res.first['title'], body: res.first['body']) : null;
  }
  /*
  read all
  */
  Future<List<FCMessage>> getAllLists() async{
    final db = await database;
    if(db == null) return [];
    var res = await db.rawQuery('SELECT * FROM $TableName ORDER BY message_id DESC') as List<Map>;
    List<FCMessage> list = res.isNotEmpty ? res.map((c) => FCMessage(messageId:c['message_id'], title:c['title'], body:c['body'])).toList() : [];
    return list;
  }
  /*
  delete one
  */
  deleteList(int id) async{
    final db = await database;
    if(db == null) return;
    var res = db.rawDelete('DELETE FROM $TableName WHERE message_id = ?', [id]);
    return res;
  }
  /*
  delete all
  */
  deleteAllLists() async{
    final db = await database;
    if(db == null) return;
    db.rawDelete('DELETE FROM $TableName');
  }
  //Update
  updateList(FCMessage fcm) async {
    final db = await database;
    if(db == null) return;
    String updateQuery = 'UPDATE $TableName SET title = ${fcm.title}, body=${fcm.body} WHERE message_id = ${fcm.messageId}';
    var res = db.rawUpdate(updateQuery);
    return res;
  }

}