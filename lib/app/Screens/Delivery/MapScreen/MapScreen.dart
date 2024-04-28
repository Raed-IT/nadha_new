import 'package:delevary/app/Screens/Delivery/MapScreen/MapScreenController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends GetView<MapScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controller.location.value == null) {
            controller.getCurrentLocation(context);
          } else {
            controller.openGoogleMaP();
          }
        },
        label: Obx(() => (controller.location .value== null)
            ?const  Row(
                children: [Icon(Icons.map_outlined), Text("اختيار موقعي ")],
              )
            : const Row(
                children: [
                  Icon(FontAwesomeIcons.mapMarked),
                  Text("فتح خرائط غوغل")
                ],
              )),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Obx(
          () => GoogleMap(
            markers: controller.marker.toSet(),
            initialCameraPosition: controller.initialCameraPosition,
          ),
        ),
      ),
    );
  }
}
