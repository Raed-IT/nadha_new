import 'package:animated_number/animated_number.dart';
import 'package:delevary/app/Data/MainController.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/Store/StoreScreen/StoreScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class StatisticStoreComponent extends GetView<StoreScreenController> {
  const StatisticStoreComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buildCard(
                onTap: () => Get.toNamed(AppRoutes.storeProducts),
                context: context,
                content: controller.statistics.value!.products!,
                title: "عدد المنتجات "),
            buildCard(
                onTap: () {
                  Get.toNamed(AppRoutes.storeOrders);
                },
                context: context,
                content: controller.statistics.value!.ordersCount!,
                title: "طلباتي"),
          ],
        ),
        Row(
          children: [
            buildCard(
                onTap: () {
                  Get.toNamed(AppRoutes.storeSliders);
                },
                context: context,
                content: controller.statistics.value!.sliders!,
                title: "الاعلانات الرئيسية"),
            buildCard(
                onTap: () {
                  Get.toNamed(AppRoutes.balances);
                },
                context: context,
                content: -1*(Get.find<MainController>().user.value?.balance ?? 0),
                title: "رصيدي"),
          ],
        )
      ],
    );
  }

  Widget buildCard(
      {required String title,
      required num content,
      required Function onTap,
      required BuildContext context}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap.call(),
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
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
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
      ),
    );
  }
}
