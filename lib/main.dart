import 'package:flutter/material.dart';
import 'package:mymoney/models/expense.dart';
import 'package:mymoney/services/expenses_db.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final db = ExpensesDb.instance;

  await db.insertExpense(Expense(
    amount: 500, 
    category: 'Food', 
    note: 'Burger', 
    date: DateTime.now(),
    ),
  );

  final expenses = await db.getAllExpenses();
  print(expenses.length);

  runApp(const MyMoneyApp());
}

class MyMoneyApp extends StatelessWidget {
  const MyMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyMoney',
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('MyMoney')),
        ),
        body: const Center(
          child: Text('Expense Model is Ready'),
        ),
      ),
    );
  }
}
