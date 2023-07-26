import 'package:shared_preferences/shared_preferences.dart';

class LocalDbService {
  LocalDbService(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  String? getString(String key) => sharedPreferences.getString(key);

  bool? getBoolean(String key) => sharedPreferences.getBool(key);

  int? getInt(String key) => sharedPreferences.getInt(key);

  double? getDouble(String key) => sharedPreferences.getDouble(key);

  Future<bool> setString(String key, String value) async =>
      sharedPreferences.setString(key, value);

  Future<bool> setDouble(String key, double value) async =>
      sharedPreferences.setDouble(key, value);

  Future<bool> setInt(String key, int value) async =>
      sharedPreferences.setInt(key, value);

  Future<bool> setBoolean(String key, bool value) async =>
      sharedPreferences.setBool(key, value);

  Future<bool> removeKey(String key) async => sharedPreferences.remove(key);
}
