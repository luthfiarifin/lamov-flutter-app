class BaseModel<T> {
  final int? page;
  final int? totalPages;
  final List<T> results;

  const BaseModel({
    required this.page,
    required this.totalPages,
    required this.results,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json, Function fromJsonT) {
    return BaseModel(
      page: json['page'],
      totalPages: json['total_pages'],
      results: (json['results'] as List<dynamic>?)
              ?.map<T>((post) => fromJsonT(post))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson(List<dynamic> post) {
    return {
      'page': page,
      'total_pages': totalPages,
      'results': results,
    };
  }
}
