import 'package:delevary/app/Extiontions/isEmail.dart';
import 'package:delevary/app/Screens/AuthScreens/LoginScreen/LoginScreenController.dart';
import 'package:delevary/app/Services/UI/OverlayLoaderService.dart';
import 'package:delevary/app/components/TextFieldComponent.dart';
import 'package:delevary/app/components/SafeAreaComponent.dart';
import 'package:delevary/app/route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../Components/AppBarAuthComponent.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // OverlayLoaderService.hide();
    controller.keyboardVisible.value =
        MediaQuery.of(context).viewInsets.bottom != 0;
    return ColoredSafeArea(
      color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          height: Get.height,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!controller.keyboardVisible.value)
                        AppBarAuthComponent(
                          onAnotherTap: () =>
                              Get.offNamed(AppRoutes.registerScreen),
                          title: 'تسجيل جديد ',
                        ),
                      if (!controller.keyboardVisible.value)
                        Text(
                          "تسجيل الدخول  ",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 35.sp,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ).animate().slideY(begin: 1),
                      if (!controller.keyboardVisible.value) 10.verticalSpace,
                      if (!controller.keyboardVisible.value)
                        Text(
                          "مرحبًا بك في منصة تسوقي \n يُرجى تسجيل الدخول للمتابعة \n اذا لم يكن لديك حساب قم بالتسجيل .",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          textAlign: TextAlign.justify,
                        ).animate().slideY(begin: 1),
                      20.verticalSpace,
                      SizedBox(
                        width: Get.width,
                        height: 50.h,
                        child: MaterialButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp)),
                          color: Theme.of(context).colorScheme.background,
                          onPressed: () =>
                              Get.offNamed(AppRoutes.registerScreen),
                          child: Text(
                            " تسجيل مستخدم جديد",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ).animate().slideY(begin: 1, duration: 500.ms),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage("assets/images/bg.png"),
                        repeat: ImageRepeat.repeat,
                        opacity: 0.04),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.sp),
                      topLeft: Radius.circular(20.sp),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          TextFieldComponent(
                            isRequired: true,
                            controller: controller.emailTextController,
                            hint: "الإيميل ",
                            // label: "اسم المستخدم",
                            validator: (data) {
                              if (data!.isEmpty || data.length < 3) {
                                return "اكتب الاسم بشكل صحيح يجب ان يكون اكثر من 3 احرف";
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
                              if (data!.isEmpty || data.length < 3) {
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
                              onPressed: () =>
                                  controller.login(context: context),
                              child: Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                            ),
                          ),
                          if (!controller.keyboardVisible.value)
                            25.verticalSpace,
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
                                onPressed: () =>
                                    controller.loginWithGoogle(context),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.google,
                                      size: 20.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    10.horizontalSpace,
                                    Text(
                                      " تسجيل الدخول باستخدام غوغل",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                    )
                                  ],
                                ),
                              ),
                            ).animate().elevation(
                                  delay: Duration(milliseconds: 500),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.sp)),
                                  duration: Duration(milliseconds: 500),
                                ),
                        ],
                      ),
                    ),
                  ),
                ).animate().slideY(
                      begin: 1,
                      duration: Duration(milliseconds: 500),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
