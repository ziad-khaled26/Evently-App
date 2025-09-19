import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/colors_manager.dart';

class BuildDropDownMenuItem extends StatelessWidget {
  const BuildDropDownMenuItem({super.key,required this.label,required this.selectedItem,required this.menuItems});

  final List<String> menuItems;
  final String label;
  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          SizedBox(height: 12.h),
          Container(
            padding: REdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: ColorsManager.blue, width: 1),
            ),
            child: Row(
              children: [
                Text(
                  selectedItem,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.blue,
                  ),
                ),
                Spacer(),
                DropdownButton<String>(
                  underline: Container(),
                  iconEnabledColor: ColorsManager.blue,
                  dropdownColor: Theme.of(context).dividerColor,
                  elevation: 1,
                  style: Theme.of(context).textTheme.displayLarge,


                  items: menuItems.map((value)=>DropdownMenuItem<String>(

                    value: value,
                      child: Text(value),
                  )).toList(),
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
