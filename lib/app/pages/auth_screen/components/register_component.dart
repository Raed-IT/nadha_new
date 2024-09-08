import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:get/get.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/data/model/city_model.dart';
import 'package:nadha/app/pages/auth_screen/auth_controller.dart';
import 'package:nadha/app/pages/auth_screen/components/googl_button.dart';
import 'package:nadha/app/pages/components/text_field_component.dart';
import 'package:nadha/app/them/app_colors.dart';

class RegisterComponent extends GetView<AuthScreenController> {
  const RegisterComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
        color: AppColors.scaffold,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Form(
        key: controller.registerKey,
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildTextFieldComponent(
                controller: controller.registerName,
                hint: 'الاسم ',
                validator: (data) {
                  if (data!.isEmpty) {
                    return "الاسم مطلوب";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              BuildTextFieldComponent(
                controller: controller.registerUserName,
                hint: 'اسم المستخدم',
                validator: (data) {
                  if (data!.isEmpty) {
                    return "اسم المستخدم مطلوب";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              BuildTextFieldComponent(
                controller: controller.registerEmail,
                hint: 'البريد الاكتروني ',
                validator: (data) {
                  if (data!.isEmpty) {
                    return "البريد الاكتروني مطلوب";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              BuildTextFieldComponent(
                isPassword: true,
                controller: controller.registerPassword,
                hint: 'كلمه السر',
                validator: (data) {
                  if (data!.isEmpty) {
                    return "كلمة السر مطلوبة";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              BuildTextFieldComponent(
                controller: controller.registerWats,
                hint: 'رقم الواتساب  ',
                validator: (data) {
                  if (data!.isEmpty) {
                    return "رقم الواتساب مطلوب";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  color: AppColors.fill,
                ),
                child: Obx(
                  () => DropdownButton<CityModel>(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    focusColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: Get.find<MainController>()
                        .cities
                        .map<DropdownMenuItem<CityModel>>((CityModel city) {
                      return DropdownMenuItem<CityModel>(
                        value: city,
                        child: Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Text(
                            "${city.name}",
                            style: const TextStyle(color: AppColors.dark),
                          ),
                        ),
                      );
                    }).toList(),
                    underline: Container(),
                    icon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
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
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () => controller.register(),
                child: Container(
                  width: Get.width,
                  height: 55.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.sp),
                      ),
                      color: AppColors.warning),
                  child: Center(
                    child: Text(
                      "تسجيل الدخول ",
                      style:
                          TextStyle(color: AppColors.scaffold, fontSize: 17.sp),
                    ),
                  ),
                ),
              ),
              GoogleButtonComponent()
            ],
          ),
        ),
      ),
    );
  }
}
