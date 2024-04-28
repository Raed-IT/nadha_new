import 'package:delevary/app/Data/ApiRoute.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
          width: Get.width,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // alignment: Alignment.topCenter,
              children: [
                Transform.translate(
                  offset: Offset(0, -100),
                  child:
                      Lottie.asset("assets/json/upgrade.json", height: 200.h),
                ),
                SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        100.verticalSpace,
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
                          child: MaterialButton(
                            color: Theme.of(context).colorScheme.primary,
                            child: Text("تحميل مباشر"),
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
                          child: MaterialButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () async {
                              Get.back();
                              Future.delayed(
                                500.ms,
                                () => EasyLauncher.url(url: ApiRoute.domin,mode: Mode.inAppWeb),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: const Text("تحميل من الموقع الرسمي"),
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
