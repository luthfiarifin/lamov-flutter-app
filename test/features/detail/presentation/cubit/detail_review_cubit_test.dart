import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lamov_flutter_app/core/data/error/error.dart';
import 'package:lamov_flutter_app/core/domain/common/model/model.dart';
import 'package:lamov_flutter_app/feature/detail/detail.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../resource/resource.dart';
import 'detail_review_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieReviewUseCase,
])
void main() {
  late MockGetMovieReviewUseCase mockGetMovieReviewUseCase;

  late DetailReviewCubit detailReviewCubit;

  setUp(() {
    mockGetMovieReviewUseCase = MockGetMovieReviewUseCase();

    detailReviewCubit = DetailReviewCubit(
      mockGetMovieReviewUseCase,
    );
  });

  tearDown(() {
    detailReviewCubit.close();
  });

  const param = GetReviewParam(id: 550);

  final BaseModel<ReviewModel> reviewModel = tReviewData;
  const errorMessage = 'error message';

  blocTest<DetailReviewCubit, DetailReviewState>(
    'emits [GetReviewLoading, GetReviewLoaded] when getReviews().',
    setUp: () {
      when(mockGetMovieReviewUseCase.call(param)).thenAnswer(
        (value) async => Right(reviewModel),
      );
    },
    build: () => detailReviewCubit,
    act: (bloc) => bloc.getReviews(param),
    wait: const Duration(milliseconds: 100),
    expect: () => <DetailReviewState>[
      GetReviewLoading(),
      GetReviewLoaded(data: reviewModel),
    ],
  );

  blocTest<DetailReviewCubit, DetailReviewState>(
    'emits [GetReviewLoading, GetReviewError] when getReviews().',
    setUp: () {
      when(mockGetMovieReviewUseCase.call(param)).thenAnswer(
        (value) async => const Left(Failure(message: errorMessage)),
      );
    },
    build: () => detailReviewCubit,
    act: (bloc) => bloc.getReviews(param),
    wait: const Duration(milliseconds: 100),
    expect: () => <DetailReviewState>[
      GetReviewLoading(),
      const GetReviewError(message: errorMessage),
    ],
  );
}
