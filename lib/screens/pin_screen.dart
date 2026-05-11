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

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _hasPin ? 'Enter PIN' : 'Setup PIN',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
              decoration: InputDecoration(
                labelText: '4-digit PIN',
                errorText: _error,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _hasPin ? 'Unlock' : 'Save PIN',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}





