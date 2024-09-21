import 'package:delevary/app/Components/v2/app_bar_compionent/app_bar_with_logo.dart';
import 'package:delevary/app/Components/v2/google_button_component.dart';
import 'package:delevary/app/Components/v2/primary_button.dart';
import 'package:delevary/app/Components/v2/text_field_component.dart';
import 'package:delevary/app/Extiontions/isEmail.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/AuthScreens/LoginScreen/LoginScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool check = RxBool(false);
    controller.keyboardVisible.value =
        MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics( ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBarWithLogoComponent(),
                64.verticalSpace,
                Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w800),
                ),
                10.verticalSpace,
                Text(
                  "الرجاء إدخال بياناتك للمتابعة",
                  style: TextStyle(fontSize: 17.sp),
                ),
                40.verticalSpace,
                TextFieldComponentV2(
                  isRequired: true,
                  controller: controller.emailTextController,
                  hint: "الإيميل",
                  validator: (data) {
                    if (data!.isEmpty || data.length < 3) {
                      return "اكتب الاسم بشكل صحيح يجب ان يكون اكثر من 3 احرف";
                    } else if (!data.isValidEmail()) {
                      return "الرجاء ادخال إيميل ";
                    }
                    return null;
                  },
                ),
                TextFieldComponentV2(
                  isPassword: true,
                  isRequired: true,
                  controller: controller.passwordTextController,
                  hint: "كلمة المرور",
                  validator: (data) {
                    if (data!.isEmpty || data.length < 3) {
                      return "اقل عدد احرف لكلمة السر 8";
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () {
                            return Checkbox(
                              value: check.value,
                              onChanged: (va) => check.value = va ?? false,
                            );
                          },
                        ),
                        Text(
                          "تذكرني",
                          style: TextStyle(color: Colors.black38),
                        ),
                      ],
                    ),
                    Text(
                      "نسيت كلمة المرور",
                      style: TextStyle(color: Colors.black38),
                    )
                  ],
                ),
                45.verticalSpace,
                PrimaryButtonComponent(
                  label: "تسجيل الدخول",
                  onTap: () {
                    controller.login(context: context);
                  },
                ),
                40.verticalSpace,
                Stack(
                  children: [
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.sp),
                          color: Theme.of(context).colorScheme.background,
                          child: const Center(
                            child: Text("أو المتابعة باستخدام"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                14.verticalSpace,
                GoogleButtonComponent(
                  onCompleted: () {
                    Get.offAllNamed(AppRoutes.homeScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
