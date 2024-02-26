import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
  final int id;
  final String name;

  const CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  List<Object?> get props => [id, name];
}

const dummyCategories = [
  CategoryModel(id: 1, name: 'Action'),
  CategoryModel(id: 2, name: 'Adventure'),
  CategoryModel(id: 3, name: 'Comedy'),
  CategoryModel(id: 4, name: 'Drama'),
  CategoryModel(id: 5, name: 'Horror'),
  CategoryModel(id: 6, name: 'Mystery'),
];
