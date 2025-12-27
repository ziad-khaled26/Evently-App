
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTabProvider extends ChangeNotifier{
   Location location=Location();
   Set<Marker> markers={};
   MapTabProvider(){
     print("ana da5alt el stream");
     print("ana da5alt el stream");


   }

   GoogleMapController? mapController;
   StreamSubscription<LocationData>? locationStream;
   CameraPosition cameraPosition=CameraPosition(
       target: LatLng(37.43296265331129, -122.08832357078792),
     zoom: 17,

   );

   Future<bool> _getLocationPermission()async{
    PermissionStatus permissionStatus=await location.hasPermission();
    if(permissionStatus==PermissionStatus.denied){
      permissionStatus=await location.requestPermission();

    }
    return permissionStatus==PermissionStatus.granted;
  }

   Future<bool> _checkLocationServices()async{
    bool isLocationServicesEnabled=await location.serviceEnabled();
    if(!isLocationServicesEnabled){
      isLocationServicesEnabled=await location.requestService();
    }
    return isLocationServicesEnabled;
  }

   Future<void> getUserLocation()async{
     bool isLocationServicesEnabled=await _checkLocationServices();
    if(!isLocationServicesEnabled) return;


    //check if location permission is granted(اتوافق عليه)
    bool permissionGranted=await _getLocationPermission();
    if(!permissionGranted) return;

    LocationData locationData=await location.getLocation();
    changeLocationOnMap(locationData);
     setLocationListener();

  }

  Future<void> changeLocationOnMap(LocationData locationData)async{
    cameraPosition=CameraPosition(
        target: LatLng(locationData.latitude??0, locationData.longitude??0),
        zoom: 17
    );
    markers.removeWhere((marker)=> marker.markerId.value=="1");
    Marker marker=Marker(
        markerId: MarkerId("1"),
        position: LatLng(locationData.latitude??0, locationData.longitude??0),
        infoWindow: InfoWindow(
            title: "My Location",
            snippet: "this is marker no.1"
        )
    );
    markers.add(marker);
    notifyListeners();
    await mapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition),duration: Duration(seconds: 1));

  }

  setLocationListener(){
     if(!hasListeners) return;
    locationStream=location.onLocationChanged.listen((newLocation){
       // if(!hasListeners) return;
      log("ana da5alt el stream");

      changeLocationOnMap(newLocation);
     },);
  }



  @override
  void dispose() async{
    mapController?.dispose();
    await locationStream?.cancel();
    super.dispose();
  }
}