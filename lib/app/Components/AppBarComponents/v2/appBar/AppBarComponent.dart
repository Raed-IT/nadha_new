import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppBarComponent extends StatelessWidget {
  final Function openDrawer;

  const AppBarComponent({super.key, required this.openDrawer});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(
              height: 67.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/logo.svg",
                    height: 33.sp,
                    width: 116.w,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      openDrawer();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      child: SvgPicture.asset(
                        "assets/svg/drawer.svg",
                        height: 16.sp,
                        width: 20.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48.h,
              width: Get.width,
              child: const Card(
                margin: EdgeInsets.zero,
              ),
            )
          ],
        ),
      ),
    );
  }
}
