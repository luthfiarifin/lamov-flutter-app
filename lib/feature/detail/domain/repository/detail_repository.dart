import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/data.dart';
import '../../../../core/domain/common/model/model.dart';
import '../../data/datasource/datasource.dart';
import '../param/param.dart';

abstract class DetailRepository {
  Future<Either<Failure, MovieModel>> getDetail(int id);
  Future<Either<Failure, BaseModel<ReviewModel>>> getReviews(
      GetReviewParam param);
}

@LazySingleton(as: DetailRepository)
class DetailRepositoryImpl implements DetailRepository {
  final DetailRemoteDataSource remoteDataSource;

  const DetailRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, MovieModel>> getDetail(int id) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        final response = await remoteDataSource.getDetail(id);
        return response;
      },
    );
  }

  @override
  Future<Either<Failure, BaseModel<ReviewModel>>> getReviews(
      GetReviewParam param) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        final response = await remoteDataSource.getReviews(param);
        return response;
      },
    );
  }
}
