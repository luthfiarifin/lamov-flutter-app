part of 'detail_cubit.dart';

sealed class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {}

final class GetDetailLoading extends DetailState {}

final class GetDetailLoaded extends DetailState {
  final MovieModel movie;

  const GetDetailLoaded({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}

final class GetDetailError extends DetailState {
  final String message;

  const GetDetailError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
