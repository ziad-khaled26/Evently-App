import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class CategoryModel{
  String id;
  String name;
  IconData icon;
  String imagePath;
  CategoryModel({required this.id,required this.name,required this.icon,required this.imagePath});

  static List<CategoryModel> categoriesWithAll=[
    CategoryModel(id: "0", name: "All", icon: Icons.explore_outlined, imagePath: "imagePath",),
    CategoryModel(id: "1", name: "Sport", icon: Icons.directions_bike_outlined, imagePath: "imagePath"),
    CategoryModel(id: "2", name: "Birthday", icon: Icons.cake_outlined, imagePath: "imagePath"),
    CategoryModel(id: "3", name: "Meeting", icon: Icons.laptop, imagePath: ImageAssets.meeting),
    CategoryModel(id: "4", name: "Gaming", icon: Icons.games_outlined, imagePath: "imagePath"),
    CategoryModel(id: "5", name: "Eating", icon: Icons.local_pizza_outlined, imagePath: "imagePath"),
    CategoryModel(id: "6", name: "Holiday", icon: Icons.holiday_village, imagePath: "imagePath"),
    CategoryModel(id: "7", name: "Exhibition", icon: Icons.water_drop_outlined, imagePath: "imagePath"),
    CategoryModel(id: "8", name: "WorkShop", icon: Icons.workspaces_outline, imagePath: "imagePath"),
    CategoryModel(id: "9", name: "BookClub", icon: Icons.book_outlined, imagePath: "imagePath"),
  ];

  static List<CategoryModel> categoriesWithOutAll=[
    CategoryModel(id: "1", name: "Sport", icon: Icons.directions_bike_outlined, imagePath: "imagePath"),
    CategoryModel(id: "2", name: "Birthday", icon: Icons.cake_outlined, imagePath: "imagePath"),
    CategoryModel(id: "3", name: "Meeting", icon: Icons.laptop, imagePath: "imagePath"),
    CategoryModel(id: "4", name: "Gaming", icon: Icons.games_outlined, imagePath: "imagePath"),
    CategoryModel(id: "5", name: "Eating", icon: Icons.local_pizza_outlined, imagePath: "imagePath"),
    CategoryModel(id: "6", name: "Holiday", icon: Icons.holiday_village, imagePath: "imagePath"),
    CategoryModel(id: "7", name: "Exhibition", icon: Icons.water_drop_outlined, imagePath: "imagePath"),
    CategoryModel(id: "8", name: "WorkShop", icon: Icons.workspaces_outline, imagePath: "imagePath"),
    CategoryModel(id: "9", name: "BookClub", icon: Icons.book_outlined, imagePath: "imagePath"),
  ];

}