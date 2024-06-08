import 'package:delevary/app/Route/Routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Data/MainController.dart';

void showPhoneDialog(BuildContext context) {
  if (Get.find<MainController>().user.value != null &&
      Get.find<MainController>().user.value?.phone == null) {
    Future.delayed(1000.ms, () {
      showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.h,
              width: Get.width - 100.w,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "إكمال بيانات الحساب ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      ),
                      Text(
                          textAlign: TextAlign.center,
                          "تساعدنا هذه الخطوة في الوصول إليكم بأقصى سرعة"),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: MaterialButton(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () => Get.back(),
                              child: Text(
                                "إلغاء",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          Expanded(
                            flex: 2,
                            child: MaterialButton(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.sp)),
                              color: Colors.green,
                              onPressed: () {
                                Get.back();
                                Get.toNamed(AppRoutes.profileScreen);
                              },
                              child: Text(
                                " الملف الشخصي",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ).animate().slideY(begin: 1, curve: Curves.elasticOut),
            ),
          ],
        ),
      );
    });
  }
}
