import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/common/model/model.dart';
import '../../domain/model/model.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<CategoryModel>? categories;
  List<MovieModel>? bannerMovies;
  List<MovieModel>? movies;

  // TODO: using real data

  void getBannerMovies() async {
    emit(GetBannerMoviesLoading());

    await Future.delayed(const Duration(seconds: 3));
    bannerMovies = dummyMovies;
    emit(GetBannerMoviesLoaded(movies: bannerMovies ?? []));
  }

  void getCategories() async {
    emit(GetCategoryLoading());

    await Future.delayed(const Duration(seconds: 2));
    categories = dummyCategories;
    emit(GetCategoryLoaded(categories: categories ?? []));
  }

  void getMovieByCategory(CategoryModel selected) async {
    movies = null;

    emit(GetMoviesByCategoryLoading());

    await Future.delayed(const Duration(seconds: 4));
    movies = dummyMovies;
    emit(GetMoviesByCategoryLoaded(movies: movies ?? []));
  }

  void getTopRatedMovies(int page) async {
    emit(GetTopRatedMoviesLoading());

    await Future.delayed(const Duration(seconds: 3));
    emit(GetTopRatedMoviesLoaded(
      movies: BaseModel(
        page: page,
        totalPages: 10,
        results: dummyMovies,
      ),
    ));
  }
}
