import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/expense.dart';

class ExpensesDb {
  ExpensesDb._privateConstructor();

  static final ExpensesDb instance = ExpensesDb._privateConstructor();

  Database? _database;
}
