import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManger {
  static final PreferenceManger _instance = PreferenceManger._internal();
  factory PreferenceManger() {
    return _instance;
  }
  PreferenceManger._internal();
  late final SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _sharedPreferences.setInt(key, value);
  }

  double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _sharedPreferences.setDouble(key, value);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  Future<bool> setListOfString(String key, List<String> value) async {
    return await _sharedPreferences.setStringList(key, value);
  }

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}
