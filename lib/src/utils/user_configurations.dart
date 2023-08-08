import 'package:shared_preferences/shared_preferences.dart';

class UserConfigurations {
  static SharedPreferences? _preferences;

  static const _keyDallE = '';
  static const _ipAddressLocalMachine = '';
  static const _portLocalMachine = '';


  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setDallEKey(String dallEKey) async => await _preferences?.setString(_keyDallE, dallEKey);
  static Future setIpAddressLocalMachine(String ipAddressLocalMachine) async => await _preferences?.setString(_ipAddressLocalMachine, ipAddressLocalMachine);
  static Future setPortLocalMachine(String portLocalMachine) async => await _preferences?.setString(_portLocalMachine, portLocalMachine);

  static String? getDallEKey() => _preferences?.getString(_keyDallE);
  static String? getIpAddressLocalMachine() => _preferences?.getString(_ipAddressLocalMachine);
  static String? getPortLocalMachine() => _preferences?.getString(_portLocalMachine);

}