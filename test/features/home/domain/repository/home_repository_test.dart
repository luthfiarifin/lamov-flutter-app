import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lamov_flutter_app/core/data/error/error.dart';
import 'package:lamov_flutter_app/core/domain/common/model/model.dart';
import 'package:lamov_flutter_app/feature/home/domain/param/param.dart';
import 'package:lamov_flutter_app/feature/home/domain/repository/home_repository.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/json_reader.dart';
import '../../../../mock/test_mock.mocks.dart';
import '../../../../resource/resource.dart';

void main() {
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;
  late HomeRepositoryImpl homeRepositoryImpl;

  setUp(() {
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    homeRepositoryImpl = HomeRepositoryImpl(
      remoteDataSource: mockHomeRemoteDataSource,
    );
  });

  final BaseModel<MovieModel> movieModel = tMoviesData;
  final List<GenreModel> genreModel = tGenresData;

  group('get genres movie', () {
    test('should return list of genres model when the response code is 200',
        () async {
      when(mockHomeRemoteDataSource.getMovieGenres()).thenAnswer(
        (_) async => genreModel,
      );

      final result = await homeRepositoryImpl.getMovieGenres();

      expect(result, equals(Right(genreModel)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockHomeRemoteDataSource.getMovieGenres()).thenThrow(
        const RemoteException(message: errorMessage),
      );

      final result = await homeRepositoryImpl.getMovieGenres();

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });

  group('get now playing movies', () {
    const param = GetMoviesPaginationParam();

    test('should return list of movie model when the response code is 200',
        () async {
      when(mockHomeRemoteDataSource.getNowPlaying(param)).thenAnswer(
        (_) async => BaseModel<MovieModel>.fromJson(
          json.decode(readJson(moviesSuccessPath)),
          (json) => MovieModel.fromJson(json),
        ),
      );

      final result = await homeRepositoryImpl.getNowPlaying(param);

      expect(result, equals(Right(movieModel)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockHomeRemoteDataSource.getNowPlaying(param)).thenThrow(
        const RemoteException(message: errorMessage),
      );

      final result = await homeRepositoryImpl.getNowPlaying(param);

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });

  group('get discover movies', () {
    const param = GetMoviesPaginationParam(categoryId: 28);

    test('should return list of movie model when the response code is 200',
        () async {
      when(mockHomeRemoteDataSource.getDiscover(param)).thenAnswer(
        (_) async => BaseModel<MovieModel>.fromJson(
          json.decode(readJson(moviesSuccessPath)),
          (json) => MovieModel.fromJson(json),
        ),
      );

      final result = await homeRepositoryImpl.getDiscover(param);

      expect(result, equals(Right(movieModel)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockHomeRemoteDataSource.getDiscover(param)).thenThrow(
        const RemoteException(message: errorMessage),
      );

      final result = await homeRepositoryImpl.getDiscover(param);

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });

  group('get popular movies', () {
    const param = GetMoviesPaginationParam();

    test('should return list of movie model when the response code is 200',
        () async {
      when(mockHomeRemoteDataSource.getPopular(param)).thenAnswer(
        (_) async => BaseModel<MovieModel>.fromJson(
          json.decode(readJson(moviesSuccessPath)),
          (json) => MovieModel.fromJson(json),
        ),
      );

      final result = await homeRepositoryImpl.getPopular(param);

      expect(result, equals(Right(movieModel)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockHomeRemoteDataSource.getPopular(param)).thenThrow(
        const RemoteException(message: errorMessage),
      );

      final result = await homeRepositoryImpl.getPopular(param);

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });

  group('get top rated movies', () {
    const param = GetMoviesPaginationParam();

    test('should return list of movie model when the response code is 200',
        () async {
      when(mockHomeRemoteDataSource.getTopRated(param)).thenAnswer(
        (_) async => BaseModel<MovieModel>.fromJson(
          json.decode(readJson(moviesSuccessPath)),
          (json) => MovieModel.fromJson(json),
        ),
      );

      final result = await homeRepositoryImpl.getTopRated(param);

      expect(result, equals(Right(movieModel)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockHomeRemoteDataSource.getTopRated(param)).thenThrow(
        const RemoteException(message: errorMessage),
      );

      final result = await homeRepositoryImpl.getTopRated(param);

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });
}
