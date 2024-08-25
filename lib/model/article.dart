import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news_feed/util/utils.dart';

import '../common/app_constant.dart';
import '../data/api/helper/json_converter.dart';
import 'article_source.dart';

@JsonSerializable()
@Entity(tableName: 'article')
class Article extends JsonConverters {
  @PrimaryKey(autoGenerate: true)
  int? id;
  ArticleSource? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Article.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? ArticleSource.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    if (source != null) {
      data['source'] = source?.toJson();
    }
    return data;
  }

  /// This function is used to get the article published date time
  String getArticleDateTimeInFormat() {
    String? dateTime;
    if (publishedAt != null) {
      try {
        dateTime = Utils.formatDate(AppConstant.apiDateTimeFormat,
            AppConstant.appDateTimeFormat, publishedAt!);
      } catch (e) {
        if (kDebugMode) {
          print("Exception in article date format $e");
        }
      }
      dateTime ??= publishedAt;
    }
    return dateTime ?? AppConstant.emptyValue;
  }
}
