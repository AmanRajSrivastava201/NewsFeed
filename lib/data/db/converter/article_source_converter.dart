import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:news_feed/model/article_source.dart';

import '../../../common/app_constant.dart';

/// This class is used to convert Article source into json string and vice-versa.
class ArticleSourceConverter extends TypeConverter<ArticleSource?, String?> {
  @override
  ArticleSource? decode(String? databaseValue) {
    if (databaseValue != null) {
      return ArticleSource.fromJson(jsonDecode(databaseValue));
    } else {
      return null;
    }
  }

  @override
  String encode(ArticleSource? value) {
    String data = value != null ? jsonEncode(value) : AppConstant.empty;
    return data;
  }
}
