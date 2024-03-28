import 'package:delevary/app/Screens/SplashScreen/SplashController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.07,
                filterQuality: FilterQuality.high,
                image: AssetImage('assets/images/bg.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ).animate().blur(
                begin: const Offset(20, 20),
                duration: 750.ms,
              ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset("assets/json/delevary_motor.json",
                        width: 280.w),
                  )
                      .animate()
                      .slideX(duration: 2500.ms, curve: Curves.elasticOut),
                  SvgPicture.asset(
                    "assets/svg/logo.svg",
                    width: 250.w,
                    height: 100.h,
                  ).animate().slideY(duration: 2100.ms, begin: 0.5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
