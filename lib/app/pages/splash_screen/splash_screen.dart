import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nadha/app/pages/splash_screen/splash_controller.dart';
import 'package:nadha/app/them/app_colors.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(1, 0.8),
                colors: AppColors.mainGradient,
                tileMode: TileMode.mirror,
              ),
            ),
          ),
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              "assets/images/App-home.png",
              fit: BoxFit.cover,
              height: Get.height,
              width: Get.width,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/logo.svg",
                  width: 200.w,
                  color: AppColors.scaffold,
                ),
                SizedBox(
                  height: 70.h,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isLoad.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "يتم تحميل البيانات",
                          style: TextStyle(fontSize: 17.sp),
                        )
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: !controller.isLoad.value,
                    child: GestureDetector(
                      onTap: () => controller.getData(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: Icon(Icons.refresh),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "اعادة تحميل البيانات",
                            style: TextStyle(fontSize: 17.sp),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
              .animate()
              .slideY(begin: 1, duration: const Duration(milliseconds: 700))
              .shimmer(
                  duration: const Duration(seconds: 1),
                  color: Colors.white,
                  delay: const Duration(milliseconds: 800),
                  colors: [AppColors.scaffold, AppColors.warning]),
        ],
      ),
    );
  }
}
