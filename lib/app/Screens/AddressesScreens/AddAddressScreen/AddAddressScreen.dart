import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Screens/AddressesScreens/AddAddressScreen/AddAddressScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../Components/DrawerComponents/DrawerComponent.dart';
import '../../../Components/TextFieldComponent.dart';
import '../../../Services/UI/OverlayLoaderService.dart';

class AddAddressScreen extends GetView<AddAddressScreenController> {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {

Loader.hide();
    return Scaffold(
      bottomSheet: Stack(
        children: [
          Builder(
            builder: (context) => Container(
              height: Get.height,
              color: Theme.of(context).colorScheme.background,
              child: Stack(
                children: [
                  Obx(() => GoogleMap(
                        markers: controller.marker.toSet(),
                        onMapCreated: (cont) {
                          controller.mapController = cont;
                        },
                        onLongPress: (latLong) {
                          controller.addMarker(latLong);
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(37.42796133580664, -122.085749655962),
                          zoom: 15,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 50.sp, horizontal: 10.sp),
                    child: BlurryContainer(
                      borderRadius: BorderRadius.circular(10.sp),
                      width: Get.width,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'إضافة عنوان ',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          10.verticalSpace,
                          Text(
                            'اضغط مطولا على المكان الذي تريب اختيارة لوضع علامة على الخريطة',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          10.verticalSpace,
                        ],
                      ),
                    ),
                  ).animate().slideY(duration: 500.ms, begin: 1).fadeIn(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              controller: controller.draggableScrollableController,
              snap: true,
              initialChildSize: 0.1,
              maxChildSize: 0.5,
              minChildSize: .1,
              builder: (context, scroll) {
                return Form(
                  key: controller.formKey,
                  child: Card(
                    child: SingleChildScrollView(
                      controller: scroll,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.all(10.sp),
                              height: 5.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(1000),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.treggerBottomSheet(),
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
                                  validator: (data){
                                    if (data!.isEmpty){
                                      return "اسم العنوان مطلوب";
                                    }
                                    return null;
                                  },
                                ),
                                TextFieldComponent(
                                  controller: controller.addressInfoController,
                                  isMultiple: true,
                                  hint: 'وصف العنوان ',
                                  validator: (data){
                                    if (data!.isEmpty){
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
                                    onPressed: () =>
                                        controller.addAddress(context),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                    ),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    child: Text(
                                      "إضافة  العنوان",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerComponent(),
    );
  }
}
