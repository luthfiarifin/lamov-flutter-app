import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_author_model.g.dart';

@JsonSerializable()
class ReviewAuthorModel extends Equatable {
  final String? name;
  final double? rating;

  const ReviewAuthorModel({
    required this.name,
    required this.rating,
  });

  factory ReviewAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewAuthorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewAuthorModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        rating,
      ];
}
