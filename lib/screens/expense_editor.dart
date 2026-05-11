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

  Future<void> _saveExpense() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final expense = Expense(
      id: widget.expense?.id,
      amount: double.parse(
        _amountController.text.trim(),
      ),
      category: _categoryController.text.trim(),
      note: _noteController.text.trim(),
      date: widget.expense?.date ?? DateTime.now(),
    );

    if (widget.expense == null) {
      await ExpensesDb.instance.insertExpense(
        expense,
      );
    } else {
      await ExpensesDb.instance.updateExpense(
        expense,
      );
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    _noteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.expense != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Expense' : 'Add Expense',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter amount';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter category';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveExpense,
                  child: Text(
                    isEditing ? 'Update Expense' : 'Save Expense',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
