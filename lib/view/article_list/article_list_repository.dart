import 'package:news_feed/data/api/model/article_list_api_response.dart';

import '../../common/app_constant.dart';
import '../../data/api/dio_api_client.dart';
import '../../data/api/dio_api_constant.dart';
import '../../data/api/helper/api_result.dart';

/// This is a repository class for Article List
class ArticleListRepository {
  DioApiClient dioApiClient = DioApiClient();

  /// This function is use to get article list from api
  /// [country] defines country for articles
  Future<ApiResult<ArticleListApiResponse>> getArticleList(
      String country) async {
    Map<String, dynamic> requestParam = getArticleListRequestParam(country);
    ApiResult<ArticleListApiResponse>? response = await dioApiClient
        .getArticleList(requestParam, DioApiConstant.getArticleList);
    return response;
  }

  /// This function is use to create the request parameter for article list api
  /// [country] defines country for articles
  Map<String, dynamic> getArticleListRequestParam(String country) {
    Map<String, dynamic> request = {};
    request[DioApiConstant.queryParamCountry] = country;
    request[DioApiConstant.queryParamApiKey] =
        const String.fromEnvironment(AppConstant.apiKey);
    return request;
  }
}
