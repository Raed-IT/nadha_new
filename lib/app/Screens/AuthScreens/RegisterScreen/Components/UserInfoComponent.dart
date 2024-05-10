import 'package:delevary/app/Extiontions/isEmail.dart';
import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/RegisterScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../Components/DropDwon.dart';
import '../../../../Data/MainController.dart';
import '../../../../components/TextFieldComponent.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';

class RegisterUserInfoComponent extends GetView<RegisterScreenController> {
  const RegisterUserInfoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          TextFieldComponent(
            isRequired: true,
            controller: controller.nameTextController,
            hint: "اسم المستخدم",
            // label: "اسم المستخدم",
            validator: (data) {
              if (data!.isEmpty || data.length < 3) {
                return "اكتب الاسم بشكل صحيح يجب ان يكون اكثر من 3 احرف";
              }
              return null;
            },
          ),
          15.verticalSpace,
          DropDownComponent<CityModel>(
            initVal: controller.currentCity,
            hintText: "اختر المدينة",
            items: Get.find<MainController>().cities,
            onSelected: (city) => controller.currentCity = city,
          ),
          TextFieldComponent(
            isRequired: true,
            controller: controller.emailTextController,
            hint: "ادخل إيميلك",
            // label: "اسم المستخدم",
            validator: (data) {
              if (data!.isEmpty || data.length < 3) {
                return "الإيميل مطلوب ";
              } else if (!data.isValidEmail()) {
                return "الرجاء ادخال إيميل ";
              }
              return null;
            },
          ),
          TextFieldComponent(
            isPassword: true,
            isRequired: true,
            controller: controller.passwordTextController,
            hint: "كلمة السر",
            // label: "كلمة السر ",
            validator: (data) {
              if (data!.isEmpty || data.length < 8) {
                return "اقل عدد احرف لكلمة السر 8";
              }
              return null;
            },
          ),
          15.verticalSpace,
          SizedBox(
            width: Get.width,
            height: 60.h,
            child: FilledButton.tonal(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.sp),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  Future.delayed(const Duration(milliseconds: 500),
                      () => controller.currentWidget.value = 1);
                } else {
                  Fluttertoast.showToast(msg: "الرجاء ملء جميع الحقول ");
                }
              },
              child: Text(
                "الــتــالــي ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
          ),
          if (!controller.keyboardVisible.value) 25.verticalSpace,
          if (!controller.keyboardVisible.value)
            SizedBox(
              width: Get.width,
              height: 60.h,
              child: FilledButton.tonal(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.sp),
                      ),
                    ),
                  ),
                ),
                onPressed: () => controller.loginWithGoogle(context),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.google,
                      size: 20.sp,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    10.horizontalSpace,
                    Text(
                      " التسجيل باستخدام Google",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.background),
                    )
                  ],
                ),
              ).animate(),
            ),
        ],
      ),
    );
  }
}
