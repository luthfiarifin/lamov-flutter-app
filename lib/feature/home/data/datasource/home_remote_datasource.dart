import 'package:injectable/injectable.dart';

import '../../../../core/data/data.dart';
import '../../../../core/domain/common/model/model.dart';
import '../../domain/param/param.dart';

abstract class HomeRemoteDataSource {
  Future<List<GenreModel>> getMovieGenres();
  Future<BaseModel<MovieModel>> getNowPlaying(GetMoviesPaginationParam param);
  Future<BaseModel<MovieModel>> getDiscover(GetMoviesPaginationParam param);
  Future<BaseModel<MovieModel>> getPopular(GetMoviesPaginationParam param);
  Future<BaseModel<MovieModel>> getTopRated(GetMoviesPaginationParam param);
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient client;

  const HomeRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<GenreModel>> getMovieGenres() {
    return client.get(
      ApiConstant.genreMovieList,
      converter: (json) =>
          (json['genres'] as List<dynamic>?)
              ?.map<GenreModel>((c) => GenreModel.fromJson(c))
              .toList() ??
          [],
    );
  }

  @override
  Future<BaseModel<MovieModel>> getNowPlaying(GetMoviesPaginationParam param) {
    return client.get(
      ApiConstant.movieNowPlaying,
      queryParameters: {
        'page': param.page,
      },
      converter: (e) => BaseModel.fromJson(
        e,
        (e) => MovieModel.fromJson(e),
      ),
    );
  }

  @override
  Future<BaseModel<MovieModel>> getDiscover(GetMoviesPaginationParam param) {
    return client.get(
      ApiConstant.discoverMovie,
      queryParameters: {
        'page': param.page,
        'with_genres': '${param.categoryId}',
      },
      converter: (e) => BaseModel.fromJson(
        e,
        (e) => MovieModel.fromJson(e),
      ),
    );
  }

  @override
  Future<BaseModel<MovieModel>> getPopular(GetMoviesPaginationParam param) {
    return client.get(
      ApiConstant.moviePopular,
      queryParameters: {
        'page': param.page,
      },
      converter: (e) => BaseModel.fromJson(
        e,
        (e) => MovieModel.fromJson(e),
      ),
    );
  }

  @override
  Future<BaseModel<MovieModel>> getTopRated(GetMoviesPaginationParam param) {
    return client.get(
      ApiConstant.movieTopRated,
      queryParameters: {
        'page': param.page,
      },
      converter: (e) => BaseModel.fromJson(
        e,
        (e) => MovieModel.fromJson(e),
      ),
    );
  }
}
