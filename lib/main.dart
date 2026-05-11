import 'package:flutter/material.dart';
import 'package:mymoney/models/expense.dart';
import 'package:mymoney/screens/pin_screen.dart';

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
      home: const PinScreen(),
    );
  }
}
