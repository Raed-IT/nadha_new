import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:delevary/app/Components/TextFieldComponent.dart';
import 'package:delevary/app/Screens/ProfileScreen/ProfileScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Components/DropDwon.dart';
import '../../../Data/MainController.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';

class UserProfileFieldsComponent extends GetView<ProfileScreenController> {
  const UserProfileFieldsComponent({super.key});

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
            TextFieldComponent(
              controller: controller.nameTextController,
              hint: "اسم المستخدم",
              label: "اسم المستخدم",
            ),
            TextFieldComponent(
              controller: controller.phoneTextController,
              hint: "رقم الهاتف",
              label: "رقم الهاتف",
            ),
            TextFieldComponent(
              controller: controller.bioTextController,
              hint: "لمحة عنك",
              label: "لمحة عنك",
              isMultiple: true,
            ),
            20.verticalSpace,
            Text(
              "اخترا المدينة",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropDownComponent<CityModel>(
              hintText: "اختر المدينة",
              items: Get.find<MainController>().cities,
              initVal: Get.find<MainController>().user.value?.city,
              onSelected: (item) {
                controller.city = item;
              },
            ),
            GestureDetector(
              onTap: () => controller.updateUserProfiled(context),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.h),
                height: 40.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Center(
                  child: Text(
                    "حفظ بيانات المستخدم",
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
