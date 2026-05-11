import 'package:flutter/material.dart';

import '../services/pin_vault.dart';
import 'expenses_screen.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final _controller = TextEditingController();

  bool _hasPin = false;

  bool _loading = true;

  String? _error;

  @override
  void initState() {
    super.initState();

    _loadPinState();
  }

  Future<void> _loadPinState() async {
    final hasPin = await PinVault.hasPin();

    setState(() {
      _hasPin = hasPin;
      _loading = false;
    });
  }

  Future<void> _submit() async {
    final pin = _controller.text.trim();

    if (pin.length != 4) {
      setState(() {
        _error = 'PIN must be 4 digits';
      });

      return;
    }

    if (!_hasPin) {
      await PinVault.savePin(pin);

      _openExpenses();
    } else {
      final correct = await PinVault.verifyPin(pin);

      if (correct) {
        _openExpenses();
      } else {
        setState(() {
          _error = 'Incorrect PIN';
        });
      }
    }
  }

  void _openExpenses() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ExpensesScreen(),
      ),
    );
  }


}





