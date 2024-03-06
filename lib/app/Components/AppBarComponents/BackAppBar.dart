import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackAppBarComponent extends StatelessWidget {
  const BackAppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            height: 50.h,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.sp),
                  bottomRight: Radius.circular(15.sp),
                )),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18.sp,
              ),
            ),
          ).animate().show(duration: 200.ms).slideX(delay: 300.ms)
        ],
      ),
    );
  }
}
