import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nadha/app/data/inital/main_controller.dart';
import 'package:nadha/app/pages/cart_screen/cart_controller.dart';
import 'package:nadha/app/route/routs.dart';
import 'package:nadha/app/them/app_colors.dart';

class TotalCartScreenComponent extends GetView<CartScreenController> {
  const TotalCartScreenComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      width: Get.width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp),
            topRight: Radius.circular(20.sp),
          ),
          color: AppColors.scaffold,
          boxShadow: const [
            BoxShadow(
              color: AppColors.highlight,
              blurRadius: 20,
              offset: Offset(0, 0.7),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () {
                return Visibility(
                  visible: Get.find<MainController>().isAddFar,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                    child: Wrap(
                      children: [
                        Text(
                          "اجرة توصيل :",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${Get.find<MainController>().option.value?.fare ?? 0} ",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "الفاتوره الاجماليه :",
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  Obx(
                    () => Text(
                      (Get.find<MainController>().isAddFar)
                          ? (Get.find<MainController>().totalPrice +
                                  Get.find<MainController>()
                                      .option
                                      .value!
                                      .fare!)
                              .toStringAsFixed(2)
                          : Get.find<MainController>()
                              .totalPrice
                              .toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "",
                          color: AppColors.success),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (Get.find<MainController>().cartItems.isNotEmpty) {
                  Get.offAndToNamed(AppRoutes.ADDRESS_SCREEN);
                } else {
                  Fluttertoast.showToast(msg: "الرجاء تعبة السلة قبل المتابعة");
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 45.w),
                height: 45.h,
                decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                width: Get.width,
                child: Center(
                  child: Text(
                    'اختيار موقع الطلب  ',
                    style:
                        TextStyle(fontSize: 17.sp, color: AppColors.scaffold),
                  ),
                ),
              )
                  .animate()
                  .slideY(duration: const Duration(milliseconds: 500), begin: 1)
                  .scale(),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
