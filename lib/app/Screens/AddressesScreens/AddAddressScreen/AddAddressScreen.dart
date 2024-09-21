import 'package:delevary/app/Screens/AddressesScreens/AddAddressScreen/AddAddressScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../Components/TextFieldComponent.dart';

class AddAddressScreen extends GetView<AddAddressScreenController> {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        borderRadius: BorderRadius.circular(15.sp),
        margin: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 15.sp),
        panelBuilder: () => Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 15.h),
                    height: 5.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  ),
                ),
                GestureDetector(
                  child: const Text(
                    "بيانات العنوان",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    children: [
                      TextFieldComponent(
                        controller: controller.addressNameController,
                        hint: 'اسم العنوان',
                        validator: (data) {
                          if (data!.isEmpty) {
                            return "اسم العنوان مطلوب";
                          }
                          return null;
                        },
                      ),
                      TextFieldComponent(
                        controller: controller.addressInfoController,
                        isMultiple: true,
                        maxLines: 8,
                        hint: 'وصف العنوان ',
                        validator: (data) {
                          if (data!.isEmpty) {
                            return "وصف العنوان مطلوب";
                          }
                          return null;
                        },
                      ),
                      20.verticalSpace,
                      SizedBox(
                        width: Get.width,
                        height: 45.h,
                        child: MaterialButton(
                          onPressed: () => controller.addAddress(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          color: Theme.of(context).colorScheme.primary,
                          child: Text(
                            "إضافة  العنوان",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: Obx(
                () => GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(36.002632, 36.667849),
                    zoom: 14,
                  ),
                  markers: controller.marker.toSet(),
                  onMapCreated: (GoogleMapController cont) {
                    controller.mapController = cont;
                  },
                  onLongPress: (latLong) {
                    controller.addMarker(latLong);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: 200.w,
                        child: const Card(
                          child: Center(
                            child: Text("اضغط مطولا لاضافة عنوانك"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.myLocation(context),
                        child: SizedBox(
                          height: 50.h,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.locationCrosshairs),
                                  10.horizontalSpace,
                                  Text("اختيار موقعي")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate().slideY(),
                ),
              ),
            )
          ],
        ),
        minHeight: 60.h,
        parallaxEnabled: true,
        defaultPanelState: PanelState.CLOSED,
        collapsed: ClipRRect(
          borderRadius: BorderRadius.circular(20.sp),
          child: GestureDetector(
            onTap: () => controller.panelController.open(),
            child: Container(
              color: Theme.of(context).colorScheme.background,
              width: Get.width,
              height: 100.h,
              child: const Center(
                child: Text(
                  "إضغط لإضافة عنوان",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        controller: controller.panelController,
      ),
    );
  }
}
