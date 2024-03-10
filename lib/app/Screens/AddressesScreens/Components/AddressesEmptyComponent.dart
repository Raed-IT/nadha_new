import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../route/Routs.dart';

class AddressesEmptyComponent extends StatelessWidget {
  const AddressesEmptyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        200.verticalSpace,
        Opacity(
          opacity: 0.4,
          child: Lottie.asset("assets/json/address.json",
              width: 100.w, height: 100.w, fit: BoxFit.contain),
        ),
        20.verticalSpace,
        Center(
          child: Text(
            "لايوجد عناوبن لك ",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
        ),
        20.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 90.w),
          child: OutlinedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(200.w, 50.h),
                ),
              ),
              onPressed: () {
                Get.back();
                Get.toNamed(AppRoutes.addAddress);
              },
              child: Text("إضافة عنوان")),
        )
      ],
    );
  }
}
