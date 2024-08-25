import '../../../model/article.dart';
import '../helper/json_converter.dart';

/// This class is used for api response of Article list
class ArticleListApiResponse extends JsonConverters {
  String? status;
  int? totalResults;
  List<Article>? articles;

  ArticleListApiResponse({this.status, this.totalResults, this.articles});

  ArticleListApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Article>[];
      json['articles'].forEach((v) {
        articles?.add(Article.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (articles != null) {
      data['articles'] = articles?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
