import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();
  DbHelper._();

  Database? _db;

  Future get database async => _db ?? await initDatabase();

  // Future getDatabase()
  // async {
  //   if(_db!=null)
  //     {
  //       return _db;
  //     }
  //   else
  //     {
  //       return await initDatabase();
  //     }
  // }


  // init database - create table
  Future initDatabase() async {
    // 1. create path to store database
    final path = await getDatabasesPath();
    final dbPath = join(path, 'finance.db');

    //2. call openDatabase method to create table
    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE finance(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        isIncome INTEGER NOT NULL,
        category TEXT);
        ''';
        await db.execute(sql);
      },
    );
    return _db;
  }

  Future<void> insertData(double amount, int isIncome, String category) async {
    Database? db = await database;
    String sql = '''
      INSERT INTO finance (amount, isIncome, category)
      VALUES (?, ?, ?);
    ''';
    await db!.rawInsert(sql, [amount, isIncome, category]);
  }

}

// 1. insert data __>