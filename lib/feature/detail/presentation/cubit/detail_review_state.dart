part of 'detail_review_cubit.dart';

sealed class DetailReviewState extends Equatable {
  const DetailReviewState();

  @override
  List<Object> get props => [];
}

final class DetailReviewInitial extends DetailReviewState {}

final class GetReviewLoading extends DetailReviewState {}

final class GetReviewLoaded extends DetailReviewState {
  final BaseModel<ReviewModel> data;

  const GetReviewLoaded({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

final class GetReviewError extends DetailReviewState {
  final String message;

  const GetReviewError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
