import 'package:flutter/material.dart';

import 'screens/pin_screen.dart';
import 'services/prefs_service.dart';
import 'services/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final darkMode = await PrefsService.isDarkMode();

  ThemeController.isDarkMode.value = darkMode;

  runApp(const MyMoneyApp());
}

class MyMoneyApp extends StatelessWidget {
  const MyMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.isDarkMode,
      builder: (
        context,
        darkMode,
        _,
      ) {
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
