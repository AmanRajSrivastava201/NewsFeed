import 'package:flutter/foundation.dart';
import 'package:news_feed/common/app_constant.dart';
import 'package:news_feed/data/api/model/article_list_api_response.dart';
import 'package:news_feed/model/article.dart';

import '../../data/api/helper/api_result.dart';
import 'article_list_repository.dart';

/// This is a viewModel class for article list screen
class ArticleListViewModel extends ChangeNotifier {
  final ArticleListRepository repository;

  ArticleListViewModel(this.repository);

  List<Article> _articleList = [];

  bool _isArticleListLoading = false;

  List<Article> get articleList => _articleList;

  bool get isArticleListLoading => _isArticleListLoading;

  /// This function is used to set article list
  /// [articleList] defines list of article
  set articleList(List<Article> articleList) {
    if (_articleList != articleList) {
      _articleList = articleList;
      notifyListeners();
    }
  }

  /// This function is used to set if article list is loading
  /// [isLoading] defines if loading list
  set isArticleListLoading(bool isLoading) {
    if (_isArticleListLoading != isLoading) {
      _isArticleListLoading = isLoading;
      notifyListeners();
    }
  }

  /// This function is use to get article list
  Future<void> getArticleList() async {
    isArticleListLoading = true;
    _getArticleList().then((value) {
      isArticleListLoading = false;
      if (value.success != null && value.success?.articles != null) {
        articleList = value.success!.articles!;
      } else {
        if (kDebugMode) {
          print("article list not found");
        }
      }
    });
  }

  /// This function is use to get article list
  Future<ApiResult<ArticleListApiResponse>> _getArticleList() async {
    return await repository.getArticleList(AppConstant.articleCountry);
  }
}
