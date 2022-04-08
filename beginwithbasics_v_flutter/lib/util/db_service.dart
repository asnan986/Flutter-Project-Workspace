import 'dart:io';

import 'package:beginwithbasics_v_flutter/models/model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static const _databaseName = 'content_dataBase.db';

  DBService._() {}

  static final DBService dbService = DBService._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    //constructing path to the apps writable database file
    var dbDir=await getDatabasesPath();
    var dbPath=join(dbDir,_databaseName);

    //deleting existing database(if any)
    await deleteDatabase(dbPath);

    //create the writable database file from bundled demo database file
    ByteData data =await rootBundle.load("assets/database/$_databaseName");
    List<int> bytes =data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);

    //opening database and returning to instance variable
    return await openDatabase(dbPath);
  }

  Future<int> insertEntity(Model model) async{
    Database db =await database;
    return await db.insert(model.map['tableName'], model.toMap());
  }

  Future<List<Model>> fetchEntity(Model model) async{
    Database db=await database;
    List<Map> list= await db.query(model.map['tableName']);
    return list.length==0?[]:list.map((e) => model.fromMap(e)).toList();
  }

  Future<List<Model>> fetchEntityByField(Model model,dynamic argumentValue) async{
    Database db=await database;
    List<Map> list= await db.query(model.map['tableName'],where: '${Model.queryField}=?',whereArgs: [argumentValue]);
    return list.length==0?[]:list.map((e) => model.fromMap(e)).toList();
  }

  Future<int> updateEntity(Model model) async{
    Database db =await database;
    return await db.update(model.map['tableName'], model.toMap(),
        where: '${model.map['id']}=?',
        whereArgs: [model.id]);
  }
  
  Future<int> deleteEntity(Model model) async{
    Database db =await database;
    return await db.delete(model.map['tableName'],where:
    '${model.map['id']}=?',whereArgs: [model.id]);
  }


}
