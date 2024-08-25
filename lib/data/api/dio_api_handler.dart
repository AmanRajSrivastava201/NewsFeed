import 'package:dio/dio.dart';
import 'package:news_feed/data/api/helper/api_interceptor.dart';
import 'package:news_feed/data/api/dio_api_constant.dart';

/// This handler class is used as a base class for [Dio] Api handler and has method to give [Dio] instance.
class DioApiHandler {
  static Dio? _instanceDio;

  /// Request base url
  String getBaseUrl() {
    return DioApiConstant.baseUrl;
  }

  /// Timeout for receiving data.
  int getReceiveTimeout() {
    return DioApiConstant.networkTimeout;
  }

  /// Timeout for opening url.
  int getConnectTimeout() {
    return DioApiConstant.networkTimeout;
  }

  /// Timeout for sending data.
  int getSendTimeout() {
    return DioApiConstant.networkTimeout;
  }

  /// It indicates the type of data that the server will respond with
  ResponseType getResponseType() {
    return ResponseType.json;
  }

  /// Interceptors list for the api
  Iterable<Interceptor> getInterceptors() {
    return [ApiInterceptor()];
  }

  /// This method will provide the instance of [Dio] with common [BaseOptions].
  Dio _getDioInstance() {
    var dio = Dio(
      BaseOptions(
        baseUrl: getBaseUrl(),
        receiveTimeout: Duration(seconds: getReceiveTimeout()),
        connectTimeout: Duration(seconds: getConnectTimeout()),
        sendTimeout: Duration(seconds: getSendTimeout()),
        responseType: getResponseType(),
      ),
    );

    final logInterceptor = LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true);

    dio.interceptors.addAll(getInterceptors());
    dio.interceptors.add(logInterceptor);
    return dio;
  }

  /// This method will provide the instance of [Dio] with common [BaseOptions].
  Dio getDio() {
    _instanceDio ??= _getDioInstance();
    return _instanceDio!;
  }
}
