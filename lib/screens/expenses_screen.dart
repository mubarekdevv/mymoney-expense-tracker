import 'package:flutter/material.dart';
import 'package:mymoney/screens/settings_screen.dart';

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

  Future<void> _openEditor({
    Expense? expense,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExpenseEditor(
          expense: expense,
        ),
      ),
    );

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyMoney'),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );

              _loadData();

              setState(() {});
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditor(),
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                MonthlyTotalCard(
                  total: _monthlyTotal,
                ),
                Expanded(
                  child: _expenses.isEmpty
                      ? const Center(
                          child: Text(
                            'No expenses yet',
                          ),
                        )
                      : ListView.builder(
                          itemCount: _expenses.length,
                          itemBuilder: (context, index) {
                            final expense = _expenses[index];

                            return Dismissible(
                              key: ValueKey(
                                expense.id,
                              ),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(
                                  right: 20,
                                ),
                                color: Colors.red,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (_) {
                                _deleteExpense(
                                  expense.id!,
                                );
                              },
                              child: ExpenseTile(
                                expense: expense,
                                onTap: () {
                                  _openEditor(
                                    expense: expense,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
