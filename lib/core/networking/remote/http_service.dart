import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/constants/api_endpoint.dart';
import 'package:liquor_ordering_system/core/shared_prefs/user_shared_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dio_error_interceptor.dart';

final httpServiceProvider = Provider<Dio>(
  (ref) => HttpService(Dio(), ref).dio,
);

class HttpService {
  final Dio _dio;
  final ProviderRef _ref;

  Dio get dio => _dio;

  HttpService(this._dio, this._ref) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final tokenResult =
              await _ref.read(userSharedPrefsProvider).getUserToken();
          tokenResult.fold(
            (failure) => handler.reject(DioException(
              requestOptions: options,
              error: 'Failed to get token',
            )),
            (token) {
              if (token != null) {
                options.headers["Authorization"] = "Bearer $token";
              }
              handler.next(options);
            },
          );
        },
      ))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }
}
