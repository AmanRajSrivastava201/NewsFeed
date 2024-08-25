import 'package:dio/dio.dart';
import 'package:news_feed/data/db/helper/db_helper.dart';
import 'package:news_feed/model/article.dart';

import 'helper/api_result.dart';
import 'helper/network_constant.dart';
import 'dio_api_handler.dart';
import 'model/article_list_api_response.dart';

/// This class work as the api client for the dio , where all the functions are defined to call apis
class DioApiClient {
  static final DioApiClient _instance = DioApiClient._internal();

  factory DioApiClient() {
    return _instance;
  }

  DioApiClient._internal();

  /// This function is used to get the article list
  /// [path] api url
  /// [queryParameters] defines queryParameters for article list api
  Future<ApiResult<ArticleListApiResponse>> getArticleList(
      Map<String, dynamic>? queryParameters, String path) async {
    try {
      final Response response = await DioApiHandler()
          .getDio()
          .get(path, queryParameters: queryParameters);
      ArticleListApiResponse apiResponse =
          ArticleListApiResponse.fromJson(response.data);
      // cache data in db
      _cacheData(apiResponse);
      return ApiResult(success: apiResponse);
    } catch (e) {
      // if got error from api, check for cache data
      final dataFromCache = await _getCacheData();
      if (dataFromCache != null && dataFromCache.isNotEmpty) {
        ArticleListApiResponse apiResponse = ArticleListApiResponse(
            articles: dataFromCache, totalResults: dataFromCache.length);
        return ApiResult(success: apiResponse);
      }
      // return error if cache not available
      return ApiResult(
          errorCode: NetworkConstant.unexpectedError,
          errorMessage: NetworkConstant.unexpectedErrorOccurred);
    }
  }

  /// This function is used to cache data from api response into db
  /// [response] defines api response
  _cacheData(ArticleListApiResponse response) async {
    if (response.articles != null && response.articles!.isNotEmpty) {
      final db = await DbHelper.getInstance();
      // clear old data before saving new data
      await db?.clearAllArticle();
      await db?.insertArticlesInDb(response.articles!);
    }
  }

  /// This function is used to fetch cache data from db
  Future<List<Article>?> _getCacheData() async {
    final db = await DbHelper.getInstance();
    List<Article>? articles = await db?.getAllArticlesFromDb();
    return articles;
  }
}
