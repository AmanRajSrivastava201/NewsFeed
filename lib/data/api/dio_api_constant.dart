/// This class contains the DIO Api constant
mixin DioApiConstant {
  static const String baseUrl = "https://newsapi.org/";
  static const String getArticleList = "v2/top-headlines";
  static const int networkTimeout = 15;
  static const String queryParamCountry = "country";
  static const String queryParamApiKey = "apiKey";
}
