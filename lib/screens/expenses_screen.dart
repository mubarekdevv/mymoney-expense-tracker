import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../services/expenses_db.dart';
import '../widgets/expense_tile.dart';
import '../widgets/monthly_total_card.dart';
import 'expense_editor.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Expense> _expenses = [];

  double _monthlyTotal = 0;

  bool _loading = true;

  @override
void initState() {
  super.initState();

  _loadData();
}

Future<void> _loadData() async {
  final expenses =
      await ExpensesDb.instance.getAllExpenses();

  final now = DateTime.now();

  final total =
      await ExpensesDb.instance.getTotalByMonth(
    now.year,
    now.month,
  );

  setState(() {
    _expenses = expenses;
    _monthlyTotal = total;
    _loading = false;
  });
}

Future<void> _deleteExpense(int id) async {
    await ExpensesDb.instance.deleteExpense(id);

    _loadData();
  }
}
