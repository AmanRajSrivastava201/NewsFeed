import 'package:shared_preferences/shared_preferences.dart';

/// This is utils class for shared preferences
class SharedPrefUtil {
  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  /// It will fetch theme data from local storage.
  static Future<String?> getThemeData() async {
    final prefs = await _getPrefs();
    return prefs.getString("theme_data");
  }

  /// It save theme data in local storage.
  /// [value] theme data
  static Future<bool?> setThemeData(String value) async {
    final prefs = await _getPrefs();
    return prefs.setString("theme_data", value);
  }

  /// It will fetch dark mode theme status from local storage.
  static Future<bool> isDarkModeTheme() async {
    final prefs = await _getPrefs();
    return prefs.getBool("dark_mode_theme") ?? false;
  }

  /// It save dark mode theme status in local storage.
  /// [status] dark mode theme status
  static Future<bool?> setDarkModeTheme(bool status) async {
    final prefs = await _getPrefs();
    return prefs.setBool("dark_mode_theme", status);
  }
}
