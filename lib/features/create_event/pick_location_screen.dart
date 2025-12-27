
import 'dart:developer';

import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/features/create_event/create_event_provider.dart';
import 'package:evently_app/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickLocationScreen extends StatelessWidget {
  PickLocationScreen({super.key,required this.createEventProvider}){
    createEventProvider.getUserLocation();
  }

  final CreateEventProvider createEventProvider;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations=AppLocalizations.of(context)!;
    return ChangeNotifierProvider.value(
      value: createEventProvider,
      child: Scaffold(
        body: Column(
          children: [
            Consumer<CreateEventProvider>(
              builder: (con,createEventProvider,_)=>
                  Expanded(
                    child: GoogleMap(
                      markers: createEventProvider.markers,
                      zoomControlsEnabled: false,
                      initialCameraPosition: createEventProvider.cameraPosition,
                      mapType: MapType.normal,
                      onMapCreated: (googleMapController){
                        createEventProvider.mapController=googleMapController;
                      },
                      onTap: (latLang){
                        createEventProvider.changeEventLocation(latLang);
                        createEventProvider.convertLatLngForEvent();
                        },
                    ),
                  ),
            ),
            Container(
              padding: REdgeInsets.all(16),
              width: double.infinity,
              color: ColorsManager.blue,
              child: Center(
                  child: Text(
                    appLocalizations.tap_on_location_to_select,
                    style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.white
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
