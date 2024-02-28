import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lamov_flutter_app/core/data/error/error.dart';
import 'package:lamov_flutter_app/core/domain/domain.dart';
import 'package:lamov_flutter_app/feature/home/domain/param/param.dart';
import 'package:lamov_flutter_app/feature/home/domain/usecase/usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock/test_mock.mocks.dart';
import '../../../../resource/resource_data.dart';

void main() {
  late MockHomeRepository mockHomeRepository;
  late GetMoviesTopRatedUseCase getMoviesTopRatedUseCase;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getMoviesTopRatedUseCase = GetMoviesTopRatedUseCase(mockHomeRepository);
  });

  final BaseModel<MovieModel> movieModel = tMoviesData;

  group('get movies top rated', () {
    const param = GetMoviesPaginationParam();

    test('should return list of movies model when the response code is 200',
        () async {
      when(mockHomeRepository.getTopRated(param)).thenAnswer(
        (_) async => Right(movieModel),
      );

      final result = await getMoviesTopRatedUseCase(param);

      expect(result, equals(Right(movieModel)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockHomeRepository.getTopRated(param)).thenAnswer(
        (_) async => const Left(Failure(message: errorMessage)),
      );

      final result = await getMoviesTopRatedUseCase(param);

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });
}
