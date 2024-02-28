import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lamov_flutter_app/core/data/error/error.dart';
import 'package:lamov_flutter_app/core/domain/domain.dart';
import 'package:lamov_flutter_app/feature/detail/detail.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock/test_mock.mocks.dart';
import '../../../../resource/resource_data.dart';

void main() {
  late MockDetailRepository mockDetailRepository;
  late GetMovieReviewUseCase getMovieReviewUseCase;

  setUp(() {
    mockDetailRepository = MockDetailRepository();
    getMovieReviewUseCase = GetMovieReviewUseCase(mockDetailRepository);
  });

  final BaseModel<ReviewModel> reviewModel = tReviewData;

  group('get movie reviews', () {
    const param = GetReviewParam(id: 550);

    test('should return list of movies model when the response code is 200',
        () async {
      when(mockDetailRepository.getReviews(param)).thenAnswer(
        (_) async => Right(reviewModel),
      );

      final result = await getMovieReviewUseCase(param);

      expect(result, equals(Right(reviewModel)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockDetailRepository.getReviews(param)).thenAnswer(
        (_) async => const Left(Failure(message: errorMessage)),
      );

      final result = await getMovieReviewUseCase(param);

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });
}
