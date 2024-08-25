import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// This is a interceptor class to manipulate api request response
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Log request details
    if (kDebugMode) {
      print('Request: ${options.method} ${options.uri}');
      print('Request headers: ${options.headers}');
      print('Request data: ${options.data}');
    }
    // Continue with the request
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log error details
    if (kDebugMode) {
      print('Error: ${err.response?.statusCode}');
      print('Error message: ${err.message}');
    }
    // Continue with the error
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log response details
    if (kDebugMode) {
      print('Response: ${response.statusCode}');
      print('Response data: ${response.data}');
    }
    // Continue with the response
    handler.next(response);
  }
}
