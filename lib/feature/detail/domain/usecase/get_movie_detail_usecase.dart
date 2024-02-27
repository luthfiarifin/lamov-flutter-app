import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/error/error.dart';
import '../../../../core/domain/common/model/movie_model.dart';
import '../../../../core/domain/usecase.dart';
import '../repository/repository.dart';

@lazySingleton
class GetMovieDetailUseCase implements UseCase<MovieModel, int> {
  final DetailRepository repository;

  const GetMovieDetailUseCase(this.repository);

  @override
  Future<Either<Failure, MovieModel>> call(int param) {
    return repository.getDetail(param);
  }
}
