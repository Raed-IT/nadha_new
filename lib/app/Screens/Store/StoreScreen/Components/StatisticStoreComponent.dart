import 'package:animated_number/animated_number.dart';
import 'package:delevary/app/Screens/Store/StoreScreen/StoreScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StatisticStoreComponent extends GetView<StoreScreenController> {
  const StatisticStoreComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buildCard(
                context: context,
                content: controller.statistics.value!.products!,
                title: "عدد المنتجات "),
            buildCard(
                context: context,
                content: controller.statistics.value!.categories!,
                title: "عدد الاقسام "),
          ],
        ),
        Row(
          children: [
            buildCard(
                context: context,
                content: controller.statistics.value!.sliders!,
                title: "الاعلانات الرئيسية"),
          ],
        )
      ],
    );
  }

  Widget buildCard(
      {required String title,
      required num content,
      required BuildContext context}) {
    return Expanded(
      child: SizedBox(
        height: 200.h,
        child: Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
          ),
          margin: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              20.verticalSpace,
              AnimatedNumber(
                startValue: 0,
                endValue: content,
                duration: Duration(seconds: 1),
                isFloatingPoint: false,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 40.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
