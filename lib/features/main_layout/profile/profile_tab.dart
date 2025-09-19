import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/features/main_layout/profile/build_drop_down_menu_item.dart';
import 'package:evently_app/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manager.dart';

class ProfileTab extends StatelessWidget {
   ProfileTab({super.key});
   AppLocalizations? appLocalizations;

  @override
  Widget build(BuildContext context) {
    appLocalizations=AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: REdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsManager.blue,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64.r)),
          ),
          child: SafeArea(
            top: true,
            bottom: false,
            child: Row(
              children: [
                Image.asset(ImageAssets.profileImage),
                SizedBox(width: 16.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ziad Khaled",
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "zoz@gmail.com",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
       BuildDropDownMenuItem(label: appLocalizations!.language, menuItems: ["English","Arabic"],selectedItem: "English",),

        SizedBox(height: 16.h),
       BuildDropDownMenuItem(label: appLocalizations!.theme, menuItems: [appLocalizations!.light,appLocalizations!.dark],selectedItem: "Light",),
        Padding(
          padding:  REdgeInsets.only(right: 8,left :8,top: 200),
          child: ElevatedButton(onPressed: (){},

              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.red,
                foregroundColor: ColorsManager.white,
                padding: EdgeInsets.all(12)
              ),
              child: Row(
                children: [
                  Icon(Icons.logout_outlined),
                  SizedBox(width: 8.w,),
                  Text(
                    appLocalizations!.log_out,
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.white
                    ),
                  )
                ],
              )
          ),
        )
      ],
    );
  }
}
