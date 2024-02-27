import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/error/error.dart';
import '../../../../core/domain/usecase.dart';
import '../model/category_model.dart';
import '../repository/home_repository.dart';

@lazySingleton
class GetMovieGenresUseCase implements UseCase<List<CategoryModel>, NoParams> {
  final HomeRepository repository;

  const GetMovieGenresUseCase(this.repository);

  @override
  Future<Either<Failure, List<CategoryModel>>> call(NoParams param) {
    return repository.getMovieGenres();
  }
}
