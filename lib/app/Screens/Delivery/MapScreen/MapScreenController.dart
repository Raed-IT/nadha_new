import 'package:delevary/app/Screens/AddressesScreens/Components/MarkerComponent.dart';
import 'package:delevary/app/Services/LocationService.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/Services/UI/ToastService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
 import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class MapScreenController extends GetxController {
  LatLng latLng = Get.arguments['latlong'];
  late CameraPosition initialCameraPosition;
  RxList<Marker> marker = RxList([]);
  Rxn<LocationData>  location=Rxn();

  @override
  void onInit() {
    super.onInit();
    initialCameraPosition = CameraPosition(target: latLng, zoom: 18);
    addMarkers();
  }

  openGoogleMaP() {
    launch(
        "https://www.google.com/maps/dir/?api=1&origin=${location.value!.latitude},${location.value!.longitude}&destination=${latLng.latitude},${latLng.longitude}&travelmode=driving&dir_action=navigate");
  }

  getCurrentLocation(BuildContext context) async {
    LocationService locationService = LocationService();
    OverlayLoaderService.show(context);
    location.value = await locationService.getLocation();
    OverlayLoaderService.hide();
    if (location.value != null) {
      addMarkers(
          currentLatLng: LatLng(location.value!.latitude!, location.value!.longitude!));
    } else {
      ToastService.showErrorToast(
          context: context, title: "فشل في الحصول على موقعك حاول مجددا");
    }
  }

  void addMarkers({LatLng? currentLatLng}) async {
    Marker currentMarker = Marker(
      markerId: MarkerId("user${currentLatLng?.longitude ?? ''}"),
      position: currentLatLng ?? latLng,
      icon: await MarkerComponent().toBitmapDescriptor(
        logicalSize: Size(150.sp, 150.sp),
        imageSize: Size(150.sp, 150.sp),
      ),
    );
    marker.add(currentMarker);
  }
}
