import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Components/v2/app_bar_compionent/app_bar_with_logo.dart';
import 'package:delevary/app/Components/v2/google_button_component.dart';
import 'package:delevary/app/Components/v2/primary_button.dart';
import 'package:delevary/app/Components/v2/text_field_component.dart';
import 'package:delevary/app/Extiontions/isEmail.dart';
import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/Components/OptionsComponent.dart';
import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/Components/UserInfoComponent.dart';
import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/RegisterScreenController.dart';
import 'package:delevary/app/Components/SafeAreaComponent.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Components/AppBarAuthComponent.dart';

class RegisterScreen extends GetView<RegisterScreenController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBarWithLogoComponent(),
                20.verticalSpace,
                Text(
                  "تسجيل الدخول",
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w800),
                ),
                10.verticalSpace,
                Text(
                  "الرجاء إدخال بياناتك للمتابعة",
                  style: TextStyle(fontSize: 17.sp),
                ),
                20.verticalSpace,
                TextFieldComponentV2(
                  isRequired: true,
                  controller: controller.nameTextController,
                  hint: "اسم المستخدم",
                  validator: (data) {
                    if (data!.isEmpty || data.length < 3) {
                      return "اكتب اسم المستخدم بشكل صحيح يجب ان يكون اكثر من 3 احرف";
                    }
                    return null;
                  },
                ),
                TextFieldComponentV2(
                  isRequired: true,
                  controller: controller.emailTextController,
                  hint: "البريد الإلكتروني ",
                  validator: (data) {
                    if (data!.isEmpty || data.length < 3) {
                      return "اكتب اسم المستخدم بشكل صحيح يجب ان يكون اكثر من 3 احرف";
                    } else if (!data.isValidEmail()) {
                      return "الرجاء ادخال إيميل ";
                    }
                    return null;
                  },
                ),
                TextFieldComponentV2(
                  isRequired: true,
                  controller: controller.phoneTextController,
                  hint: "رقم الموبايل",
                  validator: (data) {
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
                15.verticalSpace,
                PrimaryButtonComponent(
                  label: "متابعة",
                  onTap: () {
                    controller.register(context);
                  },
                ),
                30.verticalSpace,
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
                20.verticalSpace,
                Row(
                  children: [
                    Text("إذا كان لديك حساب بالفعل قم بتسجيل الدخول من  "),
                    GestureDetector(
                      onTap: ()=>Get.toNamed(AppRoutes.loginScreen),
                      child: Text(
                        "هنا ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ).animate().fadeIn(),
        ),
      ),
    );
  }
}
