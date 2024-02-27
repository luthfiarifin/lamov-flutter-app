import 'package:equatable/equatable.dart';

class GetReviewParam extends Equatable {
  final int id, page;

  const GetReviewParam({
    this.page = 1,
    required this.id,
  });

  @override
  List<Object?> get props => [
        id,
        page,
      ];
}
