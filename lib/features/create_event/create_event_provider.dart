import 'package:evently_app/features/create_event/widgets/show_image_category.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../core/utils/ui_utils.dart';
import '../../firebase/firebase_service.dart';
import '../../models/category_model.dart';
import '../../models/event_model.dart';
import '../../models/user_model.dart';

class CreateEventProvider extends ChangeNotifier {
  CreateEventProvider() {}

  //for choose event Location
  Location location = Location();
  Set<Marker> markers = {};
  late GoogleMapController? mapController;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 17,
  );

  LatLng? eventLocation;
  String? country;
  String? city;

  Future<bool> _getLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkLocationServices() async {
    bool isLocationServicesEnabled = await location.serviceEnabled();
    if (!isLocationServicesEnabled) {
      isLocationServicesEnabled = await location.requestService();
    }
    return isLocationServicesEnabled;
  }

  Future<void> getUserLocation() async {
    bool isLocationServicesEnabled = await _checkLocationServices();
    if (!isLocationServicesEnabled) return;

    //check if location permission is granted(اتوافق عليه)
    bool permissionGranted = await _getLocationPermission();
    if (!permissionGranted) return;

    LocationData locationData = await location.getLocation();
    changeLocationOnMap(locationData);
  }

  Future<void> changeLocationOnMap(LocationData locationData) async {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 17,
    );
    Marker marker = Marker(
      markerId: MarkerId("1"),
      position: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      infoWindow: InfoWindow(
        title: "My Location",
        snippet: "this is marker no.1",
      ),
    );
    markers.removeWhere((marker)=>marker.markerId.value=="1");
    markers.add(marker);
    notifyListeners();
    await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
      duration: Duration(seconds: 1),
    );
  }

  void changeEventLocation(LatLng newLocation) {
    markers.removeWhere((marker)=>marker.markerId.value=="1");
    markers.add(Marker(markerId: MarkerId("1"), position: newLocation));
    eventLocation = newLocation;
    notifyListeners();
  }

  Future<void> convertLatLngForEvent() async {
    if (eventLocation == null) return;
    List<geocoding.Placemark> placeMarks = await geocoding
        .placemarkFromCoordinates(
          eventLocation!.latitude,
          eventLocation!.longitude,
        );
    if(placeMarks.isNotEmpty){
      country = placeMarks.first.country??"unKnown";
      city = placeMarks.first.locality??"unKnown";
    }
    notifyListeners();
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ShowImageCategoryState> showImageStateKey =
      GlobalKey<ShowImageCategoryState>();

  late CategoryModel currentCategory;

  void getSelectedCategory(BuildContext context) {
    currentCategory = CategoryModel.getCategories(context)[0];
  }

  void selectEventDate(BuildContext context) async {
    selectedDate =
        await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        ) ??
        selectedDate;
    selectedDate = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );
    notifyListeners();
  }

  void selectEventTime(BuildContext context) async {
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
        selectedTime;
    selectedDate = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );
    notifyListeners();
  }

  void addEvent(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    UIUtils.showLoadingDialog(context);
    await FirebaseService.addEventToFirestore(
      EventModel(
        id: "",
        ownerId: UserModel.currentUser!.id,
        category: currentCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate,
      ),
      context,
    );
    UIUtils.hideLoadingDialog(context);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    mapController?.dispose();
    super.dispose();
  }
}
