import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model.dart';

class DatabaseHelper {
  factory DatabaseHelper() =>
      _databaseHelper ??= DatabaseHelper._createInstance();

  DatabaseHelper._createInstance();

  static DatabaseHelper _databaseHelper;
  static Database _database;

  Future<bool> checkDb() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}accounts.db';
    final bool exist = await databaseExists(path);
    return exist;
  }

  Future<bool> tableIsNotEmpty() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final Database db = await openDatabase('${directory.path}accounts.db');
    final int count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM accounts'),
    );
    final bool returnRes = count != null && count > 0;
    return returnRes;
  }

  Future<bool> isAccountInDB(String phoneNumber) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final Database db = await openDatabase('${directory.path}accounts.db');
    final List<Map<String, Object>> count = await db.rawQuery(
        // ignore: avoid_escaping_inner_quotes
        'SELECT * FROM accounts WHERE phoneNumber = \'$phoneNumber\'');
    final bool returnRes = count.isNotEmpty;
    return returnRes;
  }

  Future<Database> get database async {
    return _database ??= await initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}accounts.db';

    final Database accountDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return accountDatabase;
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute('''
CREATE TABLE accounts ( 
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  phoneNumber TEXT NOT NULL UNIQUE,
  accountNumber TEXT,
  token TEXT,
  tokenExpiry TEXT,
  isLinked TEXT,
  isLoggedIn TEXT,
  name TEXT,
  accountType TEXT,
  kycLevel TEXT)
''');
  }

  //Linked Account DB Helpers
  Future<List<Map<String, dynamic>>> getAccountInDB() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'accounts',
      orderBy: 'id ASC',
    );
    return result;
  }

  Future<int> insertAccountInDB(AccountInDB accountInDB) async {
    final Database db = await database;
    final int result = await db.insert(
      'accounts',
      accountInDB.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<int> updateAccountInDB(AccountInDB accountInDB) async {
    final Database db = await database;
    final int result = await db.update(
      'accounts',
      accountInDB.toMap(),
      where: 'id = ?',
      // whereArgs: <int>[linkedAccount.id],
    );
    return result;
  }

  Future<List<AccountInDB>> getAccountInDBList() async {
    final List<Map<String, dynamic>> accountInDBMapList =
        await getAccountInDB();
    final int count = accountInDBMapList.length;

    final List<AccountInDB> accountInDBList = <AccountInDB>[];

    for (int i = 0; i < count; i++) {
      accountInDBList.add(AccountInDB.fromMap(accountInDBMapList[i]));
    }
    return accountInDBList;
  }

  Future<void> removeDB() async {
    await _database.delete('accounts');
  }
}
