import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:lamov_flutter_app/core/data/data.dart';
import 'package:lamov_flutter_app/core/domain/common/common.dart';
import 'package:lamov_flutter_app/feature/home/data/datasource/datasource.dart';
import 'package:lamov_flutter_app/feature/home/domain/param/param.dart';

import '../../../../helper/json_reader.dart';
import '../../../../resource/resource.dart';

void main() {
  late Dio mockDio;
  late DioAdapter dioAdapter;
  late ApiClient apiClient;
  late HomeRemoteDataSourceImpl homeRemoteDataSourceImpl;

  setUp(() {
    mockDio = Dio();
    dioAdapter = DioAdapter(dio: mockDio);
    mockDio.httpClientAdapter = dioAdapter;
    apiClient = ApiClient(dio: mockDio);
    homeRemoteDataSourceImpl = HomeRemoteDataSourceImpl(client: apiClient);
  });

  final BaseModel<MovieModel> movieModel = tMoviesData;
  final List<GenreModel> genreModel = tGenresData;

  group('get genres of movie', () {
    test('should return list of genre model when the response code is 200',
        () async {
      dioAdapter.onGet(
        ApiConstant.genreMovieList,
        (request) => request.reply(
          200,
          json.decode(readJson(genresSuccessPath)),
        ),
      );

      final result = await homeRemoteDataSourceImpl.getMovieGenres();

      expect(result, genreModel);
    });

    test('should throw exception when the response code is not 200', () async {
      dioAdapter.onGet(
        ApiConstant.genreMovieList,
        (request) => request.reply(
          400,
          json.decode(readJson(genresErrorPath)),
        ),
      );

      expect(
        () async => await homeRemoteDataSourceImpl.getMovieGenres(),
        throwsException,
      );
    });
  });

  group('get now playing movies', () {
    const param = GetMoviesPaginationParam();

    test('should return list of movie model when the response code is 200',
        () async {
      dioAdapter.onGet(
        ApiConstant.movieNowPlaying,
        (request) => request.reply(
          200,
          json.decode(readJson(moviesSuccessPath)),
        ),
        queryParameters: param.toJson(),
      );

      final result = await homeRemoteDataSourceImpl.getNowPlaying(param);

      expect(result, movieModel);
    });

    test('should throw exception when the response code is not 200', () async {
      dioAdapter.onGet(
        ApiConstant.movieNowPlaying,
        (request) => request.reply(
          400,
          json.decode(readJson(moviesErrorPath)),
        ),
      );

      expect(
        () async => await homeRemoteDataSourceImpl.getNowPlaying(param),
        throwsException,
      );
    });
  });

  group('get discover movies', () {
    const param = GetMoviesPaginationParam(categoryId: 28);

    test('should return list of movie model when the response code is 200',
        () async {
      dioAdapter.onGet(
        ApiConstant.discoverMovie,
        (request) => request.reply(
          200,
          json.decode(readJson(moviesSuccessPath)),
        ),
        queryParameters: param.toJson(),
      );

      final result = await homeRemoteDataSourceImpl.getDiscover(param);

      expect(result, movieModel);
    });

    test('should throw exception when the response code is not 200', () async {
      dioAdapter.onGet(
        ApiConstant.discoverMovie,
        (request) => request.reply(
          400,
          json.decode(readJson(moviesErrorPath)),
        ),
      );

      expect(
        () async => await homeRemoteDataSourceImpl.getDiscover(param),
        throwsException,
      );
    });
  });

  group('get popular movies', () {
    const param = GetMoviesPaginationParam();

    test('should return list of movie model when the response code is 200',
        () async {
      dioAdapter.onGet(
        ApiConstant.moviePopular,
        (request) => request.reply(
          200,
          json.decode(readJson(moviesSuccessPath)),
        ),
        queryParameters: param.toJson(),
      );

      final result = await homeRemoteDataSourceImpl.getPopular(param);

      expect(result, movieModel);
    });

    test('should throw exception when the response code is not 200', () async {
      dioAdapter.onGet(
        ApiConstant.moviePopular,
        (request) => request.reply(
          400,
          json.decode(readJson(moviesErrorPath)),
        ),
      );

      expect(
        () async => await homeRemoteDataSourceImpl.getPopular(param),
        throwsException,
      );
    });
  });

  group('get top rated movies', () {
    const param = GetMoviesPaginationParam();

    test('should return list of movie model when the response code is 200',
        () async {
      dioAdapter.onGet(
        ApiConstant.movieTopRated,
        (request) => request.reply(
          200,
          json.decode(readJson(moviesSuccessPath)),
        ),
        queryParameters: param.toJson(),
      );

      final result = await homeRemoteDataSourceImpl.getTopRated(param);

      expect(result, movieModel);
    });

    test('should throw exception when the response code is not 200', () async {
      dioAdapter.onGet(
        ApiConstant.movieTopRated,
        (request) => request.reply(
          400,
          json.decode(readJson(moviesErrorPath)),
        ),
      );

      expect(
        () async => await homeRemoteDataSourceImpl.getTopRated(param),
        throwsException,
      );
    });
  });
}
