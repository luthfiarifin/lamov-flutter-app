import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'movie_credits_casts_model.dart';

part 'movie_credits_model.g.dart';

@JsonSerializable()
class MovieCreditsModel extends Equatable {
  @JsonKey(name: 'cast')
  final List<MovieCreditsCastModel> actor;

  const MovieCreditsModel({
    required this.actor,
  });

  factory MovieCreditsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCreditsModelToJson(this);

  @override
  List<Object?> get props => [actor];
}
