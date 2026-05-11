import 'package:flutter/material.dart';

import '../models/expense.dart';
import '../services/expenses_db.dart';

class ExpenseEditor extends StatefulWidget {
  final Expense? expense;

  const ExpenseEditor({
    super.key,
    this.expense,
  });

  @override
  State<ExpenseEditor> createState() => _ExpenseEditorState();
}

class _ExpenseEditorState extends State<ExpenseEditor> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _amountController;

  late final TextEditingController _categoryController;

  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();

    final expense = widget.expense;

    _amountController = TextEditingController(
      text: expense?.amount.toString() ?? '',
    );

    _categoryController = TextEditingController(
      text: expense?.category ?? '',
    );

    _noteController = TextEditingController(
      text: expense?.note ?? '',
    );
  }
}
