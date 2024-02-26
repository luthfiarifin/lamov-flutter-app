import 'package:dio/dio.dart';

import '../constant/api_constant.dart';
import '../util/data_source_util.dart';
import '../util/isolate_parser.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class ApiClient {
  late Dio _dio;

  ApiClient() {
    _dio = _createDefaultDio();
  }

  Dio _createDefaultDio({
    String baseUrl = ApiConstant.baseUrl,
    List<Interceptor> interceptors = const [],
    Map<String, dynamic>? headers = const {},
  }) {
    final dio = Dio()
      ..options = BaseOptions(
        sendTimeout: const Duration(seconds: 3),
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 10),
        baseUrl: baseUrl,
        headers: headers,
      )
      ..interceptors.addAll([
        ...interceptors,
      ]);

    return dio;
  }

  Future<T> get<T>(
    String url, {
    required ResponseConverter<T> converter,
    Map<String, dynamic>? queryParameters,
    bool newIsolate = true,
  }) async {
    return DataSourceUtil.dioCatchOrThrow(() async {
      Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );

      if (!newIsolate) {
        return converter(response.data);
      }

      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      return await isolateParse.parseInBackground();
    });
  }

  Future<T> post<T>(
    String url, {
    required Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
    bool newIsolate = true,
  }) async {
    return DataSourceUtil.dioCatchOrThrow(() async {
      Response response = await _dio.post(
        url,
        data: data,
      );

      if (!newIsolate) {
        return converter(response.data);
      }

      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      return await isolateParse.parseInBackground();
    });
  }
}
