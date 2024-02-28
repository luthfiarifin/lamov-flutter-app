import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:lamov_flutter_app/core/data/data.dart';
import 'package:lamov_flutter_app/feature/feature.dart';

import '../../../../helper/json_reader.dart';
import '../../../../resource/resource.dart';

void main() {
  late Dio mockDio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  late DetailRemoteDataSourceImpl detailRemoteDataSourceImpl;

  setUp(() {
    mockDio = Dio();
    dioAdapter = DioAdapter(dio: mockDio);
    mockDio.httpClientAdapter = dioAdapter;
    apiClient = ApiClient(dio: mockDio);
    detailRemoteDataSourceImpl = DetailRemoteDataSourceImpl(client: apiClient);
  });

  final movieModel = tMovieData;

  group('get detail movie', () {
    test('should return movie model when the response code is 200', () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(movieSuccessPath),
      );

      dioAdapter.onGet(
        '${ApiConstant.movie}/550',
        (request) => request.reply(200, jsonMap),
      );

      final result = await detailRemoteDataSourceImpl.getDetail(550);

      expect(result, equals(movieModel));
    });

    test('should return failure when the response code is not 200', () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(movieErrorPath),
      );

      dioAdapter.onGet(
        '${ApiConstant.movie}/550',
        (request) => request.reply(404, jsonMap),
      );

      expect(
        () async => await detailRemoteDataSourceImpl.getDetail(550),
        throwsException,
      );
    });
  });

  group('get movie reviews', () {
    const param = GetReviewParam(id: 550);

    test('should return list of review model when the response code is 200',
        () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(reviewSuccessPath),
      );

      dioAdapter.onGet(
        '${ApiConstant.movie}/${param.id}/${ApiConstant.reviews}',
        (request) => request.reply(200, jsonMap),
      );

      final result = await detailRemoteDataSourceImpl.getReviews(param);

      expect(result, equals(tReviewData));
    });

    test('should return failure when the response code is not 200', () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(reviewErrorPath),
      );

      dioAdapter.onGet(
        '${ApiConstant.movie}/${param.id}/${ApiConstant.reviews}',
        (request) => request.reply(404, jsonMap),
      );

      expect(
        () async => await detailRemoteDataSourceImpl.getReviews(param),
        throwsException,
      );
    });
  });
}
