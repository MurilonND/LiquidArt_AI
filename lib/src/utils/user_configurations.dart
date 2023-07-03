import 'package:shared_preferences/shared_preferences.dart';

class UserConfigurations {
  static SharedPreferences? _preferences;

  static const _keyDallE = '';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setDallEKey(String dallEKey) async => await _preferences?.setString(_keyDallE, dallEKey);
  static String? getDallEKey() => _preferences?.getString(_keyDallE);
}