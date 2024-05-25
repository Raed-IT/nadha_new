import 'package:delevary/app/Components/AppBarComponents/AppBarComponent.dart';
import 'package:delevary/app/Screens/LunchUrlScreen/LunchUrlScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Route/Routs.dart';

class LunchUrlScreen extends GetView<LunchUrlScreenController> {
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
                repeat: ImageRepeat.repeat,
                image: AssetImage('assets/images/bg.png'),
              ),
            ),
          ).animate().blur(
                delay: 50.ms,
                begin: const Offset(20, 20),
                duration: 1500.ms,
              ),
          Column(
            children: [
              AppBarComponent(
                openDrawer: () {
                  Scaffold.of(context).openDrawer();
                },
                title: "عرض الرابط",
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => launchUrl(Uri.parse(controller.url)),
                      child: Text(
                        "متابعة الى الرابط",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    10.verticalSpace,
                    TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(controller.url));
                        },
                        child: Text(controller.url)),
                    30.verticalSpace,
                    MaterialButton(
                      height: 40.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.sp)),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () => Get.offAllNamed(AppRoutes.homeScreen),
                      child: Text(
                        "العودة الى الصفحة الرئيسية",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
