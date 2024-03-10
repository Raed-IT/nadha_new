import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Screens/AddressesScreens/Components/MarkerComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class AddAddressScreenController extends GetxController {
  TextEditingController addressNameController = TextEditingController();
  TextEditingController addressInfoController = TextEditingController();
  late GoogleMapController mapController;
  RxList<Marker> marker = RxList([]);
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  void addAddress() async {}

  void addMarker(LatLng latLng) async {
    marker.value = [];
    Marker currentMarker = Marker(
      markerId: MarkerId("user"),
      position: latLng,
      icon: await MarkerComponent().toBitmapDescriptor(
          logicalSize: const Size(150, 150), imageSize: const Size(150, 150)),
    );
    marker.add(currentMarker);
    Logger().w(marker.length);
  }

  void treggerBottomSheet() {
    if (draggableScrollableController.size > 0.3) {
      draggableScrollableController.animateTo(.08,
          duration: 500.ms, curve: Curves.linear);
    } else {
      draggableScrollableController.animateTo(.5,
          duration: 500.ms, curve: Curves.linear);
    }
  }
}
