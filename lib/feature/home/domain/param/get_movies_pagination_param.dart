import 'package:equatable/equatable.dart';

class GetMoviesPaginationParam extends Equatable {
  final int page;
  final int? categoryId;

  const GetMoviesPaginationParam({
    this.page = 1,
    this.categoryId,
  });

  @override
  List<Object?> get props => [
        page,
        categoryId,
      ];

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      if (categoryId != null) 'with_genres': categoryId,
    };
  }
}
