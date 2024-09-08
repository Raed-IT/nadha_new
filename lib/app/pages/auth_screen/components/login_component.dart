import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/auth_screen/auth_controller.dart';
import 'package:nadha/app/pages/components/text_field_component.dart';

import '../../../them/app_colors.dart';
import 'googl_button.dart';

class LoginComponent extends GetView<AuthScreenController> {
  const LoginComponent({super.key});

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
        key: controller.loginKey,
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BuildTextFieldComponent(
                controller: controller.loginUserName,
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
                isPassword: true,
                controller: controller.loginPassword,
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("تذكرني"),
                    Text("هل نسيت كلمة المرور"),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => controller.login(),
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
              GoogleButtonComponent(showCityDialog: true,)
            ],
          ),
        ),
      ),
    );
  }
}
