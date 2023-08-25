import 'dart:io';
import 'package:fcm_test02/sqlite_test/dog_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String TableName ='Dog';

class DBHelper{

  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper()=> _db;

  static Database? _database;

  Future<Database?> get database async {
    // Database를 가져오는 get
    // 없으면 initDB() 호출 있으면 database 리턴
    _database ??= await initDB();

    return _database;

  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'MydogsDB.db');

    return await openDatabase(
        path,
      version: 1,
      onCreate: (db, version) async{
        String createQuery = "CREATE TABLE "+TableName+"(id INTEGER PRIMARY KEY,name TEXT)";
          await db.execute(createQuery);
      },
      onUpgrade: (db, oldVersion,newVersion){}
    );

  }

  /*
  db insert
   */
  createData(Dog dog) async{
    final db = await database;
    var res = await db?.rawInsert('INSERT INTO $TableName(name) VALUES(?)',[dog.name]);
    return res;
  }
  /*
  read
  */
  getDog(int id) async{
    final db = await database;
    if(db == null) return;
    var res = await db.rawQuery('SELECT * FROM $TableName WHERE id = ?', [id]) as List<Map>;
    return res.isNotEmpty ? Dog(id: res.first['id'], name: res.first['name']) : null;
  }
  /*
  read all
  */
  Future<List<Dog>> getAllDogs() async{
    final db = await database;
    if(db == null) return [];
    var res = await db.rawQuery('SELECT * FROM $TableName') as List<Map>;
    List<Dog> list = res.isNotEmpty ? res.map((c) => Dog(id:c['id'], name:c['name'])).toList() : [];
    return list;
  }
  /*
  delete
  */
  deleteDog(int id) async{
    final db = await database;
    if(db == null) return;
    var res = db.rawDelete('DELETE FROM $TableName WHERE id = ?', [id]);
    return res;
  }
  /*
  delete all
  */
  deleteAlldogs() async{
    final db = await database;
    if(db == null) return;
    db.rawDelete('DELETE FROM $TableName');
  }
  //Update
  updateDog(Dog dog) async {
    final db = await database;
    if(db == null) return;
    var res = db.rawUpdate('UPDATE $TableName SET name = ? WHERE = ?', [dog.name, dog.id]);
    return res;
  }

}
