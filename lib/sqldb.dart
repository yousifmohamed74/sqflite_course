import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Sqldb {
  
  static Database? _db;
  Future<Database?> get db async{
    if(_db==null){
      _db= await initDb();
      return _db;
    }
    else{
      return _db;
    }
  }

  dynamic initDb()async{
    String databasepath= await getDatabasesPath();
    String path=  join(databasepath,'sqflitecourse.db');
    Database mydb= await openDatabase(path,onCreate: _onCreate, version: 1,onUpgrade: _onUpgrade);
    return mydb;
  }

  dynamic _onUpgrade(Database db,int oldversion,int newversion)async{

  }

  dynamic _onCreate(Database db ,int version)async{
    await db.execute(
      '''
      CREATE TABLE "notes"(
        id INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT,
        notes TEXT NOT NULL
      )  
      '''     
    );
    log("Create data base and tables===========================");

  }

  dynamic readData(String sql) async{
    Database ? mydb=await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }
  
  dynamic insertData(String sql) async{
    Database ? mydb=await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  dynamic updateData(String sql) async{
    Database ? mydb=await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  dynamic deleteData(String sql) async{
    Database ? mydb=await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

}