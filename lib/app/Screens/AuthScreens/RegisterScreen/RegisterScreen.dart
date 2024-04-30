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
                        Text(
                          "ليس لديك حساب ؟!  \n قم بإنشاء حساب جديد",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 25.sp,
                            color: Theme.of(context).colorScheme.background,

                          ),
                        ).animate().slideY(begin: 1),
                      if (!controller.keyboardVisible.value) 10.verticalSpace,
                      if (!controller.keyboardVisible.value)
                        Text(
                          "مرحبًا بك في منصة تسوقي ! يُرجى انشائ حساب باستخدام بيانات حسابك للوصول إلى خدماتنا الرائعة وتجربة تسوق فريدة.",
                          style: TextStyle(fontSize: 15.sp,
                            color: Theme.of(context).colorScheme.background,

                          ),
                          textAlign: TextAlign.justify,
                        ).animate().slideY(begin: 1),
                    ],
                  ),
                ),
              ),
              50.verticalSpace,
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
