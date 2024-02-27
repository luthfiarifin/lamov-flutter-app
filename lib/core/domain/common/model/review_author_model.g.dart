// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewAuthorModel _$ReviewAuthorModelFromJson(Map<String, dynamic> json) =>
    ReviewAuthorModel(
      name: json['name'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ReviewAuthorModelToJson(ReviewAuthorModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rating': instance.rating,
    };
