import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/event_item.dart';
import 'package:evently_app/l10n/app_localization.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});


  @override
  Widget build(BuildContext context) {
    var appLocalizations=AppLocalizations.of(context);

    return Container(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: ColorsManager.blue,
                  hintText: appLocalizations!.search_for_event,
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.blue,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => EventItem(
                    event: EventModel(
                      category: CategoryModel.getCategoriesWithAll(context)[3],
                      title: "title",
                      description: "Meeting for Updating The Development Method ",
                      dateTime: DateTime.now(),
                      id: "1",
                      ownerId: "1"
                    ),
                  ),
                  itemCount: 10,
                  separatorBuilder: (context,index)=>SizedBox(height: 16.h,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
