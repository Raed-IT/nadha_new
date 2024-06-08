import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/TextFieldComponent.dart';
import 'package:delevary/app/Screens/ProfileScreen/ProfileScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Components/DropDwon.dart';
import '../../../Components/ImagePickerComponent.dart';
import '../../../Data/MainController.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';

class StoreProfileFieldsComponent extends GetView<ProfileScreenController> {
  const StoreProfileFieldsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // OverlayLoaderService.hide();
    return Container(
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: BlurryContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImagePickerComponent(
              onPicked: (files) {
                if (files.isNotEmpty) {
                  controller.storeImage = files.first;
                } else {
                  controller.storeImage = null;
                }
              },
              image: Get.find<MainController>().user.value?.store?.image,
              title: Text(
                'صوره المتجر',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.sp),
              ),
            ),
            TextFieldComponent(
              controller: controller.storeNameTextController,
              hint: "اسم المتجر",
              label: "اسم المتجر",
            ),
            TextFieldComponent(
              controller: controller.storeInfoTextController,
              hint: "اكتب عن متجرك",
              label: "اكتب عن متجرك",
              isMultiple: true,
            ),
            TextFieldComponent(
              controller: controller.storeAddressTextController,
              hint: "عنوان متجرك",
              label: "عنوان متجرك لتسهيل الوصول اليك",
              isMultiple: true,
            ),
            20.verticalSpace,
            const Text(
              "اخترا المدينة",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropDownComponent<CityModel>(
              hintText: "اختر المدينة",
              items: Get.find<MainController>().cities,
              initVal: Get.find<MainController>().user.value?.store?.city,
              onSelected: (item) {
                controller.storeCity = item;
              },
            ),
            GestureDetector(
              onTap: () => controller.updateStoreProfiled(context),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.h),
                height: 40.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Center(
                  child: Text(
                    "حفظ بيانات المتجر",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
