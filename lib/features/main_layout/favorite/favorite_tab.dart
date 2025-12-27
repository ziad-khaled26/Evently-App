import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/event_item.dart';
import 'package:evently_app/firebase/firebase_service.dart';
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
    var appLocalizations = AppLocalizations.of(context);

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
              FutureBuilder(
                future: FirebaseService.getFavouriteEvents(context),
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  List<EventModel> favouriteEvents=snapshot.data??[];
                  return Expanded(child: ListView.separated(
                      itemBuilder: (context,index)=>
                      EventItem(event: favouriteEvents[index], isFav: true),
                      separatorBuilder: (context,index)=>SizedBox(height: 16.h,),
                      itemCount: favouriteEvents.length
                  )
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
