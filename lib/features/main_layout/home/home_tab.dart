import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/custom_tab_item.dart';
import 'package:evently_app/core/widgets/event_item.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late CategoryModel selectedCategory=CategoryModel.getCategoriesWithAll(context)[0];

  @override
  void initState() {
    super.initState();
    // getEvents();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome Back ✨",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                        Text(
                          "${UserModel.currentUser!.name} ✨",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineLarge,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            SizedBox(width: 4.w),
                            Text(
                              "Cairo, Egypt",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headlineMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.light_mode_outlined),
                    Card(
                      color: themeProvider.isDarkEnabled
                          ? ColorsManager.ofWhite
                          : ColorsManager.white,
                      child: Padding(
                        padding: REdgeInsets.all(8.0),
                        child: Text(
                          "En",
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              CustomTabBar(
                categories: CategoryModel.getCategoriesWithAll(context),
                selectedBgColor: ColorsManager.white,
                unSelectedBgColor: Colors.transparent,
                selectedForegroundColor: ColorsManager.blue,
                unSelectedForegroundColor: ColorsManager.white,
                onCategoryItemSelected: (category){
                  selectedCategory=category;
                  setState(() {

                  });
                },
              ),
            ],
          ),
        ),
        // Expanded(
        //     child: eventsList.isEmpty ? Center(child: CircularProgressIndicator()) :
        //     ListView.separated(
        //         itemBuilder:(context,index)=>EventItem(event: eventsList[index]),
        //         separatorBuilder: (context,index)=>SizedBox(height: 16.h,),
        //         itemCount: eventsList.length
        //     )
        // )
        // FutureBuilder(
        //     future: FirebaseService.getEventsFromFireStore(context,selectedCategory),
        //     builder: (context, snapShot) {
        //       if (snapShot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //       if (snapShot.hasError) {
        //         return Center(child: Text(snapShot.error.toString()));
        //       }
        //       List<EventModel> events = snapShot.data ?? [];
        //       return Expanded(child: ListView.separated(
        //           itemBuilder: (context,index)=>EventItem(event: events[index]),
        //           separatorBuilder: (context,index)=>SizedBox(height: 16.h,),
        //           itemCount: events.length));
        //     }
        // ),
        StreamBuilder(
            stream: FirebaseService.getEventsWithRealTimeUpdates(context,selectedCategory),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapShot.hasError) {
                return Center(child: Text(snapShot.error.toString()));
              }
              List<EventModel> events = snapShot.data ?? [];
              return Expanded(child: ListView.separated(
                  itemBuilder: (context,index)=>EventItem(event: events[index],isFav: UserModel.currentUser!.favouriteEventsIds.contains(events[index].id),),
                  separatorBuilder: (context,index)=>SizedBox(height: 16.h,),
                  itemCount: events.length));
            }
        ),
      ],
    );
  }

// getEvents() async {
//   eventsList = await FirebaseService.getEventsFromFireStore(context);
//   setState(() {
//
//   });
// }
}
