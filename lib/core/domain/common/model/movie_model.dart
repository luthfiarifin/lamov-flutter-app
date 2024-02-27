import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'genre_model.dart';
import 'movie_credits_model.dart';
import 'movie_video_model.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends Equatable {
  const MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.runtime,
    this.videos,
    this.genres,
    this.credits,
  });

  final bool adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  final int id;

  @JsonKey(name: 'original_title')
  final String originalTitle;

  final String overview;

  final double popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  final String title;

  final bool video;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  final int? runtime;

  @JsonKey(
    fromJson: _videosFromJson,
  )
  final List<MovieVideoModel>? videos;

  final List<GenreModel>? genres;

  final MovieCreditsModel? credits;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  static List<MovieVideoModel>? _videosFromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return (json['results'] as List<dynamic>?)
        ?.map((e) => MovieVideoModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        runtime,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
        videos,
        genres,
        credits,
      ];
}
