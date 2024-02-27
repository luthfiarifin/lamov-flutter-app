import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/error/error.dart';
import '../../../../core/domain/usecase.dart';
import '../../../../core/domain/common/model/genre_model.dart';
import '../repository/home_repository.dart';

@lazySingleton
class GetMovieGenresUseCase implements UseCase<List<GenreModel>, NoParams> {
  final HomeRepository repository;

  const GetMovieGenresUseCase(this.repository);

  @override
  Future<Either<Failure, List<GenreModel>>> call(NoParams param) {
    return repository.getMovieGenres();
  }
}
