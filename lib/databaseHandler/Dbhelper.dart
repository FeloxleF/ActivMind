import 'dart:ffi';

import 'package:activmind_app/model/UserModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;


class DbHelper {
  static Database? _db;
  

  static const String db_name = 'activmind.db';
  static const String table_User = 'user';
  static const int version = 1;
  
  static const String user_id = 'userId';
  static const String email = 'email';
  static const String password = 'password';
  static const String type = 'type';
  static const String create_date = 'create_date';
  
  Future<Database?> get db async {
    if (_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  initDb()async{
    try {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, db_name);
    print("Database path: $path");
    var db = await openDatabase(path, version: version, onCreate: _oncreate);
    return db;
  } catch (e) {
    print("Error initializing database: $e");
    return null;
  } 
  }

  _oncreate(Database db, int intversion) async {
  await db.execute('''
    CREATE TABLE $table_User (
      $user_id INTEGER PRIMARY KEY AUTOINCREMENT,
      $email TEXT,
      $password TEXT,
      $type INTEGER,
      $create_date DATE
    )
  ''');
}


  // _oncreate(Database db, int intversion)async{
  //   await db.execute (" create table $table_User ("
  //   "$user_id int AUTO_INCREMENT"
  //   "$email TEXT"
  //   "$password TEXT"
  //   "$type int"
  //   "$create_date date"
  //   "PRIMARY KEY ($user_id)"
  //   ")"
  //   );

  // }
  // Future<UserModel> saveData(UserModel user) async{
  //   var dbClient = await db;
  //   user.email = (await dbClient!.insert(table_User, user.toMap())) as String;
  //   return user;
  // }
  Future<int> saveData(UserModel user) async{
    var dbClient = await db;
    var res = await dbClient!.insert(table_User, user.toMap());
    
    return res;
  }
  
  Future<UserModel?> getLoginUser(String email, String password) async{
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM $table_User WHERE "
        "$email = '$email' AND "
        "$password = '$password'");

    if (res.length > 0) {
      return UserModel.fromMap(res.first);
    }
    return null;
  }
  
}
