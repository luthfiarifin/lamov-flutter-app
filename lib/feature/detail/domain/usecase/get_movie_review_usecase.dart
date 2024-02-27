import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/error/error.dart';
import '../../../../core/domain/common/model/model.dart';
import '../../../../core/domain/usecase.dart';
import '../param/param.dart';
import '../repository/repository.dart';

@lazySingleton
class GetMovieReviewUseCase
    implements UseCase<BaseModel<ReviewModel>, GetReviewParam> {
  final DetailRepository repository;

  const GetMovieReviewUseCase(this.repository);

  @override
  Future<Either<Failure, BaseModel<ReviewModel>>> call(GetReviewParam param) {
    return repository.getReviews(param);
  }
}
