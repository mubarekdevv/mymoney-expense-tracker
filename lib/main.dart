import 'package:flutter/material.dart';
import 'package:mymoney/models/expense.dart';

void main() {

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
