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

}





