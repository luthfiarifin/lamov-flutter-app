// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_credits_casts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCreditsCastModel _$MovieCreditsCastModelFromJson(
        Map<String, dynamic> json) =>
    MovieCreditsCastModel(
      id: json['id'] as int,
      name: json['name'] as String,
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$MovieCreditsCastModelToJson(
        MovieCreditsCastModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_path': instance.profilePath,
    };
