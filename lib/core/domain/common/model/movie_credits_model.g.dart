// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_credits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCreditsModel _$MovieCreditsModelFromJson(Map<String, dynamic> json) =>
    MovieCreditsModel(
      actor: (json['cast'] as List<dynamic>)
          .map((e) => MovieCreditsCastModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieCreditsModelToJson(MovieCreditsModel instance) =>
    <String, dynamic>{
      'cast': instance.actor,
    };
