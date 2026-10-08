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

  Future<Database> initDb()async{
    String databasepath= await getDatabasesPath();
    String path=  join(databasepath,'sqflitecourse.db');
    Database mydb= await openDatabase(path,onCreate: _onCreate, version: 3,onUpgrade: _onUpgrade);
    return mydb;
  }

  dynamic _onUpgrade(Database db,int oldversion,int newversion)async{
    await db.execute("ALTER TABLE notes ADD COLUMN title TEXT");
   log("_onUpgrade====================================");
  }

  void _onCreate(Database db ,int version)async{
    await db.execute(
      '''
      CREATE TABLE "notes"(
        "id" INTEGER PRIMARY KEY  AUTOINCREMENT,
        "note" TEXT NOT NULL,
        "title" TEXT
      )  
      '''     
    );
    log("Create data base and tables===========================");

  }

  Future<List<Map>> readData(String sql) async{
    Database ? mydb=await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }
  
  Future<int> insertData(String sql) async{
    Database ? mydb=await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async{
    Database ? mydb=await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async{
    Database ? mydb=await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
  
  void deleteMyDataBase()async{
    String databasepath= await getDatabasesPath();
    String path=  join(databasepath,'sqflitecourse.db');
    await deleteDatabase(path);
  }
  //easy functions without sql
  Future<List<Map>> read(String table) async{
    Database ? mydb=await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }
  
  Future<int> insert(String table,Map<String, Object?> values) async{
    Database ? mydb=await db;
    int response = await mydb!.insert(table,values);
    return response;
  }

  Future<int> update(String table,Map<String, Object?> values,String? where,) async{
    Database ? mydb=await db;
    int response = await mydb!.update(table,values,where: where);
    return response;
  }

  Future<int> delete(String table,String? where,) async{
    Database ? mydb=await db;
    int response = await mydb!.delete(table,where: where);
    return response;
  }
}