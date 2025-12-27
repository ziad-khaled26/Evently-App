import 'dart:developer';

import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/features/main_layout/map/map_tab_provider.dart';
import 'package:evently_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {

  late MapTabProvider provider=context.read<MapTabProvider>();
  @override
  void initState() {
    super.initState();
   provider.getUserLocation();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<MapTabProvider>(
      builder: (context,provider,_)=> Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: provider.cameraPosition,
                markers: provider.markers,
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                onMapCreated: (controller) {
                  provider.mapController = controller;
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorsManager.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          onPressed: () async{
            await provider.getUserLocation();

          },
          child: Icon(
            Icons.gps_fixed_rounded,
            size: 26,
            color: Theme.of(context).cardColor,
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
  @override
  void dispose() {
    provider.locationStream?.cancel();
    log("el stream canceled");
    super.dispose();
  }
}
