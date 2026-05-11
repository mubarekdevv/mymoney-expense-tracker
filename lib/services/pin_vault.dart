import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinVault {
  PinVault._();

  static const _storage = FlutterSecureStorage();

  static const _pinKey = 'user_pin';

  static Future<void> savePin(String pin) async {
    await _storage.write(
      key: _pinKey,
      value: pin,
    );
  }

  static Future<String?> getPin() async {
    return await _storage.read(key: _pinKey);
  }

  static Future<bool> hasPin() async {
    final pin = await getPin();

    return pin != null;
  }

  static Future<bool> verifyPin(String input) async {
    final savedPin = await getPin();

    return savedPin == input;
  }

  static Future<void> clearPin() async {
    await _storage.delete(key: _pinKey);
  }
}
