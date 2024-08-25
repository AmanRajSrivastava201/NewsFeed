import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_feed/util/shared_pref_util.dart';
import 'package:news_feed/util/theme/theme_details.dart';

import '../../common/app_color_constant.dart';
import '../../common/dimens.dart';

/// This is utils class for dynamic theme that contains all common functions
class ThemeUtil {
  /// This function returns the current theme data of application from shared preference
  static Future<ThemeDetails> getThemeDataFromPref() async {
    String? jsonThemeData = await SharedPrefUtil.getThemeData();
    bool? isDarkMode = await SharedPrefUtil.isDarkModeTheme();
    ThemeDetails customThemeData;

    /// If theme data found in preference then return themeData using preference theme data json
    if (jsonThemeData != null && jsonThemeData.trim().length > 3) {
      try {
        customThemeData = ThemeDetails().customThemeDataFromJson(jsonThemeData);
      } catch (e) {
        if (kDebugMode) {
          print("Exception on parsing themeData, return default themeData ");
        }
        customThemeData = ThemeDetails();
        SharedPrefUtil.setDarkModeTheme(false);
      }
    } else {
      /// Initialise custom theme data with default value if no data found in preference
      if (kDebugMode) {
        print("No themeData in preference, return default themeData");
      }
      customThemeData = ThemeDetails();
      SharedPrefUtil.setDarkModeTheme(false);
    }
    Brightness brightness = Brightness.light;
    if (isDarkMode) {
      if (kDebugMode) {
        print("Dark mode theme is active, so setting brightness dark ");
      }
      brightness = Brightness.dark;
    }
    customThemeData.brightness = brightness;
    return customThemeData;
  }

  /// This function update the current theme data of application in shared preference
  /// It takes [value] as input which is a updated theme data
  static setThemeDataInPref(ThemeDetails value) async {
    String themeData = ThemeDetails().customThemeDataToJson(value);
    SharedPrefUtil.setThemeData(themeData);
  }

  /// This function is used to return color from int
  /// [color] defines integer value of color
  static getColor(int color) {
    return Color(color);
  }

  /// This function is used to return ThemeData from the customThemeData object
  /// It take [customThemeData] as a parameter which provides value to be set in Theme data
  /// [brightness] defines if brightness is light or dark
  static getThemeDataFromCustomThemeData(
      ThemeDetails customThemeData, Brightness brightness) {
    return ThemeData(
      primaryColor: getColor(customThemeData.primaryColor),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: getColor(customThemeData.primaryColor),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: Dimens.dp28,
            fontWeight: Dimens.semiBold,
            color: getColor(customThemeData.primaryColor)),
        titleMedium: TextStyle(
            fontSize: Dimens.dp24,
            fontWeight: Dimens.semiBold,
            color: getColor(customThemeData.primaryColor)),
        titleSmall: TextStyle(
            fontSize: Dimens.dp20,
            fontWeight: Dimens.semiBold,
            color: getColor(customThemeData.primaryColor)),
        bodyLarge: TextStyle(
            fontSize: Dimens.dp16,
            fontWeight: Dimens.regular,
            color: getColor(AppColorConstant.grey)),
        bodyMedium: TextStyle(
            fontSize: Dimens.dp14,
            fontWeight: Dimens.regular,
            color: getColor(AppColorConstant.grey)),
        bodySmall: TextStyle(
            fontSize: Dimens.dp12,
            fontWeight: Dimens.regular,
            color: getColor(AppColorConstant.grey)),
      ),
      appBarTheme: AppBarTheme(
        toolbarHeight: Dimens.dp24,
        backgroundColor: getColor(customThemeData.primaryColor),
        foregroundColor: getColor(AppColorConstant.white),
      ),
      iconTheme: IconThemeData(color: getColor(customThemeData.tertiaryColor)),
      buttonTheme: ButtonThemeData(
        buttonColor: getColor(customThemeData.primaryColor),
        disabledColor: getColor(AppColorConstant.grey),
        textTheme: ButtonTextTheme.normal,
      ),
      brightness: brightness,
    );
  }

  /// This function is used to set theme dark mode in preference
  /// [value] defines value of isDarkMode
  static setThemeModeDark(bool value) async {
    SharedPrefUtil.setDarkModeTheme(value);
    if (kDebugMode) {
      print("Shared preference updated for Dark mode = $value");
    }
  }
}
