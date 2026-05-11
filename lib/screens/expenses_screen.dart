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

  
}
