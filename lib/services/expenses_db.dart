import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/expense.dart';

class ExpensesDb {
  ExpensesDb._privateConstructor();

  static final ExpensesDb instance = ExpensesDb._privateConstructor();

  Database? _database;

  //database getter
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  //initialize databse
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  //create table
  Future<void> _createDb(
  Database db,
  int version,
) async {
  await db.execute('''
    CREATE TABLE expenses(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL NOT NULL,
      category TEXT NOT NULL,
      note TEXT NOT NULL,
      date TEXT NOT NULL
    )
  ''');
}
}
