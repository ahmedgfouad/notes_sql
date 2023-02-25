import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? _db ;
  Future<Database?> get db async{

    if(_db == null){
      _db =await initialDB();
      return _db ;
    }else{
      return _db ;
    }

  }

  initialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'gemy.db');
    Database mydb = await openDatabase(
      path, onCreate: _onCreate , version:  5, onUpgrade: _onUpgrade);
    return mydb;
  }
  _onUpgrade(Database db , int oldVersion , int newVersion )async{
    print("onUpgrade ======");

  }

  _onCreate(Database db, int version) async{
    Batch batch =db.batch();
    batch.execute('''
    CREATE TABLE "notes" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT , 
      "title" TEXT NOT NULL ,
      "note"  TEXT NOT NULL ,
      "color" TEXT NOT NULL 
    )
    ''');

    await batch.commit();
    print("Create DataBase And Table ======================== ");

  }

  readData(String sql)async{
    Database? mydb=await db ;
    List<Map> response =await mydb!.rawQuery(sql);
    return response ;
  }
   insertData(String sql)async{
    Database? mydb=await db ;
    int response =await mydb!.rawInsert(sql);
    return response ;
  }
  updateData(String sql)async{
    Database? mydb=await db ;
    int response =await mydb!.rawUpdate(sql);
    return response ;
  }
  deleteData(String sql)async{
    Database? mydb=await db ;
    int response =await mydb!.rawDelete(sql);
    return response ;
  }

  myDeleteDatabase()async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'gemy.db');
    await deleteDatabase(path);
  }


  red (String table)async{
    Database? mydb=await db ;
    List<Map> response =await mydb!.query(table);
    return response ;
  }
  insert(String table,Map<String,Object>value)async{
    Database? mydb=await db ;
    int response =await mydb!.insert(table,value);
    return response ;
  }
  update(String table,Map<String, Object?> value ,String? myWhere)async{
    Database? mydb=await db ;
    int response =await mydb!.update(table,value,where: myWhere);
    return response ;
  }
  delete(String table,String? myWhere)async{
    Database? mydb=await db ;
    int response =await mydb!.delete(table,where: myWhere);
    return response ;
  }



}


















