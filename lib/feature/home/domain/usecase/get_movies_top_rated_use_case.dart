import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/error/error.dart';
import '../../../../core/domain/common/model/base_model.dart';
import '../../../../core/domain/common/model/movie_model.dart';
import '../../../../core/domain/usecase.dart';
import '../param/get_movies_pagination_param.dart';
import '../repository/home_repository.dart';

@lazySingleton
class GetMoviesTopRatedUseCase
    implements UseCase<BaseModel<MovieModel>, GetMoviesPaginationParam> {
  final HomeRepository repository;

  const GetMoviesTopRatedUseCase(this.repository);

  @override
  Future<Either<Failure, BaseModel<MovieModel>>> call(
      GetMoviesPaginationParam param) {
    return repository.getTopRated(param);
  }
}
