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
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _currency,
              decoration: const InputDecoration(
                labelText: 'Currency',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'ETB',
                  child: Text('ETB'),
                ),
                DropdownMenuItem(
                  value: 'USD',
                  child: Text('USD'),
                ),
                DropdownMenuItem(
                  value: 'EUR',
                  child: Text('EUR'),
                ),
              ],
              onChanged: _changeCurrency,
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: _darkMode,
              onChanged: _toggleTheme,
            ),
          ],
        ),
      ),
    );
  }
}
