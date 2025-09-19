import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabItem extends StatelessWidget {
  const CustomTabItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.selectedBgColor,
    required this.unSelectedBgColor,
    required this.selectedForegroundColor,
    required this.unSelectedForegroundColor
  });

  final CategoryModel category;
  final bool isSelected;
  final Color selectedBgColor;
  final Color unSelectedBgColor;
  final Color selectedForegroundColor;
  final Color unSelectedForegroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: selectedBgColor,
          width: 1
        ),
        borderRadius: BorderRadius.circular(46.r),
        color: isSelected? selectedBgColor: unSelectedBgColor

      ),

      child: Row(
        children: [
          Icon(category.icon,color: isSelected? selectedForegroundColor: unSelectedForegroundColor,),
          SizedBox(width: 3.w,),
          Text(category.name,style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: isSelected? selectedForegroundColor: unSelectedForegroundColor
          ),)
        ],
      ),
    );
  }
}
