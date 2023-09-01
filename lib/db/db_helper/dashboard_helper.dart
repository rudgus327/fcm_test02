import 'dart:io';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../dashboard_db.dart';

final String TableName = 'TBL_DASHBOARD';

class DashboardDBhelper{

  DashboardDBhelper._();

  static final DashboardDBhelper _db = DashboardDBhelper._();
  factory DashboardDBhelper() => _db;

  static Database? _database;

  // 테이블 생성
  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'FCM_TEST02.db'); // --> 저장될 파일명 지정

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db,version) async{
        String createQuery = "CREATE TABLE $TableName(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, content TEXT, createUser TEXT, createDate TEXT, updateDate TEXT)";
        await db.execute(createQuery);
      },
      onUpgrade: (db, oldVersion,newVersion){}

    );
  }

  // 디비 가져옴.. 없으면 테이블 생성 
  Future<Database?> get database async{
    _database ??= await initDB(); // null체크
    return _database;
  }

  // insert
  createData(DashboardContents board) async{
    final db = await database;
    print("create data");
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    var createDate = formatter.format(now);
    String sql = 'INSERT INTO $TableName(title,content,createUser,createDate,updateDate) values(?,?,?,?,?)';
    var res = await db?.rawInsert(sql,[board.title,board.content,board.createUser,createDate,createDate]);
    print("create data result :$res");
    return res;
  }

  // get all list
  Future<List<DashboardContents>> getAllList() async{
    final db = await database;
    if(db == null) return [];
    String sql = "SELECT * FROM $TableName ORDER BY id DESC";
    var res = await db.rawQuery(sql) as List<Map>;
    List<DashboardContents> list = res.isNotEmpty
        ? res.map((e) => DashboardContents(id:e['id'],title:e['title'],content:e['content'],createUser:e['createUser'],createDate:e['createDate'],updateDate:e['updateDate'])).toList()
        :[];
    return list;
  }

  Future<List<DashboardContents>> getList(String title) async{
    final db = await database;
    if(db == null) return [];
    String sql = "SELECT * FROM $TableName WHERE title LIKE '%$title%' ORDER BY id DESC";
    var res = await db.rawQuery(sql) as List<Map>;
    List<DashboardContents> list = res.isNotEmpty
        ? res.map((e) => DashboardContents(id:e['id'],title:e['title'],content:e['content'],createUser:e['createUser'],createDate:e['createDate'],updateDate:e['updateDate'])).toList()
        :[];
    print('return list :$list');
    return list;
  }
  // update
  updateData(DashboardContents board) async{
    final db = await database;
    if(db == null) return;
    int? id = board.id;
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    var updateDate = formatter.format(now);
    String sql = "UPDATE $TableName SET "
        "title = '${board.title}',content = '${board.content}',createUser = '${board.createUser}',updateDate = '$updateDate' WHERE id = $id";
    print("testestest:::$sql");
    var res = db.rawUpdate(sql);
    print("update data result :$res");
    return res;
  }

  //delete
  deleteList(int? id) async{
    final db = await database;
    if(db == null) return;
    String sql = "DELETE FROM $TableName WHERE id = ?";
    var res = db.rawDelete(sql,[id]);
    return res;
  }



}
