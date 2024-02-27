import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/data.dart';
import '../../../../core/domain/common/model/model.dart';
import '../../data/datasource/datasource.dart';
import '../../domain/model/model.dart';
import '../../domain/param/param.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CategoryModel>>> getMovieGenres();
  Future<Either<Failure, BaseModel<MovieModel>>> getNowPlaying(
    GetMoviesPaginationParam param,
  );
  Future<Either<Failure, BaseModel<MovieModel>>> getDiscover(
    GetMoviesPaginationParam param,
  );
  Future<Either<Failure, BaseModel<MovieModel>>> getPopular(
    GetMoviesPaginationParam param,
  );
  Future<Either<Failure, BaseModel<MovieModel>>> getTopRated(
    GetMoviesPaginationParam param,
  );
}

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  const HomeRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<CategoryModel>>> getMovieGenres() {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        final response = await remoteDataSource.getMovieGenres();
        return response;
      },
    );
  }

  @override
  Future<Either<Failure, BaseModel<MovieModel>>> getNowPlaying(
    GetMoviesPaginationParam param,
  ) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        final response = await remoteDataSource.getNowPlaying(param);
        return response;
      },
    );
  }

  @override
  Future<Either<Failure, BaseModel<MovieModel>>> getDiscover(
    GetMoviesPaginationParam param,
  ) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        final response = await remoteDataSource.getDiscover(param);
        return response;
      },
    );
  }

  @override
  Future<Either<Failure, BaseModel<MovieModel>>> getPopular(
    GetMoviesPaginationParam param,
  ) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        final response = await remoteDataSource.getPopular(param);
        return response;
      },
    );
  }

  @override
  Future<Either<Failure, BaseModel<MovieModel>>> getTopRated(
    GetMoviesPaginationParam param,
  ) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        final response = await remoteDataSource.getTopRated(param);
        return response;
      },
    );
  }
}
