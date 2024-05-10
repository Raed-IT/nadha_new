import 'package:auto_size_text/auto_size_text.dart';
import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/Components/OptionsComponent.dart';
import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/Components/UserInfoComponent.dart';
import 'package:delevary/app/Screens/AuthScreens/RegisterScreen/RegisterScreenController.dart';
import 'package:delevary/app/components/SafeAreaComponent.dart';
import 'package:delevary/app/route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Components/AppBarAuthComponent.dart';

class RegisterScreen extends GetView<RegisterScreenController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                              Get.offNamed(AppRoutes.loginScreen),
                          title: 'تسجيل الدخول ',
                        ),
                      if (!controller.keyboardVisible.value)
                        SizedBox(
                          width: Get.width,
                          child: AutoSizeText(
                            "تسجيل مستخدم جديد ",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 35.sp,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ).animate().slideY(begin: 1),
                        ),
                      if (!controller.keyboardVisible.value) 10.verticalSpace,
                      if (!controller.keyboardVisible.value)
                        Text(
                          "مرحبًا بك في منصة تسوقي \n قم بتسجيل حساب مستخدم جديد واستمتع بخدماتنا  اذا كان لديك حساب بافعل فقم بتسجيل الدخول \n",
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          textAlign: TextAlign.justify,
                        ).animate().slideY(begin: 1),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: SizedBox(
                  width: Get.width,
                  height: 50.h,
                  child: MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp)),
                    color: Theme.of(context).colorScheme.background,
                    onPressed: () => Get.offNamed(AppRoutes.loginScreen),
                    child: Text(
                      " تسجيل الدخول",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ).animate().slideY(begin: 1, duration: 500.ms),
              ),
              10.verticalSpace,
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
                      child: Obx(() {
                        Widget currentWidget =
                            const RegisterUserInfoComponent();
                        if (controller.currentWidget.value == 0) {
                          currentWidget = const RegisterUserInfoComponent();
                        } else {
                          currentWidget = const RegisterOptionsComponent();
                        }
                        return AnimatedSwitcher(
                          transitionBuilder:
                              (Widget child, Animation<double> animation) =>
                                  SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(-1, 0),
                                    end: Offset.zero)
                                .animate(animation),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          ),
                          duration: const Duration(milliseconds: 100),
                          child: currentWidget,
                        );
                      }),
                    ),
                  ),
                ).animate().slideY(
                      begin: 1,
                      duration: const Duration(milliseconds: 500),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
