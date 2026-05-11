import 'package:flutter/material.dart';

import '../services/prefs_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _currency = 'ETB';

  bool _darkMode = false;

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final currency = await PrefsService.getCurrency();

    final darkMode = await PrefsService.isDarkMode();

    setState(() {
      _currency = currency;
      _darkMode = darkMode;
      _loading = false;
    });
  }

  Future<void> _changeCurrency(
    String? value,
  ) async {
    if (value == null) return;

    await PrefsService.setCurrency(value);

    setState(() {
      _currency = value;
    });
  }

  Future<void> _toggleTheme(
    bool value,
  ) async {
    await PrefsService.setDarkMode(value);

    setState(() {
      _darkMode = value;
    });
  }
}
