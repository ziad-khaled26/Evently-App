import 'package:evently_app/features/create_event/create_event_provider.dart';
import 'package:evently_app/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/colors_manager.dart';
import '../../../core/routes_manager.dart';

class PickLocationButton extends StatelessWidget {
  const PickLocationButton({super.key, required this.createEventProvider});

  final CreateEventProvider createEventProvider;

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: REdgeInsets.all(8),
        side: BorderSide(color: ColorsManager.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, RoutesManager.pickLocationScreen,
            arguments: createEventProvider);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8.w,

            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorsManager.blue,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.all(12.r),
                child: Icon(
                  Icons.gps_fixed_rounded,
                  color: ColorsManager.white,
                ),
              ),
              Text(
                createEventProvider.eventLocation == null ?
                appLocalizations!.choose_event_location :"${ createEventProvider.city},${createEventProvider.country}"
                ,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.blue,
                ),
              )
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: ColorsManager.blue),
        ],
      ),
    );
  }
}
