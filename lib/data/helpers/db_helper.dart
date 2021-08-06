import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../model/exported_models.dart';

class DatabaseHelper {
  factory DatabaseHelper() =>
      _databaseHelper ??= DatabaseHelper._createInstance();

  DatabaseHelper._createInstance();

  static const String dbName = 'QuickBanking';
  static const String tableUserAccounts = 'UserAccounts';
  static const String tableUserTransactions = 'UserTransactions';

  static DatabaseHelper _databaseHelper;
  static Database _database;

  Future<Database> initializeDatabase() async {
    final Database database =
        await openDatabase(dbName, version: 1, onCreate: _createDb);
    return database;
  }

  Future<Database> get database async {
    return _database ??= await initializeDatabase();
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute('''
CREATE TABLE $tableUserAccounts ( 
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  phoneNumber TEXT NOT NULL UNIQUE,
  accountNumber TEXT,
  token TEXT,
  tokenExpiry TEXT,
  availableBalance REAL,
  actualBalance REAL,
  accountType TEXT,
  firstName TEXT,
  surname TEXT,
  isQuickAccount INTEGER,
  kycLevel TEXT)
''');

    await db.execute('''
CREATE TABLE $tableUserTransactions ( 
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  transactionId INTEGER,
  createdAt TEXT,
  description TEXT,
  amount REAL,
  charge REAL,
  userPhoneNumber TEXT NOT NULL,
  FOREIGN KEY(userPhoneNumber) REFERENCES $tableUserAccounts(phoneNumber))
''');
  }

  Future<int> insertAccountInDB(UserAccount userAccount) async {
    final Database db = await database;
    final int result = await db.insert(
      tableUserAccounts,
      userAccount.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getAccountInDB() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      tableUserAccounts,
      orderBy: 'id ASC',
    );
    return result;
  }

  Future<int> updateAccountInDB(UserAccount userAccount) async {
    final Database db = await database;
    final int result = await db.update(
      tableUserAccounts,
      userAccount.toMap(),
      where: 'id = ?',
    );
    return result;
  }

  Future<bool> tableIsNotEmpty() async {
    final Database db = await database;

    final int _count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableUserAccounts'));
    // final int count =
    // (await db.rawQuery('SELECT COUNT(*) FROM $tableUserAccounts')).length;
    return _count != null && _count > 0;
  }

  Future<bool> isUserAccountInDB(String phoneNumber) async {
    final Database db = await database;

    final List<Map<String, Object>> count = await db.rawQuery(
      // ignore: avoid_escaping_inner_quotes
      'SELECT * FROM $tableUserAccounts WHERE phoneNumber = $phoneNumber',
    );
    return count.isNotEmpty;
  }

  //Linked Account DB Helpers

  Future<List<UserAccount>> getUserAccountInDBList() async {
    final List<Map<String, dynamic>> userAccountInDBMapList =
        await getAccountInDB();
    final int count = userAccountInDBMapList.length;

    final List<UserAccount> userAccountInDBList = <UserAccount>[];

    for (int i = 0; i < count; i++) {
      userAccountInDBList.add(UserAccount.fromMap(userAccountInDBMapList[i]));
    }
    return userAccountInDBList;
  }

  Future<void> removeTable() async {
    await _database.delete(tableUserAccounts);
  }
}
