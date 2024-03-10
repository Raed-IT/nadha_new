import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Thems/AppColots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MarkerComponent extends StatelessWidget {
  const MarkerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.sp),
          topLeft: Radius.circular(10.sp),
          bottomRight: Radius.elliptical(150.sp, 300.h),
          bottomLeft: Radius.elliptical(150.sp, 300.h),
        ),
      ),
      child: Column(
        children: [
          Image(
            image:
                NetworkImage("${Get.find<MainController>().user.value?.image}"),
            height: 100.sp,
            width: 100.sp,
          ),
          Text(
            "${Get.find<MainController>().user.value?.name}",
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
