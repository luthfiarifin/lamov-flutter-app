import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'review_author_model.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel extends Equatable {
  final String id;
  final String author, content;

  @JsonKey(name: 'author_details')
  final ReviewAuthorModel authorDetails;

  @JsonKey(name: 'created_at')
  final String createdAt;

  const ReviewModel({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.authorDetails,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        author,
        content,
        createdAt,
      ];
}
