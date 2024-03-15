import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadMoreComponent extends StatelessWidget {
  final RxBool isLoad;
  final RxBool isFinished;

  const LoadMoreComponent(
      {super.key, required this.isLoad, required this.isFinished});

  @override
  Widget build(BuildContext context) {
    return Obx(() => isLoad.value
        ? Container(
            height: 50.h,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/json/loader.json'),
                Text(
                  "يتم تحميل المزيد",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        : isFinished.value
            ? Container(
                height: 50.h,
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/json/empty_cube.json'),
                    Text(
                      "لايوجد المزيد",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            : Container());
  }
}
