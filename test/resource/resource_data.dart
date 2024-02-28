import 'dart:convert';

import 'package:lamov_flutter_app/core/domain/common/model/model.dart';

import '../helper/json_reader.dart';
import 'resource_path.dart';

final List<GenreModel> tGenresData =
    (json.decode(readJson(genresSuccessPath))['genres'] as List<dynamic>?)
            ?.map<GenreModel>((c) => GenreModel.fromJson(c))
            .toList() ??
        [];

final BaseModel<MovieModel> tMoviesData = BaseModel.fromJson(
  json.decode(readJson(moviesSuccessPath)),
  (json) => MovieModel.fromJson(json),
);

final MovieModel tMovieData = MovieModel.fromJson(
  json.decode(readJson(movieSuccessPath)),
);

final BaseModel<ReviewModel> tReviewData = BaseModel.fromJson(
  json.decode(readJson(reviewSuccessPath)),
  (json) => ReviewModel.fromJson(json),
);
