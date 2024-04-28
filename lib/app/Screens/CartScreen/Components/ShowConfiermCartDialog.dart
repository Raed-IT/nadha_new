import 'package:delevary/app/Screens/CartScreen/CartScreenController.dart';
import 'package:delevary/app/Screens/OrdersSecreens/OrdersSecreen/OrdersSecreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../components/TextFieldComponent.dart';

showConfirmCartDialog(BuildContext context, Function onConfirm,
    CartScreenController cartScreenController) {
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 500),
    barrierDismissible: true,
    transitionBuilder: (context, a1, a2, widget) {
      final curvedValue = Curves.elasticOut.transform(a1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 400.sp, 0.0),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldComponent(
                keyboardType: TextInputType.phone,
                controller: cartScreenController.phoneTextController,
                hint: 'رقم الهاتف',
              ),
              20.verticalSpace,
              TextFieldComponent(
                isMultiple: true,
                controller: cartScreenController.noteTextController,
                hint: 'ملاحظات الطلب',
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  onConfirm.call();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  width: Get.width,
                  height: 50.h,
                  child: Center(
                    child: Text(
                      "تاكيد الطلب",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                )
                    .animate(delay: 200.ms)
                    .elevation(
                      duration: 1000.ms,
                      borderRadius: BorderRadius.circular(10.sp),
                    )
                    .scale(duration: 100.ms)
                    .fadeIn(),
              )
            ],
          ),
          title: SizedBox(
            height: 10.h,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    top: -110,
                    right: 0,
                    left: 0,
                    child: Lottie.asset("assets/json/delevary_motor.json",
                        width: 150.sp, height: 150.h))
              ],
            ),
          ),
        ),
      );
    },
    barrierLabel: "",
    pageBuilder: (context, animation, secondaryAnimation) {
      return Column();
    },
  );
}
