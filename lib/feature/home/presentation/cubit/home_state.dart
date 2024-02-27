part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class GetBannerMoviesLoading extends HomeState {}

final class GetBannerMoviesLoaded extends HomeState {
  final List<MovieModel> movies;

  const GetBannerMoviesLoaded({
    required this.movies,
  });
}

final class GetBannerMoviesError extends HomeState {
  final String message;

  const GetBannerMoviesError({
    required this.message,
  });
}

final class GetCategoryLoading extends HomeState {}

final class GetCategoryLoaded extends HomeState {
  final List<CategoryModel> categories;

  const GetCategoryLoaded({
    required this.categories,
  });
}

final class GetCategoryError extends HomeState {
  final String message;

  const GetCategoryError({
    required this.message,
  });
}

final class GetMoviesByCategoryLoading extends HomeState {}

final class GetMoviesByCategoryLoaded extends HomeState {
  final List<MovieModel> movies;

  const GetMoviesByCategoryLoaded({
    required this.movies,
  });
}

final class GetMoviesByCategoryError extends HomeState {
  final String message;

  const GetMoviesByCategoryError({
    required this.message,
  });
}

final class GetMoviesPopularLoading extends HomeState {}

final class GetMoviesPopularLoaded extends HomeState {
  final List<MovieModel> movies;

  const GetMoviesPopularLoaded({
    required this.movies,
  });
}

final class GetMoviesPopularError extends HomeState {
  final String message;

  const GetMoviesPopularError({
    required this.message,
  });
}

final class GetTopRatedMoviesLoading extends HomeState {}

final class GetTopRatedMoviesLoaded extends HomeState {
  final BaseModel<MovieModel> movies;

  const GetTopRatedMoviesLoaded({
    required this.movies,
  });
}

final class GetTopRatedMoviesError extends HomeState {
  final String message;

  const GetTopRatedMoviesError({
    required this.message,
  });
}
