// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['id'] as String,
      author: json['author'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] as String,
      authorDetails: ReviewAuthorModel.fromJson(
          json['author_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'content': instance.content,
      'author_details': instance.authorDetails,
      'created_at': instance.createdAt,
    };
