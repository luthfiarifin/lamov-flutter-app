import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_video_model.g.dart';

@JsonSerializable()
class MovieVideoModel extends Equatable {
  const MovieVideoModel({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
  });

  final String id, key, name, type, site;

  factory MovieVideoModel.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVideoModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        key,
        type,
        site,
      ];
}
