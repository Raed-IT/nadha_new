import 'package:delevary/app/Screens/SplashScreen/SplashController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.07,
              filterQuality: FilterQuality.high,
              image: AssetImage('assets/images/bg.png'),
              repeat: ImageRepeat.repeat,
            ),
          ),
        ).animate().blur(begin: Offset(20, 20), duration: Duration(seconds: 2)),
        Positioned(
          top: -100.sp,
          right: -100.sp,
          child: Container(
            height: 250.sp,
            width: 250.sp,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(1000)),
          ).animate().scale(
                begin: Offset(0, 0),
                duration: const Duration(milliseconds: 300),
              ),
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/logo.png",
            width: 450.w,
            height: 250.h,
          ),
        ).animate().slideY(
              begin: 1,
              duration: const Duration(milliseconds: 500),
            ),
        Positioned(
          bottom: -200.sp,
          left: -200.sp,
          child: Container(
            height: 450.sp,
            width: 450.sp,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(1000)),
          ).animate().scale(
                begin: Offset(0, 0),
                duration: const Duration(milliseconds: 500),
              ),
        )
      ],
    ));
  }
}
