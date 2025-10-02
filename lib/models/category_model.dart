import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/l10n/app_localization.dart';
import 'package:flutter/material.dart';

class CategoryModel{
  String id;
  String name;
  IconData icon;
  String imagePath;
  CategoryModel({required this.id,required this.name,required this.icon,required this.imagePath});
  static List<CategoryModel> getCategoriesWithAll(BuildContext context){
    AppLocalizations appLocalization=AppLocalizations.of(context)!;
    return [
      CategoryModel(id: "0", name: appLocalization.all, icon: Icons.explore_outlined, imagePath: "imagePath",),
      CategoryModel(id: "1", name: appLocalization.sport, icon: Icons.directions_bike_outlined, imagePath: "imagePath"),
      CategoryModel(id: "2", name: appLocalization.birth_day, icon: Icons.cake_outlined, imagePath: "imagePath"),
      CategoryModel(id: "3", name: appLocalization.meeting, icon: Icons.laptop, imagePath: ImageAssets.meeting),
      CategoryModel(id: "4", name: appLocalization.gaming, icon: Icons.games_outlined, imagePath: "imagePath"),
      CategoryModel(id: "5", name: appLocalization.eating, icon: Icons.local_pizza_outlined, imagePath: "imagePath"),
      CategoryModel(id: "6", name: appLocalization.holiday, icon: Icons.holiday_village, imagePath: "imagePath"),
      CategoryModel(id: "7", name: appLocalization.exhibition, icon: Icons.water_drop_outlined, imagePath: "imagePath"),
      CategoryModel(id: "8", name: appLocalization.work_shop, icon: Icons.workspaces_outline, imagePath: "imagePath"),
      CategoryModel(id: "9", name: appLocalization.book_club, icon: Icons.book_outlined, imagePath: "imagePath"),
    ];
  }
  static List<CategoryModel> getCategories(BuildContext context){
    AppLocalizations appLocalization=AppLocalizations.of(context)!;
    return [
      CategoryModel(id: "1", name: appLocalization.sport, icon: Icons.directions_bike_outlined, imagePath: "imagePath"),
      CategoryModel(id: "2", name: appLocalization.birth_day, icon: Icons.cake_outlined, imagePath: "imagePath"),
      CategoryModel(id: "3", name: appLocalization.meeting, icon: Icons.laptop, imagePath: ImageAssets.meeting),
      CategoryModel(id: "4", name: appLocalization.gaming, icon: Icons.games_outlined, imagePath: "imagePath"),
      CategoryModel(id: "5", name: appLocalization.eating, icon: Icons.local_pizza_outlined, imagePath: "imagePath"),
      CategoryModel(id: "6", name: appLocalization.holiday, icon: Icons.holiday_village, imagePath: "imagePath"),
      CategoryModel(id: "7", name: appLocalization.exhibition, icon: Icons.water_drop_outlined, imagePath: "imagePath"),
      CategoryModel(id: "8", name: appLocalization.work_shop, icon: Icons.workspaces_outline, imagePath: "imagePath"),
      CategoryModel(id: "9", name: appLocalization.book_club, icon: Icons.book_outlined, imagePath: "imagePath"),
    ];
  }


}