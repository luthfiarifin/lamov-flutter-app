import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lamov_flutter_app/core/data/error/error.dart';
import 'package:lamov_flutter_app/core/domain/common/model/model.dart';
import 'package:lamov_flutter_app/feature/detail/detail.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/json_reader.dart';
import '../../../../mock/test_mock.mocks.dart';
import '../../../../resource/resource.dart';

void main() {
  late MockDetailRemoteDataSource mockDetailRemoteDataSource;
  late DetailRepositoryImpl detailRepositoryImpl;

  setUp(() {
    mockDetailRemoteDataSource = MockDetailRemoteDataSource();
    detailRepositoryImpl = DetailRepositoryImpl(
      remoteDataSource: mockDetailRemoteDataSource,
    );
  });

  group('get detail movies', () {
    const param = 550;

    test('should return list of movie model when the response code is 200',
        () async {
      when(mockDetailRemoteDataSource.getDetail(param)).thenAnswer(
        (_) async => MovieModel.fromJson(
          json.decode(readJson(movieSuccessPath)),
        ),
      );

      final result = await detailRepositoryImpl.getDetail(param);

      expect(result, equals(Right(tMovieData)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockDetailRemoteDataSource.getDetail(param)).thenThrow(
        const RemoteException(message: errorMessage),
      );

      final result = await detailRepositoryImpl.getDetail(param);

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });

  group('get review movies', () {
    const param = GetReviewParam(id: 550);

    test('should return list of movie model when the response code is 200',
        () async {
      when(mockDetailRemoteDataSource.getReviews(param)).thenAnswer(
        (_) async => BaseModel.fromJson(
          json.decode(readJson(reviewSuccessPath)),
          (e) => ReviewModel.fromJson(e),
        ),
      );

      final result = await detailRepositoryImpl.getReviews(param);

      expect(result, equals(Right(tReviewData)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockDetailRemoteDataSource.getReviews(param)).thenThrow(
        const RemoteException(message: errorMessage),
      );

      final result = await detailRepositoryImpl.getReviews(param);

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });
}
