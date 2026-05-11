import 'package:flutter/material.dart';

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
          child: Text('Setup Complete'),
        ),
      ),
    );
  }
}
