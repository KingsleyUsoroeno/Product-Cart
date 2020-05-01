import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static saveString(String key, String value) async {
    print("saving data into sharedPreferences");
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static saveInt(String key, int value) async {
    print("saving data into sharedPreferences");
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static saveBoolean(String key, bool value) async {
    print("saving data into sharedPreferences");
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> getBoolean(String key) async {
    print("reading data from sharedPreferences");
    final prefs = await SharedPreferences.getInstance();
    print("read value from prefs ${prefs.get(key) ?? false}");
    return prefs.getBool(key) ?? false;
  }

  static dynamic getString(String key) async {
    print("reading data from sharedPreferences");
    final prefs = await SharedPreferences.getInstance();
    print("read value from prefs ${prefs.get(key) ?? "null"}");
    return prefs.getString(key) ?? "";
  }
}
