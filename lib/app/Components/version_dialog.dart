import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Screens/HomeScreen/HomeScreenController.dart';

showVersionDialog(BuildContext context) async {
  await Future.delayed(
    5000.ms,
    () => Get.bottomSheet(
      WillPopScope(
        onWillPop: () {
          return Future(
              () => !Get.find<MainController>().setting.value!.forcedUpdate!);
        },
        child: SizedBox(
          height: 320.h,
          width: Get.width,
          child: Card(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -100.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    child:
                        Lottie.asset("assets/json/upgrade.json", height: 200.h),
                  ).animate().slideY(duration: 700.ms, begin: 1),
                ),
                Container(
                  margin: EdgeInsets.only(top: 90.h),
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            textAlign: TextAlign.center,
                            "تحديت التطبيق ",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                            "منصة تسوقي توصي بتحديث التطبيق لتوفير تجربة أفضل وأكثر سلاسة. قم بتحديث التطبيق الآن للاستمتاع بالمزايا الجديدة والتحسينات"),
                        10.verticalSpace,
                        SizedBox(
                          width: Get.width,
                          height: 40.h,
                          child: MaterialButton(
                            color: Theme.of(context).colorScheme.primary,
                            child: Text(
                              "تحميل مباشر",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              Get.find<HomeScreenController>().getApp(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        SizedBox(
                          width: Get.width,
                          height: 40.h,
                          child: MaterialButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () async {
                              launchUrl(Uri.parse(
                                  "${ApiRoute.redirectDomin}?url=${ApiRoute.domin}"));
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: const Text(
                              "تحميل من الموقع الرسمي",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        5.verticalSpace,
                        Obx(
                          () => (Get.find<HomeScreenController>()
                                  .isDownload
                                  .value)
                              ? LinearProgressIndicator(
                                  value: Get.find<HomeScreenController>()
                                          .cureentDownload
                                          .value /
                                      100,
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10.sp),
                                  minHeight: 10.h,
                                )
                              : Container(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      enableDrag: false,
      isScrollControlled: true,
      persistent: true,
      isDismissible: !Get.find<MainController>().setting.value!.forcedUpdate!,
      clipBehavior: Clip.none,
    ),
  );
}
