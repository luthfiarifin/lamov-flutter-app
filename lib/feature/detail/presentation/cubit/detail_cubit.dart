import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/common/model/model.dart';
import '../../domain/usecase/usecase.dart';

part 'detail_state.dart';

@injectable
class DetailCubit extends Cubit<DetailState> {
  final GetMovieDetailUseCase _getMovieDetailUseCase;

  DetailCubit(
    this._getMovieDetailUseCase,
  ) : super(DetailInitial());

  void getDetail(int id) async {
    emit(GetDetailLoading());

    _getMovieDetailUseCase(id).then((result) {
      result.fold(
        (failure) => emit(GetDetailError(message: failure.message)),
        (data) => emit(GetDetailLoaded(movie: data)),
      );
    });
  }
}
