import 'package:delevary/app/Components/v2/primary_button.dart';
import 'package:delevary/app/Route/Routs.dart';
import 'package:delevary/app/Screens/v2/order_complete_screen/order_complete_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OrderCompleteScreen extends GetView<OrderCompleteScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "لقد تم إرسال الطلب",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w800),
            ),
            10.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "رقم الطلب",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w800),
                ),
                Text(controller.orderId, )
              ],
            ),
            50.verticalSpace,
           Lottie.asset("assets/json/success.json",
              height: 200.h, repeat: false, fit: BoxFit.contain),
           50.verticalSpace,

            Padding(
              padding: EdgeInsets.all(20.sp),
              child: PrimaryButtonComponent(label: "العودة للصفحة الرئيسية",onTap: ()async=>Get.offAllNamed(AppRoutes.homeScreen),),
            )
          ],
        ),
      ),
    );
  }
}
