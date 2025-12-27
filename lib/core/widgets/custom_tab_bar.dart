import 'package:flutter/material.dart';

import 'custom_tab_item.dart';
import '../../models/category_model.dart';
import '../resources/colors_manager.dart';

class CustomTabBar extends StatefulWidget {

  const CustomTabBar({
    super.key,
    required this.categories,
    required this.selectedBgColor,
    required this.unSelectedBgColor,
    required this.selectedForegroundColor,
    required this.unSelectedForegroundColor,
     this.onCategoryItemSelected,
  });
  final List<CategoryModel> categories;
  final Color selectedBgColor;
  final Color unSelectedBgColor;
  final Color selectedForegroundColor;
  final Color unSelectedForegroundColor;
  final void Function(CategoryModel)? onCategoryItemSelected;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex=0;




  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        indicatorColor: Colors.transparent,
        onTap: (currentIndex){

          setState(() {
            selectedIndex=currentIndex;
          });
          widget.onCategoryItemSelected?.call(widget.categories[selectedIndex]);

        },

        isScrollable: true,
        tabs: widget.categories.map<Widget>( (category)=> CustomTabItem(
          category: category,
          isSelected: selectedIndex==widget.categories.indexOf(category),
          selectedBgColor: widget.selectedBgColor,
          unSelectedBgColor: widget.unSelectedBgColor,
          selectedForegroundColor: widget.selectedForegroundColor,
          unSelectedForegroundColor: widget.unSelectedForegroundColor,

        )).toList(),
      ),
    );
  }
}
