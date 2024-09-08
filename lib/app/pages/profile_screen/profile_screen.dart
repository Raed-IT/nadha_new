import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/components/appbar.dart';
import 'package:nadha/app/pages/components/text_field_component.dart';
import 'package:nadha/app/pages/profile_screen/profile_controller%20.dart';
import 'package:nadha/app/them/app_colors.dart';

import '../../data/inital/main_controller.dart';
import '../../data/model/city_model.dart';
import '../components/bottom_nav_component.dart';
import '../components/drawer_component.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      endDrawer:   DrawerComponent(),
      bottomNavigationBar: BottomNavComponent(),
      body: Column(
        children: [
          const AppBarComponent(title: "الملف الشخصي"),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(18.sp),
              child: Column(
                children: [
                  BuildTextFieldComponent(
                      label: "الاسم الثلاثي",
                      controller: controller.nameTextController,
                      hint: "اسم الثلاثي"),
                  SizedBox(
                    height: 10.h,
                  ),
                  BuildTextFieldComponent(
                      label: "اسم المستخدم",
                      controller: controller.usernameTextController,
                      hint: "اسم المستخدم"),
                  SizedBox(
                    height: 10.h,
                  ),
                  BuildTextFieldComponent(
                      label: "الايميل",
                      controller: controller.emailTextController,
                      hint: "الايميل "),
                  SizedBox(
                    height: 10.h,
                  ),
                  BuildTextFieldComponent(
                      label: "رقم الواتس",
                      controller: controller.watsTextController,
                      hint: "رقم الواتس"),
                  SizedBox(
                    height: 10.h,
                  ),
                  BuildTextFieldComponent(
                      label: "كلمة السر",
                      isPassword: true,
                      controller: controller.passwordTextController,
                      hint: "كلمة السر "),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Text(
                          "اختر المدينة",
                          style: TextStyle(
                              color: AppColors.dark,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.sp)),
                          color: AppColors.fill,
                        ),
                        child: Obx(
                              () =>
                              DropdownButton<CityModel>(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                focusColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                iconEnabledColor: Colors.black,
                                items: Get
                                    .find<MainController>()
                                    .cities
                                    .map<DropdownMenuItem<CityModel>>((
                                    CityModel city) {
                                  return DropdownMenuItem<CityModel>(
                                    value: city,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.sp),
                                      child: Text(
                                        "${city.name}",
                                        style: const TextStyle(
                                            color: AppColors.dark),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                underline: Container(),
                                icon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: AppColors.dark.withOpacity(0.5),
                                  ),
                                ),
                                isExpanded: true,
                                hint: Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: const Text("الرجاء اختيار المدينة"),
                                ),
                                value: controller.selectedCity.value,
                                onChanged: (value) {
                                  controller.selectedCity.value = value;
                                },
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () => controller.save(),
                    child: Container(
                      height: 60.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: AppColors.warning,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.sp),
                          )),
                      child: Center(
                        child: Text(
                          "حفظ",
                          style: TextStyle(
                              fontSize: 20.sp, color: AppColors.scaffold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
