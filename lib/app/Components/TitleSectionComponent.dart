import 'package:delevary/app/Components/LoadingComponents/CardLoadingComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildTitleSectionComponent extends StatelessWidget {
  final RxBool isLoad;
  final String title;

  const BuildTitleSectionComponent(
      {super.key, required this.isLoad, required this.title});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => isLoad.value
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardLoadingComponent(
                  borderRadius: BorderRadius.circular(10.sp),
                  width: 200.w,
                  height: 35.h,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.sp),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp),
                  ),
                ),
              ],
            ),
    );
  }
}
