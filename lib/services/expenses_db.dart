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

  //insert expense
  Future<int> insertExpense(Expense expense) async {
    final db = await instance.database;

    return await db.insert(
      'expenses',
      expense.toMap(),
    );
  }

  //fetching all the expenses
  Future<List<Expense>> getAllExpenses() async {
    final db = await instance.database;

    final result = await db.query(
      'expenses',
      orderBy: 'date DESC',
    );

    return result.map((map) => Expense.fromMap(map)).toList();
  }

  //update expense
  Future<int> updateExpense(Expense expense) async {
    final db = await instance.database;

    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  //delete expense
  Future<int> deleteExpense(int id) async {
    final db = await instance.database;

    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //monthly sum queery
  Future<double> getTotalByMonth(
    int year,
    int month,
  ) async {
    final db = await instance.database;

    final start = DateTime(year, month, 1);

    final end =
        month == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);

    final result = await db.rawQuery(
      '''
    SELECT SUM(amount) as total
    FROM expenses
    WHERE date >= ? AND date < ?
    ''',
      [
        start.toIso8601String(),
        end.toIso8601String(),
      ],
    );

    final total = result.first['total'];

    if (total == null) return 0.0;

    return total as double;
  }
}
