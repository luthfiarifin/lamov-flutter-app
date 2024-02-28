
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lamov_flutter_app/core/data/error/error.dart';
import 'package:lamov_flutter_app/core/domain/domain.dart';
import 'package:lamov_flutter_app/feature/home/domain/usecase/get_movie_genres_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock/test_mock.mocks.dart';
import '../../../../resource/resource_data.dart';

void main() {
  late MockHomeRepository mockHomeRepository;
  late GetMovieGenresUseCase getMovieGenresUseCase;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getMovieGenresUseCase = GetMovieGenresUseCase(mockHomeRepository);
  });

  final List<GenreModel> genreModel = tGenresData;

  group('get genres movie', () {
    test('should return list of genres model when the response code is 200',
        () async {
      when(mockHomeRepository.getMovieGenres()).thenAnswer(
        (_) async => Right(genreModel),
      );

      final result = await getMovieGenresUseCase(NoParams());

      expect(result, equals(Right(genreModel)));
    });

    test('should return failure when the response code is not 200', () async {
      const errorMessage = 'error message';

      when(mockHomeRepository.getMovieGenres()).thenAnswer(
        (_) async => const Left(Failure(message: errorMessage)),
      );

      final result = await getMovieGenresUseCase(NoParams());

      expect(result, equals(const Left(Failure(message: errorMessage))));
    });
  });
}
