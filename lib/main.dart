import 'package:flutter/material.dart';

import 'screens/pin_screen.dart';
import 'services/prefs_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyMoneyApp());
}

class MyMoneyApp extends StatelessWidget {
  const MyMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: PrefsService.isDarkMode(),
      builder: (context, snapshot) {
        final darkMode = snapshot.data ?? false;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyMoney',
          theme: ThemeData(
            useMaterial3: true,
            brightness: darkMode ? Brightness.dark : Brightness.light,
          ),
          home: const PinScreen(),
        );
      },
    );
  }
}
