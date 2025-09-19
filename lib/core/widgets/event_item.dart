import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventItem extends StatefulWidget {
   EventItem({super.key, this.isNotSelected=true,required this.event});
   bool isNotSelected;
   final EventModel event;

   @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 8,vertical: 8 ),
      margin: REdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 204.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.event.category.imagePath),
          fit: BoxFit.fill
        ),
        border: Border.all(
          color: ColorsManager.blue,
          width: 1

        ),
        borderRadius: BorderRadius.circular(16.r)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                      "21",
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.blue
                    ),
                  ),
                  Text(
                      "Nov",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.blue
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(
          ),
          Card(

            child: Padding(
              padding:  REdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(

                    child: Text(
                      widget.event.description,
                      style: Theme.of(context).textTheme.displaySmall
                    ),
                  ),
                   IconButton(onPressed: _onPrees,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    maxWidth: 24,
                    maxHeight: 24
                  ),
                  icon: Icon(widget.isNotSelected ?Icons.favorite_border:Icons.favorite,color: ColorsManager.blue,),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onPrees(){
    setState(() {
      widget.isNotSelected=! widget.isNotSelected;
      print(widget.isNotSelected);
    });
  }
}
