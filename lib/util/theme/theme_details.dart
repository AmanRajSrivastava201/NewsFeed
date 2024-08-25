import 'dart:convert';
import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

/// This is model class for custom theme data
@JsonSerializable()
class ThemeDetails {
  int primaryColor;
  int secColor;
  int tertiaryColor;
  Brightness brightness = Brightness.light;

  ///Constructor
  ThemeDetails({
    this.primaryColor = 0xFF67B85E,
    this.secColor = 0XFF50d387,
    this.tertiaryColor = 0X836cf4,
  });

  /// This function returns CustomThemeData object from data string
  ThemeDetails customThemeDataFromJson(String str) =>
      ThemeDetails.fromJson(json.decode(str));

  /// This function returns data String from CustomThemeData object
  String customThemeDataToJson(ThemeDetails data) => json.encode(data.toJson());

  factory ThemeDetails.fromJson(Map<String, dynamic> json) => ThemeDetails(
        primaryColor: json["primaryColor"],
        secColor: json["secColor"],
        tertiaryColor: json["tertiaryColor"],
      );

  Map<String, dynamic> toJson() => {
        "primaryColor": primaryColor,
        "secColor": secColor,
        "tertiaryColor": tertiaryColor,
      };
}
