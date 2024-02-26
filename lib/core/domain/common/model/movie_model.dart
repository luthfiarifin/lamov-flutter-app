import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

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
  });

  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
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

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}

const dummyMovies = [
  MovieModel(
    adult: false,
    backdropPath: '/oQHF0Y4gCw6VdPmapjsbZoxY2ht.jpg',
    genreIds: [80, 18],
    id: 359940,
    originalTitle: 'Three Billboards Outside Ebbing, Missouri',
    overview:
        "After seven months have passed without a culprit in her daughter's murder case, Mildred Hayes makes a bold move, painting three signs leading into her town with a controversial message directed at Bill Willoughby, the town's revered chief of police. When his second-in-command Officer Jason Dixon, an immature mother's boy with a penchant for violence, gets involved, the battle between Mildred and Ebbing's law enforcement is only exacerbated.",
    popularity: 20.593,
    posterPath: '/pZRhqJj0DBy4ghB7g6pU7MGHsWJ.jpg',
    releaseDate: '2017-12-01',
    title: 'Three Billboards Outside Ebbing, Missouri',
    video: false,
    voteAverage: 8.077,
    voteCount: 9669,
  ),
  MovieModel(
    adult: false,
    backdropPath: '/oQHF0Y4gCw6VdPmapjsbZoxY2ht.jpg',
    genreIds: [80, 18],
    id: 359940,
    originalTitle: 'Three Billboards Outside Ebbing, Missouri',
    overview:
        "After seven months have passed without a culprit in her daughter's murder case, Mildred Hayes makes a bold move, painting three signs leading into her town with a controversial message directed at Bill Willoughby, the town's revered chief of police. When his second-in-command Officer Jason Dixon, an immature mother's boy with a penchant for violence, gets involved, the battle between Mildred and Ebbing's law enforcement is only exacerbated.",
    popularity: 20.593,
    posterPath: '/pZRhqJj0DBy4ghB7g6pU7MGHsWJ.jpg',
    releaseDate: '2017-12-01',
    title: 'Three Billboards Outside Ebbing, Missouri',
    video: false,
    voteAverage: 8.077,
    voteCount: 9669,
  ),
  MovieModel(
    adult: false,
    backdropPath: '/oQHF0Y4gCw6VdPmapjsbZoxY2ht.jpg',
    genreIds: [80, 18],
    id: 359940,
    originalTitle: 'Three Billboards Outside Ebbing, Missouri',
    overview:
        "After seven months have passed without a culprit in her daughter's murder case, Mildred Hayes makes a bold move, painting three signs leading into her town with a controversial message directed at Bill Willoughby, the town's revered chief of police. When his second-in-command Officer Jason Dixon, an immature mother's boy with a penchant for violence, gets involved, the battle between Mildred and Ebbing's law enforcement is only exacerbated.",
    popularity: 20.593,
    posterPath: '/pZRhqJj0DBy4ghB7g6pU7MGHsWJ.jpg',
    releaseDate: '2017-12-01',
    title: 'Three Billboards Outside Ebbing, Missouri',
    video: false,
    voteAverage: 8.077,
    voteCount: 9669,
  ),
];
