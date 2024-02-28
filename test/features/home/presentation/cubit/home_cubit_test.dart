
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lamov_flutter_app/core/domain/common/model/model.dart';
import 'package:lamov_flutter_app/core/domain/usecase.dart';
import 'package:lamov_flutter_app/feature/feature.dart';
import 'package:lamov_flutter_app/feature/home/home.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../resource/resource.dart';
import 'home_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieGenresUseCase,
  GetMoviesNowPlayingUseCase,
  GetMoviesPopularUseCase,
  GetMoviesTopRatedUseCase,
  GetMoviesDiscoverUseCase,
])
void main() {
  late MockGetMovieGenresUseCase mockGetMovieGenresUseCase;
  late MockGetMoviesNowPlayingUseCase mockGetMoviesNowPlayingUseCase;
  late MockGetMoviesPopularUseCase mockGetMoviesPopularUseCase;
  late MockGetMoviesTopRatedUseCase mockGetMoviesTopRatedUseCase;
  late MockGetMoviesDiscoverUseCase mockGetMoviesDiscoverUseCase;

  late HomeCubit homeCubit;

  setUp(() {
    mockGetMovieGenresUseCase = MockGetMovieGenresUseCase();
    mockGetMoviesNowPlayingUseCase = MockGetMoviesNowPlayingUseCase();
    mockGetMoviesPopularUseCase = MockGetMoviesPopularUseCase();
    mockGetMoviesTopRatedUseCase = MockGetMoviesTopRatedUseCase();
    mockGetMoviesDiscoverUseCase = MockGetMoviesDiscoverUseCase();

    homeCubit = HomeCubit(
      mockGetMovieGenresUseCase,
      mockGetMoviesNowPlayingUseCase,
      mockGetMoviesDiscoverUseCase,
      mockGetMoviesPopularUseCase,
      mockGetMoviesTopRatedUseCase,
    );
  });

  tearDown(() {
    homeCubit.close();
  });

  final noParams = NoParams();

  const getMoviesPaginationParam = GetMoviesPaginationParam();
  const getMoviesPaginationParamCategory =
      GetMoviesPaginationParam(categoryId: 28);

  final List<GenreModel> genreModel = tGenresData;
  final BaseModel<MovieModel> movieModel = tMoviesData;

  blocTest<HomeCubit, HomeState>(
    'emits [GetCategoryLoading, GetCategoryLoaded] when getCategories().',
    setUp: () {
      when(mockGetMovieGenresUseCase.call(noParams)).thenAnswer(
        (value) async => Right(genreModel),
      );
    },
    build: () => homeCubit,
    act: (bloc) => bloc.getCategories(),
    wait: const Duration(milliseconds: 100),
    expect: () => <HomeState>[
      GetCategoryLoading(),
      GetCategoryLoaded(categories: genreModel),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits [GetBannerMoviesLoading, GetBannerMoviesLoaded] when getBannerMovies().',
    setUp: () {
      when(mockGetMoviesNowPlayingUseCase.call(getMoviesPaginationParam))
          .thenAnswer(
        (value) async => Right(movieModel),
      );
    },
    build: () => homeCubit,
    act: (bloc) => bloc.getBannerMovies(),
    wait: const Duration(milliseconds: 100),
    expect: () => <HomeState>[
      GetBannerMoviesLoading(),
      GetBannerMoviesLoaded(movies: movieModel.results),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits [GetMoviesPopularLoading, GetMoviesPopularLoaded] when getMoviePopular().',
    setUp: () {
      when(mockGetMoviesPopularUseCase.call(getMoviesPaginationParam))
          .thenAnswer(
        (value) async => Right(movieModel),
      );
    },
    build: () => homeCubit,
    act: (bloc) => bloc.getMoviePopular(),
    wait: const Duration(milliseconds: 100),
    expect: () => <HomeState>[
      GetMoviesPopularLoading(),
      GetMoviesPopularLoaded(movies: movieModel.results),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits [GetTopRatedMoviesLoading, GetTopRatedMoviesLoaded] when getTopRatedMovies().',
    setUp: () {
      when(mockGetMoviesTopRatedUseCase.call(getMoviesPaginationParam))
          .thenAnswer(
        (value) async => Right(movieModel),
      );
    },
    build: () => homeCubit,
    act: (bloc) => bloc.getTopRatedMovies(1),
    wait: const Duration(milliseconds: 100),
    expect: () => <HomeState>[
      GetTopRatedMoviesLoading(),
      GetTopRatedMoviesLoaded(movies: movieModel),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits [GetMoviesByCategoryLoading, GetMoviesByCategoryLoaded] when getMovieByCategory().',
    setUp: () {
      when(mockGetMoviesDiscoverUseCase.call(getMoviesPaginationParamCategory))
          .thenAnswer(
        (value) async => Right(movieModel),
      );
    },
    build: () => homeCubit,
    act: (bloc) =>
        bloc.getMovieByCategory(const GenreModel(id: 28, name: 'Action')),
    wait: const Duration(milliseconds: 100),
    expect: () => <HomeState>[
      GetMoviesByCategoryLoading(),
      GetMoviesByCategoryLoaded(movies: movieModel.results),
    ],
  );
}
