// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<Category> categories;

  CategoryModel({
    required this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  String categoryName;
  List<String> subcategory;
  String name;

  Category({
    required this.categoryName,
    required this.subcategory,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryName: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": categoryName,
        "subcategory": List<dynamic>.from(subcategory.map((x) => x)),
        " name": name,
      };
}
