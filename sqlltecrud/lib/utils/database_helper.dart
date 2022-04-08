import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlltecrud/models/contact.dart';

class DatabaseHelper {
  static const _databaseName = 'contactData.db';
  static const _databaseVersion = 1;

  DatabaseHelper._() {}
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion,
        onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Contact.tblContact}(
      ${Contact.coId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Contact.coName} TEXT NOT NULL,
      ${Contact.coMobile} TEXT NOT NULL
      )
     ''');
  }

  Future<int> insertContact(Contact contact) async {
    Database db = await database;
    return await db.insert(Contact.tblContact, contact.toMap());
  }

  Future<List<Contact>> fetchContact() async{
    Database db= await database;
    List<Map> contacts= await db.query(Contact.tblContact);
    return contacts.length==0?
        []
        :contacts.map((e) => Contact.fromMap(e)).toList();
  }

  Future<int> updateContact(Contact contact) async {
    Database db = await database;
    return await db.update(Contact.tblContact, contact.toMap(),where:
    '${Contact.coId}=?',whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db.delete(Contact.tblContact,where:
    '${Contact.coId}=?',whereArgs: [id]);
  }

}
