import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtils{

  static void saveThemeMode(bool isDark) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isDark', isDark);
  }

  static Future<bool> getThemeMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('isDark') ?? false;
  }

  static void saveUserId(int userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('userId', userId);
  }

  static Future<int> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('userId') ?? 1;
  }
}