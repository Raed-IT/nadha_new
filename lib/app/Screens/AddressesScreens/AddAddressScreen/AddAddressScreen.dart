import 'package:delevary/app/Screens/AddressesScreens/AddAddressScreen/AddAddressScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../components/TextFieldComponent.dart';

class AddAddressScreen extends GetView<AddAddressScreenController> {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
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
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Obx(
            () => GoogleMap(
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
        minHeight: 60.h,
        parallaxEnabled: true,
        defaultPanelState: PanelState.CLOSED,
        collapsed: Material(
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