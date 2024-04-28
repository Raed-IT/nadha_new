import 'package:delevary/app/Data/Models/OrderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../DeliveryOrdersScreenController.dart';

showConfirmOrderBottomSheet(DeliveryOrdersScreenController controller,
    BuildContext context, OrderModel order) {
  Get.bottomSheet(
    Card(
      child: SizedBox(
        width: Get.width,
        child: Transform.translate(
          offset: Offset(0, -70.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/json/delevary_motor.json", height: 140.h),
              10.verticalSpace,
              Text(
                "سيتم انها الطلب ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
              ),
              50.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  minWidth: Get.width,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => controller.finishedOrder(order, context),
                  child: Text(
                    " انهاء الطلب",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Theme.of(context).colorScheme.background),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
