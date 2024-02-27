import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/common/model/model.dart';
import '../../domain/param/param.dart';
import '../../domain/usecase/usecase.dart';

part 'detail_review_state.dart';

@injectable
class DetailReviewCubit extends Cubit<DetailReviewState> {
  final GetMovieReviewUseCase _getMovieReviewUseCase;

  DetailReviewCubit(
    this._getMovieReviewUseCase,
  ) : super(DetailReviewInitial());

  void getReviews(GetReviewParam param) async {
    emit(GetReviewLoading());
    final result = await _getMovieReviewUseCase(param);
    result.fold(
      (failure) => emit(GetReviewError(message: failure.message)),
      (data) => emit(GetReviewLoaded(data: data)),
    );
  }
}
