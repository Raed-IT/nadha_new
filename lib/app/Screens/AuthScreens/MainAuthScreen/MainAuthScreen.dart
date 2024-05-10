import 'package:delevary/app/Screens/AuthScreens/MainAuthScreen/MainAuthController.dart';
import 'package:delevary/app/route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MainAuthScreen extends GetView<MainAuthScreenController> {
  const MainAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.1,
                filterQuality: FilterQuality.high,
                image: AssetImage('assets/images/bg.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ).animate().blur(
                begin: const Offset(20, 20),
                duration: const Duration(seconds: 2),
              ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                10.verticalSpace,
                50.verticalSpace,
                SvgPicture.asset(
                  "assets/svg/logo.svg",
                  height: 80.sp,
                ),
                Spacer(),
                Center(
                  child: Lottie.asset("assets/json/delevary_motor.json",
                      height: 200.sp),
                ).animate().slideX(duration: 2500.ms, curve: Curves.elasticOut),
                Spacer(),
                Center(
                  child: Text(
                    "الرجاء تسجيل الدخول للمتابعة",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp),
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: Get.width,
                        child: OutlinedButton(
                          onPressed: () => Get.toNamed(AppRoutes.loginScreen),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Icon(
                                FontAwesomeIcons.rightToBracket,
                                size: 25.sp,
                              ),
                              20.horizontalSpace,
                              Text(
                                "تسجيل الدخول ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      SizedBox(
                        height: 50.h,
                        width: Get.width,
                        child: OutlinedButton(
                          onPressed: () =>
                              Get.toNamed(AppRoutes.registerScreen),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Icon(
                                FontAwesomeIcons.idCard,
                                size: 25.sp,
                              ),
                              20.horizontalSpace,
                              Text(
                                " مستخدم جديد ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      SizedBox(
                        height: 50.h,
                        width: Get.width,
                        child: OutlinedButton(
                          onPressed: () => controller.loginWithGoogle(context),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Icon(
                                FontAwesomeIcons.google,
                                size: 25.sp,
                              ),
                              20.horizontalSpace,
                              Text(
                                "التسجيل باستخدام Google   ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      20.verticalSpace,
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
