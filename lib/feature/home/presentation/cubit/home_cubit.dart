import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/common/model/model.dart';
import '../../../../core/domain/usecase.dart';
import '../../domain/param/param.dart';
import '../../domain/usecase/usecase.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetMovieGenresUseCase _getMovieGenresUseCase;
  final GetMoviesNowPlayingUseCase _getMoviesNowPlayingUseCase;
  final GetMoviesDiscoverUseCase _getMoviesDiscoverUseCase;
  final GetMoviesPopularUseCase _getMoviesPopularUseCase;
  final GetMoviesTopRatedUseCase _getMoviesTopRatedUseCase;

  HomeCubit(
    this._getMovieGenresUseCase,
    this._getMoviesNowPlayingUseCase,
    this._getMoviesDiscoverUseCase,
    this._getMoviesPopularUseCase,
    this._getMoviesTopRatedUseCase,
  ) : super(HomeInitial());

  List<GenreModel>? categories;
  List<MovieModel>? bannerMovies;
  List<MovieModel>? categoryMovies;
  List<MovieModel>? popularMovies;

  void getBannerMovies() async {
    emit(GetBannerMoviesLoading());

    _getMoviesNowPlayingUseCase(const GetMoviesPaginationParam())
        .then((result) {
      result.fold(
        (failure) => emit(GetBannerMoviesError(message: failure.message)),
        (data) {
          bannerMovies = data.results.take(3).toList();
          emit(GetBannerMoviesLoaded(movies: bannerMovies ?? []));
        },
      );
    });
  }

  void getCategories() async {
    emit(GetCategoryLoading());

    _getMovieGenresUseCase(NoParams()).then((result) {
      result.fold(
        (failure) => emit(GetCategoryError(message: failure.message)),
        (data) {
          categories = data;
          emit(GetCategoryLoaded(categories: categories ?? []));
        },
      );
    });
  }

  void getMovieByCategory(GenreModel selected) async {
    categoryMovies = null;

    emit(GetMoviesByCategoryLoading());
    _getMoviesDiscoverUseCase(GetMoviesPaginationParam(categoryId: selected.id))
        .then((result) {
      result.fold(
        (failure) => emit(GetMoviesByCategoryError(message: failure.message)),
        (data) {
          categoryMovies = data.results;
          emit(GetMoviesByCategoryLoaded(movies: categoryMovies ?? []));
        },
      );
    });
  }

  void getMoviePopular() async {
    popularMovies = null;

    _getMoviesPopularUseCase(const GetMoviesPaginationParam()).then((result) {
      result.fold(
        (failure) => emit(GetMoviesPopularError(message: failure.message)),
        (data) {
          popularMovies = data.results;
          emit(GetMoviesPopularLoaded(movies: popularMovies ?? []));
        },
      );
    });
  }

  void getTopRatedMovies(int page) async {
    emit(GetTopRatedMoviesLoading());

    _getMoviesTopRatedUseCase(GetMoviesPaginationParam(
      page: page,
    )).then((result) {
      result.fold(
        (failure) => emit(GetTopRatedMoviesError(message: failure.message)),
        (data) => emit(GetTopRatedMoviesLoaded(movies: data)),
      );
    });
  }
}
