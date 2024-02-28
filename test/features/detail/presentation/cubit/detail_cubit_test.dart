import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lamov_flutter_app/core/data/error/error.dart';
import 'package:lamov_flutter_app/core/domain/common/model/model.dart';
import 'package:lamov_flutter_app/feature/detail/detail.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../resource/resource.dart';
import 'detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetailUseCase,
])
void main() {
  late MockGetMovieDetailUseCase mockGetMovieDetailUseCase;

  late DetailCubit detailCubit;

  setUp(() {
    mockGetMovieDetailUseCase = MockGetMovieDetailUseCase();

    detailCubit = DetailCubit(
      mockGetMovieDetailUseCase,
    );
  });

  tearDown(() {
    detailCubit.close();
  });

  const param = 550;

  final MovieModel movieModel = tMovieData;
  const errorMessage = 'error message';

  blocTest<DetailCubit, DetailState>(
    'emits [GetDetailLoading, GetDetailLoaded] when getDetail().',
    setUp: () {
      when(mockGetMovieDetailUseCase.call(param)).thenAnswer(
        (value) async => Right(movieModel),
      );
    },
    build: () => detailCubit,
    act: (bloc) => bloc.getDetail(param),
    wait: const Duration(milliseconds: 100),
    expect: () => <DetailState>[
      GetDetailLoading(),
      GetDetailLoaded(movie: movieModel),
    ],
  );

  blocTest<DetailCubit, DetailState>(
    'emits [GetDetailLoading, GetDetailError] when getDetail().',
    setUp: () {
      when(mockGetMovieDetailUseCase.call(param)).thenAnswer(
        (value) async => const Left(Failure(message: errorMessage)),
      );
    },
    build: () => detailCubit,
    act: (bloc) => bloc.getDetail(param),
    wait: const Duration(milliseconds: 100),
    expect: () => <DetailState>[
      GetDetailLoading(),
      const GetDetailError(message: errorMessage),
    ],
  );
}
