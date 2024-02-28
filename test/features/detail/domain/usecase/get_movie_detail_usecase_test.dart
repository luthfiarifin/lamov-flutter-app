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
  late GetMovieDetailUseCase getMovieDetailUseCase;

  setUp(() {
    mockDetailRepository = MockDetailRepository();
    getMovieDetailUseCase = GetMovieDetailUseCase(mockDetailRepository);
  });

  final MovieModel movieModel = tMovieData;

  group('get movie detail', () {
    const param = 550;

    test('should return list of movies model when the response code is 200',
        () async {
      when(mockDetailRepository.getDetail(param)).thenAnswer(
        (_) async => Right(movieModel),
      );

      final result = await getMovieDetailUseCase(param);

      expect(result, equals(Right(movieModel)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockDetailRepository.getDetail(param)).thenAnswer(
        (_) async => const Left(Failure(message: errorMessage)),
      );

      final result = await getMovieDetailUseCase(param);

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });
}
