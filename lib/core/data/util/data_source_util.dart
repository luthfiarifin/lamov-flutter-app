import 'package:dio/dio.dart';

import '../error/exceptions.dart';

class DataSourceUtil {
  static Future<T> dioCatchOrThrow<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on DioException catch (e) {
      throw RemoteException(
        message: e.response?.statusMessage,
        status: e.response?.statusCode,
      );
    } catch (e) {
      throw const RemoteException(message: 'Something went wrong!');
    }
  }
}
