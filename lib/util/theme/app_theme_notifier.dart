import 'package:flutter/material.dart';
import 'package:news_feed/util/theme/theme_details.dart';
import 'package:news_feed/util/theme/theme_util.dart';

/// This is notifier class to notify changes in theme data to the application
class AppThemeNotifier with ChangeNotifier {
  ThemeData? _themeData;
  ThemeDetails _themeDetailsPl;

  /// constructor
  AppThemeNotifier(this._themeDetailsPl);

  /// This function returns the current theme data of application
  getTheme() => _themeData ??= ThemeUtil.getThemeDataFromCustomThemeData(
      _themeDetailsPl, _themeDetailsPl.brightness);

  /// This function update the current theme data of application
  /// It takes [customThemeData] as input which is a updated theme data
  /// It takes [brightness] as an optional parameter, mainly required for darkMode case
  setTheme(ThemeDetails customThemeData,
      {Brightness brightness = Brightness.light}) async {
    _themeData =
        ThemeUtil.getThemeDataFromCustomThemeData(customThemeData, brightness);
    await ThemeUtil.setThemeDataInPref(customThemeData);
    if (brightness == Brightness.light) {
      ThemeUtil.setThemeModeDark(false);
    } else {
      ThemeUtil.setThemeModeDark(true);
    }
    notifyListeners();
  }
}
