import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  PrefsService._();

  static const _currencyKey = 'currency';

  static const _darkModeKey = 'dark_mode';

  static Future<void> setCurrency(
    String currency,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _currencyKey,
      currency,
    );
  }

  static Future<String> getCurrency() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_currencyKey) ?? 'ETB';
  }

  static Future<void> setDarkMode(
    bool value,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      _darkModeKey,
      value,
    );
  }

  static Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_darkModeKey) ?? false;
  }
}
