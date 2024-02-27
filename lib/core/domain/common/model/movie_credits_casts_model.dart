import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_credits_casts_model.g.dart';

@JsonSerializable()
class MovieCreditsCastModel extends Equatable {
  final int id;
  final String name;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  const MovieCreditsCastModel({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory MovieCreditsCastModel.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsCastModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCreditsCastModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        profilePath,
      ];
}
