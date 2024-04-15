import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HorizontalListLoading extends StatelessWidget {
  final double? height;
  final BorderRadius? borderRadius;
  final int? generateCount;

  const HorizontalListLoading(
      {super.key, this.height, this.borderRadius, this.generateCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 140.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
            20,
            (index) => SizedBox(
                  width: 100.w,
                  height: 130.h,
                  child: CardLoadingComponent(
                    cardMargin: EdgeInsets.all(5.sp),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                )).toList(),
      ),
    );
  }
}
