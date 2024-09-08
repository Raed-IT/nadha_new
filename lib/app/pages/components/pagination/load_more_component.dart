import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nadha/app/them/app_colors.dart';

class LoadModerComponent extends StatelessWidget {
  const LoadModerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "يتم تحميل المزيد من البيانات ",
              style: TextStyle(fontSize: 15.sp),
            ),
            SizedBox(
              width: 20.w,
            ),
            SizedBox(
              height: 20.sp,
              width: 20.sp,
              child: CircularProgressIndicator(
                color: AppColors.warning,
                strokeWidth: 2.sp,
              ),
            )
          ],
        ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }
}
