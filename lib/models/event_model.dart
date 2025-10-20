import 'package:evently_app/models/category_model.dart';
import 'package:flutter/material.dart';

class EventModel {
  String id;
  final String ownerId;
  final CategoryModel category;
  final String title;
  final String description;
  final DateTime dateTime;

   EventModel({
    required this.id,
    required this.ownerId,
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  EventModel.fromJson(Map<String, dynamic> json, BuildContext context)
    : this(
        id: json["id"],
        ownerId: json["ownerId"],
        category: CategoryModel.getCategories(
          context,
        ).firstWhere((category) => category.id == json["categoryId"]),
        title: json["title"],
        description: json["description"],
        dateTime: json["dateTime"].toDate(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownerId": ownerId,
    "categoryId": category.id,
    "title": title,
    "description": description,
    "dateTime": dateTime,
  };
}
